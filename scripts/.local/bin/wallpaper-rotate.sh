#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers/static"

while true; do
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
	swww img "$WALLPAPER" --transition-type simple --transition-step 1 --transition-fps 30
    sleep 120
done
