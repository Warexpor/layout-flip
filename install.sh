#!/usr/bin/env bash
# Install layout-flip into ~/.local/bin (override with PREFIX).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
mkdir -p "$BIN_DIR"

install -m 0755 "$ROOT/bin/layout-flip" "$BIN_DIR/layout-flip"

echo "Installed: $BIN_DIR/layout-flip"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    echo "Note: $BIN_DIR is not on PATH. Add it, e.g.:"
    echo "  export PATH=\"$BIN_DIR:\$PATH\""
    ;;
esac

echo
echo "Hyprland (Omarchy Lua) — add to ~/.config/hypr/bindings.lua:"
echo
cat "$ROOT/share/hyprland/bindings.example.lua"
echo
echo "Classic Hyprland bind — see share/hyprland/bind.conf.example"
echo "Sway — see share/sway/config.snippet"
echo
echo "Dependencies: python3, wl-clipboard (Wayland) or xclip/xsel (X11)."
echo "Selection hotkey also needs Hyprland, or wtype / xdotool."
