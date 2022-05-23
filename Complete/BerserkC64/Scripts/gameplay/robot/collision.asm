.namespace ROBOT {



	CalculateBlockedWalls: {

		
			 lda SectorCentreX, y
			 sta SectorRight, x

			 lda SectorCentreY, y
			 sta SectorDown, x
		
		Up:

			lda ZP.H
			bne PasteOver1

			lda BlockUp, x
			bne Down

		PasteOver1:

			lda MAP_GENERATOR.WallUp, y
			beq NoWallUp

			lda SectorCentreY, y
			sec
			sbc #18

			NoWallUp:

			sta BlockUp, x

		Down:

			lda ZP.H
			bne PastOver2

			lda BlockDown, x
			bne Left

		PastOver2:


			lda MAP_GENERATOR.WallDown, y
			beq NoWallDown

			lda SectorCentreY, y
			clc
			adc #18

		NoWallDown:

			sta BlockDown, x

		Left:

			lda ZP.L
			bne PastOver3

			lda BlockLeft, x
			bne Right


		PastOver3:

			lda MAP_GENERATOR.WallLeft, y
			beq NoWallLeft

			lda SectorCentreX, y
			sec
			sbc #14
			sta ZP.Temp4
	
		NoWallLeft:


			sta BlockLeft, x

		Right:

			lda ZP.L
			bne PastOver4

			lda BlockRight, x
			bne Finish


		PastOver4:

			lda MAP_GENERATOR.WallRight, y
			clc
			beq NoWallRight

			lda SectorCentreX, y
			clc
			adc #14
	
		NoWallRight:

			sta BlockRight, x

			lda #0
			adc #0
			sta BlockRight_MSB, x

		Finish:


		rts
	}



	CheckWallDistances: {

		.label HEIGHT = 11
		.label WIDTH = 8
		.label MARGIN = 3

		ldx CurrentMoveRobot

		lda Sector, x
		asl
		asl
		sta ZP.Y


		ldx #0

		Loop:

			stx ZP.X
			
			ldy ZP.Y
		
			lda Segment_1_Walls, y
			bpl Continue

			jmp Finish

		Continue:

			ldx CurrentMoveRobot

			tay
			
		CheckUp:

			lda PosY, x
			sec
			sbc #MARGIN
			cmp MAP_GENERATOR.Wall_Y_End, y
			bcs NoBlockUp

			clc
			adc #HEIGHT + MARGIN
			cmp MAP_GENERATOR.Wall_Y_Start, y
			bcc NoBlockUp
			
			lda PosX_LSB, x
			cmp MAP_GENERATOR.Wall_X_End, y
			bcs NoBlockUp

			clc
			adc #WIDTH
			cmp MAP_GENERATOR.Wall_X_Start, y
			bcc NoBlockUp
		
			inc BlockUp, x
	
			jmp NoBlockDown


		NoBlockUp:

			lda PosY, x
			clc
			adc #HEIGHT + MARGIN
			cmp MAP_GENERATOR.Wall_Y_Start, y
			bcc NoBlockDown

			lda PosY, x
			cmp MAP_GENERATOR.Wall_Y_End, y
			bcs NoBlockDown

			lda PosX_LSB, x
			cmp MAP_GENERATOR.Wall_X_End, y
			bcs NoBlockDown

			clc
			adc #WIDTH
			cmp MAP_GENERATOR.Wall_X_Start, y
			bcc NoBlockDown

	

			inc BlockDown, x

		NoBlockDown:

			lda PosX_LSB, x
			sec
			sbc #MARGIN
			cmp MAP_GENERATOR.Wall_X_End, y
			bcs NoBlockLeft

			clc
			adc #WIDTH + MARGIN
			cmp MAP_GENERATOR.Wall_X_Start, y
			bcc NoBlockLeft

			lda PosY, x
			cmp MAP_GENERATOR.Wall_Y_End,y 
			bcs NoBlockLeft

			clc
			adc #HEIGHT
			cmp MAP_GENERATOR.Wall_Y_Start,y 
			bcc NoBlockLeft

		
			inc BlockLeft, x

			jmp EndLoop


		NoBlockLeft:

			lda PosX_LSB, x
			clc
			adc #WIDTH + MARGIN
			cmp MAP_GENERATOR.Wall_X_Start, y
			bcc NoBlockRight

			lda PosX_LSB, x
			cmp MAP_GENERATOR.Wall_X_End, y
			bcs NoBlockRight

		
			lda PosY, x
			cmp MAP_GENERATOR.Wall_Y_End,y 
			bcs NoBlockRight

			clc
			adc #HEIGHT
			cmp MAP_GENERATOR.Wall_Y_Start,y 
			bcc NoBlockRight

		
			inc BlockRight, x

		NoBlockRight:

			EndLoop:

			ldx ZP.X
			inc ZP.Y
			inx
			cpx #4
			beq Finish

			jmp Loop



		Finish:




		rts
	}

	CalculateSegment: {


			lda #0
			sta CharX, x

		UseLSB:

			lda PosX_LSB, x
			lsr
			lsr
			clc
			sta CharX, x
			lsr
			tay
			lda SegmentColumns, y
			sta ZP.B

			lda ColumnOverwrite, y
			sta ZP.H

		NowY:

			lda PosY, x
			sec
			sbc #50
			lsr
			lsr
			sta CharY, x
			lsr
			tay

			lda RowOverwrite, y
			sta ZP.L

			lda SegmentRows, y
			clc
			adc ZP.B

			//cmp Sector, x
			//beq NoChange

			sta Sector, x

			tay
			jsr CalculateBlockedWalls

			
			ldx CurrentMoveRobot

		NoChange:

			//lda Sector, x
			//clc
			//adc #64
			//sta SCREEN_RAM + 77


		rts
	}

	CheckSpriteCollision: {


		ldx CurrentMoveRobot

		lda SpriteID, x
		tax
		stx ZP.RobotID

		ldy #BULLET.MAX_BULLETS

		Loop:

			cpy ZP.RobotID
			beq EndLoop

			
			lda SpriteY, y
			beq EndLoop
			sec
			sbc SpriteY, x
			clc
			adc #12
			cmp #24
			bcs EndLoop

			lda SpriteMSB, x
			cmp SpriteMSB, y
			bne EndLoop

			lda SpriteX, x
			sec
			sbc SpriteX, y
			clc
			adc #6
			cmp #12
			bcs EndLoop

			sty ZP.CurrentID

			txa
			sec
			sbc #BULLET.MAX_BULLETS
			sta ZP.RobotID

			jsr Kill

			ldy ZP.CurrentID
			cpy #MAX_SPRITES - 1
			beq IsPlayer

			cpy #MAX_SPRITES - 2
			beq EndLoop


			IsRobot:

				tya
				sec
				sbc #BULLET.MAX_BULLETS
				sta ZP.RobotID
				jmp Kill
			
			IsPlayer:

				jmp PLAYER.Kill



			EndLoop:

				iny
				cpy #MAX_SPRITES
				bcc Loop


		rts
	}



}