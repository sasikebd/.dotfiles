#!/bin/bash

# Custom function to create a new directory and navigate to it
function mkcd()
{
    mkdir -p "$1" && cd "$1"
}

# Custom function to count the number of files in a directory
function file_count() 
{
    local dir=$1
    local count=$(ls -1 "$dir" | wc -l)
    echo "Total files in $dir: $count"
}

#custom functions
function gclone() 
{
    git clone https://github.com/$1.git
}

#create file 
function createfile() 
{
    touch $1
    echo "# $1" >> $1
    echo "Created by: $USER" >> $1
}

# Function to add a Neovim configuration folder to the NVIM_CONFIGS array
function add_nvim_config() 
{
  if [ -z "$1" ]; then
    echo "Empty : Operation canceled"
    return
  fi
  local config_name=$1
  print_nvim_configs
  echo "configurationt to add: $config_name"
  NVIM_CONFIGS+=("$config_name")
  print_nvim_configs
  export NVIM_CONFIGS
}

# Function to remove a Neovim configuration folder from the NVIM_CONFIGS array
function remove_nvim_config() 
{
  echo "Available Neovim Configurations to Remove:"
  for i in "${!NVIM_CONFIGS[@]}"; do
    echo "$(($i + 1)). ${NVIM_CONFIGS[$i]}"
  done

  read -p "Enter the number or name of the configuration to remove (0 to cancel): " chosen_config

  if [ -z "$chosen_config" ]; then
    echo "Empty : Operation canceled"
    return
  fi

  if [[ $chosen_config == 0 ]]; then
    echo "Operation canceled."
    return
  fi

  # Check if the chosen configuration is a valid number
  if [[ $chosen_config =~ ^[0-9]+$ ]]; then
    local config_index=$((chosen_config - 1))
    if (( config_index >= 0 && config_index < ${#NVIM_CONFIGS[@]} )); then
      chosen_config=${NVIM_CONFIGS[$config_index]}
    else
      echo "Invalid input. Please enter a valid number."
      remove_nvim_config
      return
    fi
  fi

  # Check if the chosen configuration is valid
  if [[ " ${NVIM_CONFIGS[*]} " == *" $chosen_config "* ]]; then
    
    print_nvim_configs
    echo "removing config : $chosen_config"
    # remove element with space since it saved with a space at the first place
    NVIM_CONFIGS=("${NVIM_CONFIGS/ $chosen_config}")
    export NVIM_CONFIGS
    print_nvim_configs
  else
    echo "Invalid input. Please enter a valid configuration number or name."
    remove_nvim_config
  fi
}

function print_nvim_configs()
{
  echo "Available Neovim Configurations:"
  for i in "${!NVIM_CONFIGS[@]}"; do
    echo "${NVIM_CONFIGS[$i]}"
  done
}

# Function to show available Neovim configurations and set the chosen configuration
# switch nvim configuration
function swnvim() 
{
  echo "Available Neovim Configurations:"
  for i in "${!NVIM_CONFIGS[@]}"; do
    echo "$(($i + 1)). ${NVIM_CONFIGS[$i]}"
  done

  read -p "Enter the number or name of the configuration to set (0 to cancel): " chosen_config

  if [[ $chosen_config == 0 ]]; then
    echo "Operation canceled."
    return
  fi

  # Check if the chosen configuration is a valid number
  if [[ $chosen_config =~ ^[0-9]+$ ]]; then
    local config_index=$((chosen_config - 1))
    if (( config_index >= 0 && config_index < ${#NVIM_CONFIGS[@]} )); then
      chosen_config=${NVIM_CONFIGS[$config_index]}
    else
      echo "Invalid input. Please enter a valid number."
      swnvim 
      return
    fi
  fi

  # Check if the chosen configuration is valid
  if [[ " ${NVIM_CONFIGS[*]} " == *" $chosen_config "* ]]; then
    export NVIM_APPNAME="$chosen_config"
    echo "Set Neovim configuration to: $chosen_config"
  else
    echo "Invalid input. Please enter a valid configuration number or name."
    swnvim 
  fi
}

#set given nvim config to init state by clearing plugins
function init_nvim_config()
{
  echo "Available Neovim Configurations:"
  for i in "${!NVIM_CONFIGS[@]}"; do
    echo "$(($i + 1)). ${NVIM_CONFIGS[$i]}"
  done

  read -p "Enter the number or name of the configuration to set (0 to cancel): " chosen_config

  if [[ $chosen_config == 0 ]]; then
    echo "Operation canceled."
    return
  fi

  # Check if the chosen configuration is a valid number
  if [[ $chosen_config =~ ^[0-9]+$ ]]; then
    local config_index=$((chosen_config - 1))
    if (( config_index >= 0 && config_index < ${#NVIM_CONFIGS[@]} )); then
      chosen_config=${NVIM_CONFIGS[$config_index]}
    else
      echo "Invalid input. Please enter a valid number."
      init_nvim_config
      return
    fi
  fi

  # Check if the chosen configuration is valid
  if [[ " ${NVIM_CONFIGS[*]} " == *" $chosen_config "* ]]; then
    rm -rf "$HOME/.local/share/$chosen_config/"
    rm -rf "$HOME/.config/$chosen_config/plugin/"
    echo "Neovim configuration : $chosen_config is cleared"
  else
    echo "Invalid input. Please enter a valid configuration number or name."
    init_nvim_config
  fi 
}

# open tmux with my general window/pane setup
function tux()
{

  # window 1
  tmux new-session -d -s dev_s -n nvim_max

    # split the window in to multiple panes and start nvim in one
    tmux send-keys -t dev_s:nvim_max.0 'nvim' Enter

    #split pane horizontally and run another command in the new pane
    tmux split-window -h -t dev:nvim_max
    tmux send-keys -t dev_s:nvim_max.1 'cdtmux' Enter

  # window 2
  tmux new-window -t dev_s -n py
    #split the window horizontally
    tmux split-window -h -t dev_s:py
    tmux send-keys -t dev_s:py.0 'cdprog;nvim' Enter
  #  #split right pane to have two vertical panes
    #tmux split-window -v -t dev_s:py
    tmux send-keys -t dev_s:py.1 'cdgit' Enter

    #tmux split-window -v -t dev_s:py

  ##attach to the session 
  tmux attach-session -t dev_s
}

