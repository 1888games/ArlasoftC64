
.var debug = false

MAIN: {

	* = $120 "Startup"

	Entry: {

		ldx #$1f 
		txs    //Push stack down to $100-$11f
		sei
		//Start your code HERE (205 bytes up to $1ec)

		lda #$FF  // maximum frequency values
		sta VIC.SPRITE_MULTICOLOR
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register

		Restart:
	
			//lda #%01110011
			//sta VIC.SCREEN_CONTROL_2

			lda #WHITE
			sta VIC.SPRITE_MULTICOLOR_2

			//lda #%00010010
			//sta VIC.MEMORY_SETUP

			lda #WHITE
			sta VIC.BACKGROUND_COLOR

			lda #BLACK
			sta VIC.BORDER_COLOR


			lda #%00110101
			sta $01

			jsr Clear

			jmp StartGame 

	}


	* = * "Game Start"

   StartGame: {		

   		lda #0
   		sta ZP.GameMode

   		
    	jmp Loop
    }


    Clear: {


    	ldx #250
    	lda #32

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
		cmp #255
		bne Loop

		FrameCode: 
	
			lda ZP.GameMode
			beq Playing

			Ready:

				lda $dc00
				and #JOY_FIRE
				bne Skip

				jmp Entry.Restart
		

			Playing:


				//jsr GAME.CheckControls
				//jsr GAME.FrameUpdate

			

			Skip:

			jmp Loop
    }





	#import "common/startup.asm"
	#import "new/assets.asm"
	#import "new/zeropage.asm"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4

	* = $0fff "End Of Memory" virtual
	.byte 0

}