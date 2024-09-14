#! /bin/bash
#
activewindow=$(hyprctl activewindow | grep initialTitle | awk '{print $2}')

echo $activewindow

pico=$(hyprctl clients -j | grep -E '"address":| "$activewindow:')

echo $pico
