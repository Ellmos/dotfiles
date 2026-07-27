#!/usr/bin/env node
import { Command } from "commander";
import { GwtError } from "./lib/repo";
import { cmdClone } from "./commands/clone";
import { cmdAdd } from "./commands/add";
import { cmdCd } from "./commands/cd";
import { cmdConfig } from "./commands/config";
import { cmdDone } from "./commands/done";
import { cmdMove } from "./commands/move";
import { cmdRelocate } from "./commands/relocate";
import { cmdList } from "./commands/list";
import { zshCompletionScript } from "./completion/zsh";

/**
 * Wrapper to catch GwtError, print error + command usage, and exit with code 1.
 */
function handle(fn: (...args: any[]) => void): any {
  return function(this: any, ...args: any[]) {
    try {
      fn(...args);
    } catch (err) {
      if (err instanceof GwtError) {
        process.stderr.write(`error: ${err.message}\n`);
        // Print command usage if available (this is the Command object in commander)
        if (this && typeof this.helpInformation === "function") {
          process.stderr.write("\n");
          process.stderr.write(this.helpInformation());
        }
        process.exit(1);
      }
      throw err;
    }
  };
}

const program = new Command();

program
  .name("gwt")
  .description("Git worktree manager")
  .helpOption("-h, --help", "Show help")
  .addHelpCommand(false)
  // Suppress commander's own error output so we can format it ourselves
  .exitOverride()
  .configureOutput({ writeErr: () => undefined });

// ── --completion ─────────────────────────────────────────────────────────────

program
  .option("--completion <shell>", "Print shell completion script (supported: zsh)")
  .hook("preAction", (thisCommand) => {
    const opts = thisCommand.opts();
    if (opts.completion) {
      if (opts.completion === "zsh") {
        process.stdout.write(zshCompletionScript());
        process.exit(0);
      } else {
        process.stderr.write(`error: unsupported shell '${opts.completion}' (supported: zsh)\n`);
        process.exit(1);
      }
    }
  });

// ── clone ─────────────────────────────────────────────────────────────────────

program
  .command("clone <url> [folder]")
  .description("Clone a repo using the bare+worktree layout")
  .action(handle((url: string, folder?: string) => {
    cmdClone(url, folder);
  }));

// ── add ───────────────────────────────────────────────────────────────────────

program
  .command("add <name> [branch]")
  .description("Acquire a worktree from pool or create new (-c to create branch)")
  .option("-c", "Create a new branch")
  .option("-b <base>", "Base branch/commit for new branch (requires -c)")
  .action(handle((name: string, branch: string | undefined, opts: { c?: boolean; b?: string }) => {
    cmdAdd(name, branch, { createBranch: !!opts.c, base: opts.b });
  }));

// ── cd ────────────────────────────────────────────────────────────────────────

program
  .command("cd <name>")
  .description("Print absolute path of an active worktree")
  .action(handle((name: string) => {
    cmdCd(name);
  }));

// ── config ────────────────────────────────────────────────────────────────────

const configCmd = program
  .command("config <subcommand>")
  .description("Manage gwt config (edit / set)");

configCmd
  .command("edit [file]")
  .description("Open .gwt directory or a specific config file in editor")
  .action(handle((file?: string) => {
    cmdConfig("edit", file ? [file] : []);
  }));

configCmd
  .command("set <key> [value]")
  .description("Set a config key (supported: pwd)")
  .action(handle((key: string, value?: string) => {
    cmdConfig("set", value ? [key, value] : [key]);
  }));

// ── done ─────────────────────────────────────────────────────────────────────

program
  .command("done [path]")
  .description("Release current (or given) worktree back to pool")
  .action(handle((inputPath?: string) => {
    cmdDone(inputPath);
  }));

// ── move ─────────────────────────────────────────────────────────────────────

program
  .command("move <from> <to>")
  .description("Rename a worktree directory (branch unchanged)")
  .action(handle((from: string, to: string) => {
    cmdMove(from, to);
  }));

// ── relocate ──────────────────────────────────────────────────────────────────

program
  .command("relocate [src] <new>")
  .description("Rename/move the entire gwt repository folder")
  .action(handle((...args: unknown[]) => {
    // commander passes (src?, new, options, command) — collect positional args
    const positional = args.slice(0, -2) as Array<string | undefined>;
    const filtered = positional.filter((a): a is string => a !== undefined);
    cmdRelocate(filtered);
  }));

// ── list ─────────────────────────────────────────────────────────────────────

program
  .command("list")
  .description("Show active and idle (pooled) worktrees")
  .action(handle(() => {
    cmdList();
  }));

// ── entrypoint ────────────────────────────────────────────────────────────────

// Handle --completion before parsing sub-commands
const rawArgs = process.argv.slice(2);
if (rawArgs.includes("--completion")) {
  const idx = rawArgs.indexOf("--completion");
  const shell = rawArgs[idx + 1];
  if (shell === "zsh") {
    process.stdout.write(zshCompletionScript());
    process.exit(0);
  } else {
    process.stderr.write(
      `error: unsupported shell '${shell ?? ""}' (supported: zsh)\n`
    );
    process.exit(1);
  }
}

try {
  program.parse(process.argv);
} catch (err) {
  if (err instanceof GwtError) {
    process.stderr.write(`error: ${err.message}\n`);
    process.exit(1);
  }
  // Commander throws CommanderError for --help, unknown commands, etc.
  const ce = err as { code?: string; exitCode?: number; message?: string };
  if (typeof ce.code === "string" && ce.code.startsWith("commander.")) {
    // helpDisplayed / version have exitCode 0; errors have exitCode 1
    if (ce.code === "commander.helpDisplayed" || ce.code === "commander.version") {
      process.exit(ce.exitCode ?? 0);
    }
    if (ce.code === "commander.unknownCommand") {
      const cmd = (ce.message ?? "").match(/'([^']+)'/)?.[1] ?? "";
      process.stderr.write(`error: unknown command '${cmd}'\n`);
      process.exit(1);
    }
    process.exit(ce.exitCode ?? 1);
  }
  throw err;
}
