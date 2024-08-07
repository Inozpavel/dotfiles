#!/usr/bin/bash

#paru -Sy > /dev/null

threshold_green=0
threshold_yellow=25
threshold_red=100

available_updates=$(paru -Qqu | wc -l)

css_class="green"

if [ "$available_updates" -gt $threshold_yellow ]; then
    css_class="yellow"
fi

if [ "$available_updates" -gt $threshold_red ]; then
    css_class="red"
fi

if [[ $LANG == 'ru_RU.UTF-8' ]]; then
  tooltip='Нажмите для обновления'
else
  tooltip='Click to update your system'
fi;

printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s"}' "$available_updates" "$available_updates" "$tooltip" "$css_class"
