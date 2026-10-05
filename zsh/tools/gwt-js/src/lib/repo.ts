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
 * True when `root` is the root of a gwt-managed bare+worktree repo
 * (i.e. it has a `.bare` directory, as created by `gwt clone`/`gwt migrate`).
 */
export function isGwtRepoRoot(root: string): boolean {
  const bareDir = path.join(root, ".bare");
  try {
    return fs.statSync(bareDir).isDirectory();
  } catch {
    return false;
  }
}

/**
 * Resolve the gwt repo root from any directory inside it (worktree or root).
 * Mirrors find_repo_root() in the shell script, plus a check that the
 * discovered root is actually a gwt-managed repo (has a `.bare` dir) —
 * running gwt inside a plain git repo is an error, not a silent success.
 */
export function findRepoRoot(dir: string = process.cwd()): string {
  const r = git(["-C", dir, "rev-parse", "--git-common-dir"], {
    throwOnError: false,
  });
  if (r.status !== 0 || !r.stdout) {
    throw new GwtError("not inside a git repository");
  }

  const gitCommon = r.stdout.trim();
  const absCommon = path.isAbsolute(gitCommon)
    ? gitCommon
    : path.resolve(dir, gitCommon);

  const root = path.dirname(path.resolve(absCommon));

  if (!isGwtRepoRoot(root)) {
    throw new GwtError(
      "not inside a gwt workspace (no .bare directory found) — run 'gwt migrate' to convert this repo"
    );
  }

  return root;
}

/**
 * Validate that `name` resolves to a path inside `repoRoot` and isn't one
 * of the reserved top-level names gwt uses for its own bookkeeping.
 * Returns the resolved absolute path.
 */
export function resolveWorktreeName(repoRoot: string, name: string): string {
  if (!name || name.trim() === "") {
    throw new GwtError("worktree name must not be empty");
  }

  const target = path.resolve(repoRoot, name);
  if (target !== repoRoot && !target.startsWith(repoRoot + path.sep)) {
    throw new GwtError(`invalid name '${name}': resolves outside the repo root`);
  }

  const topSegment = path.relative(repoRoot, target).split(path.sep)[0];
  const reserved = new Set(["root", ".bare", ".pool", ".gwt", ".git"]);
  if (reserved.has(topSegment)) {
    throw new GwtError(`'${topSegment}' is a reserved name and can't be used for a worktree`);
  }

  return target;
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
