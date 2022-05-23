.namespace ACTOR {
.namespace GHOST {


	.label MODE_PERSONAL = 0
	.label MODE_GLOBAL = 1

	ReleaseMode:		.byte 0
	FramesSinceLastDot:	.byte 0
	GlobalCount:		.byte 0

	GhostCounts:		.fill MAX_ACTORS, 0

	PersonalDotLimit:	.fill MAX_ACTORS, 0

	GlobalDotLimit_Pinky:		.byte 7
	GlobalDotLimit_Inky:		.byte 17
	GlobalDotLimit_Clyde:		.byte 32

	TimeoutLimit:		.byte 0



	ReleaseNewLevel: {

		lda #MODE_PERSONAL
		sta ReleaseMode

		lda #0
		sta FramesSinceLastDot

		lda #240
		sta TimeoutLimit

		lda GAME.Level
		cmp #5
		bcc NoTimeout

		lda #180
		sta TimeoutLimit

		NoTimeout:


		ldx #0
		lda #0

		Loop:

			sta GhostCounts, x

			jsr GetPersonalDotLimit

			sta PersonalDotLimit, x
			inx
			cpx #5
			bcc Loop



		rts
	}


	ReleaseRestartLevel: {

		lda #MODE_GLOBAL
		sta ReleaseMode

		lda #0
		sta FramesSinceLastDot
		sta GlobalCount

		rts
	}



	GetPersonalDotLimit: {

		cpx #PINKY
		bcc NotValid

		beq Pinky

		cpx #INKY
		beq Inky

		Clyde:

			lda GAME.Level
			cmp #1
			beq One

			cmp #2
			beq Two

			lda #0
			rts

		Two:

			lda #50
			rts

		One:

			lda #60
			rts


		Inky:

			lda GAME.Level
			cmp #2
			bcs Pinky

			lda #30
			rts

		Pinky:

			lda #0
			rts

		NotValid:

			lda #255
			rts

	}


	ReleaseOnDotEat: {

		lda #0
		sta FramesSinceLastDot

		lda ReleaseMode
		beq Personal

		Global:

			inc GlobalCount
			rts

		Personal:


			ldx #2

			Loop:

				lda Mode, x
				cmp #GHOST_PACING_HOME
				bne EndLoop
			

				inc GhostCounts, x
				rts
				
			EndLoop:

				inx
				cpx #5
				bcc Loop



		rts
	}


	CheckGlobal: {

		ldx #2


		Loop:

			lda Mode, x
			cmp #GHOST_PACING_HOME
			bne EndLoop

			lda GlobalCount
			cmp GlobalDotLimit_Pinky - 2, x
			bne EndLoop

			inc SignalLeaveHome, x

			cpx #CLYDE
			bne NotClyde

			Clyde:

				lda #0
				sta GlobalCount

				lda #MODE_PERSONAL
				sta ReleaseMode

			NotClyde:
				
				rts
			

		EndLoop:

			inx
			cpx #5
			bcc Loop


		rts
	}

	CheckPersonal: {


		ldx #2

		Loop:

			lda Mode, x
			cmp #GHOST_PACING_HOME
			bne EndLoop

			lda GhostCounts, x
			cmp PersonalDotLimit, x
			bcs Leave

				rts

			Leave:

				inc SignalLeaveHome, x

				rts

		EndLoop:

			inx
			cpx #5
			bcc Loop



		rts
	}
	
	ReleaseUpdate: {

		

		lda ReleaseMode
		beq Personal

		Global:		

			jsr CheckGlobal
			jmp CheckLastDot

		Personal:

			jsr CheckPersonal

		CheckLastDot:

			lda FramesSinceLastDot
			cmp TimeoutLimit
			bcc NoLeave
			beq NoLeave

		CheckLeave:

			lda #0
			sta FramesSinceLastDot

			ldx #2

		Loop:

			lda Mode, x
			cmp #GHOST_PACING_HOME
			bne EndLoop

			inc SignalLeaveHome, x
			
			rts

		EndLoop:

			inx
			cpx #5
			bcc Loop

			rts

		NoLeave:	

			inc FramesSinceLastDot

		rts
	}


}
}