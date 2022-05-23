
IRQ: {

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label MainIRQLine= 205

	.label ShipIRQLIne = 2
	.label JoystickIRQLine = 0

	DontDrawYet:	.byte 0



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

		lda #<TopIRQ
		ldx #>TopIRQ
		ldy #0
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS
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



	SpriteIRQ: {

		:StoreState()

		ldy $d011

		ldy VIC.RASTER_Y
		cmp #208
		bcc Okay

		//.break
		nop

		Okay:
		
		ldx ENEMIES.CurrentDrawRow
		lda ENEMIES.IRQ_Data, x
		tax
		inx
		SetDebugBorder(4)

		jsr ENEMIES.DrawRow

		DontDraw:

		jsr ENEMIES.GetNextIRQLine 



		cpy #255
		beq BackToMain

		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL


		jmp FinishInterrupt
 
		BackToMain:


			lda #<MainIRQ
			ldx #>MainIRQ
			ldy #MainIRQLine
			jsr SetNextInterrupt 

		FinishInterrupt:

			asl VIC.INTERRUPT_STATUS

			SetDebugBorder(0)
			:RestoreState()

			rti

	}

	SpriteRow2: {

		:StoreState()


		asl VIC.INTERRUPT_STATUS

		:RestoreState()

		rti

	}



	SetupMainIRQ:{


		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt 

		rts



	}
	



	TopIRQ: {


		:StoreState()

		//lda #7
		//sta $d020	

		
		ldy #2
		jsr INPUT.ReadJoystick

		lda MAIN.GameActive
		beq NoSprites
	
		jsr SHIP.Update
		jsr ENERGY.Update
		

		ldx #2
		jsr BULLET.UpdateSpecificBullet

		//lda #0
		//sta $d020

		lda ENEMIES.EnemiesReady
		beq NoSprites

			lda #0
			sta ENEMIES.CurrentDrawRow

			jsr ENEMIES.GetNextIRQLine

			cpy #255
			beq NoSprites

			lda #<SpriteIRQ
			ldx #>SpriteIRQ
			jsr SetNextInterrupt 
			jmp Finish

		NoSprites:


			ldy #MainIRQLine
			lda #<MainIRQ
			ldx #>MainIRQ
			jsr SetNextInterrupt 

		Finish:

		asl VIC.INTERRUPT_STATUS

		:RestoreState()

		rti


	}
	
	MainIRQ: {

		:StoreState()

		lda #1
		sta MAIN.PerformFrameCodeFlag

		SetDebugBorder(2)

	//	ldy #2
	//	jsr INPUT.ReadJoystick
		
		inc ZP_COUNTER

		lda MAIN.GameActive
		beq Paused

		GameActive:

			jsr BULLET.Update
			jsr LIVES.Update
			
			jsr ENEMIES.Update
			jsr sid.play


			lda SHIP.Paused
			beq Finish

			jsr LOGO.Update

			jmp Finish

		Paused:

		 jsr LOGO.Update

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

		 	
			//jsr MAIN.GameScreen


		

	
		Finish:

		ldy VIC.RASTER_Y
		cmp #240
		bcs BackToSprite

		
		jsr SCORE.CheckScoreToAdd

		BackToSprite:
//
			//lda ENEMIES.EnemiesReady
			//beq NoSprites

			//lda #0
			//sta ENEMIES.CurrentDrawRow

			//jsr ENEMIES.GetNextIRQLine

			ldy #0
			lda #<TopIRQ
			ldx #>TopIRQ
			jsr SetNextInterrupt 

		NoSprites:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti

	}

	





}