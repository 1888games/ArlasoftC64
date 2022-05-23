
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
		
		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		
		lda #BLACK
		sta VIC.BORDER_COLOR 
	
		jsr DRAW.ClearScreen

		jmp Loop
	}



	#import "sunday/assets.asm"
	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4



* = $0fff "End Of Memory" virtual
.byte 0
}