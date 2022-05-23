
.var debug = false

MAIN: {
		#import "patience/zeropage.asm"





	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"

	#import "patience/game.asm"


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

		jsr RANDOM.init

		Finish:
			

		jmp StartGame

	}


	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 	

		

			//jsr CheckControls
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



		rts


	}	

	


	StartGame: {
		
		lda #GREEN
		sta VIC.BACKGROUND_COLOR
		
		lda #GREEN
		sta VIC.BORDER_COLOR 


		lda #%00010010
		sta VIC.MEMORY_SETUP

		// multicolour mode on
		lda VIC.SCREEN_CONTROL_2
		and #%01101111
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2

		lda #RED
		sta VIC.EXTENDED_BG_COLOR_1
		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_2

		ldx #250
		lda #GREEN

		Loop2:

			sta VIC.COLOR_RAM - 1, x
			sta VIC.COLOR_RAM + 249, x
			sta VIC.COLOR_RAM + 499, x
			sta VIC.COLOR_RAM + 749, x

			dex
			bne Loop2

		lda #<GAME.Control
		sta ZP.ControlAddress

		lda #>GAME.Control
		sta ZP.ControlAddress + 1

	
	//	jsr DRAW.ClearScreen

		jmp Loop
	}



	#import "patience/assets.asm"
	 
	//* = $400 "Screen Ram" virtual
	///.fill $400, 4


	* = 1024 "Screen Ram" virtual
	.fill 280, 0

* = 1304 "Card Data"
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$ae,$d5,$b0,$ae,$af,$b0,$ae,$b1,$b0,$ae
.byte $b2,$b0,$ae,$b3,$b0,$ae,$b4,$b0,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$b9,$d4
.byte $bb,$c1,$d6,$bb,$c1,$d7,$bb,$c1,$c2,$bb,$c1,$d7,$bb,$c1,$d7,$bb
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3
.byte $c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$ae,$b5
.byte $b0,$ae,$c9,$b0,$ae,$ca,$b0,$cb,$cc,$b0,$ae,$ad,$b0,$ae,$ce,$b0
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$c1,$c2,$bb,$c1,$d7,$bb,$c1,$d7,$bb,$d8
.byte $d9,$bb,$c1,$da,$bb,$c1,$db,$bb,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$c3,$c4
.byte $c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$ae,$cf,$b0,$ae,$d5,$b0,$ae,$dc,$b0,$ae
.byte $dd,$b0,$ae,$de,$b0,$ae,$df,$b0,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$c1,$e0
.byte $bb,$c1,$e0,$bb,$e1,$e2,$bb,$e1,$e3,$bb,$e1,$e4,$bb,$e1,$e3,$bb
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$c3,$c4,$c5,$c3,$c4,$c5,$e5,$e6,$c5,$e5
.byte $e6,$c5,$e5,$e6,$c5,$e5,$e6,$c5,$ae,$ca,$b0,$cb,$cc,$b0,$ae,$ad
.byte $b0,$ae,$ce,$b0,$ae,$cf,$b0,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$ae,$e7
.byte $b0,$ae,$e8,$b0,$ae,$e9,$b0,$ae,$ea,$b0,$eb,$ec,$b0,$ae,$ed,$b0
.byte $b9,$bc,$bb,$d0,$d1,$bb,$b9,$d2,$bb,$b9,$d3,$bb,$b9,$d4,$bb,$cd
.byte $cd,$cd,$cd,$cd,$cd,$cd,$e1,$e3,$bb,$e1,$e4,$bb,$e1,$e3,$bb,$e1
.byte $e3,$bb,$ee,$ef,$bb,$e1,$f0,$bb,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4
.byte $c5,$c3,$c4,$c5,$c3,$c4,$c5,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$e5,$e6
.byte $c5,$e5,$e6,$c5,$e5,$e6,$c5,$e5,$e6,$c5,$e5,$e6,$c5,$e5,$e6,$c5
.byte $ae,$af,$b0,$ae,$b1,$b0,$ae,$b2,$b0,$ae,$b3,$b0,$ae,$b4,$b0,$ae
.byte $b5,$b0,$ae,$c9,$b0,$cd,$ae,$f1,$b0,$ae,$f2,$b0,$ae,$f3,$b0,$ae
.byte $dc,$b0,$ae,$dd,$b0,$ae,$de,$b0,$b9,$ba,$bb,$b9,$bc,$bb,$b9,$bd
.byte $bb,$b9,$bc,$bb,$b9,$bc,$bb,$b9,$bd,$bb,$b9,$bc,$bb,$cd,$e1,$f4
.byte $bb,$e1,$f5,$bb,$e1,$f5,$bb,$e1,$f6,$bb,$e1,$f7,$bb,$e1,$f8,$bb
.byte $c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3,$c4,$c5,$c3
.byte $c4,$c5,$c3,$c4,$c5,$cd,$e5,$e6,$c5,$e5,$e6,$c5,$e5,$e6,$c5,$f9
.byte $fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$ae
.byte $df,$b0,$ae,$e7,$b0,$ae,$e8,$b0,$ae,$e9,$b0,$ae,$ea,$b0,$eb,$ec
.byte $b0,$ae,$ed,$b0,$ae,$f1,$b0,$ae,$f2,$b0,$ae,$f3,$b0,$b6,$b7,$b8
.byte $cd,$cd,$cd,$cd,$cd,$cd,$cd,$e1,$f7,$bb,$e1,$f7,$bb,$e1,$f8,$bb
.byte $e1,$f7,$bb,$e1,$f7,$bb,$fb,$fc,$bb,$e1,$fd,$bb,$e1,$fe,$bb,$e1
.byte $ff,$bb,$e1,$ff,$bb,$be,$bf,$c0,$cd,$cd,$cd,$cd,$cd,$cd,$cd,$f9
.byte $fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$f9,$fa
.byte $c5,$f9,$fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$f9,$fa,$c5,$c6,$c7,$c8



* = $0fff "End Of Memory" virtual
.byte 0
}