
	* = * "Game"

	InitGameVars: {

			L6ED8:  lda #$02                //Prepare to start wave 1 with 4 asteroids (+2 later).
			L6EDA:  sta AstPerWave          //

			L6EDD:  ldx #$03                //Is the DIP switches set for 3 ships per game?
			//L6EDF:  lsr CentCMShipsSw       //
			//L6EE2:  bcs InitShipsPerGame    //If so, branch.

			//L6EE4:  inx                     //4 ships per game.

			//InitShipsPerGame:
			L6EE5:  stx ShipsPerGame        //Load initial ships to start this game with.

			L6EE7:  lda #$00                //Prepare to zero variables.
			L6EE9:  ldx #$03                //

		VarZeroloop:
		
			L6EEB:  sta ShipStatus,X        //
			L6EEE:  sta ShpShotTimer,X      //
			L6EF1:  sta PlayerScores,X      //Zero out ship Status, saucer Status and player scores.
			L6EF3:  dex                     //
			L6EF4:  bpl VarZeroloop         //

			L6EF6:  sta CurAsteroids        //Zero out current number of asteroids.
			L6EF9:  rts                     //


	}



