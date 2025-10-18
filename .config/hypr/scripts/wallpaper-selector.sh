#!/bin/bash

WALLPAPER_DIR="$HOME/Imagens/wallpapers"
ROFI_CMD="rofi -dmenu -markup-rows -theme $HOME/.config/rofi/themes/wallpaper-selector.rasi"

generate_rofi_list() {
  find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | sort | while read -r F; do
    printf "%s\0icon\x1f%s\n" "$(basename "$F")" "$F"
  done
}
set_wallpaper() {
  local wallpaper_path="$1"
  [ -z "$wallpaper_path" ] && return 1
  ln -sfn "$wallpaper_path" "$HOME/.config/hypr/current_wallpaper"
  swww img "$wallpaper_path" --transition-type wipe

  wal -i "$wallpaper_path" -q && pywalfox update
  source "$HOME/.cache/wal/colors.sh"

  hyprctl keyword general:col.active_border "rgb(${color4#\#})"
  hyprctl keyword general:col.inactive_border "rgb(${color8#\#})"

  CAVA_CONF="$HOME/.config/cava/config"
  sed -i "s/gradient_color_1 = .*/gradient_color_1 = '${color1}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_2 = .*/gradient_color_2 = '${color2}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_3 = .*/gradient_color_3 = '${color3}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_4 = .*/gradient_color_4 = '${color4}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_5 = .*/gradient_color_5 = '${color5}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_6 = .*/gradient_color_6 = '${color6}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_7 = .*/gradient_color_7 = '${color7}'/" "$CAVA_CONF"
  sed -i "s/gradient_color_8 = .*/gradient_color_8 = '${color8}'/" "$CAVA_CONF"

  killall -SIGUSR2 waybar
  swaync-client -rs
  killall -SIGUSR1 cava

  notify-send "Wallpaper & Tema Alterados" "$(basename "$wallpaper_path")"
}
chosen_filename=$(generate_rofi_list | $ROFI_CMD)
[ -z "$chosen_filename" ] && exit 0
full_path=$(find "$WALLPAPER_DIR" -type f -name "$chosen_filename")
set_wallpaper "$full_path"
