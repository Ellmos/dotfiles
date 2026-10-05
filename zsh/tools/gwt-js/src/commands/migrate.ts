import * as path from "path";
import * as fs from "fs";
import { gitC, gitCTry } from "../lib/git";
import { isGwtRepoRoot, resolveWorktreeName, GwtError } from "../lib/repo";
import { POST_ADD_HOOK_TEMPLATE } from "./clone";

/**
 * Move any entries under `from` that don't already exist at the matching
 * path under `to`. Used to recover untracked/ignored content (node_modules,
 * .env, build output, …) that a fresh `git worktree add` checkout wouldn't
 * recreate. Recurses into directories that exist on both sides so ignored
 * content nested inside an otherwise-tracked directory isn't lost.
 */
function mergeExtra(from: string, to: string): void {
  for (const entry of fs.readdirSync(from, { withFileTypes: true })) {
    const src = path.join(from, entry.name);
    const dst = path.join(to, entry.name);
    if (!fs.existsSync(dst)) {
      fs.renameSync(src, dst);
    } else if (entry.isDirectory() && fs.statSync(dst).isDirectory()) {
      mergeExtra(src, dst);
    }
    // Otherwise both sides have it (a tracked file/dir) — the fresh
    // checkout's copy is authoritative since the tree was verified clean.
  }
}

export function cmdMigrate(targetDir?: string): void {
  const dir = targetDir ? path.resolve(targetDir) : process.cwd();

  const root = gitCTry(dir, ["rev-parse", "--show-toplevel"])?.stdout;
  if (!root) {
    throw new GwtError(`'${dir}' is not inside a git repository`);
  }

  if (isGwtRepoRoot(root)) {
    throw new GwtError(`'${root}' is already a gwt workspace`);
  }

  const isBare = gitCTry(root, ["rev-parse", "--is-bare-repository"])?.stdout;
  if (isBare === "true") {
    throw new GwtError(`'${root}' is a bare repository; nothing to migrate`);
  }

  const dotGit = path.join(root, ".git");
  if (!fs.statSync(dotGit).isDirectory()) {
    throw new GwtError(
      `'${root}' is already a linked worktree or submodule (.git is not a directory); migrate only supports a plain repository`
    );
  }

  const worktreeCount = (
    gitCTry(root, ["worktree", "list", "--porcelain"])?.stdout ?? ""
  )
    .split("\n")
    .filter((l) => l.startsWith("worktree ")).length;
  if (worktreeCount > 1) {
    throw new GwtError(
      `'${root}' already has multiple linked worktrees; migrate isn't supported for multi-worktree repos`
    );
  }

  const status = gitCTry(root, ["status", "--porcelain"])?.stdout ?? "";
  if (status.trim() !== "") {
    throw new GwtError("worktree has uncommitted changes — commit or stash first");
  }

  const branch = gitCTry(root, ["symbolic-ref", "--quiet", "--short", "HEAD"])?.stdout;
  if (!branch) {
    throw new GwtError("HEAD is detached; checkout a branch before migrating");
  }

  const parentDir = path.dirname(root);
  const baseName = path.basename(root);
  const tempRoot = path.join(parentDir, `.${baseName}.gwt-migrate-tmp`);
  if (fs.existsSync(tempRoot)) {
    throw new GwtError(`temporary path '${tempRoot}' already exists; remove it and retry`);
  }

  const bareDir = path.join(root, ".bare");
  let renamedToTemp = false;
  let recreatedRoot = false;
  let movedGitDir = false;

  try {
    fs.renameSync(root, tempRoot);
    renamedToTemp = true;

    fs.mkdirSync(root);
    recreatedRoot = true;

    fs.renameSync(path.join(tempRoot, ".git"), bareDir);
    movedGitDir = true;

    gitC(bareDir, ["config", "core.bare", "true"]);
    gitCTry(bareDir, ["config", "--unset", "core.worktree"]);
    // Placeholder HEAD so the bare dir doesn't advertise a checked-out branch.
    fs.writeFileSync(path.join(bareDir, "HEAD"), "ref: refs/heads/gwt\n", "utf8");

    fs.writeFileSync(path.join(root, ".git"), "gitdir: ./.bare\n", "utf8");

    const target = resolveWorktreeName(root, branch);
    gitC(bareDir, ["worktree", "add", target, branch]);

    mergeExtra(tempRoot, target);
    fs.rmSync(tempRoot, { recursive: true, force: true });

    const gwtDir = path.join(root, ".gwt");
    fs.mkdirSync(gwtDir, { recursive: true });
    const hookPath = path.join(gwtDir, "post-add.sh");
    if (!fs.existsSync(hookPath)) {
      fs.writeFileSync(hookPath, POST_ADD_HOOK_TEMPLATE, "utf8");
    }

    process.stdout.write(`Done. Bare repo at ${root}/.bare, worktree at ${target}\n`);
  } catch (err) {
    // Best-effort rollback so a failure partway through doesn't strand the
    // user's repo in a half-migrated state.
    try {
      if (movedGitDir && fs.existsSync(bareDir)) {
        fs.renameSync(bareDir, path.join(tempRoot, ".git"));
      }
      if (recreatedRoot && fs.existsSync(root)) {
        fs.rmSync(root, { recursive: true, force: true });
      }
      if (renamedToTemp && fs.existsSync(tempRoot)) {
        fs.renameSync(tempRoot, root);
      }
    } catch (rollbackErr) {
      const msg = rollbackErr instanceof Error ? rollbackErr.message : String(rollbackErr);
      throw new GwtError(
        `migrate failed and rollback also failed — repo may be left in an inconsistent state (original content, if any, is under '${tempRoot}'): ${msg}`
      );
    }
    throw err;
  }
}
