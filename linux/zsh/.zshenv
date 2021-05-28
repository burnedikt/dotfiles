export SHELL=/usr/bin/zsh
export PATH="$PATH:/mnt/c/Users/burnedikt/AppData/Local/Programs/Microsoft VS Code/bin"
export PATH="/home/burnedikt/.pyenv/bin:$PATH"
export PATH=/usr/local/go/bin:$PATH

export EDITOR='/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code --wait'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"