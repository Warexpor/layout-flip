-- Select text (e.g. Ctrl+A), then flip EN↔RU by key position via retypex.
-- code:53 = physical X (still matches on RU layout).
-- Press bind (not release): release order of Ctrl/Shift/X is unreliable.
-- Patched retypexd waits for chord keys up, then clipboard+Ctrl+V.
o.bind("CTRL + SHIFT + code:53", "Flip EN/RU selection", "retypex sel")
