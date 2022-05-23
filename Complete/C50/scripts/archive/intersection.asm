
.var debug = false

MAIN: {
		#import "intersection/zeropage.asm"


		
	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"

	
	* = $815 "Main"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {
		

		ldx #$3f
		stx ZP.LastSpawn
		txs
		sei


		//lda #$7f
		//sta IRQControlRegister1
	//	sta IRQControlRegister2


		lda #$FF  // maximum frequency values
		sta VIC.SPRITE_MULTICOLOR
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register
	
		lda #%00110101
		sta $01
	
		lda #%01110011
		sta VIC.SCREEN_CONTROL_2

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_2

		lda #%00010010
		sta VIC.MEMORY_SETUP

		lda #GREEN
		sta VIC.BACKGROUND_COLOR


		Restart:

		lda $d01e
		
		lda #0
		sta VIC.EXTENDED_BG_COLOR_2
		sta VIC.SPRITE_MULTICOLOR_1
		sta ZP.GameMode
		sta VIC.SPRITE_ENABLE
		tay

		Loop2:

			sta VIC.SPRITE_0_Y, y
			iny
			iny
			cpy #16
			bcc Loop2
		

		lda #GRAY
		sta VIC.EXTENDED_BG_COLOR_1
		sta ZP.ShakeTimer

		CopyHalf:

			ldx #240

			Loop5:

				lda SCREEN_RAM + 679, x
				sta SCREEN_RAM + 119, x

				dex
				bne Loop5

			ldx #120

			Loop4:

				lda SCREEN_RAM + 799, x
				sta SCREEN_RAM - 1, x

				dex
				bne Loop4


		jsr ColourScreen

		lda #15
		sta $d418
		sta ZP.Cooldown

		jsr GAME.Show
		jmp Loop


	}



	


	Get17: {

		
		ldx GAME.CurrentColour
		lda GAME.ValidColours, x
		sta ZP.Colour

		inx
		stx GAME.CurrentColour
		cpx #6
		bcc NoWrap

		lda #0
		sta GAME.CurrentColour

		NoWrap:

		rts

	}




	ColourScreen: {

		jsr RANDOM.Get
		and #%00000011
		sta GAME.CurrentColour

		lda #<SCREEN_RAM + 0
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 0
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 0
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 0
		sta ZP.ColourAddress + 1

		jsr Get17

		ldx #0
		ldy #0
		sty ZP.Amount
		inc ZP.Amount

		Loop:

			sty ZP.Y
			stx ZP.X

			cpx #16
			bne NoSwitch

			lda #0
			sta ZP.Amount


			 NoSwitch:

			lda (ZP.ScreenAddress), y
			cmp #225
			beq IsGrass

			cmp #234
			bcs CheckBuilding

			White:

				lda #9
				jmp ColourIt

			CheckBuilding:

				cmp #244
				bcs White

				lda ZP.Amount
				cmp #1
				bne NextColumn

				lda ZP.Colour
				sta (ZP.ColourAddress), y
				pha

				tya
				clc
				adc #40
				tay
				pla
				sta (ZP.ColourAddress), y

				ldy ZP.Y
				jmp NextColumn

			IsGrass:

				jsr Get17
				NoColour:
				lda #YELLOW

			ColourIt:

				sta (ZP.ColourAddress), y

			NextColumn:

				ldx ZP.X
				iny
				cpy #40
				bcc Loop

				jsr GAME.MoveDownRow

				inx
				inc ZP.Amount
				lda ZP.Amount
				cmp #3
				bne NoWrap

				lda #0
				sta ZP.Amount

				NoWrap:

				ldy #0
				cpx #25
				bcc Loop



		ldx #6

		Loop3:

			lda #244
			sta SCREEN_RAM + 40, x
			sta SCREEN_RAM + 71, x

			lda #9
			sta COLOR_RAM + 40, x
			sta COLOR_RAM + 71, x
			sta COLOR_RAM, x
			sta COLOR_RAM + 31, x


			dex
			bne Loop3


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

			
				jsr GAME.CheckControls
				jsr GAME.FrameUpdate

				lda ZP.GameMode
				bne NoCollision

				Collision:

				 lda $d01e
				 beq NoCollision

				 sta ZP.Cooldown

				 lda #RED
				 sta VIC.BORDER_COLOR
				 sta ZP.GameMode

				 ldx #0
				 jsr GAME.Crash

				NoCollision:
			

			Skip:

			jmp Loop

	}	






	#import "intersection/game.asm"
	#import "intersection/assets.asm"




	 
	* = $400 "Screen Ram" virtual
	.fill $400, 4



* = $0fff "End Of Memory" virtual
.byte 0
}