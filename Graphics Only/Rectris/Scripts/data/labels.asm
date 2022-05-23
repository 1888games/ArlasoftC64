
.label ZERO= 					0
.label FALSE = 					0	
.label ALL_ON = 				255
.label TRUE = 					1


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


.label WHITE_MULT = 9
.label RED_MULT = 10
.label CYAN_MULT = 11
.label PURPLE_MULT = 12
.label GREEN_MULT = 13
.label BLUE_MULT = 14
.label YELLOW_MULT = 15

.label LEFT_MASK = 1
.label RIGHT_MASK = 2
.label DOWN_MASK = 4
.label UP_MASK= 8

.label LEFT = 0
.label RIGHT = 1
.label DOWN = 2
.label UP = 3




.label NIL = 0
.label ONE = 1


.label GAME_MODE_TITLE = 0
.label GAME_MODE_PLAY = 1
.label GAME_MODE_OVER = 2
	


.label GRID_EMPTY = 0
.label GRID_RED = 1
.label GRID_GREEN = 2
.label GRID_BLUE = 3
.label GRID_YELLOW = 4

.label GRID_ARROW_DOWN = 16
.label GRID_ARROW_DOWN_RIGHT = 17
.label GRID_ARROW_RIGHT = 18
.label GRID_ARROW_RIGHT_UP = 19
.label GRID_ARROW_UP = 20
.label GRID_ARROW_UP_LEFT = 21
.label GRID_ARROW_LEFT = 22
.label GRID_ARROW_LEFT_DOWN = 23
















