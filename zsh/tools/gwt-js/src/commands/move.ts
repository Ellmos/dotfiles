import * as path from "path";
import * as fs from "fs";
import { gitC } from "../lib/git";
import { findRepoRoot, resolveWorktreeName, worktreeNameFromPath, GwtError } from "../lib/repo";
import { getWorktreePwd, setWorktreePwd, unsetWorktreePwd } from "../lib/config";

export function cmdMove(from: string, to: string): void {
  const repoRoot = findRepoRoot();
  const poolDir = path.join(repoRoot, ".pool");
  const bareDir = path.join(repoRoot, ".bare");
  const src = path.resolve(repoRoot, from);
  const dst = resolveWorktreeName(repoRoot, to);

  if (!fs.existsSync(src)) {
    throw new GwtError(`worktree '${from}' does not exist`);
  }
  if (fs.existsSync(dst)) {
    throw new GwtError(`destination '${to}' already exists`);
  }
  if (src === repoRoot) {
    throw new GwtError("cannot move the repo root");
  }
  if (src === bareDir) {
    throw new GwtError("cannot move the bare repo");
  }
  if (src.startsWith(poolDir + path.sep) || src === poolDir) {
    throw new GwtError("cannot move a pool slot — use 'gwt add' to activate it");
  }

  gitC(bareDir, ["worktree", "move", src, dst]);

  // Carry over any configured `gwt cd` default path to the new name.
  try {
    const fromName = worktreeNameFromPath(repoRoot, src);
    const toName = worktreeNameFromPath(repoRoot, dst);
    const configuredRel = getWorktreePwd(repoRoot, fromName);
    if (configuredRel !== null) {
      unsetWorktreePwd(repoRoot, fromName);
      setWorktreePwd(repoRoot, toName, configuredRel);
    }
  } catch {
    // Best-effort: if names can't be resolved, just leave pwd-map untouched.
  }

  process.stdout.write(dst + "\n");
}
