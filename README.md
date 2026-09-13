# layout-flip

CLI utility to flip mistyped text between **English QWERTY** and **Russian ЙЦУКЕН** by physical key position.

```text
z t,fk rf,fyf? ,kz  →  я ебал кабана, бля
Ghbdtn              →  Привет
```

## Hotkeys on Hyprland: patched retypex

In-app correction uses a **patched [retypex](https://github.com/Lyssten/retypex)** daemon (evdev + uinput):

- `retypex sel` — flip selection (PRIMARY, or Ctrl+C → CLIPBOARD when PRIMARY is empty — Electron/Cursor)
- Waits for Ctrl/Shift to lift before inject so the chord does not eat keys
- Installed to `~/.local/bin/retypexd` and enabled as a **user systemd** unit (survives reboot; survives `pacman -Syu` overwriting `/usr/bin/retypexd`)

```bash
./install.sh
# or only the daemon:
./share/retypex/install-retypexd.sh
```

Needs: `retypex-git` build deps (`gcc`, `make`), user in `input` group, package udev rule for `/dev/uinput`.

Example bind: `share/hyprland/bindings.example.lua`

| Chord | Action |
|-------|--------|
| Ctrl+Shift+X | `retypex-logged sel` — flip selection |

Flow: mistype → Ctrl+A (or select) → Ctrl+Shift+X.

## CLI only

```bash
layout-flip "z t,fk"          # print flipped text
echo "Ghbdtn" | layout-flip
layout-flip --clip            # flip clipboard in place
```

Needs `python3` plus `wl-clipboard` (or `xclip` / `xsel`).

## License

MIT
