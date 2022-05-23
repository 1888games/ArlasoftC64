VIC: {

.label SCREEN_RAM = $0C00
.label COLOR_RAM = $0800
.label BORDER_BACKGROUND = $900f
.label BACKGROUND_COLOUR = $ff15 
.label BORDER_COLOUR = $ff19 
.label CHAR_RAM = $9005
.label RASTER_LINE = $FF1D
.label RAM_CHAR_MODE = $FF12
.label RAM_CHAR_ADDRESS = $FF13
.label SCREEN_MODE = $ff07
.label ROWS_ETC = $ff06

.label MULTICOLOUR_1 = $ff16
.label MULTICOLOUR_2 = $ff17

ScreenRowLSB:
		.fill 25, <[SCREEN_RAM + i * 40]
ScreenRowMSB:
		.fill 25, >[SCREEN_RAM + i * 40]

ColorRowLSB:
		.fill 25, <[COLOR_RAM + i * 40]
ColorRowMSB:
		.fill 25, >[COLOR_RAM + i * 40]



Setup:{	

		lda ROWS_ETC
		and #%11110000
		ora #%00000111
		sta ROWS_ETC			// set to 24 row mode

		lda #%01011101
		sta BACKGROUND_COLOUR   // background colour  light blue

		lda #%11000110
		sta BORDER_COLOUR  // border colour


		lda SCREEN_MODE	// screen setup
		ora #%10010000		// set 256-char mode and multicolour mode
		sta SCREEN_MODE

		lda RAM_CHAR_MODE
		and #%11111011		// set to use ram for characters (bit 2)
		sta RAM_CHAR_MODE

		lda RAM_CHAR_ADDRESS
		and #%00000011
		ora #%00100000		// character ram page 8   $2000/8192
		sta RAM_CHAR_ADDRESS

		lda #%01101111			// light green
		sta MULTICOLOUR_1

		lda #%00000101		// green
		sta MULTICOLOUR_2

		rts

}




}