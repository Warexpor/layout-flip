-- Select text (e.g. Ctrl+A), then flip EN↔RU by key position via retypex.
-- code:53 = physical X (still matches on RU layout).
-- Prefer press bind; retypexd should wait for Ctrl/Shift up before wtype
-- (release binds are unreliable with modifier chord release order).
o.bind("CTRL + SHIFT + code:53", "Flip EN/RU selection", "retypex sel")
