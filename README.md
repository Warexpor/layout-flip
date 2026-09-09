# layout-flip

Flip mistyped text between **English QWERTY** and **Russian ЙЦУКЕН** by physical key position — the classic “wrong layout” fix.

```text
z t,fk rf,fyf? ,kz  →  я ебал кабана, бля
Ghbdtn              →  Привет
```

## Install

```bash
./install.sh
```

Puts `layout-flip` on `~/.local/bin`. Needs `python3` plus a clipboard tool (`wl-clipboard` on Wayland, or `xclip` / `xsel` on X11).

For the selection hotkey you also need one of:

| Environment | Injector |
|-------------|----------|
| Hyprland    | `hyprctl` (built-in `send_key_state`) |
| Other Wayland | `wtype` |
| X11         | `xdotool` |

## Usage

```bash
layout-flip "z t,fk"          # print flipped text
echo "Ghbdtn" | layout-flip
layout-flip --clip            # flip clipboard in place
layout-flip --selection       # flip current highlight (for a hotkey)
```

### Hotkey flow

1. Select the mangled text (`Ctrl+A` or mouse).
2. Hit your bound chord (default suggestion: **Ctrl+Shift+X**).
3. The script silently copies → flips → pastes over the selection.

## Hyprland

**Omarchy / Lua** — add to `~/.config/hypr/bindings.lua` (see `share/hyprland/bindings.example.lua`):

```lua
o.bind(
  "CTRL + SHIFT + code:53",
  "Flip EN/RU layout typing",
  "layout-flip --selection"
)
```

`code:53` is the physical `X` key, so the bind still works when the RU layout is active (keysym would be `Ч`).

**Classic `.conf`** — see `share/hyprland/bind.conf.example`.

## Sway

See `share/sway/config.snippet`.

## Portability notes

- Core transform is pure Python — no DE required for CLI / `--clip`.
- `--selection` prefers Hyprland seat injection, then `wtype`, then `xdotool`.
- Clipboard restore after paste is best-effort and asynchronous.

## License

MIT
