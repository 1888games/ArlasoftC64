
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

		jsr TRAFFIC.UpdateSprites

		NoSprites:

			inc TRAFFIC.CurrentRow
			lda TRAFFIC.CurrentRow
			cmp #10
			bcc Okay

		SpritesDone:

			lda #0
			sta TRAFFIC.CurrentRow

			lda #<MainIRQ
			ldx #>MainIRQ
			ldy #MainIRQLine
			jsr SetNextInterrupt

			jmp Finish

		Okay:

			tax
			lda TRAFFIC.RowLookup, x
			sec
			sbc #5
			tay
			lda #<SpriteIRQ
			ldx #>SpriteIRQ

			jsr SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()


		rti
	}
	
	MainIRQ: {

		:StoreState()

		SetDebugBorder(3)

			lda #0
			sta $dc02

			ldy #2
			jsr INPUT.ReadJoystick

			ldy #1
			jsr INPUT.ReadJoystick

			//jsr sid.play

			jsr $3028

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
	
		Finish:


		NoSprites:

			lda TRAFFIC.RowLookup
			sec
			sbc #10
			tay
			lda #<SpriteIRQ
			ldx #>SpriteIRQ
			jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti

	}

	





}