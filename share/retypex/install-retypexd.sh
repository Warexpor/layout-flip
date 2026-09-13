#!/usr/bin/env bash
# Build+install the patched retypexd used by layout-flip hotkeys.
# Survives reboot via systemd --user; survives pacman upgrades via ~/.local/bin.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
SRC_DAEMON="$ROOT/share/retypex/daemon.c"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/retypex"
UNIT_DROPIN="$HOME/.config/systemd/user/retypexd.service.d"

need() { command -v "$1" >/dev/null 2>&1 || { echo "need $1" >&2; exit 1; }; }
need gcc
need make
need systemctl

if [[ ! -f "$SRC_DAEMON" ]]; then
  echo "missing patched daemon: $SRC_DAEMON" >&2
  exit 1
fi

# Prefer already-cloned yay/src tree; else shallow clone.
BUILD_ROOT=""
for cand in \
  "$HOME/.cache/yay/retypex-git/src/retypex-git" \
  /tmp/retypex-build
do
  if [[ -f "$cand/Makefile" && -d "$cand/src" ]]; then
    BUILD_ROOT="$cand"
    break
  fi
done

if [[ -z "$BUILD_ROOT" ]]; then
  BUILD_ROOT="/tmp/retypex-build"
  rm -rf "$BUILD_ROOT"
  git clone --depth 1 https://github.com/Lyssten/retypex.git "$BUILD_ROOT"
fi

cp -a "$SRC_DAEMON" "$BUILD_ROOT/src/daemon.c"
make -C "$BUILD_ROOT" clean
make -C "$BUILD_ROOT" PREFIX=/usr

mkdir -p "$BIN_DIR" "$STATE" "$UNIT_DROPIN"
install -m 0755 "$BUILD_ROOT/retypexd" "$BIN_DIR/retypexd"
install -m 0755 "$BUILD_ROOT/retypex" "$BIN_DIR/retypex"
install -m 0755 "$ROOT/share/retypex/retypex-logged" "$BIN_DIR/retypex-logged"

cat >"$UNIT_DROPIN/local-bin.conf" <<EOF
[Service]
# Prefer the layout-flip patched daemon in ~/.local/bin (survives pacman upgrades).
ExecStart=
ExecStart=%h/.local/bin/retypexd
EOF

cat >"$UNIT_DROPIN/logging.conf" <<EOF
[Service]
StandardOutput=append:%h/.local/state/retypex/daemon.log
StandardError=append:%h/.local/state/retypex/daemon.log
SyslogIdentifier=retypexd
LimitCORE=infinity
Restart=on-failure
RestartSec=1
ExecStartPre=/usr/bin/bash -c 'printf "%%s PRESTART\\n" "\$(date -Is)" >>"%h/.local/state/retypex/daemon.log"'
ExecStopPost=/usr/bin/bash -c 'printf "%%s STOP result=%%s exit_code=%%s status=%%s\\n" "\$(date -Is)" "\$SERVICE_RESULT" "\$EXIT_CODE" "\$EXIT_STATUS" >>"%h/.local/state/retypex/daemon.log"'
EOF

systemctl --user daemon-reload
systemctl --user enable --now retypexd.service
systemctl --user restart retypexd.service

echo "Installed patched retypexd -> $BIN_DIR/retypexd"
systemctl --user is-active retypexd
systemctl --user show retypexd -p FragmentPath -p DropInPaths -p ExecStart --no-pager
