.namespace MAP {


	.label MAP_LOCATION = $b700


	* = MAP_LOCATION "-Maze Map"
	MazeMap:	.import binary "../assets/charpad/pacman - Map (28x36).bin"

	* = MAP_LOCATION + $0400 "-Maze Colours"
	MazeColours:	.fill 1024, 0


	.label KILL_MAP = $7B00

	* = KILL_MAP "-Kill Map"
	KillMap:	.import binary "../assets/charpad/pacman - Kill (28x36).bin"



	
}