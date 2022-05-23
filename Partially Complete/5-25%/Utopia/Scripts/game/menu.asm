MENU: {


	* = $1000 "Menu"

	Show: {


		lda #1
		sta MAPLOADER.CurrentMapID

		jsr MAPLOADER.DrawMap	


		rts	

	}




	ProcessNumber: {

		lda KeyPressed
		.break






		rts
	}

}