GAME: {



	.label SleighX = 42
	.label ReindeerX = SleighX + 24
	.label StartY = 156
	.label ReindeerPointer = 54
	.label SleighPointer = 56
	.label PresentPointer = 62



	.label ReindeerFrameTime = 5
	.label SantaFrameTime = 9
	.label PowerRow = 3
	.label MaxTrack = 6
	.label MAX_STARS = 16
	.label FrameTime = 1

	.label MaxYSpeed = 2
	.label MaxYSpeed_SUB = 100


	.label MaxY = 222
	.label MinY = 70

	.label GravityForce = 9

	.label MaxYSpeed_Pos = 2
	.label MaxYSpeed_Neg = 254
	.label MaxImpulse =246  

	.label PresentStartX = 80

	Colours:	.byte RED, PURPLE, GREEN, BLUE, ORANGE, LIGHT_RED, DARK_GRAY, LIGHT_BLUE

	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000,%10000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111,%01111111

	YMove:		.byte 0, 1, 2, 1, 0, -1, 2,- 1

	.label SPRITE_0_X = $d000


	Show: {


		jsr SetupSleigh
		jsr PowerLines



		rts

	}


	FrameCode: {

		jsr Animate
		jsr ShiftChars
		jsr UpdateVertical
		jsr Presents



		rts
	}




	Presents: {

		lda ZP.PresentsPrepared
		beq Prepare

			jsr UpdatePresents
			rts


		Prepare:

			jsr PreparePresents
			rts


	}


	UpdatePresents: {


		ldx #0
		ldy #0

		Loop:

			stx ZP.X

			lda ZP.XPositions, x
			sec
			sbc #2
			sta ZP.XPositions, x

			lda ZP.XPositionsMSB, x
			sbc #0
			sta ZP.XPositionsMSB, x

			cmp #2
			bcs DontDraw

			Draw:

				cmp #0
				beq NoMSB

			MSB:

				lda VIC.SPRITE_MSB
				ora MSB_On + 2, x
				sta VIC.SPRITE_MSB
				jmp YPosition

			NoMSB:

				lda VIC.SPRITE_MSB
				and MSB_Off + 2, x
				sta VIC.SPRITE_MSB

			YPosition:

				lda ZP.XPositions, x
				sta SPRITE_2_X, y

				lda ZP.Counter
				and #%00000111
				tax

				lda YMove, x
				ldx ZP.X
				clc
				adc ZP.YPositions, x
				sta SPRITE_2_Y, y

				jmp EndLoop


			DontDraw:

			lda #0
			sta SPRITE_2_Y, y

			EndLoop:

				inx
				iny
				iny
				cpx #6
				bcc Loop


		lda ZP.XPositionsMSB + 5
		bne NotDone

		lda ZP.XPositions + 5
		cmp #5
		bcs NotDone

		lda #0
		sta ZP.PresentsPrepared

		ldy #0

		Loop2:

			sta VIC.SPRITE_2_Y, y
			iny
			iny
			cpy #12
			bcc Loop2




		NotDone:
			

		rts
	}






	PreparePresents: {

		lda #%1111100
		sta VIC.SPRITE_MSB

		jsr RANDOM.Get
		and #%0111111
		clc
		adc #MinY
		adc #12
		sta ZP.YPositions
		sta ZP.YPositions + 1
		sta ZP.YPositions + 2
		sta ZP.YPositions + 3
		sta ZP.YPositions + 4
		sta ZP.YPositions + 5

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #24
		sta ZP.XGap

		jsr RANDOM.Get
		and #%00000011
		cmp #2
		bcc Flat
		beq Diagonal

		Curve:



		Diagonal:





		Flat:

			ldx #0
			ldy #0
			lda #PresentStartX
			sta ZP.Amount

			lda #1
			sta ZP.EndID

			Loop:

				stx ZP.X

				lda #PresentPointer
				sta SPRITE_POINTERS + 2, x

				lda ZP.Amount
				clc
				adc ZP.XGap
				sta ZP.XPositions, x
				sta ZP.Amount

				lda ZP.EndID
				adc #0
				sta ZP.XPositionsMSB, x
				sta ZP.EndID

				jsr RANDOM.Get
				and #%00000111
				tax
				lda Colours, x
				sta VIC.SPRITE_COLOR_2, x

				ldx ZP.X

				inx
				iny
				iny
				cpx #6
				bcc Loop



		lda #1
		sta ZP.PresentsPrepared




		rts
	}

	PowerLines: {

		ldx #40

		Loop:

			lda #252
			sta SCREEN_RAM + (40 * PowerRow) - 1, x
			lda #251
			sta SCREEN_RAM + (40 * 24) - 1, x

			lda #WHITE +8
			sta VIC.COLOR_RAM + (40 * PowerRow) - 1, x
			sta VIC.COLOR_RAM + (40 * 24) - 1, x
			dex
			bne Loop


		rts


	}

	ShiftChars: {

		ldx #16

		Loop:	

			lda CHARS + 23, x
			asl
			bcc NoAdd

			clc
			adc #1

			NoAdd:

			asl
			bcc NoAdd2

			clc
			adc #1

			NoAdd2:

			sta CHARS + 23, x

			dex
			bne Loop




		rts

	}







	Control: {

		cmp #FIRE
		beq Fire

		rts



		Fire:

		inc ZP.SleighImpulse
		
		lda ZP.Counter
		and #%00000001
		clc
		adc ZP.SleighImpulse
		sta ZP.SleighImpulse

		cmp #MaxImpulse
		bcc Okay

		lda #MaxImpulse
		sta ZP.SleighImpulse


		Okay:

		sta SCREEN_RAM
		////lda #1
	//	sta ZP.Cooldown




		rts
	}



	ClampSpeed: {

		lda ZP.SleighYSpeed
		cmp #MaxYSpeed
		bcc Okay

		lda ZP.SleighYSpeed_SUB
		cmp #MaxYSpeed_SUB
		bcc Okay

		lda #MaxYSpeed
		sta ZP.SleighYSpeed

		lda #MaxYSpeed_SUB
		sta ZP.SleighYSpeed_SUB

		Okay:


		rts
	}
	

	UpdateVertical: {


		lda ZP.Falling
		beq Rising


		Falling:

			lda ZP.SleighYSpeed_SUB
			clc
			adc #GravityForce
			sta ZP.SleighYSpeed_SUB

			lda ZP.SleighYSpeed
			adc #0
			sta ZP.SleighYSpeed

			lda ZP.SleighYSpeed_SUB
			sec
			sbc ZP.SleighImpulse
			sta ZP.SleighYSpeed_SUB

			lda ZP.SleighYSpeed
			sbc #0
			sta ZP.SleighYSpeed

			bpl NotRising

			lda #0
			sta ZP.SleighYSpeed

			lda #1
			sta ZP.SleighYSpeed_SUB

			lda #0
			sta ZP.Falling
			jmp Draw2


			NotRising:

				jsr ClampSpeed

				lda ZP.SleighY_SUB
				clc
				adc ZP.SleighYSpeed_SUB
				sta ZP.SleighY_SUB

			Draw2:

				lda VIC.SPRITE_0_Y
				adc #0
				clc
				adc ZP.SleighYSpeed
				sta VIC.SPRITE_0_Y

				cmp #MaxY
				bcc NoLand

				lda #0
				sta ZP.SleighYSpeed
				sta ZP.SleighYSpeed_SUB


				lda #MaxY
				sta VIC.SPRITE_0_Y

			
			NoLand:

				sta VIC.SPRITE_1_Y

				jmp Finish


		Rising:

			lda ZP.SleighYSpeed_SUB
			sec
			sbc #GravityForce
			sta ZP.SleighYSpeed_SUB

			lda ZP.SleighYSpeed
			sbc #0
			sta ZP.SleighYSpeed


			lda ZP.SleighYSpeed_SUB
			clc
			adc ZP.SleighImpulse
			sta ZP.SleighYSpeed_SUB

			lda ZP.SleighYSpeed
			adc #0
			sta ZP.SleighYSpeed
			
			bpl NotFalling

			lda #1
			sta ZP.Falling

			lda #1
			sta ZP.SleighYSpeed_SUB

			lda #0
			sta ZP.SleighYSpeed

			jmp Update
		
			NotFalling:

				jsr ClampSpeed

				lda ZP.SleighY_SUB
				sec
				sbc ZP.SleighYSpeed_SUB
				sta ZP.SleighY_SUB

			Update:

				lda VIC.SPRITE_0_Y
				sbc #0
				sec
				sbc ZP.SleighYSpeed
				sta VIC.SPRITE_0_Y

				cmp #MinY
				bcs Finish

				lda #0
				sta ZP.SleighYSpeed
				sta ZP.SleighYSpeed_SUB
		

				lda #MinY
				sta VIC.SPRITE_0_Y

		Finish:

				sta VIC.SPRITE_1_Y

		rts
	}


	Animate: {

	

		Santa:

			lda ZP.SantaFrameTimer
			beq AnimateSanta

			dec ZP.SantaFrameTimer
			jmp Reindeer


		AnimateSanta:

			lda #SantaFrameTime
			sta ZP.SantaFrameTimer

			dec ZP.SantaFrame
			bpl Okay

			lda #1
			sta ZP.SantaFrame
			
			Okay:
			
			lda #SleighPointer
			clc
			adc ZP.SleighMode
			adc ZP.SantaFrame
			sta SPRITE_POINTERS + 0



		Reindeer:

			lda ZP.ReindeerFrameTimer
			beq AnimateReindeer

			dec ZP.ReindeerFrameTimer
			jmp Finish


		AnimateReindeer:

			lda #ReindeerFrameTime
			sta ZP.ReindeerFrameTimer

			dec ZP.ReindeerFrame
			bpl Okay2

			lda #1
			sta ZP.ReindeerFrame
			
			Okay2:
			
			lda #ReindeerPointer
			clc
			adc ZP.SleighMode
			adc ZP.ReindeerFrame
			sta SPRITE_POINTERS + 1




		Finish:




		rts
	}

	SetupSleigh: {

		lda #ReindeerFrameTime
		sta ZP.ReindeerFrameTimer

		lda #SantaFrameTime
		sta ZP.SantaFrameTimer

		lda #0
		sta ZP.SleighMode
		sta ZP.SantaFrame
		sta ZP.ReindeerFrame
		sta ZP.SleighY_SUB
		sta ZP.Falling
		sta ZP.SleighImpulse
		sta ZP.PresentsPrepared

		lda #SleighPointer
		sta SPRITE_POINTERS + 0

		lda #ReindeerPointer
		sta SPRITE_POINTERS + 1

		//lda #3
		//sta ZP.SleighTrack

		lda #2
		sta ZP.SleighYSpeed

		lda #ReindeerX
		sta VIC.SPRITE_1_X

		lda #StartY
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta ZP.SleighTargetY

		lda #SleighX
		sta VIC.SPRITE_0_X

		lda #RED
		sta VIC.SPRITE_COLOR_0

		lda #ORANGE
		sta VIC.SPRITE_COLOR_1

		rts
	}



	
	
}