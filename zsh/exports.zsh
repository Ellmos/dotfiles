# function to add some path to $PATH and avoid duplicates on config reload
function add_to_path() {
    if ! echo $PATH | grep -q "$1"; then
        export PATH="$PATH:$1"
    fi
}

add_to_path "/home/elmos/Documents/dotfiles/bin"

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave-browser"

export MOUNETTE_TOKEN=82V9CocCZus_C77fnx7n

add_to_path "/usr/lib/postgresql/16/bin"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export DB_USERNAME=elmos

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LLVM_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

if [[ ! -r /home/elmos/.opam/opam-init/init.zsh ]] && ! echo $PATH | grep -q ".opam"; then
    source /home/elmos/.opam/opam-init/init.zsh  &> /dev/null
fi
