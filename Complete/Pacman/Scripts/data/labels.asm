
.label ZERO= 					0
.label FALSE = 					0	
.label ALL_ON = 				255
.label TRUE = 					1
	.label MASTER_SCREEN = $a000
	.label MASTER_COLOUR = $a500


.label PAL = 					0
.label NTSC =	 				1

.label GAME_MAP =				0
.label GAME_TITLE = 1


.label PROCESSOR_PORT = 		$01
.label INTERRUPT_VECTOR = 		$fffe
.label JOY_PORT_2 = 			$dc00

.label SCREEN_RAM = 			$c000
.label SCREEN_RAM_2 = 			$f400

.label SPRITE_POINTERS = SCREEN_RAM + $3f8
.label SPRITE_POINTERS_2 = SCREEN_RAM_2 + $3f8


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

.label DIR_UP = 0
.label DIR_LEFT = 1
.label DIR_DOWN = 2
.label DIR_RIGHT = 3


.label PACMAN = 0
.label BLINKY = 1
.label PINKY = 2
.label INKY = 3
.label CLYDE = 4

.label TILE_SIZE = 8

.label TILE_EMPTY = 0
.label TILE_PELLET = 16
.label TILE_PILL = 32
.label TILE_WALL = 48


.label NIL = 0
.label ONE = 1


.label GAME_MODE_TITLE = 0
.label GAME_MODE_PLAY = 1
.label GAME_MODE_OVER = 2
.label GAME_MODE_DEAD = 3
.label GAME_MODE_READY = 4
.label GAME_MODE_EATEN = 5
.label GAME_MODE_INTERMISSION = 6
.label GAME_MODE_COMPLETE = 7

.label INTERMISSION_TITLE = 0
.label INTERMISSION_ONE = 1
.label INTERMISSION_TWO = 2

.label MID_TILE_X = 3
.label MID_TILE_Y = 4




.label GHOST_OUTSIDE = 0;
.label GHOST_EATEN = 1;
.label GHOST_GOING_HOME = 2;
.label GHOST_ENTERING_HOME = 3;
.label GHOST_PACING_HOME = 4;
.label GHOST_LEAVING_HOME = 5;


.label GHOST_SCATTER = 1
.label GHOST_CHASE = 0






