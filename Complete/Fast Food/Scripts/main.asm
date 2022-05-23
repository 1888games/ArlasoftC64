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
	#import "game/system/score.asm"
	#import "game/system/sound.asm"
	#import "game/gameplay/mouth.asm"

	* = $2000
	#import "game/gameplay/food.asm"
	#import "game/gameplay/interstition.asm"
	#import "game/gameplay/burp.asm"
	#import "game/gameplay/closed.asm"

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

		//jmp ShowTitleScreen	


		jmp ShowPage

		jmp InitialiseGame

	}







	ResetGame: {

		lda #0
		sta GameActive
		
		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		//ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

 		jsr SetGameColours

		jsr UTILITY.ClearScreen

		jsr LoadScreen	
		jsr SCORE.Reset

		jsr MOUTH.Initialise
		jsr FOOD.Initialise

		jsr MOUTH.NewGame
		jsr FOOD.NewGame


		lda #1
		sta GameActive

		lda #GAME_MODE_PLAY
		sta GameMode

		lda #255
		sta VIC.SPRITE_ENABLE

		lda #17
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y


		rts

	}


	ShowPage: {

		lda #0
		sta GameActive
		
		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		//ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

 		jsr SetGameColours

		jsr UTILITY.ClearScreen

		jsr LoadScreen	
		jsr SCORE.Reset
		jsr MOUTH.DrawPickles

		lda #GAME_MODE_OVER
		sta GameMode

		lda #30
		sta GameOverTimer

		lda #1
		sta GameActive

		jsr MOUTH.Initialise

		jmp Loop
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

		lda #%11111111
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

		lda #LIGHT_RED
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #ORANGE
	 	sta VIC.EXTENDED_BG_COLOR_2

	 	lda #LIGHT_GRAY
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

		cmp #GAME_MODE_INTERSTITION
		beq Inter

		cmp #GAME_MODE_BURP
		beq Burp

		cmp #GAME_MODE_CLOSED
		beq Closed

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


		Inter:

			jsr INTER.FrameUpdate
			jmp Loop

		Burp:

			jsr BURP.FrameUpdate
			jmp Loop


		Closed:

			jsr CLOSED.FrameUpdate
			jmp Loop


		Playing:	

			//inc $d020

			jsr MOUTH.FrameUpdate
			jsr FOOD.FrameUpdate
			jsr SCORE.FrameUpdate

			
		
		//	dec $d020

			jmp Loop

		PreStage:

		
			jmp Loop

		GameOver:

			jsr MOUTH.CheckFrame
			jsr MOUTH.UpdateSprite


			lda GameOverTimer
			beq Ready

			dec GameOverTimer
			jmp Loop

			Ready:

			lda INPUT.FIRE_UP_THIS_FRAME + 1
			beq Done

			jsr SOUND.Tick

			jmp InitialiseGame

			lda #GAME_MODE_PLAY
			sta GameMode

			jsr MOUTH.NewGame
			jsr FOOD.NewGame

			Done:

			jmp Loop
		

		GamePaused:

			jmp Loop

	}	
 
}

#import "data/assets.asm"