#!/bin/bash
# User specific aliases 

#ls
alias ll='ls -alF'
alias lsd='ls -d */'
alias ldh='ls -d1'

#clear
alias cls='clear'

#chmod
alias chux='chmod u+x'
alias ch000='chmod 000'
alias ch640='chmod 640'
alias ch644='chmod 644'
alias ch755='chmod 755'
alias ch777='chmod 777'

#git
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gco='git checkout'
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gclone='git clone'

# grep 
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Go to project directory
alias cdh='cd ~/'
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
alias cdtmux='cd ~/.tmux/'

#other open commands
alias initlua='nvim ~/.config/nvim_sbd/init.lua'
alias bashrc='nvim ~/.bashrc'
alias bashd='nvim ~/.bashrc.d'
alias alses='nvim ~/.bashrc.d/aliases.sh'
alias btips='nvim ~/work/btips.sh'
alias todos='nvim ~/work/todos.txt'

#clear 
alias clr='clear'

#source ~/.bashrc
alias ssbash='source ~/.bashrc'

#tmux
alias ntux='nvim ~/.tmux/tmux.conf'
alias tdh='tmux detach'
alias tls='tmux ls'
alias tks='tmux kill-session "$@"'
alias tksa='tmux kill-session -a'

# Start development server
alias devserver='cd ~/Projects/myapp && npm start'

# Docker aliases
alias dcls='docker ps -a'
alias dcstop='docker stop $(docker ps -aq)'
alias dcrm='docker rm $(docker ps -aq)'
alias dcrmimg='docker rmi $(docker images -q)'

# File search
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
