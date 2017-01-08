#!/usr/bin/env bash
# check if choco is installed, if not so, inform the user that he should install it
res=`which choco &>/dev/null`
if [[ $? != 0 ]]; then
  fail "$(printf "You need to install %b%s%b first. Please refer to the readme and run install.ps1 in an elevated Powershell before running the install.sh script" $light_red "Chocolatey Package Manager" $reset_color)"
else
  success "$(printf "%b%s%b correctly installed. Packages need to be installed from elevated powershell" $light_green "Chocolatey Package Manager" $reset_color)"
fi
