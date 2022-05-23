BASES: {

	* = * "Bases"

	Visible:		.fill 6, 0
	ShowAll:		.byte 0
	Frame:			.fill 6, 0
	FrameTimer:		.fill 6, 0

	Destroyed:		.byte 0
	OrderPosition:	.byte 0
	FlashTimer:		.byte 255

	Order1:		.byte 0, 1, 2, 3, 4, 5
	Order2:		.byte 2, 4, 5, 1, 3, 0
	Order3:		.byte 4, 0, 1, 5, 3, 2
	Order4:		.byte 3, 5, 2, 0, 4, 1
	Order5:		.byte 1, 5, 0, 2, 4, 3
	Order6:		.byte 5, 1, 3, 0, 2, 4
	Order7:		.byte 4, 1, 5, 0, 3, 2
	Order8:		.byte 2, 5, 3, 0, 1, 4


	OrderLookup:	.word Order1, Order2, Order3, Order4, Order5, Order6, Order7, Order8


	LevelShow:		.byte 1, 0, 0, 0

	CurrentLevel:	.byte 0
	Colour:			.byte WHITE

	.label SpriteY = 43
	SpriteX:		.fill 6, 94 + (32 * i)
					.byte 0


	TokenAdd:		.byte 0, 32

	.label FrameTime = 2
	.label FlashTime = 8
	.label BasesToDestroy = 6


	NewGame: {

		lda #0
		sta CurrentLevel

		lda #255
		sta FlashTimer

		rts
	}



	Hit: {

		// x = ID

		lda #0
		sta Visible, x

		inc Destroyed


		CheckLevelComplete:

			lda Destroyed
			cmp #BasesToDestroy
			bcc NotComplete

		LevelIsComplete:

			jsr LEVEL.LevelComplete
			jsr FlashTunnel
			jmp SkipOrder

		NotComplete:

		jsr FlashTunnel

		CheckNextBase:

			lda ShowAll
			bne SkipOrder
			inc OrderPosition
			lda OrderPosition
			cmp #6
			bcc OkayOrder

			lda #0
			sta OrderPosition

		OkayOrder:

			tay
			lda (ZP.OrderAddress), y
			tay
			lda #1
			sta Visible, y

		SkipOrder:

			lda LEVEL.BaseScoreID
			ldx PLAYER.HasToken
			clc
			adc TokenAdd, x
			tay

			jsr SCORE.AddScore

		sfx(SFX_DEAD)

		rts
	}


	FlashTunnel: {

		lda #FlashTime
		sta FlashTimer

		rts	


	}



	Initialise: {

		lda #0
		sta Destroyed

		lda #WHITE
		sta Colour

		ldx LEVEL.VisibleCounter
		lda LEVEL.AllVisible, x
		sta ShowAll	
		sta Visible
		sta Visible + 1
		sta Visible + 2
		sta Visible + 3
		sta Visible + 4
		sta Visible + 5
		bne AllVisible


		GetStartPosition:

			jsr RANDOM.Get
			and #%00000111
			asl
			tax

			lda OrderLookup, x
			sta ZP.OrderAddress

			lda OrderLookup + 1, x
			sta ZP.OrderAddress + 1


			PickPosition:

				jsr RANDOM.Get
				and #%00000111
				cmp #6
				bcs PickPosition

				sta OrderPosition

			tax
			lda #1
			sta Visible, x


		AllVisible:

		ldx #0

		Loop:

			jsr RANDOM.Get
			and #%00000001
			sta Frame, x

			jsr RANDOM.Get
			and #%00000001
			sta FrameTimer ,x

			inx
			cpx #6
			bcc Loop


		rts
	}

	UpdateSprites: {

		lda MAIN.GameMode
		cmp #GAME_MODE_PLAY
		bne Finish

		ldx #0
		ldy #0

		Loop:

			lda Visible, x
			beq Hide


			Show:

				lda FrameTimer, x
				beq Ready

				dec FrameTimer, x
				jmp Draw

			Ready:

				lda #FrameTime
				sta FrameTimer, x

				lda Frame, x
				eor #%00000001
				sta Frame, x

			Draw:

				lda #SpriteY
				sta VIC.SPRITE_0_Y, y

				lda SpriteX, x
				sta VIC.SPRITE_0_X, y

				lda Colour
				sta VIC.SPRITE_COLOR_0, x

				lda #17
				clc
				adc Frame, x
				sta SPRITE_POINTERS, x
		

				lda VIC.SPRITE_MSB
				and VIC.MSB_Off, x
				sta VIC.SPRITE_MSB

				jmp EndLoop

			Hide:

				lda #0
				sta VIC.SPRITE_0_Y, y

			EndLoop:

				inx
				iny
				iny
				cpx #6
				bcc Loop


		Finish:

		rts
	}

	CheckFlash: {

		lda FlashTimer
		bmi Finish

		beq Ready

		dec FlashTimer
		inc VIC.EXTENDED_BG_COLOR_1
		rts

		Ready:	

		lda #255
		sta FlashTimer

		lda PLAYER.TunnelColour
		sta VIC.EXTENDED_BG_COLOR_1

		Finish:
	

		rts
	}


	CheckLast: {

		lda Destroyed
		cmp #5
		bcc Finish

		inc Colour


		Finish:
		
		rts
	}

	FrameUpdate: {

		jsr CheckFlash
		jsr CheckLast
	
		rts
	}


}