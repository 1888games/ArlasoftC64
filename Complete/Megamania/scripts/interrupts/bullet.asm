BULLET:{


	PosX:		.byte 0, 0, 0
	MSBX:		.byte 0, 0, 0
	PosY:		.byte 0, 0, 0
	Active:		.byte 0, 0, 0
	Speed:		.byte 5, 2, 2
	Colours: 	.byte 2, 6, 6
	Destroy: 	.byte 0, 0, 0
	EnemyToFire:	.byte 0

	EnemyFireX_LSB:	.byte 100
	EnemyFireX_MSB: .byte 0
	EnemyFireY:	.byte 120




	.label MinY  = 60
	.label MaxY = 212
	.label StartCharacter = 59
	.label AddForTopCharacter = 16
	.label ShipBeginY = 198

	Cooldown:	.byte 60, 30
	
	RowY:	.fill 25, 67 + (i * 8)
	ColX:	.fill 40, 20 + (i * 8)
			.fill 10, 2 + (i * 8)
			

	PrevCol:	.byte 0, 0, 0
	PrevRow:	.byte 0, 0, 0

	OffsetX:	.byte 0, 0, 0

	CharacterID:	.byte 0, 0, 0

	StopProgram: .byte 0

	CurrentCollisionRow:	.byte 0

	EnemiesChecked:	.byte 0

	.label FireSoundID = 0


	Reset: {
		
		
		lda #0
		sta Active
		sta Active + 1
		sta Active + 2
		sta EnemyToFire

		rts



	}


	ResetLevel: {


		lda #0
		sta EnemyToFire

		rts
	}


	EnemyFire: {

		lda SHIP.Paused
		bne Finish

		ldx #1
		ldy #2
		lda Active, x
		beq OkayToFire

		inx
		dey
		lda Active, x
		beq OkayToFire

		jmp Finish

		OkayToFire:

			lda EnemyFireX_LSB
			clc
			adc #8
			sta NewBulletX_LSB

			// lda PosX, y
			// sec
			// sbc EnemyFireX_LSB
			// cmp #12
			// bcc Finish

		

			lda EnemyFireX_MSB
			adc #0
			sta NewBulletX_MSB


			lda EnemyFireY
			clc
			adc #26
			sta NewBulletY


			lda Active, y
			beq Okay

			lda PosX, y
			sec
			sbc NewBulletX_LSB

			bcs Positive

			eor #$ff
			adc #01

			Positive:

			cmp #12
			bcs Okay

			jmp Finish

			Okay:

			jsr Fire

		Finish:

		lda #0
		sta EnemyToFire

		rts



	}

	PlayerFire: {

		lda Active
		bne Finish

		ldx #0

		lda SHIP.PosY
		clc
		adc #16
		sta NewBulletY

		lda SHIP.PosX_MSB
		sta NewBulletX_MSB

		lda SHIP.PosX_LSB
		sta NewBulletX_LSB



		jsr Fire

		sfx(0)

		Finish:

		rts


	}


	Draw: {	

		stx CurrentID

		lda PrevCol, x
		beq DoDraw

		Delete:

			lda PrevRow, x
			tay

			lda PrevCol, x
			tax

			lda #0

			cpy #19
			bne Transparent

			Solid:

			lda #91
			jsr PLOT.PlotCharacter
			lda #0
			jsr PLOT.ColorCharacter
			jmp Common

			Transparent:

			jsr PLOT.PlotCharacter

			Common:

			dey

			lda #0
			jsr PLOT.PlotCharacter




		ldx CurrentID

		lda Active, x
		bne DoDraw

		jmp Finish

		DoDraw:


			ldx CurrentID

			lda Active, x
			bne OkayToDraw

			jmp Finish


			OkayToDraw:

				lda Colours, x
				sta Colour

				cpx #0
				beq CalcRow

				ldy SHIP.CurrentPlayer
				lda SHIP.Colours, y
				sta Colour

			CalcRow:

				lda PosY, x
				sta BulletPositionAdjY
				sec
				sbc #60
				lsr
				lsr
				lsr

				// cmp #25
				// bcs Error

				// jmp NoError

				// Error:

				// ldy BulletPositionAdjY



				// .break
				// nop

				// NoError:

				sta PrevRow, x
				tay

			CalcColumn:

				lda MSBX, x
				beq ReduceByBorder

				lda PosX, x
				sta BulletPositionAdjX
				jmp DivideBy8

			ReduceByBorder:

				lda PosX, x
				sta BulletPositionAdjX
				sec
				sbc #14

			DivideBy8:

				lsr
				lsr
				lsr

			CheckMSB:

				pha

				lda MSBX, x
				beq NoColAdd

				pla
				clc
				adc #30
				jmp StoreCol

				NoColAdd:

				pla

			StoreCol:

				sta PrevCol, x
				tax

			CalculateCharacter:

				lda StopProgram
				beq DontStop

			//	.break
				nop

				DontStop:

				lda ColX, x
				sec
				sbc BulletPositionAdjX

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
					sta PrevCol, x

					pla
					tax
					lda #6

				ValidValue:

				lsr
				clc

				adc #StartCharacter
				sta CharacterID



			CalculateYOffset:

				ldx CurrentID

				lda PrevRow, x
				tay

				//lda BulletPositionAdjY
				//tax

				lda RowY, y
				sec
				sbc BulletPositionAdjY
				lsr
				asl
				asl
				clc
				adc CharacterID
				sta CharacterID

				// cmp #59
				// bcc Oops

				// cmp #90
				// bcs Oops

				// jmp DrawBullet

				// Oops:



				// 	pha

				// 	lda #1
				// 	sta StopProgram

				// 	lda RowY, y
				// 	tay
				// 	lda BulletPositionAdjY
				// 	tax

				// 	pla



				// 	.break
				// 	nop

			DrawBullet:	

				ldx CurrentID

				lda PrevRow, x
				tay

				lda PrevCol, x
				tax

				lda CharacterID

				//.break

				jsr PLOT.PlotCharacter

				tya
				pha

				lda Colour
				jsr PLOT.ColorCharacter

				pla
				tay

				lda CharacterID
				clc
				adc #AddForTopCharacter

				dey

				cpy #25
				bcs Finish

				jsr PLOT.PlotCharacter

				lda Colour
				jsr PLOT.ColorCharacter

			Debug:

				lda INPUT.FIRE_UP_THIS_FRAME + 1
				beq Finish


				ldx CurrentID
				lda PrevCol, x
				tay
				tax
				lda ColX, y
				tay

				lda SHIP.PosX_LSB

				//.break

				nop

		Finish:

			rts


	
	}



	Fire: {

		lda NewBulletX_MSB
		bne Okay

		lda NewBulletX_LSB
		cmp #50
		bcc Finish


		Okay:

		lda NewBulletX_LSB
		sta PosX, x
			
		lda NewBulletY
		sta PosY, x

		lda NewBulletX_MSB
		sta MSBX, x

		lda #1
		sta Active, x

	
		Finish:

		rts


	}


	CheckHitEnemy: {

		cpx #0
		bne Finish

		//SetDebugBorder(13)
	
		ldy CurrentCollisionRow	// loop through rows of ships

		RowLoop:

		 	lda ENEMIES.PosY_MSB, y
		 	cmp #255
		 	beq EndRowLoop

		 	lda ENEMIES.PosY_LSB, y
		 	sec
		 	sbc PosY

		 	bcc EnemyBelow

		 	eor $ff

		 	EnemyBelow:

			 	cmp #8

			  	bcs EndRowLoop
		 		
		 	CheckXPositions:

		 		lda ENEMIES.RowFirstEnemyIndex, y
		 		tax

		 		ColumnLoop:

		 			lda ENEMIES.PosX_MSB, x
		 			cmp #2
		 			beq EndColumnLoop

		 			cmp #255
		 			beq EndColumnLoop

		 			EndColumnLoop:

		 				inx
		 				cpx ENEMIES.CurrentColumns
		 				beq EndRowLoop
		 				jmp ColumnLoop

		 	EndRowLoop:

		 		iny
		 		cpy ENEMIES.CurrentRows
		 		bcc Continue

		 		ldy #0

		 		Continue:

		 		sty CurrentCollisionRow


		 Finish:

		 	//SetDebugBorder(15)

			rts


	}

	CheckHitShip:{

		cpx #0
		beq Finish


		lda PosY, x

		cmp #ShipBeginY
		bcc Finish

		lda MSBX, x
		cmp SHIP.PosX_MSB
		bne Finish

		lda PosX, x
		cmp SHIP.PosX_LSB
		bcs GreaterThan

		LessThan:

			lda SHIP.PosX_LSB
			sec
			sbc PosX, x
			jmp CheckGap

		GreaterThan:

			sec
			sbc SHIP.PosX_LSB

		CheckGap:

			cmp #6
			bcs Finish

		Destroyed:


			ldy SHIP.PosX_LSB
			lda PosX, x
			pha
			lda PosY, x
			tax
			pla


			
		//	inc $d020
			//dec $d020

			ldx CurrentID

			jsr Deactivate
			jsr Draw
			jsr SHIP.Kill
	

		
			
		Finish:


		rts
	}




	UpdateSpecificBullet: {

		stx CurrentID
	//	SetDebugBorder(2)

		lda Active, x
		beq Finish

		jsr UpdateYPosition
		jsr UpdateXPosition

		ldx CurrentID
		jsr Draw

		ldx CurrentID
		jsr CheckHitShip
	
		ldx CurrentID

		Finish:

			rts


	}

	Update: {

	 ldx #0

		Loop:

			stx CurrentID
		//	SetDebugBorder(3)

			lda Destroy, x
			beq DontDestroy

			jsr DestroyBullet
			jmp EndLoop

			DontDestroy:

			lda Active, x
			beq EndLoop

			jsr UpdateYPosition
			jsr UpdateXPosition

			ldx CurrentID

			jsr Draw

			ldx CurrentID
			jsr CheckHitShip

			
			ldx CurrentID

			EndLoop:

			inx
			cpx #2
			beq Finish
			jmp Loop


		Finish:

		lda EnemyToFire
		beq Done

		jsr EnemyFire


		Done:

		rts
	}


	UpdateXPosition: {


		cpx #0
		bne Finish

		lda MAIN.Difficulty
		bne Finish

		lda SHIP.PosX_LSB
		sta PosX, x

		lda SHIP.PosX_MSB
		sta MSBX, x


		Finish:



		rts
	}

	UpdateYPosition: {

		lda PosY, x

		cpx #0
		beq Rising

		Falling:

			clc
			adc Speed, x
			adc MAIN.BulletSpeed
			jmp CheckPosition

		Rising:

			sec
			sbc Speed, x

		CheckPosition:

			cmp #MinY
			bcs NoClampMin

		OutOfScreenTop:

			ldx CurrentID
			jsr Deactivate
			jmp Finish

		NoClampMin:

			cmp #MaxY
			bcc NoClampMax

		OutOfScreenBottom:

			ldx CurrentID

			jsr Deactivate

			ldx CurrentID

			//jsr EnemyFire
			jmp Finish


		NoClampMax:

		sta PosY, x


		Finish:

		rts

	}


	DestroyBullet: {

		lda #0
		sta Active, x	
		sta Destroy, x
		jsr Draw



		rts

	}


	Deactivate: {	

		lda #0
		sta Active, x
		sta PosX, x
		sta MSBX, x

			

		rts
	}


	
}