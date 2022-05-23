SPRITE: {

	SourceX:		.byte 170
	SourceY:		.byte 154


	PosX_LSB:		.byte 184, 184
	PosX_MSB:		.byte 0, 0
	PosY:			.byte 150, 150

	TargetPosX_LSB:	.byte 0, 0
	TargetPosX_MSB:	.byte 0, 0
	TargetPosY:		.byte 0, 0

	Speed:			.byte 13

	BeingDealt:		.byte 1, 0
	BeingFolded:	.byte 0, 0

	ReachedXTarget:	.byte 0, 0
	ReachedYTarget:	.byte 0, 0


	DealCard: {


		lda SourceX
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		lda SourceY
		sta PosY

		lda VIC.SPRITE_ENABLE
		and #%00000001

		ldx SLOTS.NextSlotID
		lda SLOTS.Columns, x
		tay

		lda SLOTS.XPosLSB, y
		sta TargetPosX_LSB

		lda SLOTS.XPosMSB, y
		sta TargetPosX_MSB

		lda SLOTS.Rows, x
		tay

		lda SLOTS.YPos, y
		sta TargetPosY

		jsr PositionCard

		lda #0
		sta VIC.SPRITE_COLOR_0
		sta ReachedYTarget
		sta ReachedXTarget

		lda #1
		sta BeingDealt

		ldx SLOTS.NextSlotID
		lda SLOTS.Shown, x
		beq CardBack


		jsr decK.GetCurrentCard

		txa
		clc
		adc #16

		jmp SetSpritePointer

		CardBack:

			lda #69

		SetSpritePointer:
		
		sta SPRITE_POINTERS

		inc SLOTS.NextSlotID

		rts


	}



	PositionCard: {


		lda PosX_LSB, x
		sta VIC.SPRITE_0_X

		lda PosX_MSB, x
		sta VIC.SPRITE_MSB
	
		lda PosY, x
		sta VIC.SPRITE_0_Y


		rts


	}



	CardFinishedMove: {

		jsr decK.GetNextCard
	
		ldy SLOTS.NextSlotID
		dey

		jsr DRAW.DrawCard

		rts

	}


	MoveCards: {

		ldx #0

		Loop:

			stx CardID

			lda BeingDealt, x
			bne MoveEm

			jmp EndLoop


			MoveEm:

			lda ReachedXTarget, x
			beq XAxis

			jmp YAxis

			XAxis:

			CheckMSB:

				lda TargetPosX_MSB, x
				cmp PosX_MSB, x

				beq CheckLSB
				bcc MoveLeft
				bcs MoveRight

	

			CheckLSB:

				lda TargetPosX_LSB, x
				cmp PosX_LSB, x
				bcc MoveLeft
				bcs MoveRight
				jmp Finish


			MoveLeft:

				lda PosX_LSB, x
				sec
				sbc Speed
				sta PosX_LSB, x

				lda PosX_MSB, x
				sbc #00
				sta PosX_MSB, x

				CheckIfArrived:

					lda TargetPosX_MSB, x
					cmp PosX_MSB, x
					bne YAxis

					lda TargetPosX_LSB, x
					cmp PosX_LSB, x
					bcc YAxis

					lda TargetPosX_LSB, x
					sta PosX_LSB, x
					lda #1
					sta ReachedXTarget, x

					lda ReachedYTarget, x
					beq YAxis

					lda #0
					sta BeingDealt, x
					jsr CardFinishedMove
					jmp EndLoop

				
			MoveRight:


				lda PosX_LSB, x
				clc
				adc Speed
				sta PosX_LSB, x

				lda PosX_MSB, x
				adc #00
				sta PosX_MSB, x

					CheckIfArrived2:

					lda TargetPosX_MSB, x
					cmp PosX_MSB, x
					bne YAxis

					lda PosX_LSB, x
					cmp TargetPosX_LSB, x
					bcc YAxis

					lda TargetPosX_LSB, x
					sta PosX_LSB, x
					lda #1
					sta ReachedXTarget, x

					lda ReachedYTarget, x
					beq YAxis

					lda #0
					sta BeingDealt, x
					jsr CardFinishedMove
					jmp EndLoop


			YAxis:

				lda ReachedYTarget, x
				bne EndLoop

			CheckY:

				lda TargetPosY, x
				cmp PosY, x
				bcc MoveUp
				bcs MoveDown
				jmp Finish


			MoveUp:

				lda PosY, x
				sec
				sbc Speed
				sta PosY, x

				CheckIfArrived3:

					lda TargetPosY, x
					cmp PosY, x
					bcc EndLoop

					lda TargetPosY, x
					sta PosY, x
					lda #1
					sta ReachedYTarget, x

					lda ReachedXTarget, x
					beq EndLoop

					lda #0
					sta BeingDealt, x

					jsr CardFinishedMove

					jmp EndLoop


			MoveDown:


				lda PosY, x
				clc
				adc Speed
				sta PosY, x

					CheckIfArrive42:

					lda TargetPosY, x
					cmp PosY, x
					bne EndLoop

					lda PosY, x
					cmp TargetPosY, x
					bcc EndLoop

					lda TargetPosY, x
					sta PosY, x
					lda #1
					sta ReachedYTarget, x

					lda ReachedXTarget, x
					beq EndLoop

					lda #0
					sta BeingDealt, x
					jsr CardFinishedMove

					jmp EndLoop


			EndLoop:

				ldx CardID

				jsr PositionCard



				inx
				cpx #2
				beq Finish


		Finish:

			rts
	}






}