
.label ZERO= 					0
.label FALSE = 					0	
.label ALL_ON = 				255
.label ONE=						1
.label TRUE = 					1



.label PAL = 					0
.label NTSC =	 				1

.label GAME_MAP =				0


.label PROCESSOR_PORT = 		$01
.label INTERRUPT_VECTOR = 		$fffe
.label JOY_PORT_2 = 			$dc00

.label SCREEN_RAM = 			$c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


.label IRQControlRegister1 = 	$dc0d
.label IRQControlRegister2 = 	$dd0d


.label WHITE_MULT = 9
.label RED_MULT = 10
.label CYAN_MULT = 11
.label PURPLE_MULT = 12
.label GREEN_MULT = 13
.label BLUE_MULT = 14
.label YELLOW_MULT = 15

.label LEFT = 0
.label RIGHT = 1
.label DOWN = 1
.label UP = 0


.label GAME_MODE_TITLE = 0
.label GAME_MODE_PRE_STAGE = 1
.label GAME_MODE_ATTRACT = 2
.label GAME_MODE_PLAY = 3
.label GAME_MODE_OVER = 4
.label GAME_MODE_SWITCH_TITLE = 5



.label HAT = 0
.label EYES = 1
.label EARS = 2
.label NOSE = 4
.label MOUTH = 5
.label HEAD = 6
.label COLOUR = 7


.label NUM_HATS = 8
.label NUM_EYES = 16
.label NUM_EARS = 8
.label NUM_NOSES = 8
.label NUM_MOUTHS = 8
.label NUM_HEADS = 4
.label NUM_COLOURS = 8

// 10101010

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



















