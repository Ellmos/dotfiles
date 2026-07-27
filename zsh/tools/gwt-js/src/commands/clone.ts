import * as path from "path";
import * as fs from "fs";
import { gitC } from "../lib/git";
import { GwtError } from "../lib/repo";

const POST_ADD_HOOK_TEMPLATE = `#!/bin/sh

# Runs after \`gwt add\` inside the target worktree.
# Available environment variables:
# - GWT_REPO_ROOT
# - GWT_WORKTREE_PATH
# - GWT_WORKTREE_NAME
# - GWT_BRANCH
# - GWT_ADD_CREATED_BRANCH

# Example:
# if [ -f package.json ]; then
#   npm install
# fi
`;

export function cmdClone(url: string, folder?: string): void {
  const dest = folder ?? path.basename(url, ".git");

  if (fs.existsSync(dest)) {
    throw new GwtError(`destination '${dest}' already exists`);
  }

  const bareDir = path.join(dest, ".bare");
  fs.mkdirSync(bareDir, { recursive: true });

  gitC(bareDir, ["init", "--bare"]);
  gitC(bareDir, ["remote", "add", "origin", url]);
  gitC(bareDir, [
    "config",
    "remote.origin.fetch",
    "+refs/heads/*:refs/remotes/origin/*",
  ]);
  gitC(bareDir, ["fetch", "origin"]);
  gitC(bareDir, ["remote", "set-head", "origin", "-a"]);

  const headRef = gitC(bareDir, [
    "symbolic-ref",
    "--short",
    "refs/remotes/origin/HEAD",
  ]).stdout;
  const defaultBranch = headRef.replace(/^origin\//, "");

  // Add worktree for the default branch (relative path from bareDir)
  gitC(bareDir, ["worktree", "add", `../${defaultBranch}`, defaultBranch]);

  // Root .git file so Git recognises the root directory
  fs.writeFileSync(path.join(dest, ".git"), "gitdir: ./.bare\n", "utf8");

  // Reset HEAD to a placeholder so the bare dir doesn't advertise a branch
  fs.writeFileSync(
    path.join(bareDir, "HEAD"),
    "ref: refs/heads/gwt\n",
    "utf8"
  );

  // Create default post-add hook scaffold
  const gwtDir = path.join(dest, ".gwt");
  fs.mkdirSync(gwtDir, { recursive: true });
  const hookPath = path.join(gwtDir, "post-add.sh");
  fs.writeFileSync(hookPath, POST_ADD_HOOK_TEMPLATE, "utf8");

  process.stdout.write(
    `Done. Bare repo at ${dest}/.bare, default worktree at ${dest}/${defaultBranch}\n`
  );
}
