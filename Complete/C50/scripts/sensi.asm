
.var debug = false

MAIN: {

	* = $120 "Startup"

	Entry: {

		ldx #$1f 
		txs    //Push stack down to $100-$11f
		sei
		//Start your code HERE (205 bytes up to $1ec)

		lda #$FF  // maximum frequency values
		sta VIC.SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register



		Restart:
	
			lda #%11011000
			sta VIC.SCREEN_CONTROL_2

			lda #BLACK
			sta VIC.EXTENDED_BG_COLOR_2
			sta VIC.BORDER_COLOR		

			lda #LIGHT_RED
			sta VIC.EXTENDED_BG_COLOR_1
			sta VIC.SPRITE_MULTICOLOR_1

			lda #GREEN
			sta BACKGROUND_COLOR

			lda #$35
			sta $01

			
			jsr BALL.Colour
   			jsr BALL.Reset

	   		DrawTop:

				ldx #8

				LoopT:

					lda BALL.TopLeft - 1, x
					sta SCREEN_RAM + 2, x

					 lda #WHITE
					sta COLOR_RAM + 2, x
					sta COLOR_RAM + 28, x

					lda BALL.Middle - 1, x
					sta SCREEN_RAM + 15, x

					lda #BLACK
					sta COLOR_RAM + 15, x
					//sta COLOR_RAM + 2, x
					//sta COLOR_RAM + 28, x

					lda BALL.TopRight - 1, x
					sta SCREEN_RAM + 28, x

					dex
					bne LoopT

			jmp Loop


	}


	
	* = * "Game Start"




	IncreaseSwerve: {

 		
		lda ZP.BallSwerve
		cmp #40
		bcs NoWrap5

		clc
		adc #6
		sta ZP.BallSwerve


		NoWrap5:

	
		rts
 	}

    CheckScore: {

    	lda ZP.ScoreToAdd
    	beq Finish

    	dec ZP.ScoreToAdd
    	
		Scoring:

			ldx #4

			Loop:

				inc SCREEN_RAM + 19, x
				lda SCREEN_RAM + 19, x
				cmp #58
				bcc Okay

				lda #48
				sta SCREEN_RAM + 19, x

				dex
				bne Loop

			Okay:

    	Finish:



    	rts
    }	


    Loop: {


		lda VIC.RASTER_Y
		cmp #255
		bne Loop

		FrameCode: 	

			inc ZP.Counter
	
			lda ZP.GameMode
			beq Playing

			Ready:

				lda $dc00
				and #JOY_FIRE
				bne Skip

				jmp Entry.Restart
		

			Playing:

				jsr BALL.Update
				jsr BALL.Controls
				jsr CheckScore

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
	#import "sensi/assets.asm"
	#import "sensi/zeropage.asm"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "sensi/game.asm"
	#import "sensi/ball.asm"
	#import "common/random.asm"
	
	 
	* = $400 "Screen Ram" virtual
	* = $0fff "End Of Memory" virtual
	.byte 0

}