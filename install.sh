#!/usr/bin/env bash
# Install layout-flip CLI + patched retypexd (Hyprland hotkeys).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
mkdir -p "$BIN_DIR"

install -m 0755 "$ROOT/bin/layout-flip" "$BIN_DIR/layout-flip"
install -d "$PREFIX/lib/layout-flip"
install -m 0644 "$ROOT/bin/layout_flip_core.py" "$PREFIX/lib/layout-flip/layout_flip_core.py"
install -m 0644 "$ROOT/bin/layout_flip_core.py" "$BIN_DIR/layout_flip_core.py"

echo "Installed: $BIN_DIR/layout-flip (CLI / --clip only)"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    echo "Note: $BIN_DIR is not on PATH. Add it, e.g.:"
    echo "  export PATH=\"$BIN_DIR:\$PATH\""
    ;;
esac

echo
echo "Installing patched retypexd (user systemd, ~/.local/bin)..."
"$ROOT/share/retypex/install-retypexd.sh"

echo
echo "Hyprland bind example — share/hyprland/bindings.example.lua"
echo "  Ctrl+Shift+X → retypex-logged sel (flip highlighted / Ctrl+A text)"
