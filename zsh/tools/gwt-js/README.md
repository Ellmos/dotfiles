# gwt-js — Git Worktree Manager CLI (TypeScript)

This directory contains the TypeScript/Node.js rewrite of the original POSIX shell `gwt` script, providing better modularity and maintainability.

## Setup

```bash
npm install
npm run build
```

This compiles the TypeScript source to `dist/` using the CommonJS module format.

## Structure

- **src/index.ts** — CLI entry point; registers all commands with `commander`
- **src/lib/** — Reusable utilities:
  - `git.ts` — Safe git subprocess wrappers (uses `spawnSync` with arg arrays, never shell strings)
  - `repo.ts` — Repo root detection, worktree introspection, pool slot management
  - `config.ts` — Worktree pwd-map file management (CRUD)
  - `fs.ts` — Path rewriting for relocate; recursive `.git` file discovery
- **src/commands/** — Command implementations (one file per command):
  - `clone.ts`, `add.ts`, `cd.ts`, `config.ts`, `done.ts`, `move.ts`, `relocate.ts`, `list.ts`
- **src/completion/** — Shell completion script generation
  - `zsh.ts` — Generates the full `_gwt` zsh completion script

## Usage

```bash
# Build the project
npm run build

# Test the CLI
node dist/index.js --help
node dist/index.js list

# Generate zsh completions (checked in to ../../../completions/_gwt)
node dist/index.js --completion zsh
```

## Dependencies

- **commander** — CLI argument parsing and command registration
- **chalk** — Terminal colors (replaces raw ANSI escapes in `list` output)

## Development

```bash
# Watch mode (requires ts-node installed globally or via npx)
npx ts-node src/index.ts --help
```

## Comparison to Shell Version

The TypeScript version maintains **exact behavioral compatibility** with the original POSIX shell script while providing:

- **Modularity** — Each command and utility is in its own file
- **Type safety** — Full TypeScript strict mode
- **Better error handling** — Structured error classes with clear messages
- **Security** — All git commands use `spawnSync(cmd, args[])` to prevent shell injection
- **Maintainability** — Easier to debug, extend, and test

The shell script (`../../bin/gwt`) now acts as a thin wrapper that delegates to `dist/index.js`, so all existing shell aliases and completion functions continue to work unchanged.
