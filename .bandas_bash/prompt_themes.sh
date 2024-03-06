#!/bin/bash

source $HOME/.bandas_bash/color_pallet.sh

# color protocol for theming of the prompt
# p.s-> A /B stands for COL_A , COL_B naming 
# p.s-> C-D stands for gradient color range
# --------------------------Line_1----------------------------------------------
# ______________________________________________________________________________
# Info      | ┌user@hostname  |▶| workdir | git branch | git status     | time 
# ______________________________________________________________________________
# background|  A              |C|   C-D   |  E         |  Reffer COL_ST |   A 
# foreground|  B              |A|   B     |  F         |    BLOCK        |   B
# ______________________________________________________________________________
#
# --------------------------Line_2----------------------------------------------
# Info      | └-➤$   
# foreground|  A 
# background|  B 
# ______________________________________________________________________________
#
# --------------------------Git Status Colors-----------------------------------
# COL_GST_CLEAN              # clean repository
# COL_GST_STAGED             # changes staged to commit
# COL_GST_CHANGED            # cahnges unstaged
# COL_GST_UNSTAGED_UNTRACKED # untracked files
# COL_GST_AHEAD              # changes ahead of remotDEe
# COL_GST_BEHIND             # changes behind remote
# ______________________________________________________________________________
#######################################################################

# Theme : Kalawewa (blue & greanery view)
 declare -A THEME_KALAWEWA=(
  [COL_A]=$DARK_GREEN
  [COL_B]=$WHITE
  [COL_C]=$DEEP_SKY_BLUE_6
  [COL_D]=$DODGER_BLUE_2
  [COL_E]=$BLACK  
  [COL_F]=$RED 
  [COL_G]=$YELLOW 
  [COL_GIT_CLEAN]=$LIME
  [COL_GIT_STAGED]=$ORANGE_1
  [COL_GIT_CHANGED]=$RED
  [COL_GIT_UNSTAGED_UNTRACKED]=$MAGENTA_1
  [COL_GIT_AHEAD]=$AQUA
  [COL_GIT_BEHIND]=$PINK_3
)
