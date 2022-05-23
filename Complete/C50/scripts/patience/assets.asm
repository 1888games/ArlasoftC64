
.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


* = $0d68

 * = * "Chars"
CHARS: .import binary "../../assets/patience - Chars.bin"


* = $0d00 "Sprite"
SPRITES: .import binary "../../assets/hand - Sprites.bin"
