#!/bin/bash

# default editor is nvim 
export EDITOR=nvim

# export $NVIM_APPNAME TO default
# this controls the sub-dir that nvim will read the config
export NVIM_APPNAME="nvim_sbd"

# export nvim config : initialize with vim 
export NVIM_CONFIGS=("nvim" "nvim_backup" "nvim_sbd")

# set node version manager directory 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

