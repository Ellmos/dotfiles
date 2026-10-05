import * as path from "path";
import * as fs from "fs";
import { findRepoRoot, listWorktrees, GwtError } from "../lib/repo";
import { rewritePathFile } from "../lib/fs";

export function cmdRelocate(args: string[]): void {
  let srcRoot: string;
  let dstRoot: string;

  if (args.length === 1) {
    srcRoot = findRepoRoot();
    const dstArg = args[0];
    dstRoot = path.isAbsolute(dstArg)
      ? dstArg
      : path.join(path.dirname(srcRoot), dstArg);
  } else if (args.length === 2) {
    try {
      srcRoot = fs.realpathSync(args[0]);
    } catch {
      throw new GwtError(`path '${args[0]}' does not exist`);
    }
    const dstArg = args[1];
    dstRoot = path.isAbsolute(dstArg)
      ? dstArg
      : path.resolve(process.cwd(), dstArg);
  } else {
    throw new GwtError("usage: gwt relocate <new> | gwt relocate <src> <new>");
  }

  if (!fs.existsSync(path.join(srcRoot, ".bare"))) {
    throw new GwtError(`'${srcRoot}' is not a gwt repo root (.bare missing)`);
  }
  if (!fs.existsSync(path.join(srcRoot, ".git"))) {
    throw new GwtError(`'${srcRoot}' is not a gwt repo root (.git missing)`);
  }

  // Canonicalize the destination: resolve the parent, keep the basename as entered
  const dstParent = path.dirname(dstRoot);
  const dstName = path.basename(dstRoot);
  let dstParentAbs: string;
  try {
    dstParentAbs = fs.realpathSync(dstParent);
  } catch {
    throw new GwtError(`destination parent '${dstParent}' does not exist`);
  }
  dstRoot = path.join(dstParentAbs, dstName);

  if (srcRoot === dstRoot) {
    throw new GwtError("source and destination are identical");
  }
  if (dstRoot.startsWith(srcRoot + path.sep)) {
    throw new GwtError("destination cannot be inside source");
  }
  if (fs.existsSync(dstRoot)) {
    throw new GwtError(`destination '${dstRoot}' already exists`);
  }

  const oldRoot = srcRoot;
  fs.renameSync(oldRoot, dstRoot);

  const bareDir = path.join(dstRoot, ".bare");
  const warnings: string[] = [];

  // Update bare metadata pointing to linked worktrees. These files store
  // the worktree's own .git file path, e.g. "<oldRoot>/<name>/.git" — once
  // rewritten, `git worktree list` against the new bare dir will correctly
  // resolve to the new worktree paths.
  const worktreesDir = path.join(bareDir, "worktrees");
  if (fs.existsSync(worktreesDir)) {
    for (const entry of fs.readdirSync(worktreesDir)) {
      const metaFile = path.join(worktreesDir, entry, "gitdir");
      if (fs.existsSync(metaFile) && !rewritePathFile(metaFile, oldRoot, dstRoot)) {
        warnings.push(metaFile);
      }
    }
  }

  // Update each linked worktree's own .git gitlink file back to .bare.
  // We deliberately don't walk the filesystem tree here (that would also
  // wander into node_modules, submodules, etc. in every worktree, which is
  // both slow and liable to rewrite unrelated .git files) — `git worktree
  // list` (now resolving correctly thanks to the rewrite above) already
  // tells us exactly which paths need fixing.
  for (const wt of listWorktrees(bareDir)) {
    if (wt.bare || wt.path === dstRoot) continue;
    const gitFile = path.join(wt.path, ".git");
    if (fs.existsSync(gitFile) && !rewritePathFile(gitFile, oldRoot, dstRoot)) {
      warnings.push(gitFile);
    }
  }

  if (warnings.length > 0) {
    process.stderr.write(
      `warning: could not update the following worktree metadata files (they may still reference the old path):\n` +
        warnings.map((w) => `  ${w}\n`).join("")
    );
  }

  process.stdout.write(dstRoot + "\n");
}
