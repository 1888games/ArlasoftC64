LAVA: {


	Falling: 	.byte 0, 0, 0
	Position: 	.byte 0, 0, 0
	Column: 	.byte 0, 0, 0
	SpritePointers: .byte 2, 3, 6
	EnableFlags: .byte %00000100, %00001000, %01000000

	EnableFlag: .byte %00000100
	DisableFlag: .byte %00000100

	FirstPositionForColumn: .byte 0, 5, 11, 17, 23
	MaxPositionForColumn: .byte 5, 11, 17, 23, 29
	PositionsThatKill: .byte 3, 9, 15, 21, 27

	ColumnAlreadyUsed: .byte 6
	MaxInstance: .byte 2

	.label Colour = RED


	Frames: .byte 2, 3, 4, 5, 6
			.byte 7, 16, 17, 18, 19, 20
			.byte 22, 25, 63,74, 76, 78
			.byte 80, 81, 82, 84, 85, 2
			.byte 3, 4, 5, 6, 7, 16


	XPos:	.byte 85, 83, 80, 75, 63
			.byte 115, 98, 105, 108, 107, 120
			.byte 145, 135, 134, 137, 139, 129
			.byte 176, 166, 170, 166, 172, 178
			.byte 210, 200, 202, 200, 205, 195

	YPos:	.byte 70, 95, 120, 147, 168
			.byte 70, 90, 105, 117, 137, 156
			.byte 65, 80, 102, 119, 142, 155
			.byte 66, 80, 101, 115, 139, 166
			.byte 68, 81, 100, 115, 140, 157



	Reset:{
		lda VIC.SPRITE_ENABLE
		and #%10110011
		sta VIC.SPRITE_ENABLE
		
		lda #ZERO
		sta Falling
		sta Falling + 1
		sta Falling + 2

		rts

	}


	CheckHitCaveman: {

		ldx #ZERO
		.label StoreX = TEMP5
		.label ThisPosition = TEMP6

		Loop:	

			lda Falling, x
			beq EndLoop

			lda Position, x
			sta ThisPosition

			ldy Column, x
			lda PositionsThatKill, y
			
			cmp ThisPosition
			bne EndLoop

			cpy CAVEMAN.Position
			bne EndLoop

			lda #ZERO
			sta Falling, x

			stx StoreX

			

			jsr CAVEMAN.Died

			jmp Finish

			ldx StoreX

		EndLoop:
			inx
			cpx MaxInstance
			beq Finish
			jmp Loop 

		Finish:

			rts

	}



	MoveLava: {

		//.break

		.label MaxPositionThisColumn = TEMP1
		.label ThisPosition = TEMP2
		.label ThisColumn = TEMP3
		.label StoreY = TEMP4
		.label StoreX = TEMP5

		stx StoreX

		lda Position, x
		clc
		adc #01
		sta ThisPosition

		ldy Column, x
		sty ThisColumn
		lda MaxPositionForColumn, y
		sta MaxPositionThisColumn

		ldy ThisPosition
		cpy MaxPositionThisColumn
		bcc StillFalling

		lda #ZERO
		sta Falling, x
		jmp Finish

		StillFalling:

		Finish:

			lda ThisPosition
			ldx StoreX
			sta Position, x

			rts
	}



	SpawnLava:{

	
		jsr MAIN.Random

		cmp #127
		bcs Finish

		jsr MAIN.Random
		and #$07

		cmp #5
		bcc DontSubtract

		sec
		sbc #3

		DontSubtract:

			cmp ColumnAlreadyUsed
			beq Finish

			sta Column, x
			tay
			lda FirstPositionForColumn, y
			sta Position, x

			lda #ONE
			sta Falling, x


		Finish:

		rts
	}


	Update:{

		lda VIC.SPRITE_ENABLE
		and #%10110011
		sta VIC.SPRITE_ENABLE

		// not if volcano inactive
		lda VOLCANO.IsActive
		beq Finish

		//inc $d020

		ldx #ZERO

		Loop:

			lda Falling, x
			beq NotFalling

			jsr MoveLava
			jmp EndLoop

			NotFalling:

			lda VOLCANO.Position
			cmp #2
			beq CheckSpawn

			jmp EndLoop

			CheckSpawn:

				jsr SpawnLava


		EndLoop:

			jsr DrawLava

			inx
			cpx MaxInstance
			beq Finish
			jmp Loop

		Finish:

			lda #6
			sta ColumnAlreadyUsed

			rts


	}


	DrawLava: {

		.label LavaID = TEMP1
		.label XPosUse = TEMP2
		.label YPosUse = TEMP3



		stx LavaID

		lda Falling, x
		beq Finish

		// get current position ID
		ldy Position, x

		// get sprite positions for this position
		lda XPos, y
		sta XPosUse
		lda YPos, y
		sta YPosUse

		// get sprite frame for this position
		lda Frames, y
		clc
		adc #64

		ldy SpritePointers, x
		sta SPRITE_POINTERS, y

		lda EnableFlags, x
		sta EnableFlag

		lda VIC.SPRITE_ENABLE
		ora EnableFlag
		sta VIC.SPRITE_ENABLE

		lda #Colour
		sta VIC.SPRITE_COLOR_0, y

		tya
		asl
		tay 

		lda XPosUse
		sta VIC.SPRITE_0_X, y
		lda YPosUse
		sta VIC.SPRITE_0_Y, y

	
		Finish:

		rts


	}






}