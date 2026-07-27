import * as path from "path";
import * as fs from "fs";
import { gitC } from "../lib/git";
import { findRepoRoot, GwtError } from "../lib/repo";
import { getWorktreePwd } from "../lib/config";

export function cmdCd(name: string): void {
  const repoRoot = findRepoRoot();
  const poolDir = path.join(repoRoot, ".pool");
  const bareDir = path.join(repoRoot, ".bare");

  if (name === "root") {
    process.stdout.write(repoRoot + "\n");
    return;
  }

  const rawTarget = path.join(repoRoot, name);

  let target: string;
  try {
    target = fs.realpathSync(rawTarget);
  } catch {
    throw new GwtError(`worktree '${name}' does not exist`);
  }

  if (target === path.resolve(bareDir)) {
    throw new GwtError("cannot cd to the bare repo");
  }

  if (target.startsWith(path.resolve(poolDir) + path.sep) || target === path.resolve(poolDir)) {
    throw new GwtError("cannot cd to an idle pool slot; activate it with 'gwt add'");
  }

  // Verify it is a registered active worktree
  const r = gitC(bareDir, ["worktree", "list", "--porcelain"]);
  const isActive = r.stdout
    .split("\n")
    .some((line) => line === `worktree ${target}`);

  if (!isActive) {
    throw new GwtError(`'${name}' is not an active worktree`);
  }

  // Apply configured pwd if any
  const configuredRel = getWorktreePwd(repoRoot, name);
  if (configuredRel && configuredRel !== ".") {
    target = path.join(target, configuredRel);
  }

  if (!fs.existsSync(target)) {
    throw new GwtError(`configured cd path does not exist: '${target}'`);
  }

  process.stdout.write(target + "\n");
}
