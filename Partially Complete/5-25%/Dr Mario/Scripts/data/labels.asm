
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

.label SUBTUNE_BLANK = 0

.label GAME_MODE_PLAY = 0


.label CELL_YELLOW = 0
.label CELL_RED = 1
.label CELL_BLUE = 2

.label VIRUS_ADD = 4

.label VIRUS_YELLOW = VIRUS_ADD + CELL_YELLOW
.label VIRUS_RED = VIRUS_ADD + CELL_RED
.label VIRUS_BLUE = VIRUS_ADD + CELL_BLUE

