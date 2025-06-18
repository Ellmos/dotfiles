alias shut='systemctl poweroff'
alias reboot='systemctl reboot'
alias :q='exit'
alias d='cd'

alias ls='ls --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias tree='tree -C'
alias c='clear'
alias cat='bat'

alias nv='nvim'
alias vim='nvim'
alias rmswap='rm -rf ~/.local/state/nvim/swap/*'
alias gdb='gdb -tui'
alias brave='brave-browser'

alias ga='git add .'
alias gc='git commit -m'
alias gt='git tag -ma'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gs='git status'
alias gl='git log'
alias glp='git log -p'
alias glog='git log --all --decorate --graph --oneline'
alias gd='git diff'

alias clangf='find $(git rev-parse --show-toplevel) -name "*.h" -o -name "*.c" -o -name "*.hh" -o -name "*.cc" -o -name "*.hxx"  | xargs clang-format -i'
alias gccc='gcc -Wextra -Wall -Werror -Wvla -std=c99 -pedantic -fsanitize=address -g -o main '
alias g+++='g++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '
alias clang+++='clang++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '

alias change-output='bash ~/.config/i3/scripts/change-output.sh'

alias py='python3'

alias delete-log='sudo find /var/log -mtime +30 -type f -delete'

alias reload='source ~/.zshrc'

alias make='make -j'

alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'

alias lint='yarn run eslint --fix'

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
