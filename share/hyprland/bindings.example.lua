-- Flip highlighted text EN↔RU (select with Ctrl+A, then this chord).
-- code:53 is the physical X key so it still matches on the RU layout.
o.bind(
  "CTRL + SHIFT + code:53",
  "Flip EN/RU layout typing",
  "layout-flip --selection"
)
