ENERGIZER: {


	* = * "---------"
	* = * "ENERGIZER"

	IsActive:		.byte 0

	Frames:			.byte 0
	On:				.byte 0
	Scared:			.byte 0

	Colour:			.byte 0
	FlashState:		.byte 0


	.label TOP_PILL_ROW = -3
	.label BOT_PILL_ROW = 19
	.label LEFT_PILL_ROW = 7
	.label RIGHT_PILL_ROW = 32
	.label FlashInterval = 14

	.label Flash5 = (5 * FlashFrames * 2)
	.label Flash3 = (3 * FlashFrames * 2)
	.label Flash0 = (3 * FlashFrames * 2)

	FlashStarts:	.byte 360 - 140
					.byte 300 - 140
					.byte 240 - 140
					.byte 180 - 140
					.byte 0
					.byte 360 - 140
					.byte 0
					.byte 0
					.byte 0
					.byte 360 - 140
					.byte 0
					.byte 0
					.byte 0
					.byte 180 - 140
					.byte 0
					.byte 0
					.byte 0
					.byte 0
					.byte 0


	X:	.byte LEFT_PILL_ROW, RIGHT_PILL_ROW, LEFT_PILL_ROW, RIGHT_PILL_ROW
	Y:	.byte TOP_PILL_ROW, TOP_PILL_ROW, BOT_PILL_ROW, BOT_PILL_ROW

	SecondsLookup:	.byte 6,5,4,3,2,5,2,2,1,5,2,1,1,3,1,1,0,1


	Seconds:		.byte 0
	SecondsTimer:	.byte 0
	CurrentSeconds:	.byte 0


	Flashes:		.byte 0
	Points:			.byte 0
	PointsFramesLeft: .byte 0
	FlashStart:		.byte 0
	FlashTimer:		.byte 0

	FrameTimer:		.byte 0

	PillAddress:		.word VIC.COLOR_RAM + (-3 * 40) + 7, VIC.COLOR_RAM + (-3 * 40) + 33 
						.word VIC.COLOR_RAM + (17 * 40) + 7, VIC.COLOR_RAM + (17 * 40) + 33 
	
	PillEaten:			.fill 4, 0
	PillRow:			.byte -3, -3, 17, 17
	CurrentPillRow:		.fill 4, 0

	.label FlashFrames = 14
	
 
	NewGame: {

		jsr NewLevel

		rts
	}

	 NewLevel: {

	 	lda #0
	 	sta Scared
	 	sta IsActive

    	ldx GAME.Level
    	dex
    	cpx #18
    	bcc UseLookup

    	ldx #16

    	UseLookup:

    	lda SecondsLookup, x
    	//lda #2
    	sta Seconds

    	lda FlashStarts, x
    	//lda #220
    	sta FlashStart

    	ldx #0
    	ldy #0

    	Loop:

    		lda #0
    		sta PillEaten, x

    		lda PillRow, x
    		sta CurrentPillRow, x

    		lda PillAddress, y
    		sta ZP.PillAddress_1, y

    		iny

    		lda PillAddress, y
    		sta ZP.PillAddress_1, y
    		
    		inx
    		iny
    		cpx #4
    		bcc Loop


    	lda #FlashFrames
    	sta FrameTimer

    	lda #1
    	sta On


    	rts
    }


    ResetLevel: {

		ldx #0
    	ldy #0

    	Loop:

    		lda PillRow, x
    		sta CurrentPillRow, x

    		lda PillAddress, y
    		sta ZP.PillAddress_1, y

    		iny

    		lda PillAddress, y
    		sta ZP.PillAddress_1, y
    		
    		inx
    		iny
    		cpx #4
    		bcc Loop




    	rts
    }

    OnEnergized: {

    	

		lda Seconds
    	sta CurrentSeconds
    	beq JustEatIt

    	jsr PlayEnergizer

    	lda #60
    	sta SecondsTimer

    	lda #1
    	sta Scared

    	lda FlashStart
    	sta FlashTimer

    	lda #0
    	sta Colour
    	sta FlashState


    	JustEatIt:

    		lda #0
    		sta ZP.ShortestTurn

	  		lda ACTOR.TileX
	  		cmp #10
	  		bcc Left

  		Right:

  			inc ZP.ShortestTurn

  		Left:

	  		lda ACTOR.TileY
	  		cmp #10
	  		bcc Top

	  		inc ZP.ShortestTurn
	  		inc ZP.ShortestTurn

  		Top:

	  		ldy ZP.ShortestTurn
	  		lda #1
	  		sta PillEaten, y

	  	lda Seconds
	    jsr ACTOR.GHOST.OnEnergized

	    NoEnergize:

	    jsr TurnOff

    	DoNothing:


    	rts
    }


  

    TurnOn: {

    	lda #LIGHT_RED
    	jmp Switch

    
    }

    TurnOff: {

    	lda #0
    	jmp Switch

    }

    Switch: {

    	CheckTop:

	    	ldy CurrentPillRow + 0
	    	bmi NotTop

	    	ldy PillEaten
	    	bne Eaten1

	    	ldy #0
	    
	    	sta (ZP.PillAddress_1), y

	    Eaten1:

	    	ldy PillEaten + 1
	    	bne NotTop

	    	ldy #25
	    	sta (ZP.PillAddress_1), y

    	NotTop:

	    	ldy CurrentPillRow + 2
	    	cmp #25
	    	bcs NotBottom

    		ldy PillEaten + 2
    		bne Eaten3

	    	ldy #0
	    	sta (ZP.PillAddress_3), y

	    Eaten3:

	    	ldy PillEaten + 3
	    	bne NotBottom

	    	ldy #25
	    	sta (ZP.PillAddress_3), y

    	NotBottom:



    	rts
    }

   	

   	FlashGhosts: {

   		lda FlashTimer
   		beq Switch

   		dec FlashTimer
   		rts

   		Switch:

   		lda #FlashFrames
   		sta FlashTimer

   		lda FlashState
   		eor #%00000001
   		sta FlashState

   		rts
   	}
   

    HandleScared: {

    	lda Scared
    	beq Finish

    	lda MAIN.GameMode
    	cmp #GAME_MODE_EATEN
    	beq Finish

    	jsr FlashGhosts

    	lda SecondsTimer
    	beq SecondElapsed

    	dec SecondsTimer
    	rts

    	SecondElapsed:

	    	lda #60
	    	sta SecondsTimer

	    	dec CurrentSeconds
	    	lda CurrentSeconds
	    	bne Finish

	    FinishScared:

	    	lda #0
	    	sta Scared
	    	sta Points
	    	sta PointsFramesLeft
	    	sta FlashState

	    	jsr ACTOR.PLAYER.SetAlarm
	    	jsr ACTOR.GHOST.ReturnToNormal

    	Finish:



    	rts
    }

    CheckFlash: {

		lda GAME.Active
		beq Skip

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

			lda #FlashFrames
			sta FrameTimer

			lda On
			eor #%00000001
			sta On
			beq Off

			jmp TurnOn

			Off:	

			jmp TurnOff


		Skip:

    	rts
    }


	FrameUpdate: {

		jsr HandleScared
		jsr CheckFlash
		
	


		rts
	}


	

}