#!/bin/bash

# Define color variables
COLOR_RESET='\e[0m'
COLOR_BOLD='\e[1m'
COLOR_RED='\e[31m'
COLOR_GREEN='\e[32m'
COLOR_YELLOW='\e[33m'
COLOR_BLUE='\e[34m'

PS1="${COLOR_BOLD}${COLOR_GREEN}\u@\h ${COLOR_BLUE}\w ${COLOR_RED}\$  ${COLOR_RESET}"

# Function to get Git branch name
function git_branch {
    local branch_name=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if [[ -n "$branch_name" ]]; then
        echo "[$branch_name]" 
    fi
}

# Function to get Git status
function git_status {
    local status
    status=$(git status 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        if [[ -n $(git status -s) ]]; then
            echo " ⚡" # Untracked changes
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
            echo " ✓" # Clean repository
        fi
    else
        echo "" # Not a Git repository
    fi
}


# customize prompt
PS1="${COLOR_BOLD}${COLOR_GREEN}\u@\h ${COLOR_BLUE}\w${COLOR_RESET}$(git_branch)${COLOR_YELLOW}$(git_status)${COLOR_RESET}\$ "
