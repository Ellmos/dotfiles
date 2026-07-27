import * as path from "path";
import * as fs from "fs";
import { spawnSync } from "child_process";
import { gitCTry } from "../lib/git";
import { findRepoRoot, worktreeNameFromPath, GwtError } from "../lib/repo";
import {
  configDirPath,
  ensureConfigDir,
  setWorktreePwd,
} from "../lib/config";

export function cmdConfig(subcmd: string, args: string[]): void {
  const repoRoot = findRepoRoot();
  const configDir = configDirPath(repoRoot);
  ensureConfigDir(repoRoot);

  switch (subcmd) {
    case "edit": {
      const fileArg = args[0];
      let target: string;
      if (fileArg) {
        target = path.isAbsolute(fileArg)
          ? fileArg
          : path.join(configDir, fileArg);
      } else {
        target = configDir;
      }

      const editor = process.env.VISUAL ?? process.env.EDITOR ?? "vi";
      const result = spawnSync(editor, [target], { stdio: "inherit" });
      if (result.status !== 0) {
        process.exit(result.status ?? 1);
      }
      break;
    }

    case "set": {
      const key = args[0];
      if (key !== "pwd") {
        throw new GwtError(`unknown config key '${key}' (supported: pwd)`);
      }

      const pathArg = args[1];

      const currentWtRoot = gitCTry(process.cwd(), [
        "rev-parse",
        "--show-toplevel",
      ])?.stdout;
      if (!currentWtRoot) {
        throw new GwtError("run this command from inside a worktree");
      }

      let wtName: string;
      try {
        wtName = worktreeNameFromPath(repoRoot, currentWtRoot);
      } catch {
        throw new GwtError("current directory is outside this gwt repo");
      }

      if (wtName === "root") {
        throw new GwtError("cannot set worktree pwd for repo root");
      }
      const poolDir = path.join(repoRoot, ".pool");
      if (currentWtRoot.startsWith(poolDir + path.sep)) {
        throw new GwtError("cannot set worktree pwd for pooled worktrees");
      }

      let absTarget: string;
      if (!pathArg) {
        absTarget = process.cwd();
      } else {
        absTarget = path.isAbsolute(pathArg)
          ? pathArg
          : path.resolve(process.cwd(), pathArg);
      }

      if (!fs.existsSync(absTarget)) {
        throw new GwtError(`path does not exist: '${absTarget}'`);
      }
      absTarget = fs.realpathSync(absTarget);

      let relTarget: string;
      if (absTarget === currentWtRoot) {
        relTarget = ".";
      } else if (absTarget.startsWith(currentWtRoot + path.sep)) {
        relTarget = absTarget.slice(currentWtRoot.length + 1);
      } else {
        throw new GwtError(
          `path must be inside current worktree: '${currentWtRoot}'`
        );
      }

      setWorktreePwd(repoRoot, wtName, relTarget);
      process.stdout.write(
        `Set default path for worktree ${wtName} to ${relTarget}\n`
      );
      break;
    }

    default:
      throw new GwtError(`unknown config subcommand '${subcmd}'`);
  }
}
