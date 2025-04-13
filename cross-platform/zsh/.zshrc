#!/usr/bin/env zsh

# Load zi, successor to zinit, see https://wiki.zshell.dev/docs/getting_started/installation
source "$HOME/.zi/bin/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands

# SSH and GPG must be loaded prior to the p10k instant prompt
zi snippet OMZ::plugins/gpg-agent/gpg-agent.plugin.zsh
zi snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Uncomment following line if you want red dots to be displayed while waiting for completion
#export COMPLETION_WAITING_DOTS="true"

# Correct spelling for commands
setopt correct
unsetopt CASE_GLOB
setopt dotglob
# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"

# environment variables
if [ -r ~/.zshenv ]; then
  source ~/.zshenv
else
  echo "Could not read zshenv file ... Is it actually located under ~/.zshenv?"
fi

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

# initialize direnv to automatically prepare environment when entering a directory
eval "$(direnv hook zsh)"

# Initialize pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Load zi plugins
if [[ -f $HOME/.zi-plugins ]]; then
  source "$HOME/.zi-plugins"
fi

# Force rehash of completions
autoload -Uz compinit && compinit

# NVM Setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
