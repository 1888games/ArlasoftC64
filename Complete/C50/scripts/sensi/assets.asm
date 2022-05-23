.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = $0E40

 * = * "Partial Charset"
CHARS: .import binary "../../assets/sensi4k_2 - Chars.bin"

* = $1fa

CHAR_COLORS: .import  binary "../../assets/sensi4k_2 - CharAttribs.bin"


* = $0d00 "Sprites"
SPRITES: .import binary "../../assets/sensi_2k_4 - Sprites.bin"


* = 1024 "Hard-coded Screen"
.import binary "../../assets/sensi4k_2 - MapArea (8bpc, 40x25).bin"
