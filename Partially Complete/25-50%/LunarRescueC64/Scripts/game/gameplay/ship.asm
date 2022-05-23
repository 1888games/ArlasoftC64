.label SHIP_DOCKED = 0
.label SHIP_FALLING = 1
.label SHIP_LANDED = 2
.label SHIP_CLIMBING = 3

.label SpriteNumber = 22

.label StartPointer = 25

SHIP: {

	PosX_Frac:	.byte 0
	PosX:		.byte 0
	PosY:		.byte 0
	PosY_Frac:	.byte 0

	Mode:		.byte SHIP_DOCKED


	Colours:	.byte YELLOW, GREEN, PURPLE, CYAN, YELLOW, RED, GREEN
	StartY:		.fill 7, 50 + i * 24
	EndY:		.fill 7, 50 + (i+1) * 24



	.label X_Speed_Fall = 50
	.label Y_Speed_Fall = 200
	.label Y_Speed_Thrust = 100

	TopColour:		.byte 0
	BottomColour:	.byte 0
	TopRows:		.byte 0
	BottomRows:		.byte 0

	

	Reset: {

		lda #SHIP_DOCKED
		sta Mode

		jmp Docked

		rts
	}

	Docked: {

		lda MOTHERSHIP.PosX
		clc
		adc #10
		sta PosX

		lda MOTHERSHIP.PosX_LSB
		sta PosX_Frac

		lda #MOTHERSHIP.PosY
		clc
		adc #3
		sta PosY

		lda #0
		sta PosY_Frac



		jmp UpdateSprite

	}


	UpdateSprite: {

		ldx #SpriteNumber

		lda #YELLOW
		sta SpriteColor, x

		lda PosX
		sta SpriteX, x

		lda PosY
		sta SpriteY, x

		lda #StartPointer
		sta SpritePointer, x


		rts
	}


	CreateSprites: {









		rts
	}


	CalculatePosition: {

		ldx #0

		Loop:

			lda PosY
			cmp EndY, x
			bcc EndLoop

			cmp EndY, x
			bcs EndLoop

			.break
			nop


			EndLoop:

				inx
				cpx #7
				bcc Loop





		rts
	}


	FrameUpdate: {

		lda Mode
		cmp #SHIP_DOCKED
		bne NotDocked

		jmp Docked



		NotDocked:










		rts
	}









}