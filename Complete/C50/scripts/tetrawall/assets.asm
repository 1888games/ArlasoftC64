
.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = $0f64

 * = * "Chars"
CHARS: .import binary "../../assets/tetrawall - Chars.bin"


* = 3904 "Sprite"
SPRITES: .import binary "../../assets/tetra - Sprites.bin"
