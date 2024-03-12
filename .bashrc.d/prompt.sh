#!/bin/bash

source $HOME/.bandas_bash/prompt_themes.sh

## prompt color theme
declare -A P_THEME

#color reset
COLOR_RESET='\e[0m'

#apply color theme
#currently expect theme has followed the protocol
#if not it is error prone
for key in "${!THEME_KALAWEWA[@]}"; do
  P_THEME["$key"]="${THEME_KALAWEWA["$key"]}"
done

# Define color variables
BG_PREFIX="\[\e[48;5;"
FG_PREFIX="\[\e[38;5;"
COL_POSTFIX="m\]"

#ASCII BOX CHARS
top_left="┌"
top_right="┐"
bottom_left="└"
bottom_right="┘"
horizontal="─"
vertical="│"
seperator=$vertical

#background color set 
function BG()
{
  local _color="$1"
  local _out_color="${BG_PREFIX}${_color}${COL_POSTFIX}"
  echo -e "${_out_color}" 
}

#foreground color set
function FG()
{
  local _color="$1"
  local _out_color="${FG_PREFIX}${_color}${COL_POSTFIX}"
  echo -e "${_out_color}" 
}

#foreground + background set
function BG_FG()
{ 
  local _color_bg="$1"
  local _color_fg="$2"
  local _out_color=$(BG $_color_bg)$(FG $_color_fg)
  echo -e "${_out_color}" 
}

# Function to get Git branch name
function git_branch()
{
    local branch_name
    if [ "$PWD" = "$HOME" ]; then
      # my home is the work dir of --bare .dotfiles git repo
      branch_name=$(dgit branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    else
      branch_name=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    fi
    [[ -n "$branch_name" ]] && echo "[$branch_name]" 
}

# Function to get Git status
function git_status()
{
    local status
    if [ "$PWD" = "$HOME" ]; then
      # my home is the work dir of --bare .dotfiles git repo
      status="$(dgit status --porcelain  2>/dev/null)"
    else
      status="$(git status --porcelain  2>/dev/null)"
    fi

    if [[ $? -eq 0 ]]; then
      case "$status" in 
        '')   echo -e "$(FG ${P_THEME[COL_GIT_CLEAN]})✅";;              # Clean repository
        *?)   echo -e "$(FG ${P_THEME[COL_GIT_CHANGED]})⚡";;            # Untracked changes
        M*)   echo -e "$(FG ${P_THEME[COL_GIT_CHANGED]})✱★";;            # Changes not staged for commit
        ??*)  echo -e "$(FG ${P_THEME[COL_GIT_STAGED]})✔"$;;             # Changes staged for commit
        M*A*) echo -e "$(FG ${P_THEME[COL_GIT_UNSTAGED_UNTRACKED]})✚";;  # Untracked and unstaged changes
        ??*)  echo -e "$(FG ${P_THEME[COL_GIT_CHANGED]})✱";;             # Changes not staged for commit
        '*')  echo -e "$(FG ${P_THEME[COL_GIT_UNSTAGED_UNTRACKED]})⚡";; # Other Untracked changes
        U*)   echo -e "$(FG ${P_THEME[COL_GIT_AHEAD]})▲";;               # Changes ahead of remote
        D*)   echo -e "$(FG ${P_THEME[COL_GIT_BEHIND]})▼";;              # Changes behind remote
      esac
    else
        echo "" # Not a Git repository
    fi
}

#sets gradient background between 
#two colors for given text
# $1 = textToGradient
# $2 = start background color
# $3 = end background color
# $4 = foreground color
function text_colorize_gradient_bg() 
{
  local text=$1            # text to colorize

  local start_color=0;     # start color
  local end_color=255;     # end color

  if [[ $3 -gt $2 ]]; then 
    start_color=$2      
    end_color=$3        
  else
    start_color=$3      
    end_color=$2        
  fi

  local foreground_color=$4 # foreground color
  local length=${#text}
  local output=""
  local step=$((( end_color - start_color)/ length ))
  local color=$start_color
  local dispText="$text"

  if [[ $length -eq 0 ]]; then 
    length=1
  fi

  if [[ $step -eq 0 ]]; then 
    step=1
  fi  

  for(( i=0; i<$length; i++ )); do
    local char="${dispText:$i:1}"
    local tempColor=$(( color + step ))
    if [[ tempColor -ge $end_color  ]]; then 
      color=$end_color
    else
      color=$tempColor
    fi 

    local current_color="$(BG_FG $color $foreground_color)"
    output="${output}${current_color}${char}"	
  done

  output+=${COLOR_RESET}
  echo -e ${output}
}

# color protocol for theming of the prompt
# p.s-> A /B stands for COL_A , COL_B naming 
# p.s-> C-D stands for gradient color range
# --------------------------Line_1----------------------------------------------
# ______________________________________________________________________________
# Info      | ┌user@hostname  |▶| workdir | git branch | git status     | time 
# ______________________________________________________________________________
# background|  A              |C|   C-D   |  E         |  E             |   A 
# foreground|  B              |A|   B     |  F         |  G             |   B
# ______________________________________________________________________________
#
# --------------------------Line_2----------------------------------------------
# Info      | └-➤$   
# foreground|  A 
# background|  B 
# ______________________________________________________________________________
#
#######################################################################

function left_block()
{
  local user_at_host="$USER@$HOSTNAME"
  local work_dir="$PWD"

  local p1_userhost="$(BG_FG ${P_THEME[COL_A]} ${P_THEME[COL_B]})$user_at_host"
  local p2_seperator="$(BG_FG ${P_THEME[COL_C]} ${P_THEME[COL_A]})$seperator"
  local p3_workdir=$(text_colorize_gradient_bg $work_dir ${P_THEME[COL_C]} ${P_THEME[COL_D]} ${P_THEME[COL_B]})

  echo -e "\n${top_left}${p1_userhost}${p2_seperator}${p3_workdir}${COLOR_RESET}"	
}

function middle_block()
{
  echo -e "$(BG_FG ${P_THEME[COL_E]} ${P_THEME[COL_F]})$(git_branch)$(BG_FG ${P_THEME[COL_E]} ${P_THEME[COL_G]})$(git_status)${COLOR_RESET}"
}

function right_block()
{
  local time_disp="$(BG_FG ${P_THEME[COL_A]} ${P_THEME[COL_B]})⌚$(date +%H:%M)${COLOR_RESET}"
  echo -e "${time_disp}$(FG ${P_THEME[COL_B]})\n${bottom_left}${horizontal}\$${COLOR_RESET}"
}

function update_prompt() 
{
  PS1="$(left_block)$(middle_block)$(right_block)"
}

# main  routine
# -----------------
#set terminal type specifics
case "$TERM" in 
  xterm|rxvt*)
    #simple terminal for xterm/rxvt
     seperator="➤"
     ;;
  xterm-256color)
     seperator="▶"
    #gnome-terminal, put more info
    ;;
  gnome*)
     seperator="▶"
    #gnome-terminal, put more info
    ;;
  *)
    #for other prompt set basic prompt
    seperator=""
    ;;
esac

# below set the refresh capable :)
PROMPT_COMMAND="update_prompt" 
