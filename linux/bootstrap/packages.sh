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
sudo apt install direnv zsh libffi-dev nodejs npm git-lfs -y

which pyenv || curl https://pyenv.run | bash
whch nvm || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install go
GO_VERSION=1.16.4.linux-amd64
GO_ARCHIVE=go$GO_VERSION.tar.gz
which go || (wget https://golang.org/dl/$GO_ARCHIVE && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_ARCHIVE && rm $GO_ARCHIVE)

# Install pipenv
pip install --user --upgrade pipenv