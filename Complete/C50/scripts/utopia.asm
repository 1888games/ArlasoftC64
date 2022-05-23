
.var debug = false

.label DefaultSeconds = 50
.label MaxSeconds = 120 + 1

MAIN: {

	* = $120 "Startup"

	Entry: {

		ldx #$1f 
		txs    //Push stack down to $100-$11f
		sei
		//Start your code HERE (205 bytes up to $1ec)

		lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register

		Restart:

			lda #BLACK
			sta VIC.BORDER_COLOR	
			sta ZP.GameMode	

			lda #YELLOW
			sta BACKGROUND_COLOR

			lda #$35
			sta $01
			sta ZP.Timer

			lda #<CHOOSE.Update
			sta ZP.UpdateAddress

			lda #>CHOOSE.Update
			sta ZP.UpdateAddress + 1

			lda #<CHOOSE.Control
			sta ZP.ControlAddress

			lda #>CHOOSE.Control
			sta ZP.ControlAddress + 1

			lda #5 +48
			sta SCREEN_RAM + 6
			sta SCREEN_RAM + 38

			jmp GameLoop

	}

	
	* = * "Game Start"

    GameLoop: {

		lda VIC.RASTER_Y
		cmp #255
		bne GameLoop

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

				jsr CheckControls
				jmp (ZP.UpdateAddress)


			Skip:

				
			jmp GameLoop
    }








   IncreaseScreenValue: {


		Loop:

			inc SCREEN_RAM, x
			lda SCREEN_RAM, x
			cmp #58
			bcc Okay

			lda #48
			sta SCREEN_RAM, x

			dex
			dey
			bne Loop

		Okay:

		rts
	}

	DecreaseScreenValue: {


		Loop:

			dec SCREEN_RAM, x
			lda SCREEN_RAM, x
			cmp #48
			bcs Okay

			lda #57
			sta SCREEN_RAM, x

			dex
			dey
			bne Loop

		Okay:

		rts
	}


  

	CheckControls: {

		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount

		ldx #4

		Loop3:

			lda ZP.Amount
			and Lookups, x
			bne	EndLoop

			lda #5
			sta ZP.Cooldown

			jmp (ZP.ControlAddress)

			EndLoop:

			dex
			bpl Loop3

		rts

	}	



	 Lookups:	.byte JOY_LEFT, JOY_RIGHT, JOY_UP, JOY_DOWN, JOY_FIRE


	#import "common/startup.asm"
	#import "utopia/assets.asm"
	#import "utopia/zeropage.asm"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "utopia/game.asm"
	#import "utopia/choose.asm"
	#import "common/random.asm"
	

	
	 
	* = $400 "Screen Ram" virtual

	* = $0fff "End Of Memory" virtual
	.byte 0

}