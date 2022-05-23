//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

.var sid = LoadSid("../assets/sfx/blank.sid")

MAIN: {

	#import "data/zeropage.asm"

	BasicUpstart2(Entry)

	*=$1000 "Modules"

	#import "data/labels.asm"
	#import "data/vic.asm"
	#import "game/system/irq.asm"
	#import "common/utility.asm"
	#import "common/macros.asm"
	#import "common/input.asm"
	
	#import "common/maploader.asm"
	#import "common/plot.asm"
	#import "common/random.asm"
	#import "game/gameplay/taz.asm"
	#import "game/gameplay/objects.asm"
	#import "game/system/score.asm"
	#import "game/system/sound.asm"
	

	* = $9000

	#import "common/sfx.asm"

	

	* = * "Main"

	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	GameActive: 			.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	GameOverTimer:			.byte 0
	
	Entry: {


		jsr IRQ.DisableCIA
		jsr UTILITY.BankOutKernalAndBasic


		lda #GAME_MODE_TITLE
		sta GameMode

		lda #0
		//jsr sid.init
		//jsr set_sfx_routine
		jsr RANDOM.init
		
		jsr IRQ.SetupInterrupts

		jsr SetGameColours
		jsr SetupVIC

		jsr $3000


		

		//jsr STATS.Calculate
		//jsr PLEXOR2.start

		jmp ShowTitleScreen	

		jmp InitialiseGame

	}







	ResetGame: {

		lda #0
		sta GameActive
		
		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

 		jsr SetGameColours

		jsr UTILITY.ClearScreen

		jsr LoadScreen	

		jsr TAZ.InitialiseGame
		jsr OBJECTS.InitialiseGame
		jsr SCORE.Reset

		lda #1
		sta GameActive

		lda #GAME_MODE_PLAY
		sta GameMode

		lda #255
		sta VIC.SPRITE_ENABLE



		rts

	}


	InitialiseGame: {
		
		jsr ResetGame



		jmp Loop

	}


	ShowTitleScreen: {

		lda #GAME_TITLE
		sta MAPLOADER.CurrentMapID

		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		//ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

		jsr MAPLOADER.DrawMap

		lda #GAME_MODE_TITLE
		sta GameMode

		lda #LIGHT_GRAY
		sta VIC.BACKGROUND_COLOR

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #ORANGE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #BLUE
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #LIGHT_GRAY
	 	sta VIC.EXTENDED_BG_COLOR_2

	 	lda #WHITE
	 	sta VIC.SPRITE_MULTICOLOR_2

	 	lda #1
	 	sta GameActive

	 	lda #0
		sta VIC.SPRITE_ENABLE

		jmp Loop
	}

	LoadScreen: {

		lda #GAME_MAP
		sta MAPLOADER.CurrentMapID

		jsr MAPLOADER.DrawMap

		

		rts
	}

	SetupVIC: {

		//lda #0
		//sta $bfff

		lda #ALL_ON
		sta VIC.SPRITE_ENABLE

		lda #%00001100
		sta VIC.MEMORY_SETUP

		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		and #%11111100
		//ora #%00000001
		sta VIC.BANK_SELECT

		lda #%00000000
		sta VIC.SPRITE_PRIORITY

		lda #%11111110
		sta VIC.SPRITE_MULTICOLOR


	SwitchOnMulticolourMode:

		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2


		rts
	}

	// traffic speeds
	// sounds
	  
	SetGameColours: {

		lda #BLACK
		sta VIC.BACKGROUND_COLOR

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #ORANGE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #BLUE
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #LIGHT_GRAY
	 	sta VIC.EXTENDED_BG_COLOR_2

	 	lda #WHITE
	 	sta VIC.SPRITE_MULTICOLOR_2

		rts

	}



	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		jmp FrameCode

	}




	FrameCode: {

		lda #0
		sta PerformFrameCodeFlag


		lda GameActive
		beq GamePaused

		lda GameMode
		cmp #GAME_MODE_PLAY
		beq Playing

		cmp #GAME_MODE_OVER
		beq GameOver

		cmp #GAME_MODE_TITLE
		beq TitleScreen

		TitleScreen:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire


			jsr SOUND.Tick

			jmp InitialiseGame

		NoFire:
			
			jmp Loop


		Playing:	

			//inc $d020

			jsr TAZ.FrameUpdate
			jsr OBJECTS.FrameUpdate
		
		//	dec $d020

			jmp Loop

		PreStage:

		
			jmp Loop

		GameOver:

			lda GameOverTimer
			beq Ready

			dec GameOverTimer
			jmp Loop

			Ready:

			lda INPUT.FIRE_UP_THIS_FRAME + 1
			beq Done

			jmp ShowTitleScreen

			Done:

			jmp Loop
		

		GamePaused:

			jmp Loop

	}	
 
}

#import "data/assets.asm"