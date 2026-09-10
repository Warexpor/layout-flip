# layout-flip

CLI utility to flip mistyped text between **English QWERTY** and **Russian ЙЦУКЕН** by physical key position.

```text
z t,fk rf,fyf? ,kz  →  я ебал кабана, бля
Ghbdtn              →  Привет
```

## Hotkeys on Hyprland: use retypex

The old clipboard/`wtype` hotkey approach is too unreliable on Wayland. For in-app correction, install and run **[retypex](https://github.com/Lyssten/retypex)** instead:

- Daemon reads keycodes via **evdev**, injects via **uinput**
- `retypex word` — erase last word, switch layout, retype same keys
- `retypex sel` — convert highlighted text

```bash
yay -S retypex-git
# uinput access (once): user in `input` group + udev rule from the package
systemctl --user enable --now retypexd
```

Example bind: `share/hyprland/bindings.example.lua`

| Chord | Action |
|-------|--------|
| Ctrl+Shift+X | `retypex sel` — flip highlighted text |

Flow: mistype → Ctrl+A (or select) → Ctrl+Shift+X.

Also worth knowing: **[gswitch](https://github.com/arumata/gswitch)** (double-Shift trigger, more polished packaging; not Hyprland-specific).

## Install (this CLI)

```bash
./install.sh
```

Needs `python3` plus `wl-clipboard` (or `xclip` / `xsel`).

## Usage

```bash
layout-flip "z t,fk"          # print flipped text
echo "Ghbdtn" | layout-flip
layout-flip --clip            # flip clipboard in place
```

## License

MIT
