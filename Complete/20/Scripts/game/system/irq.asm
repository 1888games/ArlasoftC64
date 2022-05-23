
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

	


	SpriteIRQ: {


		:StoreState()
		
		//ldx DISH.CurrentBeltID
		//inx
		//stx $d020

		
		BackToMain:

			lda #<MainIRQ
			ldx #>MainIRQ
			ldy #MainIRQLine
			jsr SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		//lda #0
		//sta $d020

		:RestoreState()


	
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

			//jsr sid.play

			jsr $2028

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
	
		Finish:

			lda MAIN.GameMode
			cmp #GAME_MODE_PLAY
			beq DoIRQs

			cmp #GAME_MODE_DEAD
			beq DoIRQs

			jmp NoIRQs

		DoIRQs:

			lda #0
			
			sta VIC.SPRITE_2_Y
			sta VIC.SPRITE_3_Y
			sta VIC.SPRITE_4_Y
		
			ldy #40
			lda #<SpriteIRQ
			ldx #>SpriteIRQ
			jsr SetNextInterrupt

			jmp DoneIRQ


		NoIRQs:	

		

		DoneIRQ:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

	}

	





}