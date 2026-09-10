-- Flip highlighted text EN↔RU (select with Ctrl+A, then this chord).
-- NEVER use os.execute/io.popen in a Hyprland bind — it blocks the compositor.
local LAYOUT_FLIP = (os.getenv("HOME") or "") .. "/.local/bin/layout-flip"

local function send_shortcut_once(mods, key)
  hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
  hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
  end, { timeout = 25, type = "oneshot" })
end

local function flip_en_ru_selection()
  send_shortcut_once("CTRL", "C")
  hl.timer(function()
    hl.exec_cmd(LAYOUT_FLIP .. " --clip")
    hl.timer(function()
      send_shortcut_once("CTRL", "V")
    end, { timeout = 70, type = "oneshot" })
  end, { timeout = 45, type = "oneshot" })
end
-- code:53 = physical X (still matches on RU layout).
o.bind("CTRL + SHIFT + code:53", "Flip EN/RU layout typing", flip_en_ru_selection)
