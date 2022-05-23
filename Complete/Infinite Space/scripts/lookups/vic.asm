VIC: {
	.label COLOR_ADDRESS = VECTOR1
	.label SCREEN_ADDRESS = VECTOR2

	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000,%10000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111,%01111111
	
	ScreenRowLSB:
		.fill 25, <[i * $28]
	ScreenRowMSB:
		.fill 25, >[i * $28]

	.label SPRITE_0_X = $d000
	.label SPRITE_0_Y = $d001

	.label SPRITE_1_X = $d002
	.label SPRITE_1_Y = $d003

	.label SPRITE_2_X = $d004
	.label SPRITE_2_Y = $d005

	.label SPRITE_3_X = $d006
	.label SPRITE_3_Y = $d007

	.label SPRITE_4_X = $d008
	.label SPRITE_4_Y = $d009

	.label SPRITE_5_X = $d00a
	.label SPRITE_5_Y = $d00b

	.label SPRITE_6_X = $d00c
	.label SPRITE_6_Y = $d00d

	.label SPRITE_7_X = $d00e
	.label SPRITE_7_Y = $d00f

	.label SPRITE_MSB = $d010

	.label RASTER_Y = $d012 

	.label SPRITE_ENABLE = $d015
	.label SCREEN_CONTROL_2 = $d016

	.label VIC_BANK_SELECT = $dd00

	.label SCREEN_CONTROL = $d011
	.label MEMORY_SETUP = $d018

	.label INTERRUPT_CONTROL = $d01a
	.label INTERRUPT_STATUS = $d019
	
	.label SPRITE_MULTICOLOR = $d01c

	.label BORDER_COLOR = $d020
	.label BACKGROUND_COLOR = $d021
	.label EXTENDED_BG_COLOR_1 = $d022
	.label EXTENDED_BG_COLOR_2 = $d023

	.label SPRITE_MULTICOLOR_1 = $d025
	.label SPRITE_MULTICOLOR_2 = $d026

	.label SPRITE_COLOR_0 = $d027
	.label SPRITE_COLOR_1 = $d028
	.label SPRITE_COLOR_2 = $d029
	.label SPRITE_COLOR_3 = $d02a
	.label SPRITE_COLOR_4 = $d02b
	.label SPRITE_COLOR_5 = $d02c
	.label SPRITE_COLOR_6 = $d02d
	.label SPRITE_COLOR_7 = $d02e

	.label SPRITE_PRIORITY = $d01b
	.label SPRITE_BG_COLLISION = $d01f

	.label COLOR_RAM = $d800
	


	SetupRegisters: {

		lda #ALL_ON
		sta SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR

		//Set VIC BANK 3, last two bits = 00
		lda VIC_BANK_SELECT
		and #%11111100
		sta VIC_BANK_SELECT

		//Set screen and character memory
		lda #%00001110
		sta MEMORY_SETUP	

		lda #%11111111
		sta SPRITE_PRIORITY

		lda #LIGHT_BLUE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #RED
		sta VIC.SPRITE_MULTICOLOR_2

		// //38 col mode
		// lda SCREEN_CONTROL_2
		// and #%11110111
		// sta SCREEN_CONTROL_2 

		// // multicolour mode on
		// lda SCREEN_CONTROL_2
		// and #%11101111
		// ora #%00010000
		// sta SCREEN_CONTROL_2

		// lda SCREEN_CONTROL
		// and #%11110111
		// ora #%00000111
		// sta SCREEN_CONTROL

		rts

	}

	ColourLastRow: {



		ldy #24
		lda ScreenRowLSB, y
		clc
		adc #ZERO
		sta SCREEN_ADDRESS
		sta $d020
		sta COLOR_ADDRESS

		lda ScreenRowMSB, y
		adc #ZERO
		sta SCREEN_ADDRESS + 1

		// Calculate colour ram address
		adc #>[COLOR_RAM-SCREEN_RAM]
		sta COLOR_ADDRESS +1

		ldy #ZERO

		Loop:	

			lda #0
			sta (SCREEN_ADDRESS), y
			lda #2
			sta (COLOR_ADDRESS), y

			cpy #39
			beq Finish
			iny
			jmp Loop

		Finish:

			rts

	}

	SetupColours:

		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		lda #CYAN
		sta VIC.BORDER_COLOR

		// lda #BLACK
		// sta VIC.EXTENDED_BG_COLOR_1
		// lda #CYAN
		// sta VIC.EXTENDED_BG_COLOR_2


		rts

}


