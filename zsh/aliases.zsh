alias shut='systemctl poweroff'
alias reboot='systemctl reboot'
alias :q='exit'
alias d='cd'

alias ls='gls --color=auto'
alias la='gls -A --color=auto'
alias ll='gls -l --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias tree='tree -C -I ".git|node_modules|__pycache__"'
alias c='clear'
alias cat='bat'

alias nv='nvim'
alias vim='nvim'
alias nvimSwapDelete='rm -rf ~/.local/state/nvim/swap/*'
alias gdb='gdb -tui'
alias brave='brave-browser'

alias ga='git add .'
alias gc='git commit -S -m'
alias gt='git tag -ma'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gs='git status'
alias gl='git log'
alias glp='git log -p'
alias glog='git log --all --decorate --graph --oneline'
alias gd='git diff'
alias gds='git diff --staged'

alias clangf='find $(git rev-parse --show-toplevel) -name "*.h" -o -name "*.c" -o -name "*.hh" -o -name "*.cc" -o -name "*.hxx"  | xargs clang-format -i'
alias gccc='gcc -Wextra -Wall -Werror -Wvla -std=c99 -pedantic -fsanitize=address -g -o main '
alias g+++='g++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '
alias clang+++='clang++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '

alias py='python3'

alias reload='source ~/.zshrc'

alias make='make -j'

alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcubd='docker compose up --build -d'
alias dcd='docker compose down'
alias dps='docker ps'
alias dpsf='docker ps --format "table {{.Image}}\t{{.Names}}\t{{.Status}}"'

alias lint='yarn run eslint --fix'

alias plic="cd ~/Desktop/mti/plic"
alias front="cd ~/Desktop/mti/plic/front/PLIC-App"
alias back="cd ~/Desktop/mti/plic/back/"

alias k="kubectl"

# Not making binary out of this because it needs to change the cwd
function gccd() {
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: $0 <repo_url> [directory_name]"
        return 1
    fi

    REPO_URL="$1"
    DIR_NAME="$2"

    if [ "$#" -eq 1 ]; then
        DIR_NAME=$(basename "$REPO_URL" .git)
    fi

    git clone "$REPO_URL" "$DIR_NAME"

    if [ $? -eq 0 ]; then
        cd "$DIR_NAME"
    fi
}
