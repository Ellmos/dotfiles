import * as path from "path";
import * as fs from "fs";
import { findRepoRoot, GwtError } from "../lib/repo";
import { rewritePathFile, findGitFiles } from "../lib/fs";

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

  // Update bare metadata pointing to linked worktrees
  const worktreesDir = path.join(dstRoot, ".bare", "worktrees");
  if (fs.existsSync(worktreesDir)) {
    for (const entry of fs.readdirSync(worktreesDir)) {
      const metaFile = path.join(worktreesDir, entry, "gitdir");
      rewritePathFile(metaFile, oldRoot, dstRoot);
    }
  }

  // Update each linked worktree .git file that points into .bare/worktrees/*
  const gitFiles = findGitFiles(dstRoot, [
    path.join(dstRoot, ".git"),
    path.join(dstRoot, ".bare"),
  ]);
  for (const gitFile of gitFiles) {
    rewritePathFile(gitFile, oldRoot, dstRoot);
  }

  process.stdout.write(dstRoot + "\n");
}
