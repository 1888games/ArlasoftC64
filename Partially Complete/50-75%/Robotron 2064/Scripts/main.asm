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

	* = $2000

	#import "game/gameplay/player.asm"
	#import "game/gameplay/grunt.asm"
	#import "game/gameplay/bullet.asm"



	* = $5000
	#import "game/gameplay/mine.asm"
	#import "game/gameplay/shared.asm"
	#import "game/system/multiplexor.asm"
	#import "game/gameplay/humans.asm"
	#import "game/gameplay/hulk.asm"
	#import "game/gameplay/brain.asm"
	#import "game/gameplay/grunt_piece.asm"
	#import "game/gameplay/spheroid.asm"
	#import "game/system/level_data.asm"
	#import "game/gameplay/enforcer.asm"
	#import "game/system/sound.asm"

	#import "game/system/complete.asm"

	#import "common/sfx.asm"	
	#import "game/system/title.asm"	
	#import "game/gameplay/spark.asm"


	// sega sonic bros
	// freeze atari
	// qwak8


	

	//* = $8000 "Main"

	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	GameActive: 			.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	GameOverTimer:			.byte 30

	Entry: {


		jsr IRQ.DisableCIA
		jsr UTILITY.BankOutKernalAndBasic


		lda #GAME_MODE_TITLE
		sta GameMode

		lda #0
		jsr sid.init
		jsr set_sfx_routine
		jsr RANDOM.init
			
		jsr PLEXOR.Initialise
		jsr IRQ.SetupInterrupts

		jsr SetGameColours
		jsr SetupVIC

		jsr $4000

		lda #<$a000
		sta $4128 + 1

		lda #>$a000
		sta $4128 + 2


		//jsr $3000

		Wait:
			
		ldy #1
		lda INPUT.JOY_LEFT_NOW, y
		//beq Wait



		jmp TitleScreen

		jmp InitialiseGame

	}



	TitleScreen: {


		lda #GAME_MODE_TITLE
		sta GameMode

		lda #0
		sta GameActive
		
		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

 		jsr SetGameColours


 		lda #2
 		sta MAPLOADER.CurrentMapID

 		jsr MAPLOADER.DrawMap
 		
		//jsr SCORE.NewLevel


		lda #0
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		lda #1
		sta GameActive

		jmp Loop


	}



	

	ResetGame: {

		lda #0
		sta GameActive
		

		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

 		jsr SetGameColours

		//jsr UTILITY.ClearScreen

		jsr LoadScreen	

		jsr LEVEL_DATA.NewLevel

		jsr SPRITE_MANAGER.Reset

		jsr PLAYER.Initialise
		jsr GRUNT.Initialise
		jsr MINE.Initialise
		jsr HUMANS.Initialise
		jsr HULK.Initialise
		jsr SPHEROID.Initialise
		jsr ENFORCER.Initialise
		jsr SPARK.Initialise
		jsr BRAIN.Initialise


		jsr SCORE.DrawP1

		lda #GAME_MODE_PLAY
		sta GameMode

		lda #255
		sta VIC.SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR

		lda #0
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		lda #1
		sta GameActive

		rts

	}

	


	InitialiseGame: {
		
		jsr ResetGame



		jmp Loop

	}



	LoadScreen: {

		lda #0
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
	  
	SetGameColours: {

		lda #BLACK
		sta VIC.BACKGROUND_COLOR

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #BLUE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #GREEN
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #YELLOW
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




	ScrollBackground: {

		lda ZP.Counter
		and #%00000011
		bne NoScroll

		ldx #0
		
		Loop2:


			lda $f000, x
			asl
			adc #0
			sta $f000, x

			inx
			cpx #8
			bcc Loop2

		// lda $f000
		// sta ZP.Temp1

		// lda $f001
		// sta $f000

		// lda $f002
		// sta $f001

		// lda $f003
		// sta $f002

		// lda $f004
		// sta $f003

		// lda $f005
		// sta $f004

		// lda $f006
		// sta $f005

		// lda $f007
		// sta $f006

		// lda ZP.Temp1
		// sta $f007

		NoScroll:

		rts
	}



	FrameCode: {

		lda #0
		sta PerformFrameCodeFlag


		lda GameActive
		bne Active

		Paused:

			jmp Loop

		Active:

		lda GameMode
		cmp #GAME_MODE_PLAY
		beq Playing

		cmp #GAME_MODE_OVER
		beq GameOver

		cmp #GAME_MODE_TITLE
		beq TitleScreen2

		cmp #GAME_MODE_LEVEL_COMPLETE
		beq Complete

		TitleScreen2:

			lda GameOverTimer
			beq ReadyTitle

			dec GameOverTimer
			jmp NoFire

			ReadyTitle:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			//jsr SOUND.Tick

			lda #120
			sta GameOverTimer

			jmp InitialiseGame

		Complete:

			jsr COMPLETE.FrameUpdate
			jmp Loop

		NoFire:
			
			jsr PLEXOR.Sort
			jsr TITLE.FrameUpdate
			jmp Loop


		GameOver:

			lda GameOverTimer
			beq Ready

			dec GameOverTimer
			jmp Loop

			Ready:

			lda #30
			sta GameOverTimer

			jmp TitleScreen

		Playing:	

			//inc $d020
	
			jsr PLEXOR.Sort

		//	dec $d020

			//lda #4
			//sta $d020

		//	inc $d020

			SetDebugBorder(PURPLE)

			inc ZP.Counter

			lda ZP.Counter
			and #%00000001
			beq FrameOne

			FrameTwo:

				//lda #4
				//sta $d020

				jsr PLAYER.FrameUpdate
				jsr GRUNT.ProcessSpawn
				
				jsr GRUNT.FrameUpdate
				jsr MINE.FrameUpdate	
				jsr BULLET.FrameUpdate	
				jsr SPARK.FrameUpdate
				jsr SPRITE_MANAGER.FrameUpdate
				jsr BRAIN.FrameUpdate


				jmp Done

			FrameOne:

				//lda #3
				//sta $d020


				jsr GRUNT.ProcessSpawn
				jsr HUMANS.FrameUpdate
				jsr HULK.FrameUpdate
				jsr BULLET.FrameUpdate	
				jsr GRUNT_PIECE.FrameUpdate
				jsr ENFORCER.FrameUpdate
				jsr SPHEROID.FrameUpdate
				jsr SPRITE_MANAGER.FrameUpdate

			Done:

			//lda #0
			//sta $d020
			

			SetDebugBorder(DARK_GRAY)
			

			jmp Loop

		PreStage:

		
			jmp Loop




	}	
 
}

#import "game/system/spriteManager.asm"
#import "data/assets.asm"