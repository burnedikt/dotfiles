#!/usr/bin/env zsh

# Used for setting user's environment variables; it should not contain commands that produce output or assume
# the shell is attached to a tty. This file will always be sourced.
# see https://wiki.archlinux.org/index.php/zsh

echo -en "\r\033[K > .zshenv start"

source ~/.env

echo -en "\r\033[K > .zshenv end"
