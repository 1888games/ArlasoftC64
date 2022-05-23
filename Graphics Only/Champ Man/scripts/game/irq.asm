
IRQ: {

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label MainIRQLine= 250

	MusicTimer: .byte 0, 6


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

		asl VIC.INTERRUPT_staTUS
		cli

		rts


	}



	SetNextInterrupt: {

		sta REGISTERS.RASTER_INTERRUPT_VECTOR
		stx REGISTERS.RASTER_INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}




	
	MainIRQ: {

		:Storestate()

		
		jsr sid.play

		jsr decK.Update
		
		SetDebugBorder(2)
	
		lda #1
		sta MAIN.PerformFrameCodeFlag
		
		inc ZP_COUNTER

		lda MusicTimer
		beq ReadMKey

		dec MusicTimer
		jmp NoSpace

		ReadMKey:


		ldx #$ff
		stx $dc02
	
		lda $ef  //%01111111 
	    sta $DC00 
	    lda $DC01 
	    and #$10  //mask %00010000 
	    bne NoSpace

	    lda MAIN.MusicOn
	    beq TurnMusicOn

	    lda #1
	    jsr sid.init

	    lda #0
	    sta MAIN.MusicOn

	    lda MusicTimer + 1
	    sta MusicTimer

	    jmp NoSpace

	    TurnMusicOn:

	    lda #0
	    jsr sid.init

	    lda #1
	    sta MAIN.MusicOn

	    lda MusicTimer + 1
	    sta MusicTimer

   		NoSpace:

   		ldx #0
   		stx $dc02

   		ldy #2
		jsr INPUT.ReadJoystick
		

   	
		lda MAIN.GameActive
		beq Paused

		GameActive:

			jsr CONTROL.Update
			jmp Finish

		Paused:

		 lda MAIN.GameIsOver
		 beq Finish
		
		 lda MAIN.GameOverTimer
		 beq CheckFireButton

		 dec MAIN.GameOverTimer
		 jmp Finish

		 CheckFireButton:

		 	ldy #1
		 	lda INPUT.FIRE_UP_THIS_FRAME, y
		 	beq Finish

		Finish:

		asl VIC.INTERRUPT_staTUS

		SetDebugBorder(0)

		:Restorestate()

		rti

	}

	





}