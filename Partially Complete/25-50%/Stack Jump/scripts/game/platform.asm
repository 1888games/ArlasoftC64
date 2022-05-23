PLATFORM:{


	.label StartCharacter = 4
	.label AddForTopCharacter = 4
	.label ShipBeginY = 198

	PosX:		.byte 150, 150
	MSBX:		.byte 0, 0
	PosY:		.byte 150, 150
	Speed:		.byte 5, 5

	Cooldown:	.byte 60, 30
	
	RowY:	.fill 25, 67 + (i * 8)
	ColX:	.fill 40, 20 + (i * 8)
			.fill 10, 2 + (i * 8)
			

	PrevCol:	.byte 0, 0
	PrevRow:	.byte 0, 0

	OffsetX:	.byte 0

	CharacterID:	.byte 0

	Active:	.byte 1, 1

	TopColour:	.byte 14
	BottomColour: .byte 4

	NextRow: .byte 16, 16



	CurrentColumn: .byte 6, 6
	CurrentRow:		.byte 16, 16
	PreviousColumn:	.byte 6, 6
	PreviousRow: .byte 16, 6
	CurrentOffset: .byte 5, 5
	CurrentDirection: .byte 0, 0

	OffsetTimer:	.byte 255, 255


	SpeedChange: 	.byte 0

	Reset: {


		lda #0
		sta Active

		lda #16
		sta CurrentRow
	

		jsr Generate

		rts

	}




	Generate: {

		lda SpeedChange
		beq ChangeSpeed

		dec SpeedChange
		jmp NoSpeedChange

		ChangeSpeed:

			jsr RANDOM.Get

			and #%01111111
			clc
			adc #120
			sta OffsetTimer + 1

			jsr RANDOM.Get
			and #%00000011
			clc
			adc #3
			sta SpeedChange


		NoSpeedChange:

		jsr RANDOM.Get

		cmp #128
		bcc GoingLeft

		GoingRight:

			lda #8
			sta CurrentColumn

			lda #0
			sta CurrentDirection

			lda #0
			sta CurrentOffset

			jmp Finish



		GoingLeft:

			lda #27
			sta CurrentColumn

			lda #1
			sta CurrentDirection

			lda #7
			sta CurrentOffset



		Finish:

			lda #1
			sta Active


			rts

	}



	Update: {

		lda Active
		beq NoDraw

		ldx #0

		Loop:
		
		lda OffsetTimer
		sec
		sbc OffsetTimer + 1
		sta OffsetTimer
		bcs NoColumnMove

		lda CurrentDirection
		beq GoingRight


		GoingLeft:

			dec CurrentOffset
			lda CurrentOffset
			cmp #255
			bcc NoColumnMove

			lda #7
			sta CurrentOffset

			dec CurrentColumn

			jmp NoColumnMove

		GoingRight:


			inc CurrentOffset
			lda CurrentOffset
			cmp #8
			bcc NoColumnMove

			lda #0
			sta CurrentOffset
			inc CurrentColumn

		NoColumnMove:

		inx
		cpx #3
		bcc Loop



		Finish:

		jsr Draw

		NoDraw:

	

		rts	
	}


	Draw: {

		lda PreviousColumn
		cmp CurrentColumn
		beq NoDelete

		Delete:

			//.break

			lda #0
			ldx PreviousColumn
			ldy PreviousRow

			jsr PLOT.PlotCharacter

			iny

			jsr PLOT.PlotCharacter


			inx
			inx
			inx
			inx
			inx

			jsr PLOT.PlotCharacter

			dey

			jsr PLOT.PlotCharacter



		NoDelete:

			lda CurrentOffset
			asl
			asl
			asl
			clc
			adc #StartCharacter
			sta CharacterID


			ldx CurrentColumn
			ldy CurrentRow

			stx PreviousColumn
			sty PreviousRow

			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter

			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter

			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter
			
			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda TopColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			dex
			dex	
			dex
			dex
			dex
			iny
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter

			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter

			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter

			inc CharacterID
			lda CharacterID
			inx
			jsr PLOT.PlotCharacter
			lda BottomColour
			jsr PLOT.ColorCharacter





			



			rts


	}



	Draw2: {	

		lda PrevCol
		beq DoDraw

		Delete:

			lda PrevRow
			tay

			lda PrevCol
			tax

			lda #0

			Solid:

			jsr PLOT.PlotCharacter
			jsr PLOT.ColorCharacter
			

			dey

			lda #0
			jsr PLOT.PlotCharacter


		lda Active
		bne DoDraw

		jmp Finish

		DoDraw:

				CalcRow:

				lda NextRow
				sta PrevRow
				tay

			CalcColumn:

				lda MSBX
				beq ReduceByBorder

				lda PosX
				sta PlatformPositionAdjX
				jmp DivideBy8

			ReduceByBorder:

				lda PosX
				sta PlatformPositionAdjX
				sec
				sbc #14

			DivideBy8:

				lsr
				lsr
				lsr

			CheckMSB:

				pha

				lda MSBX
				beq NoColAdd

				pla
				clc
				adc #30
				jmp StoreCol

				NoColAdd:

				pla

			StoreCol:

				//.break

				sta PrevCol
				tax

			CalculateCharacter:

				lda ColX
				sec
				sbc PlatformPositionAdjX

				cmp #7
				bcc ValidValue

				adc #8
				bcs Borrow

				jmp ValidValue

				Borrow:

					cmp #7
					bcc ValidValue

					inx
					txa
					pha
					ldx CurrentID
					sta PrevCol

					pla
					tax
					lda #6

				ValidValue:

				asl
				asl
				asl
				clc

				adc #StartCharacter
				sta CharacterID



			

			DrawBullet:	

				lda PrevRow
				tay

				lda PrevCol
				tax

				lda CharacterID

				//.break

				jsr PLOT.PlotCharacter

				tya
				pha

				lda TopColour
				jsr PLOT.ColorCharacter

				
				inx

				pla
				tay

				jsr PLOT.PlotCharacter

				tya
				pha
				lda TopColour
				jsr PLOT.ColorCharacter

		

		Finish:

			rts


	
	}


}