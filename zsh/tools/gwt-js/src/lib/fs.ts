import * as fs from "fs";
import * as path from "path";

/**
 * Rewrite a one-line metadata file that stores an absolute path under oldRoot.
 * Mirrors rewrite_path_file() in the shell script.
 */
export function rewritePathFile(
  file: string,
  oldRoot: string,
  newRoot: string
): void {
  if (!fs.existsSync(file)) return;

  const content = fs.readFileSync(file, "utf8");
  const line = content.split("\n")[0];

  if (line.startsWith(`gitdir: ${oldRoot}`)) {
    const rest = line.slice(`gitdir: ${oldRoot}`.length);
    fs.writeFileSync(file, `gitdir: ${newRoot}${rest}\n`, "utf8");
  } else if (line.startsWith(oldRoot)) {
    const rest = line.slice(oldRoot.length);
    fs.writeFileSync(file, `${newRoot}${rest}\n`, "utf8");
  }
}

/**
 * Recursively find all files named `.git` under dir,
 * excluding the paths matching excludePaths.
 */
export function findGitFiles(dir: string, excludePaths: string[]): string[] {
  const results: string[] = [];

  function walk(current: string): void {
    let entries: fs.Dirent[];
    try {
      entries = fs.readdirSync(current, { withFileTypes: true });
    } catch {
      return;
    }

    for (const entry of entries) {
      const fullPath = path.join(current, entry.name);
      if (excludePaths.some((excl) => fullPath === excl || fullPath.startsWith(excl + path.sep))) {
        continue;
      }
      if (entry.isDirectory()) {
        walk(fullPath);
      } else if (entry.isFile() && entry.name === ".git") {
        results.push(fullPath);
      }
    }
  }

  walk(dir);
  return results;
}
