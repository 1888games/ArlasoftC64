COLLECT: {


	.label Margin = 30
	.label MinX = PLAYER.MinX + Margin
	.label MaxX = PLAYER.MaxX - Margin

	.label MinY = PLAYER.MinY + Margin
	.label MaxY = PLAYER.MaxY - Margin - 50

	.label StartPointer = 33
	.label FrameTime = 4


	.label StartChar = 70

	PosX_LSB:		.byte 0
	PosX_MSB:		.byte 0
	PosY:			.byte 0
	Frame:			.byte 0
	FrameTimer: 	.byte 0
	Delay:			.byte 10

	PosX_Char:		.byte 0
	PosY_Char:		.byte 0

	Collected:		.byte 0


	Reset:	{

		lda #0
		sta FrameTimer
		sta PosY

		lda #YELLOW
		//sta SpriteColor + 1

		lda MAIN.GameIsOver
		beq Okay	

		dec MAIN.GameIsOver
		rts


		Okay:

		jsr New

		rts
	}





	New: {

		lda PosY
		beq NoDelete

		ldx PosX_Char
		ldy PosY_Char
		lda #0

		jsr PLOT.PlotCharacter


	NoDelete:


		lda #0
		sta PosX_MSB

	NewRandom:

		jsr RANDOM.Get
		and #%00111111
		cmp #40
		bcs NewRandom

		sta PosX_Char
		asl
		asl
		clc
		asl
		bcs IsMSB

	AddOffset1:

		clc
		adc #17
		bcc NoMSB1

		inc PosX_MSB
		jmp NoMSB1

	IsMSB:

		inc PosX_MSB
		jmp AddOffset1

	NoMSB1:
		
		sta PosX_LSB

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #3
		sta PosY_Char

		tay
		asl
		asl
		asl
		clc
		adc #44
		sta PosY
		
		lda PosX_Char
		cmp #16
		bcc NoCheck

		lda PosX_Char
		cmp #15
		bcc NoCheck

		cmp #24
		bcs NoCheck

		jmp NoDelete


		NoCheck:

		ldx PosX_Char
		lda #StartChar

	
		jsr PLOT.PlotCharacter

		lda #YELLOW + 8
		jsr PLOT.ColorCharacter

		lda #0
		sta FrameTimer
		sta Frame

		lda #2
		sta Delay


		rts

	}


	FrameUpdate: {

		lda Delay
		beq Ready2

		dec Delay
		rts

		Ready2:

		lda PosY
		//sta SpriteY + 1

		lda FrameTimer
		beq Ready

		dec FrameTimer
		jmp NotYet

		Ready:

			lda #FrameTime
			sta FrameTimer

			inc Frame
			lda Frame
			cmp #4
			bcc Okay

			lda #0
			sta Frame

		Okay:

			clc
			adc #StartPointer
			//sta SpritePointer + 1

		NotYet:

		rts
	}




}