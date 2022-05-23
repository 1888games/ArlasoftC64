.namespace ACTOR {
.namespace GHOST {


	Steer_GoingHome: {

		CheckArrived:


			lda TileY, x
			cmp #DOOR_TILE_Y
			bne NotHomeYet

			lda PixelX, x
			cmp #DOOR_PIXEL_X
			bne NotHomeYet

		AtDoorTile:

			lda #DIR_DOWN
			sta Direction, x
			
			lda #0
			sta Targeting, x

			lda #GHOST_ENTERING_HOME
			sta Mode, x
		

		ConfirmDirection:

			lda Direction, x
			sta NextDirection, x
			jsr SetDirectionFromEnum

		NotHomeYet:


		rts
	}

	Steer_EnteringHome: {

		lda PixelY, x
		cmp #HOME_BOTTOM_PIXEL
		bne NotSeatYet

		lda PixelX, x
		cmp Start_X, x
		bne SideStep


		Arrived:

			lda ENERGIZER.Scared
			beq NoSound

			jsr PlayEnergizer

			ldx ZP.GhostID

		NoSound:

			lda Arrived_Mode, x
			sta Mode, x

			lda #DIR_UP
			sta Direction, x
			jmp ConfirmDirection

		SideStep:

			bcc GoRight

		GoLeft:

			lda #DIR_LEFT
			sta Direction, x
			jmp ConfirmDirection


		GoRight:

			lda #DIR_RIGHT
			sta Direction, x

		ConfirmDirection:

			lda Direction, x
			sta NextDirection, x
			jsr SetDirectionFromEnum



		NotSeatYet:


		rts
	}

	Steer_LeavingHome: {


		lda PixelX, x
		cmp #DOOR_PIXEL_X
		bne Finish

		lda PixelY, x
		cmp #DOOR_PIXEL_Y
		beq TurnAtDoor

		lda #DIR_UP
		sta Direction, x
		jmp ConfirmDirection

		TurnAtDoor:

			lda #DIR_LEFT
			sta Direction, x

			lda #GHOST_OUTSIDE
			sta Mode, x

		ConfirmDirection:

			lda Direction, x
			sta NextDirection, x
			jsr SetDirectionFromEnum


		Finish:


		rts
	}

	LeaveHome: {


			lda #0
			sta SignalLeaveHome, x

			lda #GHOST_LEAVING_HOME
			sta Mode, x

			lda PixelX, x
			cmp #DOOR_PIXEL_X
			bne NotSetUp

			lda #DIR_UP
			sta Direction, x
	
			jmp ConfirmDirection

		NotSetUp:

			bcc GoRight

		GoLeft:

			lda #DIR_LEFT
			sta Direction, x
			jmp ConfirmDirection

		GoRight:

			lda #DIR_RIGHT
			sta Direction, x


		ConfirmDirection:

			jsr SetDirectionFromEnum
			lda Direction, x
			sta NextDirection, x


		rts
	}

	Steer_PacingHome: {

		lda SignalLeaveHome, x
		beq Pacing

		jmp LeaveHome

		
		Pacing:


			lda PixelY, x
			cmp #HOME_TOP_PIXEL
			beq GoDown

			cmp #HOME_BOTTOM_PIXEL
			beq GoUp

			rts

		GoDown:

			lda #DIR_DOWN
			sta Direction, x

			jmp ConfirmDirection

		GoUp:

			lda #DIR_UP
			sta Direction, x

		ConfirmDirection:

			jsr SetDirectionFromEnum
			lda Direction, x
			sta NextDirection, x


		rts
	}

	HomeSteer: {


		CheckGoingHome:

			lda Mode, x
			cmp #GHOST_GOING_HOME
			bne NotGoingHome

			jmp Steer_GoingHome

		NotGoingHome:

			cmp #GHOST_ENTERING_HOME
			bne NotEnteringHome

			jmp Steer_EnteringHome

		NotEnteringHome:

			cmp #GHOST_PACING_HOME
			bne NotPacingHome

			jmp Steer_PacingHome

		NotPacingHome:

			cmp #GHOST_LEAVING_HOME
			bne Finish

			jmp Steer_LeavingHome

		Finish:


		rts
	}
	

}
}