# Determine exact linux distro (only debian based supported at the moment), see https://askubuntu.com/a/459425
# If available, use LSB to identify distribution
if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
    DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
# Otherwise, use release info file
else
    DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
fi


# currently only Ubuntu or Debian supported (apt-get package manager)
if [ "$DISTRO" == "Ubuntu" ] || [ "$DISTRO" == "Debian" ]; then
    info "Running on Debian-based system. Using apt as package manager"
    res=`which apt &>/dev/null`
    if [[ $? != 0 ]]; then
        fail "Expected to have apt package manager on distro $DISTRO but didn't find it... Aborting."
    fi
else
    fail "Unsupported distro $DISTRO"
fi

# Request superuser rights for package installation
sudo apt update
sudo apt install direnv zsh -y

# Starship
test ! -f $(which starship) && curl -fsSL https://starship.rs/install.sh | bash
