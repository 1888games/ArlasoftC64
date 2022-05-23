.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = $0f18

 * = * "Chars"
CHARS: .import binary "../../assets/froo - Chars.bin"


* = $0e00 "Sprite"
SPRITES: .import binary "../../assets/zoop - Sprites.bin"
