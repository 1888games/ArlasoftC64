IRQ: {


	* = * "IRQ"

	.label INTERRUPT_CONTROL = 				$d01a
	.label INTERRUPT_STATUS = 				$d019
	.label RASTER_INTERRUPT_VECTOR = 		$fffe
	.label IRQControlRegister1 = 	$dc0d
	.label IRQControlRegister2 = 	$dd0d


	.label MainIRQLine = 220
	.label ShakeIRQLine = 254
	.label SidTime = 5


	Mode:	.byte 0


	//.label Colours = 5
	//TowerColours:	.byte PURPLE, LIGHT_BLUE, CYAN, LIGHT_RED, BROWN
	//TowerLines:		.byte 30, 70, 105, 160, 218

	.label Colours = 2
	TowerColours:	.byte BLACK, BLACK
	TowerLines:		.byte 62, 218
	SidTimer:		.byte 5



	TowerStatus:	.byte 0
	SIDCounter:		.byte 0


	DisableCIAInterrupts: {

		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		rts

	}

	NMI: {

		rts
	}


	Setup: {

		lda #0
		sta Mode

		sei 	// disable interrupt flag
		lda INTERRUPT_CONTROL
		ora #%00000001		// turn on raster interrupts
		sta INTERRUPT_CONTROL

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl INTERRUPT_STATUS
		cli

		lda #255
		sta SidTimer

		lda MAIN.MachineType
		bne NoSkip

		lda #SidTime
		sta SidTimer

		NoSkip:

		rts


	}



	SetNextInterrupt: {

		sta RASTER_INTERRUPT_VECTOR
		stx RASTER_INTERRUPT_VECTOR + 1
		sty VIC.RASTER_LINE
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}




	PerformEveryFrame: {


		lda ROCKS.FramesPerSecond
		cmp #50
		beq Okay

		lda SIDCounter
		beq Skip

		Okay:

		jsr SidFrameUpdate


		Skip:

		ldx SIDCounter
		inx
		cpx #6
		bcc Okay2

		ldx #0

		Okay2:

		stx SIDCounter
	
		SetDebugBorder(2)
		
		inc ZP.FrameCounter

   		ldy #2
		jsr INPUT.ReadJoystick

		ldy #1
		jsr INPUT.ReadJoystick


		lda #1
		sta MAIN.PerformFrameCodeFlag

		Finish:

		

		rts
	}

	ShakeIRQ: {

		:StoreState()

		ScreenShake:

			lda GRID.ScreenShakeValue
			beq Reset

			lda VIC.SCREEN_CONTROL
			and #%01111000
			ora GRID.ScreenShakeValue
			sta VIC.SCREEN_CONTROL

			lda VIC.SCREEN_CONTROL_2
			and #%01111000
			ora GRID.ScreenShakeValue
			sta VIC.SCREEN_CONTROL_2

			jmp Finish

		Reset:

			lda VIC.SCREEN_CONTROL
			and #%01111000
			ora #%00000011
			sta VIC.SCREEN_CONTROL

			lda VIC.SCREEN_CONTROL_2
			and #%11111000
			sta VIC.SCREEN_CONTROL_2
		

		Finish:

		ldy #MainIRQLine
		lda #<MainIRQ
		ldx #>MainIRQ
		jsr SetNextInterrupt

		asl INTERRUPT_STATUS

		:RestoreState()


		rti
	}

	MainIRQ: {

		:StoreState()
			
		SetDebugBorder(2)

		jsr PerformEveryFrame
		
		lda MAIN.GameActive
		beq Paused
   
	 	GameActive:
		
			jmp Finish

		Paused:


		 CheckFireButton:

		 	ldy #1
		 	lda INPUT.FIRE_UP_THIS_FRAME, y
		 	beq Finish

		Finish:

		ldy #ShakeIRQLine
		lda #<ShakeIRQ
		ldx #>ShakeIRQ
		jsr SetNextInterrupt

		Tower:

		SetDebugBorder(11)

		asl INTERRUPT_STATUS


		:RestoreState()

		rti

	}





}