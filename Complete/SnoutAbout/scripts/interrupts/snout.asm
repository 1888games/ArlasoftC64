SNOUT:{



	.label TopCharID = 4
	.label BottomCharID = 10

	NoseCharIDs: .byte 4, 4, 5, 10, 11, 12, 14, 0, 0
	SniffCharIDs: .byte 4, 56, 52, 55, 53, 54, 14, 0, 0
	NoseRowOffset: .byte 0, 0, 0, 1, 1, 1, 2, 2, 2
	NoseColOffset: .byte 0, 1, 2, 0, 1, 2, 0, 1, 2


	NosePosition: .byte 4
	PrevNosePosition: .byte 38

	.label MinNosePosition = 3
	.label MaxNosePosition = 38
	.label NoseYPosition = 18
	.label SniffTime = 12
	.label ToothChar = 9

	MoveSpeed: .byte 2
	CurrentMove: .byte 0
	SniffTimeRemaining: .byte 0





	Reset:{

		lda #37
		sta NosePosition
		sta PrevNosePosition

		ldx #4
		jsr MoveNose

		rts
	}


	Update: {

		ldy #1

		CheckRight:

		lda INPUT.JOY_RIGHT_NOW, y
		beq CheckLeft


		lda INPUT.JOY_RIGHT_LAST, y
		bne HoldingRight

		StartedRight:

			ldx MoveSpeed
			dex
			stx CurrentMove
			jmp CheckFire
		
		HoldingRight:

			
			ldx CurrentMove
			inx
			stx CurrentMove
			cpx MoveSpeed

			bne CheckFire

			ldx NosePosition
			inx
			jsr MoveNose

			ldx #ZERO
			stx CurrentMove
			jmp CheckFire
		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckFire

			lda INPUT.JOY_LEFT_LAST, y
			bne HoldingLeft

		StartedLeft:

			ldx MoveSpeed
			dex
			stx CurrentMove
			jmp CheckFire
		
		HoldingLeft:

			ldx CurrentMove
			inx
			stx CurrentMove
			cpx MoveSpeed

			bne CheckFire

			ldx NosePosition
			dex
			jsr MoveNose
			
			ldx #ZERO
			stx CurrentMove
			jmp CheckFire



		CheckFire: 

			lda SniffTimeRemaining
			bne StillSniffing

			lda INPUT.JOY_FIRE_LAST, y
			bne Finish
		
			ldy #1
			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			lda #SniffTime
			sta SniffTimeRemaining	

			jsr SOUND.SniffSound

			jsr DrawSnout
			jmp Finish

		StillSniffing:

			ldx SniffTimeRemaining
			dex
			stx SniffTimeRemaining
			cpx #ZERO
			bne Finish

			jsr DrawSnout

		Finish:

			rts

	}

	DrawSnout: {	

		.label CharIndex = TEMP5
		.label ThisCharID = TEMP6
		.label ThisRow = TEMP7
		.label ThisCol = TEMP8


		ldx #0

		Loop:

			stx CharIndex

			lda SniffTimeRemaining
			beq NormalNose

				lda SniffCharIDs, x
				sta ThisCharID
				jmp GetPosition

			NormalNose:

				lda NoseCharIDs, x
				sta ThisCharID




			GetPosition:

				lda NoseRowOffset, x
				clc
				adc #NoseYPosition
				sta ThisRow

				lda NoseColOffset, x
				clc
				adc NosePosition
				sta ThisCol

				ldy ThisRow
				ldx ThisCol

				cpx #4
				bne NotTeeth

				cpy #19
				bne NotTeeth

				lda #ToothChar
				jmp DrawChar

				NotTeeth:

				lda ThisCharID

				DrawChar:

				jsr PLOT.PlotCharacter

				ldx CharIndex
				inx
				cpx #9
				beq Finish

			jmp Loop

		
		Finish:

		rts

	}


	DrawBridge:{

		ldx PrevNosePosition

		.label ThisNosePosition = TEMP8

		Loop:

			stx ThisNosePosition


			ldy #NoseYPosition
			lda #TopCharID
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition
			ldy #NoseYPosition
			iny 
			lda #BottomCharID
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition
			ldy #NoseYPosition
			iny 
			iny
			lda #0
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition

			inx
			cpx NosePosition
			beq Finish

			jmp Loop

		Finish:

			rts


	}

	ClearBridge: {

		
		.label MaxNosePosition = TEMP9
		.label ThisNosePosition = TEMP8

		stx ThisNosePosition

		ldx PrevNosePosition
		inx
		inx
		inx
		stx MaxNosePosition


		Loop:

			ldx ThisNosePosition
			cpx MaxNosePosition
			bcs Finish

			ldy #NoseYPosition
			lda #ZERO
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition
			ldy #NoseYPosition
			iny 
			lda #ZERO
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition
			ldy #NoseYPosition
			iny 
			iny
			lda #0
			jsr PLOT.PlotCharacter

			ldx ThisNosePosition
			inx
			stx ThisNosePosition
			jmp Loop


		Finish:


		rts
	}

	MoveNose: {

		cpx #MaxNosePosition
		beq Finish

		cpx #MinNosePosition
		beq Finish
	
		stx NosePosition
	
		cpx PrevNosePosition
		bcs NoseExtending


		NoseRetracting:

			jsr DrawSnout

			ldx NosePosition
			inx
			inx
			inx
			jsr ClearBridge

			jmp Finish

		NoseExtending:

			jsr DrawBridge

			ldx NosePosition


			jsr DrawSnout 




		Finish:

			ldx NosePosition
			stx PrevNosePosition

			rts
	}

}