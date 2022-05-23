VIC: {

.label SCREEN_RAM = $8000
.label SCREEN_DATA_LOCATION = $600
.label RASTER_LINE =  $E840
.label RASTER_MASK=  %00100000

ScreenRowLSB:
		.fill 25, <[SCREEN_RAM + i * 40]
ScreenRowMSB:
		.fill 25, >[SCREEN_RAM + i * 40]

GameScreenRowLSB:
		.fill 25, <[SCREEN_DATA_LOCATION + i * 40]
GameScreenRowMSB:
		.fill 25, >[SCREEN_DATA_LOCATION + i * 40]



Setup:{	

	

		rts

}




ColourMyBorder: {

	txa
	pha


	ldx #0

	Loop:

		lda #86
		sta SCREEN_RAM, x
		sta SCREEN_RAM + 920, x
		cpx #79
		beq EndLoop
		inx
		jmp Loop


	EndLoop:

	pla
	tax

	rts
}


RestoreBorder: {

	txa
	pha

	ldx #0

	 Loop:

		lda SCREEN_DATA.Game, x
		sta SCREEN_RAM, x
		lda SCREEN_DATA.Game + 920, x
		sta SCREEN_RAM + 920, x
		cpx #79
		beq EndLoop
		inx
		jmp Loop


	EndLoop:

		pla
		tax

		rts




}


}