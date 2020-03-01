#!/usr/bin/env zsh

# set default locale so zplug will work correctly
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

# Correct spelling for commands
setopt correct
unsetopt CASE_GLOB
setopt dotglob
# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin

# environment variables
source ~/.zshenv

# Fun with SSH
if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    # We're on OS X. Try to load ssh keys using pass phrases stored in
    # the OSX keychain.
    #
    # You can use ssh-add -K /path/to/key to store pass phrases into
    # the OSX keychain
    ssh-add -k
  fi
fi

if [ -f ~/.ssh/id_rsa ]; then
  if [ $(ssh-add -l | grep -c ".ssh/id_rsa" ) -eq 0 ]; then
    ssh-add ~/.ssh/id_rsa
  fi
fi

if [ -f ~/.ssh/id_dsa ]; then
  if [ $(ssh-add -L | grep -c ".ssh/id_dsa" ) -eq 0 ]; then
    ssh-add ~/.ssh/id_dsa
  fi
fi

# Now that we have $PATH set up and ssh keys loaded, configure zplug for zsh package management
source "${HOME}/.zplug/init.zsh" && zplug update
source "${HOME}/.zplug-packages"

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
# Share your history across all your terminal windows
setopt share_history

# set some more options
setopt pushd_ignore_dups

# Keep a ton of history.
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Customize to your needs...
# source functions
if [ -r ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# Stuff only tested on zsh, or explicitly zsh-specific
if [ -r ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
else
  echo "Could not read zsh_aliases file ... Is it actually located under ~/.zsh_aliases?"
fi

export LOCATE_PATH=/var/db/locate.database

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

echo
echo "Current SSH Keys:"
ssh-add -l
echo

# In case a plugin adds a redundant path entry, remove duplicate entries
# from PATH
#
# This snippet is from Mislav Marohnić <mislav.marohnic@gmail.com>'s
# dotfiles repo at https://github.com/mislav/dotfiles
dedupe_path() {
  typeset -a paths result
  paths=($path)

  while [[ ${#paths} -gt 0 ]]; do
    p="${paths[1]}"
    shift paths
    [[ -z ${paths[(r)$p]} ]] && result+="$p"
  done

  export PATH=${(j+:+)result}
}

# initialize direnv to automatically prepare environment when entering a directory
eval "$(direnv hook zsh)"

dedupe_path

# NVM Setup
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Forward SSH-Agent to docker (on Mac OS), see https://github.com/uber-common/docker-ssh-agent-forward
pinata-ssh-forward

# Starfish prompt
eval "$(starship init zsh)"
