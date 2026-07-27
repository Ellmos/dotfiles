import * as path from "path";
import * as fs from "fs";

export function configDirPath(repoRoot: string): string {
  return path.join(repoRoot, ".gwt");
}

export function pwdMapFilePath(repoRoot: string): string {
  return path.join(configDirPath(repoRoot), "pwd-map");
}

export function ensureConfigDir(repoRoot: string): void {
  fs.mkdirSync(configDirPath(repoRoot), { recursive: true });
}

/**
 * Read the pwd-map file and return the stored relative path for wtName, or null.
 */
export function getWorktreePwd(
  repoRoot: string,
  wtName: string
): string | null {
  const mapFile = pwdMapFilePath(repoRoot);
  if (!fs.existsSync(mapFile)) return null;

  for (const line of fs.readFileSync(mapFile, "utf8").split("\n")) {
    const tab = line.indexOf("\t");
    if (tab === -1) continue;
    if (line.slice(0, tab) === wtName) {
      return line.slice(tab + 1) || null;
    }
  }
  return null;
}

/**
 * Upsert the pwd-map entry for wtName → relPath.
 */
export function setWorktreePwd(
  repoRoot: string,
  wtName: string,
  relPath: string
): void {
  ensureConfigDir(repoRoot);
  const mapFile = pwdMapFilePath(repoRoot);

  let lines: string[] = [];
  let updated = false;

  if (fs.existsSync(mapFile)) {
    lines = fs.readFileSync(mapFile, "utf8").split("\n");
    lines = lines.map((line) => {
      const tab = line.indexOf("\t");
      if (tab !== -1 && line.slice(0, tab) === wtName) {
        updated = true;
        return `${wtName}\t${relPath}`;
      }
      return line;
    });
  }

  if (!updated) lines.push(`${wtName}\t${relPath}`);

  // Remove trailing empty lines but keep a final newline
  const content = lines.filter((l, i) => l !== "" || i < lines.length - 1).join("\n") + "\n";
  fs.writeFileSync(mapFile, content, "utf8");
}

/**
 * Remove the pwd-map entry for wtName.
 */
export function unsetWorktreePwd(repoRoot: string, wtName: string): void {
  const mapFile = pwdMapFilePath(repoRoot);
  if (!fs.existsSync(mapFile)) return;

  const lines = fs.readFileSync(mapFile, "utf8").split("\n");
  const filtered = lines.filter((line) => {
    const tab = line.indexOf("\t");
    return !(tab !== -1 && line.slice(0, tab) === wtName);
  });
  fs.writeFileSync(mapFile, filtered.join("\n"), "utf8");
}
