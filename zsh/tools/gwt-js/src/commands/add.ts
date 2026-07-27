import * as path from "path";
import * as fs from "fs";
import { spawnSync } from "child_process";
import { git, gitC, gitCTry } from "../lib/git";
import { findRepoRoot, nextPoolSlot, GwtError } from "../lib/repo";

interface AddOptions {
  createBranch: boolean;
  base?: string;
}

export function cmdAdd(name: string, branch?: string, opts: AddOptions = { createBranch: false }): void {
  const { createBranch, base: baseRef } = opts;

  // -b without -c makes no sense
  if (baseRef && !createBranch) {
    throw new GwtError("-b requires -c");
  }

  // Branch defaults to the worktree name when not specified
  const resolvedBranch = branch ?? name;

  const repoRoot = findRepoRoot();
  const bareDir = path.join(repoRoot, ".bare");
  const target = path.join(repoRoot, name);

  if (fs.existsSync(target)) {
    throw new GwtError(`worktree '${resolvedBranch}' already exists at '${target}'`);
  }

  // Resolve base when -c is given but no -b
  let resolvedBase = baseRef;
  if (createBranch && !resolvedBase) {
    const currentWtRoot = gitCTry(process.cwd(), ["rev-parse", "--show-toplevel"])?.stdout ?? null;
    if (currentWtRoot && currentWtRoot !== repoRoot) {
      const head = gitCTry(currentWtRoot, ["symbolic-ref", "--quiet", "--short", "HEAD"])?.stdout ?? null;
      if (!head) {
        throw new GwtError("current worktree is detached; pass -b <base> explicitly");
      }
      resolvedBase = head;
    } else {
      throw new GwtError("-c requires -b <base> when run from the repo root");
    }
  }

  const poolDir = path.join(repoRoot, ".pool");

  // Find the first available numeric pool slot
  const idleSlot = findIdleSlot(poolDir);

  if (idleSlot) {
    // Reuse a pool worktree — validate branch BEFORE moving so a missing branch
    // doesn't strand the worktree outside the pool.
    if (!createBranch) {
      const localExists = gitCTry(bareDir, ["rev-parse", "--verify", `refs/heads/${resolvedBranch}`]);
      const remoteExists = gitCTry(bareDir, ["rev-parse", "--verify", `refs/remotes/origin/${resolvedBranch}`]);
      if (!localExists && !remoteExists) {
        throw new GwtError(`branch '${resolvedBranch}' not found; use -c to create it`);
      }
    }

    gitC(bareDir, ["worktree", "move", idleSlot, target]);

    if (createBranch) {
      gitC(target, ["switch", "-c", resolvedBranch, resolvedBase!]);
    } else {
      gitC(target, ["switch", resolvedBranch]);
    }
  } else {
    // Create a fresh worktree
    if (createBranch) {
      gitC(bareDir, ["worktree", "add", "-b", resolvedBranch, target, resolvedBase!]);
    } else {
      const r = git(["-C", bareDir, "worktree", "add", target, resolvedBranch], {
        throwOnError: false,
      });
      if (r.status !== 0) {
        throw new GwtError(`branch '${resolvedBranch}' not found; use -c to create it`);
      }
    }
  }

  runPostAddHook(repoRoot, target, resolvedBranch, createBranch);

  process.stdout.write(target + "\n");
}

function findIdleSlot(poolDir: string): string | null {
  if (!fs.existsSync(poolDir)) return null;

  const entries = fs.readdirSync(poolDir);
  const numericSlots = entries
    .filter((e) => /^\d+$/.test(e))
    .map(Number)
    .sort((a, b) => a - b);

  for (const n of numericSlots) {
    const slotPath = path.join(poolDir, String(n));
    if (fs.statSync(slotPath).isDirectory()) {
      return slotPath;
    }
  }
  return null;
}

function runPostAddHook(
  repoRoot: string,
  target: string,
  branch: string,
  createdNewBranch: boolean
): void {
  const hook = path.join(repoRoot, ".gwt", "post-add.sh");
  if (!fs.existsSync(hook)) return;

  const result = spawnSync("sh", [hook], {
    cwd: target,
    stdio: "inherit",
    env: {
      ...process.env,
      GWT_REPO_ROOT: repoRoot,
      GWT_WORKTREE_PATH: target,
      GWT_WORKTREE_NAME: path.basename(target),
      GWT_BRANCH: branch,
      GWT_ADD_CREATED_BRANCH: createdNewBranch ? "1" : "0",
    },
  });

  if (result.status !== 0) {
    throw new GwtError(`post-add hook failed: ${hook}`);
  }
}
