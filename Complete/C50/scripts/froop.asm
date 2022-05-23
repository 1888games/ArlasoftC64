
.var debug = false

MAIN: {
		#import "froop/zeropage.asm"


		
	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"

	.label NextCellTime = 14


	* = $812 "MAIN"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {
		

		ldx #$3f
		txs
		sei

		ldx #231

		LoopC:

			lda $0540 - 1, x
			sta $0140 - 1, x

			lda $061C - 1, x
			sta $021C - 1, x

			//lda $06F8 - 1, x
		//	sta $02F8 - 1, x

		
			dex
			bne LoopC

		Restart:


		lda #NextCellTime
		sta ZP.NextCellSpeed


		lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register

		lda #$35
		sta $01
		sta ZP.LastQuadrant

		lda #%01111000
		sta VIC.SCREEN_CONTROL_2

		DrawTop:

			ldx #10

			LoopT:

				lda TopLeft - 1, x
				sta SCREEN_RAM + 2, x

				lda #GREEN
				sta COLOR_RAM + 2, x

				lda Middle - 1, x
				sta SCREEN_RAM + 14, x

				lda #CYAN
				sta COLOR_RAM + 14, x

				lda TopRight - 1, x
				sta SCREEN_RAM + 28, x

				lda #YELLOW
				sta COLOR_RAM + 28, x

				dex
				bne LoopT

		lda #DARK_GRAY
		sta VIC.BACKGROUND_COLOR
		
		lda #BLACK
		sta VIC.EXTENDED_BG_COLOR_2
		sta ZP.Takeaway
		sta ZP.Takeaway + 2
	
		lda #5
		sta ZP.Takeaway + 1
	
		lda #LIGHT_GREEN
		sta VIC.EXTENDED_BG_COLOR_1


		jmp StartGame


	

	}


	

	StartGame: {

		ldx #3
		stx ZP.Cooldown



		Loop2:

			lda ZP.Takeaway - 1, x
			clc
			adc #48
			sta SCREEN_RAM + 34, x

			dex
			bne Loop2

		lda #BLACK
		sta VIC.BORDER_COLOR
		sta ZP.GameMode

		jsr GAME.Show
		jmp Loop

	}

	.encoding "screencode_upper"
	TopLeft: .text 	"LEVEL 01  "
	Middle:	 .text 	"SCORE 0000"
	TopRight: .text "TO GO 000 "

	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #255
		bne Loop

		FrameCode: 


			lda #0
			sta $d418

			lda ZP.GameMode
			beq Playing

			CheckFire:

			lda ZP.Cooldown
			beq Ready

			dec ZP.Cooldown
			jmp Skip

			Ready:

				lda $dc00
				and #JOY_FIRE
				bne Skip

				lda ZP.GameMode
				cmp #1
				beq StartGame

				jmp Entry.Restart

			Playing:

				jsr GAME.CheckControls
				jsr GAME.FrameUpdate

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






	#import "froop/game.asm"
	#import "froop/assets.asm"
	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4



* = $0fff "End Of Memory" virtual
.byte 0
}