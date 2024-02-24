#!/bin/bash

# User specific aliases 
# Custom aliases
alias ll='ls -alF'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gco='git checkout'
alias dotGit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# grep 
alias grep='grep --color=auto'

# Go to project directory
alias cddown='cd ~/Downloads'
alias cdwork='cd ~/work/'
alias cdgit='cd ~/work/01_git'
alias cdscript='cd ~/work/02_scripts'
alias cdprog='cd ~/work/03_prog'
alias cdconfig='cd ~/.config'
alias cdlocal='cd ~/.local/'
alias cdshare='cd ~/.local/share'
alias cdlocalnvim='cd ~/.local/share/nvim_sbd'
alias cdnvim='cd ~/.config/nvim_sbd/'

#other open commands
alias initlua='nvim ~/.config/nvim_sbd/init.lua'
alias bashrc='nvim ~/.bashrc'
alias bashd='nvim ~/.bashrc.d'
alias alses='nvim ~/.bashrc.d/aliases.sh'
alias btips='nvim ~/work/btips.sh'

#clear 
alias clr='clear'

#source ~/.bashrc
alias ssbash='source ~/.bashrc'

# Start development server
alias devserver='cd ~/Projects/myapp && npm start'

# Docker aliases
alias dcls='docker ps -a'
alias dcstop='docker stop $(docker ps -aq)'
alias dcrm='docker rm $(docker ps -aq)'
alias dcrmimg='docker rmi $(docker images -q)'

# File search
#alias ffind='find . -name'
#search from /
alias findfr='sudo find / -type f -name'
alias finddr='sudo find / -type d -name'

# serch in home
alias findfh='find ~/. -type f -name'
alias finddh='find ~/. -type d -name'

# search in current dir
alias findfc='find . -type f -name'
alias finddc='find . -type d -name'

# Network utils
alias myip='curl ifconfig.me'

#encrypt using openssl
alias encPass='sudo openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -salt -out $1'

#decrypt using openssl 
alias decFile='sudo openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -in $1'

#prog
alias py="python3"
