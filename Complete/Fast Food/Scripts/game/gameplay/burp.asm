BURP: {


	.label LeftX = 140
	.label StartY = 180
	.label Y1 = StartY + 21
	.label Y2 = Y1 + 21
	.label Y3 = Y2 + 21

	PosX:	.fill 4, LeftX + (24 * i)
			.fill 4, LeftX + (24 * i)
			
	PosY:	.fill 4, 0


	Pointers: .fill 8, 47 + i
	Drawn: .byte 0


	Initialise: {

		jsr SOUND.GameOver

		lda #GAME_MODE_BURP
		sta MAIN.GameMode

		lda #0
		sta Drawn

		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		lda #71
		sta Pointers

		lda #StartY
		sta PosY

		lda #Y1
		sta PosY + 1

		lda #Y2
		sta PosY + 2

		lda #Y3
		sta PosY + 3

		lda #0
		sta VIC.SPRITE_MSB

		lda #BLUE
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_7


		rts
	}


	Draw: {

		jsr INTER.HideChars

		inc Drawn

		rts
	}


	TopSprites: {

		lda MAIN.GameMode
		cmp #GAME_MODE_BURP
		bne Finish

		lda PosY
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y

		lda PosY + 1
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
 
		lda Pointers + 0
		sta SPRITE_POINTERS + 0
		lda Pointers + 1
		sta SPRITE_POINTERS + 1
		lda Pointers + 2
		sta SPRITE_POINTERS + 2
		lda Pointers + 3
		sta SPRITE_POINTERS + 3
		lda Pointers + 4
		sta SPRITE_POINTERS + 4
		lda Pointers + 5
		sta SPRITE_POINTERS + 5
		lda Pointers + 6
		sta SPRITE_POINTERS + 6
		lda Pointers + 7
		sta SPRITE_POINTERS + 7

		lda #BLUE
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_7


		lda #0
		sta VIC.SPRITE_MSB

		ldx #0
		ldy #0

		Loop:

			lda PosX, x
			sta VIC.SPRITE_0_X, y

			inx
			iny
			iny

			cpx #8
			bcc Loop

		Finish:

	


		rts
	}

	



	FrameUpdate: {

		lda Drawn
		bne DoneIt

		jsr Draw

		DoneIt:

		dec PosY
		dec PosY + 1
		
		lda PosY
		cmp #70
		bcs Okay


		jsr CLOSED.Initialise

	

		Okay:

		jsr TopSprites


		rts
	}




}