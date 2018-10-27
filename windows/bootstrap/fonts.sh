#!/usr/bin/env bash

# this is the directory in which this file resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# check if fonts are maybe already installed
check_res=`powershell -ExecutionPolicy Bypass "'${DIR}/check-fonts.ps1'"`
# exit code will be 1 if not installed yet
if [[ $? == 1 ]]; then
  info "$check_res"
  # if not installed yet, install now
  powershell -ExecutionPolicy Bypass "${DIR}/../../fonts/install.ps1"
  success "$(printf "%bPowerline%b fonts successfully installed" $light_green $reset_color)"
else
  warn "$check_res"
fi
