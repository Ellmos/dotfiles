import * as path from "path";
import * as fs from "fs";
import { git, gitCTry } from "./git";

export class GwtError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "GwtError";
  }
}

/**
 * Resolve the gwt repo root from any directory inside it (worktree or root).
 * Mirrors find_repo_root() in the shell script.
 */
export function findRepoRoot(dir: string = process.cwd()): string {
  const r = git(["-C", dir, "rev-parse", "--git-common-dir"], {
    throwOnError: false,
  });
  if (r.status !== 0 || !r.stdout) {
    throw new GwtError("not inside a gwt repo");
  }

  const gitCommon = r.stdout.trim();
  const absCommon = path.isAbsolute(gitCommon)
    ? gitCommon
    : path.resolve(dir, gitCommon);

  return path.dirname(path.resolve(absCommon));
}

/**
 * Echo the lowest unused numeric pool slot number (1, 2, 3, …).
 */
export function nextPoolSlot(poolDir: string): number {
  let n = 1;
  while (fs.existsSync(path.join(poolDir, String(n)))) {
    n++;
  }
  return n;
}

/**
 * Derive the worktree name relative to the repo root.
 * Returns 'root' when wtPath === repoRoot.
 */
export function worktreeNameFromPath(
  repoRoot: string,
  wtPath: string
): string {
  if (wtPath === repoRoot) return "root";
  if (wtPath.startsWith(repoRoot + path.sep)) {
    return wtPath.slice(repoRoot.length + 1);
  }
  throw new GwtError("worktree path is outside the repo root");
}

/**
 * List all worktrees by parsing `git worktree list --porcelain`.
 * Returns an array of { path, head, branch, bare }.
 */
export interface WorktreeInfo {
  path: string;
  head: string;
  branch: string | null;
  bare: boolean;
}

export function listWorktrees(bareDir: string): WorktreeInfo[] {
  const r = gitCTry(bareDir, ["worktree", "list", "--porcelain"]);
  if (!r) return [];

  const worktrees: WorktreeInfo[] = [];
  let current: Partial<WorktreeInfo> = {};

  for (const line of r.stdout.split("\n")) {
    if (line.startsWith("worktree ")) {
      if (current.path !== undefined) worktrees.push(current as WorktreeInfo);
      current = { path: line.slice("worktree ".length), bare: false, head: "", branch: null };
    } else if (line.startsWith("HEAD ")) {
      current.head = line.slice("HEAD ".length);
    } else if (line.startsWith("branch ")) {
      current.branch = line.slice("branch ".length);
    } else if (line === "bare") {
      current.bare = true;
    }
  }
  if (current.path !== undefined) worktrees.push(current as WorktreeInfo);
  return worktrees;
}
