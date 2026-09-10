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

> **Hyprland:** never call `os.execute` / block on clipboard from a bind handler — that freezes the compositor. Use the Lua example (`hl.exec_cmd` + timers) or bind `layout-flip --selection` for other WMs.

**Omarchy / Lua** — copy `share/hyprland/bindings.example.lua` into `~/.config/hypr/bindings.lua`.

That snippet injects Ctrl+C / Ctrl+V via Hyprland Lua (`send_key_state`), then runs `layout-flip --clip`. Do not bind bare `layout-flip --selection` on Hyprland — bash `hyprctl send_key_state` is unreliable.

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
