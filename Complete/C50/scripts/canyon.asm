
.var debug = false

MAIN: {
		#import "tetrawall/zeropage.asm"





	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "canyon/random.asm"
	#import "common/draw.asm"
	#import "tetrawall/game.asm"


	* = * "MAIN"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {
		
		
		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		Restart:

			
			lda #%00010010
			sta VIC.MEMORY_SETUP

			lda #BLACK
			sta VIC.EXTENDED_BG_COLOR_2
			sta VIC.BORDER_COLOR		

			lda #LIGHT_RED
			sta VIC.EXTENDED_BG_COLOR_1
			sta VIC.SPRITE_MULTICOLOR_1

			lda #DARK_GRAY
			sta BACKGROUND_COLOR

			lda #$35
			sta $01

			ldx #250
			lda #BLACK

			Loop2:

				sta VIC.COLOR_RAM - 1, x
				sta VIC.COLOR_RAM + 249, x
				sta VIC.COLOR_RAM + 499, x
				sta VIC.COLOR_RAM + 749, x

				dex
				bne Loop2

			jsr RANDOM.init

		Finish:
			

		jmp StartGame

	}


	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 

			jsr CheckControls
			jmp Loop

	}	



	CheckControls: {

		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount

		CheckLeft:

			and #JOY_LEFT
			bne	CheckRight

			lda #LEFT
			//jmp (ZP.ControlAddress)

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			lda #RIGHT
			//jmp (ZP.ControlAddress)

		CheckUp:

			lda ZP.Amount
			and #JOY_UP
			bne	CheckDown

			lda #UP
			//jmp (ZP.ControlAddress)


		CheckDown:

			lda ZP.Amount
			and #JOY_DOWN
			bne	CheckFire

			lda #DOWN  
			//jmp (ZP.ControlAddress)


		CheckFire:

			lda ZP.Amount
			and #JOY_FIRE
			bne	Finish

			lda #FIRE
			//jmp (ZP.ControlAddress)


		Finish:



		rts


	}	

	


	StartGame: {
	

		jmp Loop
	}



	#import "canyon/assets.asm"
	 
	//* = $400 "Screen Ram" virtual
	///.fill $400, 4


	* = 1024 "Screen Ram"



* = 1464

.byte $ed,$ed,$ed,$ed,$e7,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$eb,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ee,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ef,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ee,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$e7,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$eb,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ee,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$f0,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$f0,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ef,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$e7
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ef,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$e7,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$eb
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $f2,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$f0,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$f2,$ec,$ec,$ec,$ec,$ec,$ec,$ec
.byte $ef,$ee,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ef
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ee,$ec,$ec,$ec,$ec,$ec,$ec,$eb,$ed,$ed,$e7,$ec,$ec,$eb,$ed,$ee
.byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ee,$ec,$ec,$ec,$ec,$ec,$ef
.byte $ed,$ed,$ee,$ec,$ec,$ef,$ed,$ed,$ee,$ec,$ec,$ec,$ec,$ec,$ef,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
.byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed





* = $0fff "End Of Memory" virtual
.byte 0
}