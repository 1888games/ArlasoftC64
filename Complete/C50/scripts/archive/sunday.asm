
.var debug = false

MAIN: {

	#import "sunday/zeropage.asm"
	BasicUpstart2(Entry)



	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"
	#import "common/draw.asm"



	// = $0dea
	* = * "MAIN"


	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {


		ldx #$2f
		txs
		sei

		ldx #231

		LoopC:

			lda $0530 - 1, x
			sta $0130 - 1, x

			lda $060C - 1, x
			sta $020C - 1, x

			lda $06F0 - 1, x
			sta $02F0 - 1, x

		
			dex
			bne LoopC

		Restart:

		
		lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register

		//lda #$7f
		//sta IRQControlRegister1
		//sta IRQControlRegister2

		lda #$35
		sta $01


		ldx #255

		Loopy:

			dex
			bne Loopy
	
      	// jmp Entry

	

		Finish:
			

		jmp StartGame

	}


	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 

			jsr CheckControls
			//jsr MATCH.Process
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
		
		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		
		lda #BLACK
		sta VIC.BORDER_COLOR 
	

		jsr DRAW.ClearScreen
		
		jsr PLAYERS.Reset
		jsr MENU.Show

		jmp Loop
	}




	#import "sunday/menu.asm"
	#import "sunday/match.asm"
	#import "sunday/players.asm"	
	#import "common/assets.asm"


	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4



* = $0fff "End Of Memory" virtual
.byte 0
}