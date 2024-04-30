alias shut='systemctl poweroff'
alias reboot='systemctl reboot'
alias :q='exit'

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
alias glog="git log --all --decorate --graph --oneline"
alias clangf='find $(git rev-parse --show-toplevel) -name "*.h" -o -name "*.c" -o -name "*.hh" -o -name "*.cc" -o -name "*.hxx"  | xargs clang-format -i'

alias gccc='gcc -Wextra -Wall -Werror -Wvla -std=c99 -pedantic -fsanitize=address -g -o main '
alias g+++='g++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '
alias clang+++='clang++ -Wall -Wextra -Werror -pedantic -std=c++20 -Wold-style-cast -fsanitize=address -g -o main '


alias banquise='sudo tailscale up && sudo swanctl -q && sudo swanctl -i --child banquise'
alias bluetooth='sudo hciconfig hci0 down && sudo rmmod btusb && sudo modprobe btusb && sudo hciconfig hci0 up && sudo bluetoothctl'

alias change-output='bash ~/.config/i3/scripts/change-output.sh'

alias py='python3.11'
alias up='nmcli con up'

alias delete-log='sudo find /var/log -mtime +30 -type f -delete'

alias myfind='~/Desktop/ing1/myfind/myfind/myfind'
alias 42sh='~/Desktop/ing1/42sh/69sh/src/42sh'

alias reload='source ~/.zshrc'

alias 69='cd ~/Desktop/ing1/42sh/69sh'

alias make='make -j'
alias tc="/home/elmos/Desktop/ing1/tiger/miau-rawr/src/tc"
