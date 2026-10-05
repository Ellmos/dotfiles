import * as fs from "fs";
import * as path from "path";

/**
 * Rewrite a one-line metadata file that stores an absolute path under oldRoot.
 * Mirrors rewrite_path_file() in the shell script.
 * Returns true if the file existed and was rewritten, false otherwise —
 * callers use this to detect metadata that didn't match the expected shape.
 */
export function rewritePathFile(
  file: string,
  oldRoot: string,
  newRoot: string
): boolean {
  if (!fs.existsSync(file)) return false;

  const content = fs.readFileSync(file, "utf8");
  const line = content.split("\n")[0];

  if (line.startsWith(`gitdir: ${oldRoot}`)) {
    const rest = line.slice(`gitdir: ${oldRoot}`.length);
    fs.writeFileSync(file, `gitdir: ${newRoot}${rest}\n`, "utf8");
    return true;
  } else if (line.startsWith(oldRoot)) {
    const rest = line.slice(oldRoot.length);
    fs.writeFileSync(file, `${newRoot}${rest}\n`, "utf8");
    return true;
  }
  return false;
}
