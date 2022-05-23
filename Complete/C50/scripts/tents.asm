
.var debug = false

MAIN: {
		#import "tents/zeropage.asm"

	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"
	#import "tents/game.asm"

	* = * "MAIN"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {	

		 lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register

	//	lda #$7f
	//	sta IRQControlRegister1
	//	sta IRQControlRegister2

		lda #$35
		sta $01

		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		sta ZP.GameMode

		

		ldx #244

		Loop:

			lda #0
			sta VIC.COLOR_RAM - 1, x

			lda #2	
			sta VIC.COLOR_RAM + 279, x

			lda #7
			sta VIC.COLOR_RAM + 599, x

			lda #4
			sta VIC.COLOR_RAM + 839, x
			sta ZP.GridSize
			//sta ZP.Cooldown

			dex
			bne Loop

		Wait:

		lda $dc00
		and #JOY_FIRE
		bne Wait

		lda #%00010010
		sta VIC.MEMORY_SETUP

		lda #%01111000
		sta VIC.SCREEN_CONTROL_2

		lda #1
		sta ZP.Level
	

		lda #GREEN
		sta VIC.BORDER_COLOR
		sta ZP.Cooldown
		
		Finish:
			

		jmp StartGame

	}


	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 


			

			inc ZP.Counter
			lda ZP.Counter

			and #%00000011
			bne NoFlash

			inc VIC.SPRITE_COLOR_0
	
			NoFlash:

			lda ZP.GameMode
			beq Play

			EndOfLevel:

				lda ZP.GameOverCount
				beq Ready

				and #%00000111
				bne NoFlash2

				inc $d020

				NoFlash2:

				dec ZP.GameOverCount
				jmp Loop

			Ready:

				dec ZP.GameMode

				inc ZP.Level
				lda ZP.Level
				lsr
				lsr

				clc
				adc #5
				sta ZP.GridSize

				cmp #12
				bcc Reset

				lda #11
				jmp Reset
				

			Play:	

			sta $d418
			lda ZP.ScoreCounter
			beq Ready2

			dec ZP.ScoreCounter
			jmp Skip


			Ready2:

			dec ZP.ScoreCounter

			lda ZP.ScoreThisRound
			beq Skip

			sed
			sec
			sbc #1
			sta ZP.ScoreThisRound
			cld

			Skip:

			jsr CheckControls


			jmp Loop
		
	}	


		Reset: {

		lda #BlankCharacterID
		ldx #250

		Loop3:

			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop3

		lda #BLACK

		Loop2:

			sta VIC.COLOR_RAM - 1, x
			sta VIC.COLOR_RAM + 249, x
			sta VIC.COLOR_RAM + 499, x
			sta VIC.COLOR_RAM + 749, x

			dex
			bne Loop2

		Finish:

		jsr GAME.CreateGrid
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


	.label BlankCharacterID = 200

	

	StartGame: {
		
		lda #LIGHT_GREEN
		sta VIC.BACKGROUND_COLOR
		
		lda #BLACK
		sta VIC.BORDER_COLOR 
		sta VIC.EXTENDED_BG_COLOR_1
		sta ZP.Score + 1
		sta ZP.Score

		lda #ORANGE
		sta VIC.EXTENDED_BG_COLOR_2

		lda #<GAME.Controls
		sta ZP.ControlAddress

		lda #>GAME.Controls
		sta ZP.ControlAddress + 1

		lda #$99
		sta ZP.ScoreThisRound

		jmp Reset
	
		
	}
 
		




	

	TitleScreen: {

		* = 1024 + 40
		.encoding "screencode_upper"
		
		
		//.text "                                        "


		* = $518
	
		.text "             TENTS AND TREES            "
		.text "                                        "
		.text "            (C) ARLASOFT 2020           "
		.text "                                        "
		.text "                                        "
		.text "         CASSETTE 50 COMPETITION        "
		.text "                                        "
		.text "      ALL CODE AND DATA UNDER $1000     "
		.text "                                        "
		.text "                                        "
		.text "     PLACE A TENT NEXT TO EACH TREE     "
		.text "   SO THAT THE TOTAL IN EACH ROW AND    "
		.text "  COLUMN MATCHES THE NUMBERS DISPLAYED  "
		.text "                                        "
		.text "                                        "
		.text "           JOYSTICK IN PORT 2           "
		.text "                                        "
		.text "                                        "


	


		
	}


	#import "tents/assets.asm"
	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4

	//* = $2a7 



* = $0fff "End Of Memory" virtual
.byte 0
}