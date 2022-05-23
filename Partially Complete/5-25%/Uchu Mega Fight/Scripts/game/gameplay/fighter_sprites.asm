.label HEAD = 0
.label TORSO = 1
.label LEFT_HAND = 2
.label RIGHT_HAND = 3
.label LEFT_FOOT = 4
.label RIGHT_FOOT = 5
.label SHADOW = 6

.label BODY_PARTS = 7


.namespace FIGHTER {

						//    HEA, TOR, LFH, RTH, LFF, RTF  


	SpriteMSB:			.fill MAX_SPRITES, 0

	OffsetStart:			.byte 0, BODY_PARTS
	OffsetEnd:				.byte BODY_PARTS - 1, ((BODY_PARTS) * 2) - 1

	BodyPartOffsetX:	.byte 001, -02, -09, 010, -10, 012, 000
						.byte 001, 000, 012, -14, 012, -12, 000

	BodyPartOffsetY:	.byte 000, 018, 016, 022, 038, 038, 000
						.byte 000, 018, 016, 018, 040, 040, 000


	AnimOffsetX:		.fill BODY_PARTS * 2, 0
	AnimOffsetX_Frac:	.fill BODY_PARTS * 2, 0
	AnimOffsetY:		.fill BODY_PARTS * 2, 0
	AnimOffsetY_Frac:	.fill BODY_PARTS * 2, 0

	Pointers:			.byte 22, 21, 19, 16, 20, 17, 28



	// Fractions Per Frame
	// Pixels Per Frame
	// Number Of Frames








	CurrentFrame:	.byte 0, 0
	AnimationID:	.byte 0, 0
	Reverse:		.byte 0, 0

	SetupSprites: {


		ldx #0

		Loop:

			lda Pointers, x
			sta SpritePointer, x
			sta SpritePointer + BODY_PARTS, x

			lda #WHITE
			sta SpriteColor, x

			lda #YELLOW
			sta SpriteColor + BODY_PARTS, x

			inx
			cpx #BODY_PARTS
			bcc Loop


		ldx #0
		jsr CalculatePositions

		ldx #1
		jsr CalculatePositions

		lda #0
		ldx #0
		stx ZP.PlayerID
		jsr SetupAnimation

		lda #0
		ldx #1
		stx ZP.PlayerID
		jsr SetupAnimation


		rts
	}



	DoHead: {

		ldx ZP.PlayerID

		lda OffsetStart, x
		tay

		lda Facing, x
		bne Left

		Right:

			lda #22
			sta SpritePointer, y
			rts

		Left:

			lda #27
			sta SpritePointer, y

	


		rts
	}


	SetupAnimation: {

		// x = player

		sta AnimationID, x

		txa
		asl
		tay

		lda AnimationID, x
		tax

		lda Animations_LSB, x
		sta ZP.AnimationAddresses, y

		lda Animations_MSB, x
		sta ZP.AnimationAddresses + 1, y


		lda AnimationReset, x
		beq NoReset

		jsr ResetOffsets

		NoReset:

		lda AnimationReverse, x
		pha


		lda AnimationFrames, x
		ldx ZP.PlayerID
		sta CurrentFrame, x

		pla
		sta Reverse, x
		bpl NotFixed

		jmp SetupOffsets

		NotFixed:


		

		rts

		
	}


	SetupOffsets: {


		lda OffsetEnd, x
		sta ZP.EndID

		ldy #0
		lda OffsetStart, x
		tax

		Loop:

			lda (ZP.AnimationAddresses), y
			sta AnimOffsetX, x

			iny
			lda (ZP.AnimationAddresses), y
			sta AnimOffsetY, x

			lda #0
			sta AnimOffsetX_Frac, x
			sta AnimOffsetY_Frac, x

			iny
			inx
			cpy #BODY_PARTS * 2
			bcc Loop
			


		rts
	}


	ResetOffsets: {

		

		ldy #0

		Loop:

			lda #0
			sta AnimOffsetX, y
			iny
			cpy #BODY_PARTS * 8
			bcc Loop



		rts
	}



	GetAnimationAddress: {

		txa
		asl
		tax
		lda ZP.AnimationAddresses, x
		sta ZP.DataAddress

		lda ZP.AnimationAddresses + 1, x
		sta ZP.DataAddress + 1


		rts
	}

	CheckFaceDirection: {

			lda Facing, x
			beq FacingRight

		FacingLeft:

			lda ZP.ReverseX
			eor #%00000001
			sta ZP.ReverseX

		FacingRight:

			rts

	}



	NextFrame: {

		CheckDone:

			ldx ZP.PlayerID

			lda CurrentFrame, x
			clc
			adc #19
			sta SCREEN_RAM

			lda CurrentFrame, x
			beq AnimationDone

		NotDone:

			dec CurrentFrame, x
			rts

		AnimationDone:

			lda AnimationID, x
			tay
			lda AnimationComplete, y

			jsr SetupAnimation

			rts
	}

	UpdateAnimation: {


		CheckAnimType:

			lda Reverse, x
			sta ZP.ReverseX
			sta ZP.ReverseY
			bpl IsAnimation

		IsSetPosition:
		
			jmp Done

		IsAnimation:

			
			jsr CheckFaceDirection
			jsr GetAnimationAddress

		SetupRegisters:

			ldy #0
			ldx ZP.PlayerID
			
			lda OffsetStart,x
			tax

		Loop:

			jsr AnimateBodyPart

			EndLoop:

				inx
				iny
				iny
				cpy #24
				beq Done

			jmp Loop



		Done:

			jsr NextFrame
			jsr DoHead

		rts
	}



	AnimateX: {

			.label PixelMove = ZP.Amount

			iny
			lda (ZP.DataAddress), y
			cmp #150
			bne UsePixel

			lda #0

		UsePixel:

			sta PixelMove

			lda ZP.ReverseX
			beq NoReverse

			lda PixelMove
			beq NoReverse
			eor #%11111111
			clc
			adc #1
			sta PixelMove

		NoReverse:

			lda PixelMove
			clc
			adc AnimOffsetX, x
			sta AnimOffsetX, x

			lda (ZP.DataAddress), y
			bmi GoLeft

		GoRight:

			lda ZP.ReverseX
			bne DoLeft

		DoRight:

		RightFrac:

			dey

			lda AnimOffsetX_Frac, x
			clc
			adc (ZP.DataAddress), y
			sta AnimOffsetX_Frac, x

			lda AnimOffsetX, x
			adc #0
			sta AnimOffsetX, x

			rts

		GoLeft:

			lda ZP.ReverseX
			bne DoRight

		DoLeft:

		LeftFrac:

			dey

			lda AnimOffsetX_Frac, x
			sec
			sbc (ZP.DataAddress), y
			sta AnimOffsetX_Frac, x
			bcs NoWrapX

			dec AnimOffsetX, x

		NoWrapX:





		rts
	}

	AnimateY: {

			.label PixelMove = ZP.Amount

			iny
			iny
			iny

			lda (ZP.DataAddress), y
			cmp #150
			bne UsePixel

			lda #0

		UsePixel:

			sta PixelMove

			lda ZP.ReverseY
			beq NoReverse

			lda PixelMove
			beq NoReverse
			eor #%11111111
			clc
			adc #1
			sta PixelMove

		NoReverse:

			lda PixelMove
			clc
			adc AnimOffsetY, x
			sta AnimOffsetY, x

			lda (ZP.DataAddress), y
			bmi GoLeft

		GoRight:

			lda ZP.ReverseY
			bne DoLeft

		DoRight:

		RightFrac:

			dey

			lda AnimOffsetY_Frac, x
			clc
			adc (ZP.DataAddress), y
			sta AnimOffsetY_Frac, x

			lda AnimOffsetY, x
			adc #0
			sta AnimOffsetY, x

			rts

		GoLeft:

			lda ZP.ReverseY
			bne DoRight

		DoLeft:

		LeftFrac:

			dey

			lda AnimOffsetY_Frac, x
			sec
			sbc (ZP.DataAddress), y
			sta AnimOffsetY_Frac, x
			bcs NoWrapX

			dec AnimOffsetY, x

		NoWrapX:





		rts
	}

	AnimateBodyPart: {


		DoX:

			jsr AnimateX



		DoY:

			jsr AnimateY

		

		rts
	}

	
	CalculatePositions: {

		lda OffsetEnd, x
		sta ZP.EndID

		lda OffsetStart, x
		tay

		Loop:

			lda BodyPartOffsetX, y
			bmi SubtractX


		AddX:

			lda PosX_LSB, x
			clc
			adc BodyPartOffsetX, y
			sta SpriteX, y

			lda PosX_MSB, x
			adc #0
			sta SpriteMSB, y
			jmp DoAnimX


		SubtractX:

			lda PosX_LSB, x
			clc
			adc BodyPartOffsetX, y
			sta SpriteX, y
			bcc NoWrapX

			lda #0
			jmp StoreMSB

		NoWrapX:

			lda PosX_MSB, x 

		StoreMSB:

			sta SpriteMSB, y


		DoAnimX:

			lda AnimOffsetX, y
			bmi SubtractAX

		AddAX:

			lda SpriteX, y
			clc
			adc AnimOffsetX, y
			sta SpriteX, y

			lda SpriteMSB, y
			adc #0
			sta SpriteMSB, y
			jmp DoY


		SubtractAX:

			lda SpriteX, y
			clc
			adc AnimOffsetX, y
			sta SpriteX, y
			bcc NoWrapAX

			lda #0
			jmp StoreAMSB

		NoWrapAX:

			lda SpriteMSB, y 

		StoreAMSB:

			sta SpriteMSB, y


		DoY:

		
			lda PosY, x
			clc
			adc BodyPartOffsetY, y
			sta SpriteY, y


		DoAnimY:

			lda AnimOffsetY, y
			bmi SubtractAY

		AddAY:

			lda SpriteY, y
			clc
			adc AnimOffsetY, y
			sta SpriteY, y
			
			jmp EndLoop


		SubtractAY:

			lda SpriteY, y
			clc
			adc AnimOffsetY, y
			sta SpriteY, y
			
		EndLoop:


			iny
			cpy ZP.EndID
			beq Done

			jmp Loop


		Done:



		lda PosX_LSB, x
		clc
		adc #1
		sta SpriteX, y

		lda PosX_MSB, x
		adc #0
		sta SpriteMSB, y

		lda #206
		sta SpriteY,y 




		rts
	}


}