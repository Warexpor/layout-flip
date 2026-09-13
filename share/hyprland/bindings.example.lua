-- Select text (e.g. Ctrl+A), then flip EN↔RU by key position via retypex.
-- code:53 = physical X (still matches on RU layout).
-- Press bind (not release): release order of Ctrl/Shift/X is unreliable.
-- Patched retypexd: wait for chord up, PRIMARY or Ctrl+C→CLIPBOARD, then Ctrl+V.
o.bind(
  "CTRL + SHIFT + code:53",
  "Flip EN/RU selection",
  (os.getenv("HOME") or "") .. "/.local/bin/retypex-logged sel"
)
