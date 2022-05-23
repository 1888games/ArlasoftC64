
.var debug = false

MAIN: {

	* = $120 "Startup"

	Entry: {

		ldx #$1f 
		txs    //Push stack down to $100-$11f
		sei
		//Start your code HERE (205 bytes up to $1ec)


		Restart:
	
			//lda #%01110011
			//sta VIC.SCREEN_CONTROL_2

			lda #%00010010
			sta VIC.MEMORY_SETUP

			lda #BLACK
			sta VIC.BACKGROUND_COLOR
			sta VIC.BORDER_COLOR

			lda #$35
			sta $01
		
			jsr RANDOM.init

			New:

			jsr Clear
			
			jmp NewGame 

	}


	* = * "Game Start"

   NewGame: {		

   		lda #0
   		sta ZP.GameMode
   		sta ZP.Level

   		lda #1
   		sta ZP.ResetLevel
   		sta ZP.WaitFire

   		lda #0
   		sta ZP.StartHeight

   		lda #35
   		sta ZP.NewDelay
   		sta ZP.NewTimer

   		lda #9
   		sta ZP.FallChance

   		lda #4
   		sta ZP.BatChance


   		lda #3
   		sta ZP.Lives
   		sta ZP.FallTime
   		sta ZP.MaxBats

   		

   		lda #7
   		sta ZP.BatSpeed

   		jsr GAME.Show

    	jmp Loop
    }

   
    Clear: {


    	ldx #250
    	lda #GAME.BlankCharID

    	Loop:

    		sta SCREEN_RAM - 1, x
    		sta SCREEN_RAM + 249, x
    		sta SCREEN_RAM + 499, x
    		sta SCREEN_RAM + 749, x

    		dex
    		bne Loop

    	rts



    }


    Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 	

			inc ZP.Counter
	
			lda ZP.GameMode
			cmp #2
			bcc Playing

			Ready:

			 	lda #0
	    		sta $d418

				lda $dc00
				and #JOY_FIRE
				bne NotYet2

				lda ZP.GameMode
				cmp #3
				bcc NotGameOver

				jmp Entry.Restart

				NotGameOver:

				jmp GAME.Restart

			Playing:

				jsr GAME.FrameUpdate
				jsr GAME.CheckControls

			
			NotYet2:

				lda VIC.RASTER_Y
				cmp #48
				bne NotYet2
			
			Skip:

				lda #%00010100
				sta VIC.MEMORY_SETUP

			NotYet:

				lda VIC.RASTER_Y
				cmp #58
				bne NotYet

			ldx #9

			NopLoop:

					dex
					bne NopLoop
				

			lda #%00010010
			sta VIC.MEMORY_SETUP

			jmp Loop
    }







	#import "common/startup.asm"
	#import "stalac/assets.asm"
	#import "stalac/zeropage.asm"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"

	#import "stalac/game.asm"
	#import "stalac/random.asm"
	
	* = $400 "Screen Ram" virtual
	.fill $400, 4

	* = $0fff "End Of Memory" virtual
	.byte 0

}


