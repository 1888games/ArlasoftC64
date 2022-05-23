
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =255

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20
	
	DisableCIA: {

		// prevent CIA interrupts now the kernal is banked out
		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		rts

	}


	SetupInterrupts: {

		sei 	// disable interrupt flag
		lda VIC.INTERRUPT_CONTROL
		ora #%00000001		// turn on raster interrupts
		sta VIC.INTERRUPT_CONTROL

		//lda #<MainIRQ
		//ldx #>MainIRQ
	//	ldy #MainIRQLine
		//jsr SetNextInterrupt

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS
		cli

		rts


	}



	SetNextInterrupt: {

		sta INTERRUPT_VECTOR
		stx INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}

	SetLowInterrupt: {

		sta INTERRUPT_VECTOR
		stx INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+

		sta VIC.SCREEN_CONTROL

		rts

	}


	SpriteIRQ: {

		:StoreState()

		SetDebugBorder(4)

		jsr OBJECTS.Top7

		lda #<GradientIRQ
		ldx #>GradientIRQ
		ldy Lines
		jsr SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti
	}

	BottomSpriteIRQ: {

		:StoreState()

		SetDebugBorder(4)

		jsr OBJECTS.BottomSprite

		lda #<BottomLivesIRQ
		ldx #>BottomLivesIRQ
		ldy #185
		jsr SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti
	}

	BottomLivesIRQ: {

		:StoreState()

		SetDebugBorder(4)

		jsr OBJECTS.Bottom

		lda #<BottomGradientIRQ
		ldx #>BottomGradientIRQ
		ldy Lines2
		jsr SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti
	}



	//Colour1:			.byte BLUE, CYAN, BLUE, CYAN, BLUE
	//Colour2:			.byte LIGHT_BLUE, PURPLE, LIGHT_BLUE, PURPLE, BLUE

	Colour1:			.byte BLUE, BLUE, PURPLE, LIGHT_BLUE, LIGHT_BLUE, LIGHT_BLUE
	Colour2:			.byte LIGHT_BLUE, LIGHT_BLUE, BLUE, BLUE, LIGHT_BLUE
	
	Lines:				.byte 62, 66, 70, 74, 78
	Lines2:				.byte 201, 205, 209, 213, 217
	CurrentGradient:	.byte 0

	BottomGradientIRQ: {

		:StoreState()

		ldx #0

		Loop:

			inx
			cpx #9
			bcc Loop


		ldx CurrentGradient
		lda Colour1, x
		sta VIC.EXTENDED_BG_COLOR_1

		lda Colour2, x
		sta VIC.EXTENDED_BG_COLOR_2

		inc CurrentGradient
		lda CurrentGradient
		cmp #5
		bcc Okay

		Reset:

			lda #0
			sta CurrentGradient

			lda #<MainIRQ
			ldx #>MainIRQ
			ldy #MainIRQLine
			jsr SetNextInterrupt

			jmp Finish

		Okay:	

			ldx CurrentGradient
			lda Lines2, x
			tay

			lda #<BottomGradientIRQ
			ldx #>BottomGradientIRQ
			jsr SetNextInterrupt

		Finish:


		asl VIC.INTERRUPT_STATUS

		//SetDebugBorder(0)

		lda #%00000000
		sta VIC.SPRITE_MULTICOLOR


		:RestoreState()

		//dec $d020

		rti
	}
	

	GradientIRQ: {

		:StoreState()

		//inc $d020

		//SetDebugBorder(4)

		ldx #0

		Loop:

			inx
			cpx #10
			bcc Loop

		nop
		nop

		ldx CurrentGradient
		lda Colour1, x
		sta VIC.EXTENDED_BG_COLOR_1

		lda Colour2, x
		sta VIC.EXTENDED_BG_COLOR_2

		inc CurrentGradient
		lda CurrentGradient
		cmp #5
		bcc Okay

		Reset:

			lda #0
			sta CurrentGradient

			lda #<BottomSpriteIRQ
			ldx #>BottomSpriteIRQ
			ldy #180
			jsr SetNextInterrupt

			jmp Finish

		Okay:	

			ldx CurrentGradient
			lda Lines, x
			tay

			lda #<GradientIRQ
			ldx #>GradientIRQ
			jsr SetNextInterrupt

		Finish:


		asl VIC.INTERRUPT_STATUS

		//SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti
	}
	
	MainIRQ: {

		:StoreState()

		//inc $d020

		SetDebugBorder(3)

			lda #0
			sta $dc02

			ldy #2
			jsr INPUT.ReadJoystick

			//ldy #1
			//jsr INPUT.ReadJoystick

			//jsr sid.play

			jsr $3028

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
	
		Finish:

			lda MAIN.GameMode
			cmp #GAME_MODE_TITLE
			beq NoIRQs


		NoSprites:

			ldy #10
			lda #<SpriteIRQ
			ldx #>SpriteIRQ
			jsr SetNextInterrupt

		NoIRQs:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

	}

	





}