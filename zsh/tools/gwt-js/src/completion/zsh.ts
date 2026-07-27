/**
 * Returns the complete _gwt zsh completion script as a string.
 * Run `gwt --completion zsh > completions/_gwt` to regenerate the checked-in file.
 */
export function zshCompletionScript(): string {
  return `#compdef gwt
# Auto-generated — do not edit.
# Regenerate with: gwt --completion zsh > completions/_gwt

# ---------------------------------------------------------------------------
# Zsh completion for gwt (git worktree manager)
# ---------------------------------------------------------------------------

_gwt() {
  local -a commands
  commands=(
    'clone:Clone a repo using the bare+worktree layout'
    'add:Acquire a worktree from pool or create new (-c to create branch)'
    'cd:Change to an active worktree'
    'config:Manage gwt config (edit/set)'
    'done:Release current worktree back to pool'
    'move:Rename a worktree directory (branch unchanged)'
    'relocate:Rename/move the entire gwt repository folder'
    'list:Show active and idle worktrees'
  )

  if (( CURRENT == 2 )); then
    _describe 'command' commands
    return
  fi

  case $words[2] in
    add)
      # After -b, always complete refs as the base value
      [[ $words[CURRENT-1] == '-b' ]] && { _gwt_branches; return }
      case $CURRENT in
        3)  _gwt_branches ;;   # <name>: suggest branch names as convenience
        4)  # <branch> or flag
            [[ $words[CURRENT] == -* ]] \\
              && _arguments '-c[create new branch]' '-b[base branch/commit]:base:_gwt_branches' \\
              || _gwt_branches ;;
        *)  _arguments '-c[create new branch]' '-b[base branch/commit]:base:_gwt_branches' ;;
      esac
      ;;
    cd)
      (( CURRENT >= 3 )) && _gwt_cd_targets
      ;;
    config)
      case $CURRENT in
        3) _gwt_config_subcommands ;;
        4)
          case $words[3] in
            edit) _gwt_config_files ;;
            set)  _gwt_config_keys ;;
          esac
          ;;
        *)
          [[ $CURRENT -ge 5 && $words[3] == 'set' && $words[4] == 'pwd' ]] && _gwt_config_pwd_paths
          ;;
      esac
      ;;
    done)
      (( CURRENT == 3 )) && _gwt_active_worktrees
      ;;
    move)
      if (( CURRENT == 3 )); then
        _gwt_active_worktrees
      elif (( CURRENT == 4 )); then
        _message 'new worktree name'
      fi
      ;;
    relocate)
      if (( CURRENT == 3 )); then
        _files -/
      elif (( CURRENT == 4 )); then
        _message 'new repository folder name/path'
      fi
      ;;
  esac
}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

_gwt_repo_root() {
  local common
  common=$(git rev-parse --git-common-dir 2>/dev/null) || return 1
  [[ "$common" != /* ]] && common="$(pwd)/$common"
  # :A = resolve to canonical absolute path, :h = dirname
  echo "\${common:A:h}"
}

_gwt_branches() {
  local repo_root
  local -a branches
  repo_root=$(_gwt_repo_root 2>/dev/null) || return

  branches=(\${(f)"$(
    git -C "$repo_root/.bare" for-each-ref \\
      --format='%(refname:short)' \\
      refs/heads refs/remotes/origin 2>/dev/null \\
    | sed 's|^origin/||' \\
    | grep -v '^HEAD$' \\
    | sort -u
  )"})

  (( \${#branches} )) && _describe 'branch' branches
}

_gwt_active_worktrees() {
  local repo_root pool_dir line wt_path rel
  local -a worktrees
  repo_root=$(_gwt_repo_root 2>/dev/null) || return
  pool_dir="$repo_root/.pool"

  while IFS= read -r line; do
    case "$line" in
      worktree\\ *)
        wt_path=\${line#worktree }
        case "$wt_path" in
          "$repo_root")
            continue
            ;;
          "$repo_root/.bare"|"$pool_dir"/*)
            continue
            ;;
          "$repo_root"/*)
            rel=\${wt_path#"$repo_root"/}
            worktrees+=("$rel")
            ;;
        esac
        ;;
    esac
  done < <(git -C "$repo_root/.bare" worktree list --porcelain 2>/dev/null)

  (( \${#worktrees} )) && compadd -Q -- "\${(@u)worktrees}"
}

_gwt_cd_targets() {
  local -a targets
  targets=(root)

  local -a active
  active=(\${(@f)"\$(_gwt_collect_active_worktrees)"})
  (( \${#active} )) && targets+=("\${active[@]}")

  compadd -Q -- "\${(@u)targets}"
}

_gwt_collect_active_worktrees() {
  local repo_root pool_dir line wt_path rel
  local -a worktrees
  repo_root=$(_gwt_repo_root 2>/dev/null) || return
  pool_dir="$repo_root/.pool"

  while IFS= read -r line; do
    case "$line" in
      worktree\\ *)
        wt_path=\${line#worktree }
        case "$wt_path" in
          "$repo_root"|"$repo_root/.bare"|"$pool_dir"/*)
            continue
            ;;
          "$repo_root"/*)
            rel=\${wt_path#"$repo_root"/}
            worktrees+=("$rel")
            ;;
        esac
        ;;
    esac
  done < <(git -C "$repo_root/.bare" worktree list --porcelain 2>/dev/null)

  printf '%s\\n' "\${worktrees[@]}"
}

_gwt_config_files() {
  local repo_root config_dir
  repo_root=$(_gwt_repo_root 2>/dev/null) || return
  config_dir="$repo_root/.gwt"

  # Existing files are suggested; new file names remain valid manual input.
  _files -W "$config_dir"
}

_gwt_config_subcommands() {
  local -a subcommands
  subcommands=(
    'edit:Open .gwt directory or a config file in editor'
    'set:Set a configuration value'
  )
  _describe 'config-subcommand' subcommands
}

_gwt_config_keys() {
  local -a keys
  keys=(
    'pwd:Set default directory used by gwt cd for current worktree'
  )
  _describe 'config-key' keys
}

_gwt_config_pwd_paths() {
  # Suggest existing directories; user can still type a new one manually.
  _files -/
}

_gwt "$@"
`;
}
