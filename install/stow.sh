#!/usr/bin/env zsh

# GNU stow is a symlink manager and can help us symlinking our dotfiles
res=`which -s stow`
if [[ $? != 0 ]]; then
  echo 'Installing GNU Stow'
  if [[ "$_platform" == "cygwin" ]]; then
    pact install stow
  elif [[ "$_platform" == "macos" ]]; then
    brew install stow
  else
    echo 'Your current platform is unsupported. Please manually install GNU stow before proceeding'
  fi
fi

# also find dotfiles with globs
setopt glob_dots
# remove / backup existing files if they are no links
for path_candidate in `ls -l ./{git,system,sandboxd,zsh}/*.* | awk -F '/' '{print $NF}'`
do
  expanded_path_candidate=~/"${path_candidate}"
  # only back up real files that are no symlinks
  if [[ ! -h ${expanded_path_candidate} && -f ${expanded_path_candidate} ]]; then
    echo "Backing up existing file ..."
    mv -v $expanded_path_candidate "${expanded_path_candidate}.bak"
  fi
done
# no longer glob dotfiles
unsetopt glob_dots
# now symlink the configuration files / dotfiles for zsh to our home folder
echo 'Symlinking global dotfiles'
  # symlink all files from system folder to home folder
  stow --verbose -t ~ system
echo 'Symlinking zsh dotfiles'
  # symlink all files from zsh folder to home folder
  stow --verbose -t ~ zsh
echo 'Symlinking sandboxed script'
  # symlink all files from sandboxd folder to home folder
  stow --verbose -t ~ --ignore=.example sandboxd
echo 'Symlinking global git files'
  # make sure to remove any defaults first
  # symlink all files from git folder to home folder
  stow --verbose -t ~ git
