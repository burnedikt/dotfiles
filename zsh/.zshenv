#!/usr/bin/env zsh

# Used for setting user's environment variables; it should not contain commands that produce output or assume
# the shell is attached to a tty. This file will always be sourced.
# see https://wiki.archlinux.org/index.php/zsh

echo -en "\r\033[K > .zshenv start"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# use sublime as default editor
export EDITOR='subl -w'

# path for Go lang packages
export GOPATH=/usr/local/lib/gocode

# include nvm
NVM_DIR="$HOME/.nvm"

# include anaconda (assuming its installed inthe correct path)
ANACONDA_DIR="$HOME/anaconda2/bin"

# include go
export PATH=$ANACONDA_DIR:$PATH:$NVM_DIR:$GOPATH/bin:/usr/local/opt/go/libexec/bin

# Open ssl stuff
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib

echo -en "\r\033[K > .zshenv end"
