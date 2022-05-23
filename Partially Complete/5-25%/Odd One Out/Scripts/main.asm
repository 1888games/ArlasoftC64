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
	#import "data/assets.asm"
	#import "common/maploader.asm"
	#import "common/plot.asm"
	#import "common/random.asm"
	#import "common/text.asm"
	#import "game/gameplay/generate.asm"
	#import "game/gameplay/sprites.asm"

	

	* = $9000

	#import "common/sfx.asm"

	

	* = * "Main"

	GameActive: 			.byte FALSE
	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	
	Entry: {


		jsr IRQ.DisableCIA
		jsr UTILITY.BankOutKernalAndBasic


		lda #0
		jsr sid.init
		jsr set_sfx_routine
		jsr RANDOM.init
		
		jsr IRQ.SetupInterrupts

		jsr SetGameColours
		jsr SetupVIC

		//jsr STATS.Calculate
		//jsr PLEXOR2.start

		//jmp ShowTitleScreen	

		jmp InitialiseGame

	}



	ShowTitleScreen: {

		jsr UTILITY.ClearScreen
	
		//jsr LoadScreen

		lda #GAME_MODE_TITLE
		sta GameMode

		lda #TRUE
		sta GameActive

		jmp Loop


		rts
	}





	ResetGame: {

		lda #0
		sta GameActive
		

		jsr UTILITY.ClearScreen

		jsr LoadScreen	

		jsr GENERATE.Initialise

		jsr GENERATE.NewLevel

		jsr GENERATE.CreateNewPeep

		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep
		jsr GENERATE.CreateNewPeep

		rts

	}


	InitialiseGame: {
		
		jsr ResetGame



		jmp Loop

	}


	LoadScreen: {

		lda #GAME_MAP
		sta MAPLOADER.CurrentMapID

		jsr MAPLOADER.DrawMap

		

		rts
	}

	SetupVIC: {

		lda #0
		sta $bfff

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

		lda #%11111111
		sta VIC.SPRITE_MULTICOLOR


	SwitchOnMulticolourMode:

		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2


		rts
	}

	SetGameColours: {

		lda #BLACK
		sta VIC.BACKGROUND_COLOR

		lda #BLACK
		sta VIC.BORDER_COLOR
		sta VIC.SPRITE_MULTICOLOR_1

		lda #GREEN
		sta VIC.EXTENDED_BG_COLOR_1
		


	 	lda #LIGHT_BLUE
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

		cmp #GAME_MODE_PRE_STAGE
		beq PreStage

		cmp #GAME_MODE_OVER
		beq GameOver

		cmp #GAME_MODE_SWITCH_TITLE
		bne TitleScreen

		jmp ShowTitleScreen


		TitleScreen:
			
			lda GameMode
			cmp #GAME_MODE_PLAY
			beq Loop


			
			jmp Loop


		Playing:	

			//inc $d020

		

			//dec $d020

			jmp Loop

		PreStage:

		
			jmp Loop

		GameOver:

			jmp Loop
		

		GamePaused:

			jmp Loop


	}	
 
}