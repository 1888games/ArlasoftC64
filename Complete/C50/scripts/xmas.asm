
.var debug = false

MAIN: {
	
	#import "xmas/zeropage.asm"

	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "common/macros.asm"
	#import "common/random.asm"
	#import "xmas/game.asm"


	* = * "MAIN"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {
		
		
		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT

		//jsr RANDOM.init7

		Finish:

		jmp StartGame 

	}


	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop
 
		FrameCode: 

			jsr CheckControls
			jsr GAME.FrameCode
			jmp Loop

	}	



	ClearScreen: {

		lda #248
		ldx #250

		Loop:

			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop

		// lda #9

		// Loop2:

		// 	sta VIC.COLOR_RAM - 1, x
		// 	sta VIC.COLOR_RAM + 249, x
		// 	sta VIC.COLOR_RAM + 499, x
		// 	sta VIC.COLOR_RAM + 749, x

		// 	dex
		// 	bne Loop2

		// Finish:

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

		CheckLeft:

			and #JOY_LEFT
			bne	CheckRight

			lda #LEFT
			jmp (ZP.ControlAddress)

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			lda #RIGHT
			jmp (ZP.ControlAddress)

		CheckUp:

			lda ZP.Amount
			and #JOY_UP
			bne	CheckDown

			lda #UP
			jmp (ZP.ControlAddress)


		CheckDown:

			lda ZP.Amount
			and #JOY_DOWN
			bne	CheckFire

			lda #DOWN  
			jmp (ZP.ControlAddress)


		CheckFire:

			lda ZP.Amount
			and #JOY_FIRE
			bne	Finish

			lda #FIRE
			jmp (ZP.ControlAddress)


		Finish:

		lda #0
		sta ZP.SleighImpulse

		rts


	}	

	


	StartGame: {
		
		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		
		lda #DARK_GRAY
		sta VIC.BORDER_COLOR 

		lda #%00010010
		sta VIC.MEMORY_SETUP

		// multicolour mode on
		lda VIC.SCREEN_CONTROL_2
		and #%01101111
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2

		lda #GRAY
		sta VIC.EXTENDED_BG_COLOR_1
		lda #RED
		sta VIC.EXTENDED_BG_COLOR_2

		lda #255
		sta VIC.SPRITE_ENABLE

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #YELLOW
		sta VIC.SPRITE_MULTICOLOR_2

		lda #%11111111
		sta VIC.SPRITE_MULTICOLOR

		lda #<GAME.Control
		sta ZP.ControlAddress

		lda #>GAME.Control
		sta ZP.ControlAddress + 1
	
		jsr ClearScreen

		jsr GAME.Show

		jmp Loop
	}



	#import "xmas/assets.asm"
	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4







* = $0fff "End Of Memory" virtual
.byte 0
}