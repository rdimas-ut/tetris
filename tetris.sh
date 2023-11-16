#!/bin/bash

# Colors
CYAN='\033[0;36m'
BLUE='\033[0;34m'
ORANGE='\033[0;37m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
COLOROFF='\033[0m'

# Play Area
wall=('<!' ' .' ' .' ' .' ' .' ' .' ' .' ' .' ' .' ' .' ' .' '!>' $'\n')
floor=('<!' '==' '==' '==' '==' '==' '==' '==' '==' '==' '==' '!>' $'\n')
foundation=('<!' '\/' '\/' '\/' '\/' '\/' '\/' '\/' '\/' '\/' '\/' '!>' $'\n')
for i in {0..19}; do play_area+=("${wall[@]}"); done
play_area+=("${floor[@]}")
play_area+=("${foundation[@]}")

# Score,Lines, & Level
pad='                    '
score_text=('      SCORE: ' '0' '      ')
lines_text=('      LINES: ' '0' '      ')
level_text=('      LEVEL: ' '0' '      ')
top_box='   xxxxxxxxxxxxxx   '
side_box=('  ' ' x' '  ' '  ' '  ' '  ' '  ' '  ' 'x ' '  ')
for i in {0..3}; do inside_box+=("${side_box[@]}"); done
score=0
lines=0
level=0

# Shape
current_shape=(4 5 6 18)
current_shape_color=$PURPLE

# Shapes
BLOCK='\xE2\x96\x88'

LINE="$CYAN${BLOCK}\n${BLOCK}\n${BLOCK}\n${BLOCK}"
SQUARE="$RED${BLOCK}${BLOCK}$COLOROFF"

# Frame Buffer
frame_buffer=""

# printf "${SQUARE}${SQUARE}\n  ${SQUARE}${SQUARE}"
# printf '\n'
# printf '%s' "${play_area[@]}"
# printf "${play_area[10]}"


# escape_char=$(printf "\u1b")
# while true
# do 
# read -srn1 cmd

# if [ $cmd == $escape_char ]; then
#   read -srn2 cmd
# elif [ $cmd == 'W' ] || [ $cmd == 'A' ] || [ $cmd == 'S' ] || [ $cmd == 'D' ]; then
#   printf ""
# elif [ $cmd == 'w' ] || [ $cmd == 'a' ] || [ $cmd == 's' ] || [ $cmd == 'd' ]; then
#   printf ""
# fi

update_frame() {
  while true; do
    sleep 0.1

    for i in ${current_shape[@]}; do
      play_area[$i]=$'\033[0;36m\xE2\x96\x88\xE2\x96\x88\033[0m'
    done    

    printf '\n'
    printf '%s' "${play_area[@]}"
    printf '\n'
  done
}

input() {
  local escape_char=$(printf "\u1b")
  local update_play_area=("${play_area[@]}")
  while true; do
    read -s -r -n 1 cmd

    if [ "$cmd" == $escape_char ]; then
      read -srn2 cmd
    elif [ "$cmd" == 'W' ] || [ "$cmd" == 'A' ] || [ "$cmd" == 'S' ] || [ "$cmd" == 'D' ]; then
      printf ""
    elif [ "$cmd" == 'w' ] || [ "$cmd" == 'a' ] || [ "$cmd" == 's' ] || [ "$cmd" == 'd' ]; then
      cmd_down
      printf "The down keays has been presse"
    fi

    update_play_area=("${play_area[@]}")
    for i in ${current_shape[@]}; do
      update_play_area[$i]=$'\033[0;36m\xE2\x96\x88\xE2\x96\x88\033[0m'
    done    

    printf '\n'
    printf '%s' "${update_play_area[@]}"
    printf '\n'
  done
}

screen() {
  local escape_char=$(printf "\u1b")
  local update_play_area=("${play_area[@]}")
  while true; do
    read -s -r -n 1 cmd

    if [ "$cmd" == $escape_char ]; then
      read -srn2 cmd
    elif [ "$cmd" == 'W' ] || [ "$cmd" == 'A' ] || [ "$cmd" == 'S' ] || [ "$cmd" == 'D' ]; then
      printf cmd
    elif [ "$cmd" == 'w' ] || [ "$cmd" == 'a' ] || [ "$cmd" == 's' ] || [ "$cmd" == 'd' ]; then
      cmd_down
    fi

    update_play_area=("${play_area[@]}")
    for i in ${current_shape[@]}; do
      update_play_area[$i]=$'\033[0;36m\xE2\x96\x88\xE2\x96\x88\033[0m'
    done    

    printf '\n'
    printf '%s' "${update_play_area[@]}"
    printf '\n'
  done
}

cmd_down() {
  for i in "${!current_shape[@]}"; do
    current_shape[$i]=$((13 + current_shape[$i]))
  done
}

ticker() {
    while true; do printf 's'; sleep 1; done
}
 
# case $cmd in
#   '[A') echo $cmd;;
#   '[B') echo $cmd;;
#   '[D') echo $cmd;;
#   '[C') echo $cmd;;
#   # '^[') echo $cmd;;
#   'W') echo $cmd;;
#   'A') echo $cmd;;
#   'S') echo $cmd;;
#   'D') echo $cmd;;
#   'w') echo $cmd;;
#   'a') echo $cmd;;
#   's') echo $cmd;;
#   'd') echo $cmd;;
# esac
#done



# (
#   ticker &
#   input
# )|(
#   update_frame
# )
ticker|input

# while true;do
#   update_frame
# done
