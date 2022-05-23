HUD: {



	Load: {

		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		sta VIC.BORDER_COLOR
		
	 	lda #0
	 	sta MAPLOADER.CurrentMapID

	 	jsr MAPLOADER.DrawMap
	 	jsr ColourHudText

		jsr DrawBottomRow


		rts
	}


	DrawBottomRow: {

		ldx #0

		Loop:
		
			lda #0
			sta SCREEN_RAM + 960, x

			lda #0
			sta VIC.COLOR_RAM + 960, x

			inx 
			cpx #40
			beq Finish
			jmp Loop

		Finish:

		rts


	}



ColourHudText: {


	lda #7
	// scoreText
	sta VIC.COLOR_RAM + 4
	sta VIC.COLOR_RAM + 5
	sta VIC.COLOR_RAM + 6
	sta VIC.COLOR_RAM + 7
	sta VIC.COLOR_RAM + 8

	// ammoText
	sta VIC.COLOR_RAM + 17
	sta VIC.COLOR_RAM + 18
	sta VIC.COLOR_RAM + 19
	sta VIC.COLOR_RAM + 20



	lda #1
	// scoreValue
	sta VIC.COLOR_RAM + 10
	sta VIC.COLOR_RAM + 11
	sta VIC.COLOR_RAM + 12
	sta VIC.COLOR_RAM + 13
	sta VIC.COLOR_RAM + 14
	sta VIC.COLOR_RAM + 15

	// locationName
	sta VIC.COLOR_RAM + 937
	sta VIC.COLOR_RAM + 938
	sta VIC.COLOR_RAM + 939
	sta VIC.COLOR_RAM + 940
	sta VIC.COLOR_RAM + 941
	sta VIC.COLOR_RAM + 942
	sta VIC.COLOR_RAM + 943
	sta VIC.COLOR_RAM + 944
	sta VIC.COLOR_RAM + 945
	sta VIC.COLOR_RAM + 946
	sta VIC.COLOR_RAM + 947
	sta VIC.COLOR_RAM + 948
	sta VIC.COLOR_RAM + 949
	sta VIC.COLOR_RAM + 950
	sta VIC.COLOR_RAM + 951
	sta VIC.COLOR_RAM + 952
	sta VIC.COLOR_RAM + 953

	lda #12

	sta VIC.COLOR_RAM + 927
	sta VIC.COLOR_RAM + 928
	sta VIC.COLOR_RAM + 929
	sta VIC.COLOR_RAM + 930
	sta VIC.COLOR_RAM + 931
	sta VIC.COLOR_RAM + 932
	sta VIC.COLOR_RAM + 933
	sta VIC.COLOR_RAM + 934
	sta VIC.COLOR_RAM + 935
	sta VIC.COLOR_RAM + 936





	rts


}


}