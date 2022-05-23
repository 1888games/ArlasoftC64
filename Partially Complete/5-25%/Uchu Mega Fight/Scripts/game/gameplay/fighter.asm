.label STATE_IDLE = 0

.label P1 = 0
.label P2 = 1

.namespace FIGHTER {



	PosX_LSB:		.byte 0, 0
	PosX_MSB:		.byte 0, 0
	PosX_Frac:		.byte 0, 0

	PosY:			.byte 0, 0
	PosY_Frac:		.byte 0, 0




	Facing:			.byte 0, 0
	State:			.byte 0, 0
	AI:				.byte 0, 0





	.label PlayerOne_X = 120
	.label PlayerTwo_X = 220

	.label GroundY = 160




	Reset: {

		lda #PlayerOne_X
		sta PosX_LSB + P1

		lda #PlayerTwo_X
		sta PosX_LSB + P2


		lda #GroundY
		sta PosY + P1
		sta PosY + P2 

		lda #0
		sta PosX_MSB + P1
		sta PosX_MSB + P2
		sta Facing + P1

		lda #1
		sta Facing + P2


		lda #127
		sta PosX_Frac + P1
		sta PosX_Frac + P2
		sta PosY_Frac + P1
		sta PosY_Frac + P2

		jsr SetupSprites



		rts
	}



	FrameUpdate: {

		ldx #0


		Loop:

			stx ZP.PlayerID

			jsr Control	
			jsr UpdateAnimation
			jsr CalculatePositions


		EndLoop:


			ldx ZP.PlayerID
			inx 
			cpx #2
			bcc Loop














		rts
	}















}