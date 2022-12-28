#!/bin/bash

i3status --config ~/.config/i3status/config | while :
do
    read line
    #LG=$(setxkbmap -query | awk '/layout/{print $2}')
    LG=$(xkblayout-state print %s | awk '{print toupper($0)}')
    if [ $LG == "US" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
