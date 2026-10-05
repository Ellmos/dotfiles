import { spawnSync, SpawnSyncOptions } from "child_process";

export class GitError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "GitError";
  }
}

interface GitResult {
  stdout: string;
  stderr: string;
  status: number | null;
}

/**
 * Run a git command with explicit arg array (never interpolated into a shell string).
 * Returns stdout on success. Throws GitError on non-zero exit.
 */
export function git(
  args: string[],
  options: SpawnSyncOptions & { throwOnError?: boolean } = {}
): GitResult {
  const { throwOnError = true, ...spawnOptions } = options;
  const result = spawnSync("git", args, {
    encoding: "utf8",
    ...spawnOptions,
  });

  if (result.error) {
    // git binary missing, EACCES, etc. — spawnSync never actually ran the
    // process, so result.status is null and stderr is empty; without this
    // check that would surface as a misleading "exited with code 1".
    throw new GitError(`failed to run git: ${result.error.message}`);
  }

  const stdout =
    typeof result.stdout === "string" ? result.stdout.trimEnd() : "";
  const stderr =
    typeof result.stderr === "string" ? result.stderr.trimEnd() : "";
  const status = result.status ?? 1;

  if (throwOnError && status !== 0) {
    const msg = stderr || `git ${args.join(" ")} exited with code ${status}`;
    throw new GitError(msg);
  }

  return { stdout, stderr, status };
}

/** git -C <cwd> <args…> */
export function gitC(cwd: string, args: string[]): GitResult {
  return git(["-C", cwd, ...args]);
}

/** git -C <cwd> <args…> — returns null on non-zero instead of throwing */
export function gitCTry(cwd: string, args: string[]): GitResult | null {
  const r = git(["-C", cwd, ...args], { throwOnError: false });
  return r.status === 0 ? r : null;
}
