#!/bin/bash

# Define color variables
COLOR_RESET='\e[0m'
COLOR_BOLD='\e[1m'
COLOR_ITALIC='\e[3m'
COLOR_DIM='e[1m'
COLOR_RED='\e[31m'
COLOR_GREEN='\e[32m'
COLOR_YELLOW='\e[33m'
COLOR_BLUE='\e[34m'

# foreground + background colors
F_LIGHTCYAN_B_DARKBLUE="\e[96;44m"
F_LIGHTBLUE_B_DARDKCYAN="\033[94;46m"

F_RED_B_BLACK="\e[31;40m"
F_GREEN_B_BLACK="\e[32;40m"
F_YELLOW_B_BLACK="\e[33;40m"
F_CYAN_B_BLACK="\e[33;40m"
F_ORANGE_B_BLACK="\e[38;5;208m"

F_WHITE_B_BLUE="\e[37;44m"
F_WHITE_B_CYAN="\e[37;46m"
F_WHITE_B_MAGENTA="\e[97;45m"
F_WHITE_B_RED="\e[97;41m"
F_WHITE_B_GREEN="\e[37;42m"
F_WHITE_B_YELLOW="\e[97;43m"

## Function to get Git status
function git_status_ {
    local status
    status=$(git status 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        if [[ -n $(git status -s) ]]; then
            echo " ⚡ Untracked changes" # Untracked changes
        elif [[ -n $(git diff --cached) ]]; then
            echo " ✔" # Changes staged for commit
        elif [[ -n $(git ls-files --other --exclude-standard) ]]; then
            echo " ✚" # Untracked files
        elif [[ -n $(git diff) ]]; then
            echo " ✱" # Changes not staged for commit
        elif [[ -n $(git log --branches --not --remotes) ]]; then
            echo " ⬆" # Changes ahead of remote
        elif [[ -n $(git log --remotes --not --branches) ]]; then
            echo " ⬇" # Changes behind remote
        else
    :        echo "✓" # Clean repository
        fi
    else
        echo "" # Not a Git repository
    fi
}


# Function to get Git branch name
function git_branch {
    local branch_name
    if [ "$PWD" = "$HOME" ]; then
      # my home is the work dir of --bare .dotfiles git repo
      branch_name=$(dotgit branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    else
      branch_name=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    fi
    [[ -n "$branch_name" ]] && echo "$F_RED_B_BLACK [$branch_name]" 
}

# Function to get Git status
function git_status {
    local status
    if [ "$PWD" = "$HOME" ]; then
      # my home is the work dir of --bare .dotfiles git repo
      status="$(dotgit status --porcelain  2>/dev/null)"
    else
      status="$(git status --porcelain  2>/dev/null)"
    fi

    if [[ $? -eq 0 ]]; then
      case "$status" in 
        '')   echo -e "$F_GREEN_B_BLACK✅";; # Clean repository
        *?)   echo -e "$F_YELLOW_B_BLACK⚡";; # Untracked changes
        M*)   echo -e "$F_RED_B_BLACK✱ ★";; # Changes not staged for commit
        ??*)  echo -e "$F_ORANGE_B_BLACK✔"$;;# Changes staged for commit
        M*A*) echo -e "$F_WHITE_B_YELLOW✚";; # Untracked and unstaged changes 
        ??*)  echo -e "$F_WHITE_B_YELLOW✱";; # Changes not staged for commit
        '*')  echo -e "$F_WHITE_B_YELLOW⚡";; # Other Untracked changes
        M*)   echo -e "$F_WHITE_B_YELLOW✱";; # Changes not staged for commit
        U*)   echo -e "$F_WHITE_B_YELLOW⬆";; # Changes ahead of remote
        D*)   echo -e "$F_WHITE_B_YELLOW⬇";;# Changes behind remote
      esac
    else
        echo "" # Not a Git repository
    fi
}

##configure left block of the prompt
function set_left_block(){

  echo -e "TODO \n "

}

#configure right block of the prompt
function set_right_block()
{
  echo -e "ToODO\n "
}

#
# update the prompt
function update_prompt() 
{
  #PS1="${F_WHITE_B_BLUE}\u@\h ${F_LIGHTCYAN_B_DARKBLUE}\w${F_WHITE_B_RED}$(git_branch)${F_YELLOW_B_BLACK}$(git_status)${F_YELLOW_B_BLACK}\n➤➤ \$ ${COLOR_RESET}"
  #PS1="${F_WHITE_B_BLUE}\u@\h ${F_LIGHTCYAN_B_DARKBLUE}\w${F_WHITE_B_RED}$(git_branch)${COLOR_RESET}$(git_status)${F_YELLOW_B_BLACK}\n➤➤ \$ ${COLOR_RESET}"
  PS1="${B_CYAN}\u@\h ${F_LIGHTCYAN_B_DARKBLUE}\w${F_WHITE_B_RED}$(git_branch)${COLOR_RESET}$(git_status)${F_YELLOW_B_BLACK}\n➤➤ \$ ${COLOR_RESET}"
}

# refresh prompt and set prompt
PROMPT_COMMAND="update_prompt" 
