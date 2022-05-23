.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = $0ee8

 * = * "Partial Charset"
CHARS: .import binary "../../assets/traff - Chars.bin"


* = $0dc0 "Sprites"
SPRITES: .import binary "../../assets/traffic - Sprites.bin"


* = $568 "Hard-coded Screen"
.import binary "../../assets/traff - MapArea (8bpc, 40x16).bin"
