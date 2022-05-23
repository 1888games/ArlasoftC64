SPRITES: {

	MultiplexorRows:	.byte 75, 124, 164, 204
	TraitRows:			.byte 134, 174, 214



	CurrentPlexor:		.byte 0


	// sprite 0 = clues
	// sprite 1 = crosshair

	ShowTrait: {

		lda CurrentPlexor
		beq Finish

		sec
		sbc #1

		tax

		lda GENERATE.CluePointers, x
		sta SPRITE_POINTERS

		lda #17
		sta VIC.SPRITE_0_X

		lda #%00000001
		sta VIC.SPRITE_MSB

		lda TraitRows, x
		sta VIC.SPRITE_0_Y

		lda #%00000001
	//	sta $d017
		//sta $d01d


		Finish:

		rts
	}


}