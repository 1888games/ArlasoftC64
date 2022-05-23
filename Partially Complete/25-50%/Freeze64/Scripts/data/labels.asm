
.label ZERO= 					0
.label FALSE = 					0	
.label ALL_ON = 				255
.label TRUE = 					1


.label OBJ_INACTIVE = 0
	.label OBJ_FOOD = 1
	.label OBJ_BOMB = 2
	.label OBJ_SCORE = 3



.label FISH_GREEN = 0
.label FISH_RED = 1
.label FISH_BLUE = 2
.label FISH_YELLOW = 3
.label FISH_FROZEN = 8
.label NO_FISH = 255


.label PAL = 					0
.label NTSC =	 				1

.label GAME_MAP =				0
.label GAME_TITLE = 1


.label PROCESSOR_PORT = 		$01
.label INTERRUPT_VECTOR = 		$fffe
.label JOY_PORT_2 = 			$dc00

.label SCREEN_RAM = 			$c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


.label IRQControlRegister1 = 	$dc0d
.label IRQControlRegister2 = 	$dd0d

.label PLAYER_SELECT_COLUMN = 0
.label PLAYER_MOVE_FISH = 1
.label PLAYER_LAUNCH_FISH = 2



.label WHITE_MULT = 9
.label RED_MULT = 10
.label CYAN_MULT = 11
.label PURPLE_MULT = 12
.label GREEN_MULT = 13
.label BLUE_MULT = 14
.label YELLOW_MULT = 15

.label LEFT = 0
.label RIGHT = 1
.label DOWN = 2
.label UP = 3


.label NIL = 0
.label ONE = 1


.label GAME_MODE_TITLE = 0
.label GAME_MODE_INTERSTITION = 1
.label GAME_MODE_BURP = 2
.label GAME_MODE_PLAY = 3
.label GAME_MODE_OVER = 4
.label GAME_MODE_CLOSED = 5



// lda OverlayByte
// and %00000011
// sta FourthPair

// beq DoNothing

// tax

// lda SpriteByte
// and %11111100
// ora FourthPair
// sta SpriteByte


// lda OverlayByte
// and %00001100
// beq DoNothing

// tax

// lda SpriteByte
// and %11110011



















