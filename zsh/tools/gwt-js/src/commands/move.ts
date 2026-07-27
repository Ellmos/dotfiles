import * as path from "path";
import * as fs from "fs";
import { gitC } from "../lib/git";
import { findRepoRoot, GwtError } from "../lib/repo";

export function cmdMove(from: string, to: string): void {
  const repoRoot = findRepoRoot();
  const poolDir = path.join(repoRoot, ".pool");
  const bareDir = path.join(repoRoot, ".bare");
  const src = path.join(repoRoot, from);
  const dst = path.join(repoRoot, to);

  if (!fs.existsSync(src)) {
    throw new GwtError(`worktree '${from}' does not exist`);
  }
  if (fs.existsSync(dst)) {
    throw new GwtError(`destination '${to}' already exists`);
  }
  if (src.startsWith(poolDir + path.sep) || src === poolDir) {
    throw new GwtError("cannot move a pool slot — use 'gwt add' to activate it");
  }

  gitC(bareDir, ["worktree", "move", src, dst]);
  process.stdout.write(dst + "\n");
}
