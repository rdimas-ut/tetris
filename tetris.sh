#!/bin/bash

RED='\033[0;31m'
COLOROFF='\033[0m'
BLOCK='\xE2\x96\x88'
SQUARE="$RED${BLOCK}${BLOCK}"
printf "${SQUARE}${SQUARE}\n  ${SQUARE}${SQUARE}"

escape_char=$(printf "\u1b")
while true
do 
read -rsn1 mode

if [[ "$mode == $escape_char" ]]; then
  read -rsn2 mode
fi

case $mode in
  '[A') echo UP;;
  '[B') echo DOWN;;
  '[D') echo LEFT;;
  '[C') echo RIGHT;;
esac
done
