import * as path from "path";
import * as fs from "fs";
import chalk from "chalk";
import { findRepoRoot, listWorktrees, GwtError } from "../lib/repo";

export function cmdList(): void {
  const repoRoot = findRepoRoot();
  const poolDir = path.join(repoRoot, ".pool");
  const bareDir = path.join(repoRoot, ".bare");

  const worktrees = listWorktrees(bareDir);

  process.stdout.write(`${chalk.bold("Root:")} ${repoRoot}\n\n`);

  process.stdout.write(`${chalk.bold("Active worktrees:")}\n`);
  for (const wt of worktrees) {
    if (wt.path === path.resolve(bareDir)) continue;
    if (wt.path === poolDir || wt.path.startsWith(poolDir + path.sep)) continue;

    let rel: string;
    if (wt.path === repoRoot) {
      rel = ".";
    } else if (wt.path.startsWith(repoRoot + path.sep)) {
      rel = wt.path.slice(repoRoot.length + 1);
    } else {
      rel = wt.path;
    }

    const branchLabel = wt.branch
      ? wt.branch.replace(/^refs\/heads\//, "")
      : "(detached)";
    process.stdout.write(`  ${rel} [${branchLabel}]\n`);
  }

  process.stdout.write(`\n${chalk.bold("Idle (pool):")}\n`);
  const poolSlots = worktrees.filter(
    (wt) =>
      wt.path !== poolDir && wt.path.startsWith(poolDir + path.sep)
  );

  if (poolSlots.length === 0 || !fs.existsSync(poolDir)) {
    process.stdout.write("  (none)\n");
  } else {
    for (const wt of poolSlots) {
      process.stdout.write(`  slot ${path.basename(wt.path)}\n`);
    }
  }
}
