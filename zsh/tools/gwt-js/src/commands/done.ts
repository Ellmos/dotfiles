import * as path from "path";
import * as fs from "fs";
import { gitC, gitCTry } from "../lib/git";
import { findRepoRoot, nextPoolSlot, worktreeNameFromPath, GwtError } from "../lib/repo";
import { unsetWorktreePwd } from "../lib/config";

export function cmdDone(inputPath?: string): void {
  const resolvedInput = inputPath ?? process.cwd();

  let wtPath: string;
  try {
    wtPath = fs.realpathSync(resolvedInput);
  } catch {
    throw new GwtError(`path '${resolvedInput}' does not exist`);
  }

  const wtRoot = gitCTry(wtPath, ["rev-parse", "--show-toplevel"])?.stdout;
  if (!wtRoot) {
    throw new GwtError(`path '${resolvedInput}' is not inside a git worktree`);
  }

  const repoRoot = findRepoRoot(wtRoot);
  const poolDir = path.join(repoRoot, ".pool");

  let wtName: string;
  try {
    wtName = worktreeNameFromPath(repoRoot, wtRoot);
  } catch {
    throw new GwtError("cannot resolve worktree name");
  }

  if (wtRoot === repoRoot) {
    throw new GwtError("cannot release the repo root");
  }
  if (wtRoot === path.join(repoRoot, ".bare")) {
    throw new GwtError("cannot release the bare repo");
  }
  if (wtRoot.startsWith(poolDir + path.sep) || wtRoot === poolDir) {
    throw new GwtError("worktree is already in the pool");
  }

  // Check for uncommitted changes
  const statusOutput = gitCTry(wtRoot, ["status", "--porcelain"])?.stdout ?? "";
  if (statusOutput.trim() !== "") {
    throw new GwtError("worktree has uncommitted changes — commit or stash first");
  }

  const bareDir = path.join(repoRoot, ".bare");

  gitC(wtRoot, ["checkout", "--detach", "HEAD"]);

  fs.mkdirSync(poolDir, { recursive: true });
  const slot = nextPoolSlot(poolDir);
  const slotPath = path.join(poolDir, String(slot));

  gitC(bareDir, ["worktree", "move", wtRoot, slotPath]);

  unsetWorktreePwd(repoRoot, wtName);

  process.stdout.write(`Worktree parked in pool slot ${slot}.\n`);
}
