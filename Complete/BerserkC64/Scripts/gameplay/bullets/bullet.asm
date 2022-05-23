.namespace BULLET {

	.label MAX_BULLETS = 7


	PosX_LSB:	.fill MAX_BULLETS, 0
	PosX_MSB:	.fill MAX_BULLETS, 0
	PosY:		.fill MAX_BULLETS, 0
	PosX_Frac:	.fill MAX_BULLETS, 0
	PosY_Frac:	.fill MAX_BULLETS, 0

	DirectionX:	.fill MAX_BULLETS, 0
	DirectionY:	.fill MAX_BULLETS, 0

	CharX:		.fill MAX_BULLETS, 0
	CharX_2:	.fill MAX_BULLETS, 0
	CharY:		.fill MAX_BULLETS, 0
	CharY_2:	.fill MAX_BULLETS, 0
	CharX_3:	.fill MAX_BULLETS, 0
	CharY_3:	.fill MAX_BULLETS, 0

	CollisionOffsetX:	.fill MAX_BULLETS, 0
	CollisionOffsetY:	.fill MAX_BULLETS, 0


	OffsetX:	.fill MAX_BULLETS, 0
	OffsetY:	.fill MAX_BULLETS, 0
	Frame:		.fill MAX_BULLETS, 255
	Diagonal:		.fill MAX_BULLETS, 0

	Pointer:	.fill MAX_SPRITES, 0
	Colour:		.fill MAX_SPRITES, 0

	BulletSpeed_Pixel:	.fill MAX_BULLETS, 0
	BulletSpeed_Frac:	.fill MAX_BULLETS, 0

	Delay:		.fill MAX_BULLETS, 0
	IDThatFired: .fill MAX_BULLETS, 0
	Sector:		.fill MAX_BULLETS, 0

	
	PlayerOffsetX:			.byte 07, -6, 03, 06, -4, -7, 04, 06
	PlayerOffsetY:			.byte 00, 06, 07, 06, 00, -7, -4, -4


	RobotOffsetX:			.byte 07, -6, 04, 06, -6, -5, 04, 05
	RobotOffsetY:			.byte 03, 06, 07, 06, 03, 01, -4, 01


	DirectionLookupX:		.byte 1, -1, 0, 1, -1, -1, 0, 1
	DirectionLookupY:		.byte 0, 1, 1, 1, 0, -1, -1, -1

	PlayerSpriteWidth:		.byte 7, 7, 1, 7, 7, 7, 1, 7


							//0.  1.  2.  3.  4.  5.  6.  7
	CharOffsetX_Pos:	.byte 01, 00, 01, 01, 00, 00, 01, 01

	CharOffsetX_P:		.byte 03, 01, 01, 03, 01, 02, 01, 03
	CharOffsetX_Fine_P:	.byte 00, 03, 01, 00, 00, 00, 02, 00

	CharOffsetX_R:		.byte 03, 01, 01, 03, 01, 01, 01, 01
	CharOffsetX_Fine_R:	.byte 00, 03, 00, 00, 02, 02, 02, 02


	CharOffsetY_Pos:	.byte 01, 01, 01, 01, 01, 00, 00, 00
	CharOffsetY_Pos_R:	.byte 01, 01, 01, 01, 01, 01, 00, 01

	CharOffsetY_P:		.byte 00, 03, 03, 02, 00, 02, 00, 01
	CharOffsetY_Fine_P:	.byte 02, 02, 02, 03, 02, 00, 02, 01

	CharOffsetY_R:		.byte 01, 03, 03, 02, 01, 00, 00, 00
	CharOffsetY_Fine_R:	.byte 02, 02, 02, 03, 02, 02, 02, 02

							//0.  1.  2.  3.  4.  5.  6.  7
	WholeOffsetX_Pos:		.byte 01, 00, 01, 01, 00, 00, 01, 01
	WholeOffsetX_P:			.byte 01, 00, 01, 01, 01, 02, 01, 03
	WholeOffsetX_Fine_P:	.byte 03, 07, 02, 00, 03, 00, 03, 00

	WholeOffsetY_Pos:		.byte 01, 01, 01, 01, 01, 00, 00, 00
	WholeOffsetY_P:			.byte 00, 03, 03, 02, 00, 02, 01, 01
	WholeOffsetY_Fine_P:	.byte 03, 02, 02, 03, 03, 00, 00, 01

	CollisionOffsetsX:		.byte 00, 00, 00, 00, 00, 00, 00, 00
	CollisionOffsetsY:		.byte 02, 02, 02, 02, 02, 02, 02, 02 

	CollisionOffsetsX_R:		.byte 00, 00, 00, 00, 00, 00, 00, 00
	CollisionOffsetsY_R:		.byte  04, 04, 04, 04, 04, 04, 04, 04

	.label PixelSpeed = 3
	.label FracSpeed = 154

	.label PixelSpeed_Diag = 2
	.label FracSpeed_Diag = 141


	IsDiagonal:		.byte 0, 1, 0, 1, 0, 1, 0, 1


	FrameLookup:	.byte 0, 3, 1, 2, 0, 2, 1, 3

	.label MinY = 40
	.label MaxY = 250
	.label MinX = 4
	.label MaxX = 248

	DebugChar:		.byte 13, 14, 7, 15

	MaxEnemyBullets:		.byte 2
	EnemyBullets:			.byte 2




	.label StartPlayerPointer = 80
	.label StartRobotPointer = 92

	
	
	
	ClearAll: {

		lda MaxEnemyBullets
		sta EnemyBullets

		ldx #0

		Loop:

			lda #0
			sta SpriteY, x
			sta SpriteCopyY, x

			lda #255
			sta Frame, x

			inx
			cpx #MAX_BULLETS
			bcc Loop



		rts
	}



	Destroy: {

		ldx ZP.X

		lda #0
		sta PosY, x
		sta PosX_MSB, x
		sta PosX_LSB, x

		lda #255
		sta Frame, x

		

		jsr UpdateSprite

		lda #0
		sta SpriteX, x
		sta SpriteCopyX, x
		sta ColourCopy, x

		cpx #2
		bcc NotRobot

		inc EnemyBullets


		NotRobot:


		rts
	}


	
	Process: {

		DoX:


			lda DirectionX, x
			bne MoveX

			jmp DoY

		MoveX:

			bpl MoveRight

			MoveLeft:

				lda PosX_Frac, x
				sec
				sbc BulletSpeed_Frac, x
				sta PosX_Frac, x

				lda PosX_LSB, x
				sta ZP.Amount
				sbc BulletSpeed_Pixel, x
				sta PosX_LSB, x

				cmp #MinX
				bcs NoLeftLeave

				jmp Destroy

			NoLeftLeave:


				lda PosX_LSB, x
				sec
				sbc ZP.Amount
				clc
				adc OffsetX, X
				sta OffsetX, X

			CheckOffsetXLeft:

				lda OffsetX, x
				bpl NoWrapOffsetLeft

				clc
				adc #4
				sta OffsetX, x

				dec CharX, x
				dec CharX_2,x
				dec CharX_3, x

				jmp CheckOffsetXLeft

			NoWrapOffsetLeft:

				jmp DoY
				
			MoveRight:

				lda PosX_Frac, x
				clc
				adc BulletSpeed_Frac, x
				sta PosX_Frac, x

				lda PosX_LSB, x
				sta ZP.Amount
				adc BulletSpeed_Pixel, x
				sta PosX_LSB, x

				cmp #MaxX
				bcc NoLeaveRight

				jmp Destroy

			NoLeaveRight:

				
				lda PosX_LSB, x
				sec
				sbc ZP.Amount
				clc
				adc OffsetX, x
				sta OffsetX, x

			CheckOffsetXRight:

				lda OffsetX, x
				cmp #4
				bcs WrapOffsetRight

				jmp NoWrapOffsetRight

			WrapOffsetRight:

				sec
				sbc #4
				sta OffsetX, x

				inc CharX, x
				inc CharX_2, x
				inc CharX_3, x

				jmp CheckOffsetXRight

			NoWrapOffsetRight:


		DoY:

			lda DirectionY, x
			bne MoveY

			jmp Finish

		MoveY:

			bpl MoveDown

			MoveUp:

				lda PosY_Frac, x
				sec
				sbc BulletSpeed_Frac, x
				sta PosY_Frac, x

				lda PosY, x
				sta ZP.Amount
				sbc #0
				sec
				sbc BulletSpeed_Pixel, x
				sta PosY, x

				cmp #MinY
				bcs NoUpLeave

				jmp Destroy


			NoUpLeave:


				lda PosY, x
				sec
				sbc ZP.Amount
				clc
				adc OffsetY, X
				sta OffsetY, X

			CheckOffsetYUp:

				lda OffsetY, x
				bpl NoWrapOffsetUp

				clc
				adc #4
				sta OffsetY, x

				dec CharY, x
				dec CharY_2,x
				dec CharY_3, x

				jmp CheckOffsetYUp

			NoWrapOffsetUp:

				jmp Finish

			MoveDown:

				lda PosY_Frac, x
				clc
				adc BulletSpeed_Frac, x
				sta PosY_Frac, x

				lda PosY, x
				sta ZP.Amount
				adc #0
				clc
				adc BulletSpeed_Pixel, x
				sta PosY, x

				cmp #MaxY
				bcc NoLeaveDown

				jmp Destroy

			NoLeaveDown:

				lda PosY, x
				sec
				sbc ZP.Amount
				clc
				adc OffsetY, x
				sta OffsetY, x

			CheckOffsetYDown:

				lda OffsetY, x
				cmp #4
				bcs WrapOffsetDown

				jmp NoWrapOffsetDown

			WrapOffsetDown:

				sec
				sbc #4
				sta OffsetY, x

				inc CharY, x
				inc CharY_2, x
				inc CharY_3, x

				jmp CheckOffsetYDown

			NoWrapOffsetDown:


		Finish:


		rts
	}

	CalculateSegment: {

		UseLSB:

			lda PosX_LSB, x
			lsr
			lsr
			lsr
			tay
			lda ROBOT.SegmentColumns, y
			sta ZP.B

		NowY:

			lda PosY, x
			sec
			sbc #50
			lsr
			lsr
			lsr
			tay

			lda ROBOT.SegmentRows, y
			clc
			adc ZP.B
			sta Sector, x

		NoChange:

			//lda Sector, x
			//clc
			//adc #64
			//sta SCREEN_RAM + 77

		rts


	}

	FrameUpdate: {

		SetDebugBorder(WHITE)

		lda MAP_GENERATOR.Scrolling
		beq NotScrolling

		rts

		NotScrolling:


		ldx #0

		Loop:	

			stx ZP.X

			lda Frame, x
			bmi EndLoop

			lda Delay, x
			bne SkipMove

			Okay:	

				jsr Process
	
		//		jsr CalculateSegment
				jsr CheckRobotCollision
				jsr CheckPlayerCollision

			SkipMove:

			jsr UpdateSprite

			ldx ZP.X

			lda Delay, x
			beq Okay2

			dec Delay, x
			jmp SkipCollision

		Okay2:
			//inc $D020
			jsr CheckWallCollision
				
		SkipCollision:

			ldx ZP.X

		EndLoop:

			inx
			cpx #MAX_BULLETS
			bcc Loop

		SetDebugBorder(BLACK)


		rts
	}


	

	UpdateSprite: {

		lda #0
		sta PosX_MSB, x

		lda PosX_LSB, x
		clc
		adc #24
		sta SpriteX, x

		lda PosX_MSB, x
		adc #0
		sta PosX_MSB, x

		lda PosY, x
		sta SpriteY, x

		lda PosX_MSB, x
		sta SpriteMSB, x
		jsr UTILITY.StoreMSBColourX
	

		rts
	}


	Fire: {









		rts
	}
}