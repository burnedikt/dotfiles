#!/usr/bin/env zs

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

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

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

# Starfish prompt
eval "$(starship init zsh)"

### Added by Zinit's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# Load zinit plugins
if [[ -f $HOME/.zinit-plugins ]]; then
  source "$HOME/.zinit-plugins"
fi
