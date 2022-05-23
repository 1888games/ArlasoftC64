TITLE: {



* = * "Title"

	.label SPRITE_POINTER = 160

	Colours:		.byte LIGHT_BLUE, YELLOW, GREEN, RED, PURPLE, CYAN, LIGHT_RED, ORANGE
	XPos:			.byte 35, 		25, 	79, 	132, 	179, 210, 	15, 	52
	XPos_MSB:		.byte 0, 		0, 		0,		0,		0,	 0, 	1,		1
	YPos:			.byte 225,		85,		192,	115,	96,	 190,  	210,	102
	FrameTime:		.byte 2, 		3,      4,      3,      2,   2,     3,      4
	Direction:		.byte 0,        0,      1,      0,      1,   0,     1,      0

	FrameTimer:	.fill 8, 0
	DoneFrame: .byte 0


	Show: {	

		lda #0
		jsr sid.init

		jsr SetupVIC
		jsr CopyColourRAM
		//jsr SetupSprites

		lda #DARK_GRAY
		sta VIC.BORDER_COLOUR

		lda #FrameTime
		sta FrameTimer

		jmp TitleLoop

	}


	// SetupSprites: {

	// 	ldx #0

	// 	Loop:	

	// 		txa
	// 		asl
	// 		tay

	// 		jsr RANDOM.Get
	// 		and #%00000001
	// 		clc
	// 		adc #SPRITE_POINTER

	// 		sta TITLE_POINTERS, x
			
	// 		lda Colours, x
	// 		sta VIC.SPRITE_COLOR_0, x

	// 		lda XPos, x
	// 		sta VIC.SPRITE_0_X, y

	// 		lda YPos, x
	// 		sta VIC.SPRITE_0_Y, y

	// 		lda FrameTime, x
	// 		sta FrameTimer, x

	// 		lda XPos_MSB, x
	// 		bne MSB


	// 		NoMSB:

	// 			lda VIC.SPRITE_MSB
	// 			and DRAW.MSB_Off, x
	// 			sta VIC.SPRITE_MSB
	// 			jmp EndLoop

	// 		MSB:

	// 			lda VIC.SPRITE_MSB
	// 			ora DRAW.MSB_On, x
	// 			sta VIC.SPRITE_MSB

	// 		EndLoop:

	// 			inx
	// 			cpx #8
	// 			bcc Loop



	// 	rts
	// }

	CopyColourRAM:{

		ldx #0

		Loop:

			.for (var i=0; i<4; i++) {
				lda BitmapColor+(i*$100),x
				sta COLOR_RAM+(i*$100),x

			
			}

			
			inx
			bne Loop
			
		rts

	}

	SetupVIC: {

		lda VIC.BANK_SELECT
		and #%11111100
		ora #%00000010
		sta VIC.BANK_SELECT

		lda #%10000000
		sta VIC.MEMORY_SETUP	

		lda VIC.SCREEN_CONTROL
		and #%10011111
		ora #%00100000
		sta VIC.SCREEN_CONTROL

		lda VIC.SCREEN_CONTROL_2
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2

		lda VIC.SPRITE_ENABLE
		ora #%11111111
		sta VIC.SPRITE_ENABLE

		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

	

		rts

	}

	TitleLoop: {

		lda MAIN.PerformFrameCodeFlag
		beq TitleLoop

		lda #0
		sta cooldown
		sta MAIN.PerformFrameCodeFlag

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		jsr SwitchScreenBack
		jmp MENU.Show

		Finish:

		//jsr AnimateSprites

		jmp TitleLoop

		
		
	}







	// AnimateSprites: {


	// 	ldx #0

	// 	Loop:

	// 		lda FrameTimer, x
	// 		beq Ready

	// 		dec FrameTimer, x
	// 		jmp Okay


	// 	Ready:

	// 		lda FrameTime, x
	// 		sta FrameTimer, x

	// 		lda Direction, x
	// 		beq Right

	// 		Left:


	// 		dec TITLE_POINTERS, x
	// 		lda TITLE_POINTERS, x
	// 		cmp #160
	// 		bcs Okay

	// 		lda #162
	// 		sta TITLE_POINTERS, x
	// 		jmp Okay

	// 		Right:

	// 		inc TITLE_POINTERS, x
	// 		lda TITLE_POINTERS, x
	// 		cmp #163
	// 		bcc Okay

	// 		lda #160
	// 		sta TITLE_POINTERS, x


	// 	Okay:

	// 		inx
	// 		cpx #8
	// 		bcc Loop



	// 	rts
	// }


	SwitchScreenBack: {


		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		and #%11111100
		sta VIC.BANK_SELECT

		lda VIC.SCREEN_CONTROL
		and #%10011111
		sta VIC.SCREEN_CONTROL

		lda #%00000110
		sta VIC.MEMORY_SETUP

		lda VIC.SCREEN_CONTROL_2
		and #%11101111
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2




		rts

	}








}