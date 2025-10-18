#!/bin/bash

ICON="" # Ícone do Spotify (requer Nerd Fonts)

PLAYER_STATUS=$(playerctl status -p spotify 2>/dev/null)

if [[ "$PLAYER_STATUS" == "Playing" ]]; then
  TITLE=$(playerctl metadata title -p spotify)

  OUTPUT="$ICON - $TITLE"
  MAX_LENGTH=25

  if [ ${#OUTPUT} -gt $MAX_LENGTH ]; then
    OUTPUT="${OUTPUT:0:$MAX_LENGTH}…"
  fi

  printf '{"text": "%s", "tooltip": "%s - %s", "class": "spotify"}\n' "$OUTPUT" "$ARTIST" "$TITLE"

else
  echo ""
fi
