.namespace ACTOR {

	* = * "-Lookup"

	Start_X:		
	Pacman_X:	.byte (14 * TILE_SIZE) - 1
	Blinky_X:	.byte (14 * TILE_SIZE) - 1
	Pinky_X:	.byte (14 * TILE_SIZE) - 1
	Inky_X:		.byte (12 * TILE_SIZE) - 1
	Clyde_X:	.byte (16 * TILE_SIZE) - 1

	Start_Y:		
	Pacman_Y:	.byte (26 * TILE_SIZE) + MID_TILE_Y
	Blinky_Y:	.byte (14 * TILE_SIZE) + MID_TILE_Y
	Pinky_Y:	.byte (17 * TILE_SIZE) + MID_TILE_Y
	Inky_Y:		.byte (17 * TILE_SIZE) + MID_TILE_Y
	Clyde_Y:	.byte (17 * TILE_SIZE) + MID_TILE_Y

	Start_Dir:	
	Pacman_Dir:	.byte DIR_LEFT
	Blinky_Dir:	.byte DIR_LEFT
	Pinky_Dir:	.byte DIR_UP
	Inky_Dir:	.byte DIR_UP
	Clyde_Dir:	.byte DIR_UP

	StartLook:	
	Pacman_Di:	.byte DIR_LEFT
	Blinky_Di:	.byte DIR_LEFT
	Pinky_Di:	.byte DIR_DOWN
	Inky_Di:	.byte DIR_UP
	Clyde_Di:	.byte DIR_UP

	CornerTileX:
	Pacman_CnrX:	.byte 0
	Blinky_CnrX:	.byte 28-1-2
	PinkyCnrX:		.byte 2
	InkyCnrX:		.byte 28-1
	ClydeCnrX:		.byte 0

	CornerTileY:
	Pacman_CnrY:	.byte 0
	Blinky_CnrY:	.byte 0
	Pinky_CnrY:		.byte 0
	Inky_CnrY:		.byte 36-2
	Clyde_CnrY:		.byte 36-2

	Start_Mode:
	Pacman_Mode:	.byte 0
	Blinky_Mode:	.byte GHOST_OUTSIDE
	Pinky_Mode:		.byte GHOST_PACING_HOME
	Inky_Mode:		.byte GHOST_PACING_HOME
	Clyde_Mode:		.byte GHOST_PACING_HOME

	Arrived_Mode:
	Pacman_Arr:		.byte 0
	Blinky_Arr:		.byte GHOST_LEAVING_HOME
	Pinky_Arr:		.byte GHOST_PACING_HOME
	Inky_Arr:		.byte GHOST_PACING_HOME
	Clyde_Arr:		.byte GHOST_PACING_HOME







}