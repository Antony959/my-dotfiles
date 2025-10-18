#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/waybar/themes"

TARGET_CONFIG="$HOME/.config/waybar/config.jsonc"
TARGET_STYLE="$HOME/.config/waybar/style.css"

TEMP_STYLE="$HOME/.config/waybar/temp_style.css"

mapfile -t THEMES < <(find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | sort)

if [ ${#THEMES[@]} -eq 0 ]; then
  notify-send "Rofi Waybar" "Nenhum tema encontrado em $THEMES_DIR"
  exit 1
fi

CHOICE=$(printf '%s\n' "${THEMES[@]}" | rofi -theme-str 'window {width: 500px;}' -dmenu -p "")

if [ -z "$CHOICE" ]; then
  exit 0
fi

THEME_PATH="$THEMES_DIR/$CHOICE"
NEW_CONFIG="$THEME_PATH/config.jsonc"
NEW_STYLE="$THEME_PATH/style.css"

if [ ! -f "$NEW_CONFIG" ] || [ ! -f "$NEW_STYLE" ]; then
  notify-send "Rofi Waybar" "Arquivos config.jsonc ou style.css faltando em $THEME_PATH"
  exit 1
fi

cat <<EOF >"$TEMP_STYLE"
@import "$TARGET_STYLE";
window#waybar {
    transition: opacity 0.5s ease-in-out;
    opacity: 0;  /* Fade out */
}
EOF

ln -sf "$TEMP_STYLE" "$TARGET_STYLE"
pkill -USR2 waybar # Reload style sem reiniciar full

sleep 0.5

cp -f "$TARGET_CONFIG" "$TARGET_CONFIG.bak"
cp -f "$TARGET_STYLE" "$TARGET_STYLE.bak"

ln -sf "$NEW_CONFIG" "$TARGET_CONFIG"
ln -sf "$NEW_STYLE" "$TARGET_STYLE"

pkill waybar
waybar &

rm "$TEMP_STYLE"

notify-send "Waybar-Theme" "Tema '$CHOICE' aplicado"
