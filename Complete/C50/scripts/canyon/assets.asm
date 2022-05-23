
.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = $0e60

 * = * "Chars"
CHARS: .import binary "../../assets/canyon - Chars.bin"


* =$0c00 "Sprites"
SPRITES: .import binary "../../assets/canyon - Sprites.bin"
