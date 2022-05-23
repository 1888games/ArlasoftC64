  //exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

  //exomizer sfx sys -t 64 -x "lda #14 sta $d021 inc $d020" -o galaga.prg bin/main.prg

.var sid = LoadSid("../assets/goattracker/galaga.sid")

MAIN: {

	#import "data/zeropage.asm"

	BasicUpstart2(Entry)

	*=$880 "Modules"

	#import "data/labels.asm"
	#import "data/vic.asm"
	#import "game/system/irq.asm"
	#import "common/utility.asm"
	#import "common/macros.asm"
	#import "common/input.asm"
	#import "game/gameplay/ship.asm"
	#import "game/gameplay/bullets.asm"
	#import "game/gameplay/formation.asm"

	#import "common/maploader.asm"

	#import "game/system/stars.asm"



	#import "game/system/multiplexor.asm"
	#import "game/gameplay/enemy.asm"
	#import "game/gameplay/enemy_variables.asm"
	#import "game/gameplay/collision.asm"
	
	#import "game/gameplay/spawn.asm"
	#import "game/gameplay/pathfinding.asm"
	#import "game/gameplay/stage.asm"

	#import "common/text.asm"
	#import "data/enemy_data.asm"
	#import "game/system/title.asm"

	#import "game/system/demo.asm"
		#import "game/system/hi_score.asm"
	* = $f800



		

 	* = $8000


	#import "game/system/disk.asm"
	#import "game/system/score.asm"
	#import "game/gameplay/bombs.asm"
	#import "game/system/lives.asm"
	#import "game/system/pre_stage.asm"
	#import "common/random.asm"
	#import "common/plot.asm"



	#import "game/system/stats.asm"
	#import "game/system/game_over.asm"
	#import "common/sfx.asm"

	#import "game/system/bonus.asm"

	#import "game/gameplay/charger.asm"
	#import "game/gameplay/flight.asm"

	#import "game/gameplay/spriteCharLookup.asm"


	* = $6c00 "Main"

	GameActive: 			.byte FALSE
	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	
	Entry: {

		lda $2A6
		sta MachineType

		jsr IRQ.DisableCIA

		jsr SaveKernalZPOnly

		jsr UTILITY.BankOutKernalAndBasic

		lda #SUBTUNE_BLANK
		jsr sid.init

		jsr set_sfx_routine
		jsr RANDOM.init
		jsr PLEXOR.Initialise
		jsr IRQ.SetupInterrupts
		jsr SetGameColours	
		jsr SetupVIC
		jsr SetupRestoreKey

		lda #11
		sta TextRow

		lda #14
		sta TextColumn

		ldx #WHITE
		lda #TEXT.LOADING

		jsr TEXT.Draw

		lda #14
		sta TextColumn

		inc TextRow
		inc TextRow

		ldx #WHITE
		lda #TEXT.LOADING2

		jsr TEXT.Draw

		lda #0
		sta TextColumn

		lda #24
		sta TextRow

		ldx #WHITE
		lda #TEXT.VERSION

		jsr TEXT.Draw


		jsr LoadScores

		ldx #0

		DelayLoop:

			lda $d012
			cmp #200
			bne DelayLoop

			inx
			
		Wait:
			cmp $d012
			beq Wait
			cpx #1
			bcc DelayLoop

		sfx(SFX_COIN)

		jmp ShowTitleScreen	

		jmp InitialiseGame

	}

	
	LoadScores: {
	
		jsr DISK.LOAD

		lda LowByte
		sta SCORE.Best + 0

		lda MedByte 
		sta SCORE.Best + 1

		lda HiByte 
		sta SCORE.Best + 2

		lda MillByte 
		sta SCORE.Best + 3

		rts
	}
	

	SetupRestoreKey: {

		lda #<nmi
		sta $fffa
		lda #>nmi
		sta $fffb

		rts
	}


	Unpause: {

		inc GameActive

		ldy #BLACK
		sty $d020

		ldx #7
		ldy #23
		lda #25

		jsr UTILITY.DeleteText

		rts
	}


	nmi: {

		:StoreState()

		
			lda GameMode
			cmp #GAME_MODE_PLAY
			beq CanPause

			cmp #GAME_MODE_PRE_STAGE
			beq CanPause

			jmp Exit

		CanPause:

			lda GameActive
			bne Pause

			jsr Unpause
		
			jmp Exit

		Pause:

			lda #0
			sta $D418

			lda #RED
			//sta $d020

			lda #23
			sta TextRow

			lda #7
			sta TextColumn

			ldx #GREEN
			lda #TEXT.PAUSE

			jsr TEXT.Draw

			dec GameActive
	
		

		Exit:

		:RestoreState()

		rti
	}


	ShowTitleScreen: {


	
		jsr TITLE.Initialise
		//jsr LoadScreen

		lda #GAME_MODE_TITLE
		sta GameMode

		lda #TRUE
		sta GameActive

		lda #0
		sta VIC.SPRITE_ENABLE

		ldx #0

		Loop2:

			sta SpriteY, x

			inx
			cpx #MAX_SPRITES
			bcc Loop2
			


		jmp Loop


		rts
	}


	ResetGame: {

		lda #0
		sta GameActive
		sta SCORE.ScoreInitialised

		jsr UTILITY.ClearScreen

		jsr LoadScreen	

		jsr SCORE.Reset
		jsr SCORE.DrawP1
		jsr SCORE.DrawBest
		jsr STATS.Reset

		jsr LIVES.NewGame
		jsr LIVES.Draw
		
		

		jsr PRE_STAGE.Initialise

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

		lda #RED
		sta VIC.COLOR_RAM + 272
		sta VIC.COLOR_RAM + 432



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

		lda #LIGHT_RED
		lda #RED
		sta VIC.EXTENDED_BG_COLOR_1
		sta VIC.SPRITE_MULTICOLOR_1
	 	lda #BLUE
	 	sta VIC.EXTENDED_BG_COLOR_2
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
		bne IsActive

		jmp GamePaused

	IsActive:

		lda GameMode
		cmp #GAME_MODE_PLAY
		beq Playing

		cmp #GAME_MODE_PRE_STAGE
		beq PreStage

		cmp #GAME_MODE_OVER
		beq GameOver
		
		cmp #GAME_MODE_SCORE
		beq Score

		cmp #GAME_MODE_DEMO
		beq Demo

		cmp #GAME_MODE_SWITCH_TITLE
		bne TitleScreen


		jmp ShowTitleScreen

		GameOver:

			jsr PLEXOR.Sort
			jsr FORMATION.FrameUpdate	
			jsr LIVES.FrameUpdate
			jsr STARS.FrameUpdate
			jsr END_GAME.FrameUpdate
			jsr BONUS.FrameUpdate
			jsr CHARGER.FrameUpdate


			jmp Loop
		

		Demo:

			jsr STARS.FrameUpdate
			jsr DEMO.FrameCode
			jsr CHARGER.FrameUpdate

			jmp Loop

		Score:

			jsr STARS.FrameUpdate
			jsr HI_SCORE.FrameCode
			jsr CHARGER.FrameUpdate

			jmp Loop


		TitleScreen:
			
			jsr PLEXOR.Sort
			jsr TITLE.FrameUpdate

			lda GameMode
			cmp #GAME_MODE_PLAY
			beq Loop

			jsr STARS.FrameUpdate
			jsr CHARGER.FrameUpdate

			
			jmp Loop

			
		PreStage:

			jsr STARS.FrameUpdate
			jsr PRE_STAGE.FrameUpdate
			jsr LIVES.FrameUpdate
			jsr BONUS.FrameUpdate
		//	jsr SHIP.FrameUpdate
			jsr CHARGER.FrameUpdate

			jmp Loop


		Playing:	

			lda IRQ.SidTimer
			bmi DoPalMode



		DoNTSCMode:

			lda IRQ.SidTimer
			cmp #1
			beq Skip

			jsr PLEXOR.Sort
			
			jsr FORMATION.CalculateEnemiesLeft

			jsr SHIP.FrameUpdate
			jsr BULLETS.FrameUpdate		
			jsr BONUS.FrameUpdate
			jsr BOMBS.FrameUpdate
			jsr SFX.FrameUpdate
			jsr LIVES.FrameUpdate


		Skip:

			
			jsr STAGE.FrameUpdate
			jsr ENEMY.FrameUpdate
			jsr CHARGER.FrameUpdate


			lda IRQ.SidTimer
			cmp #1
			bne DoMore

			jsr STARS.FrameUpdate
			
			jmp Loop
			
		DoMore:

		Wait:

			lda $d012
			cmp #146
			bcc Wait

		jsr FORMATION.FrameUpdate

			lda $d012
			cmp #200

			bcs NoStars2

			jsr STARS.FrameUpdate


		NoStars2:
		
			jmp Loop

		DoPalMode:

			jsr PLEXOR.Sort

			lda IRQ.Frame
			clc
			adc #1
			cmp #5
			bcc Okay

			lda #0

		Okay:

			sta IRQ.Frame

			jsr FORMATION.FrameUpdate		
			jsr FORMATION.CalculateEnemiesLeft
		
			jsr SFX.FrameUpdate

			jsr STAGE.FrameUpdate
			jsr ENEMY.FrameUpdate
			jsr CHARGER.FrameUpdate
			jsr BOMBS.FrameUpdate
			jsr LIVES.FrameUpdate

			jsr SHIP.FrameUpdate
			jsr BULLETS.FrameUpdate		
			
			jsr BONUS.FrameUpdate

		Stars:
				lda $d012
				cmp #180

				bcs NoStars
				jsr STARS.FrameUpdate

			NoStars:
		
			jmp Loop


		

		GamePaused:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoQuit

			jsr Unpause

			lda #GAME_MODE_SWITCH_TITLE
			sta GameMode

			lda #0
			sta SCORE.ScoreInitialised
			sta TITLE.Players

			 lda #0
            sta $d404               // Sid silent 
            sta $d404+7 
            sta $d404+14 

			jsr SCORE.Reset

		NoQuit:

			jmp Loop
	}	

	SaveKernalZP: {

		ldx #2

		Loop:

			lda $00, x
			sta KernalZP, x

			lda GameZP, x
			sta $00, x

			inx
			bne Loop

		rts
	}

	SaveKernalZPOnly: {

		ldx #2

		Loop:

			lda $00, x
			sta KernalZP, x
			inx
			bne Loop

		rts
	}

	SaveGameZP: {

		ldx #2

		Loop:

			lda $00, x
			sta GameZP, x

			lda KernalZP, x
			sta $00, x

			inx
			bne Loop

		rts
	}
	
	
 
}

* = $810 "Hi score_Data"

		FirstInitials:		.text "acnse"
		SecondInitials:		.text "roiaa"
		ThirdInitials:		.text "lrcmk"

		// HiByte:				.byte $10, $07, $04, $02, $01, $10, $07, $04, $02, $01, $10, $07, $05, $02, $01
		// MedByte:			.byte $45, $69, $82, $57, $50, $45, $69, $82, $57, $29, $52, $41, $11, $40, $58
		// LowByte:			.byte $23, $12, $70, $63, $78, $91, $52, $46, $02, $08, $99, $31, $47, $28, $12

		MillByte:			.byte $00, $00, $00, $00, $00
		HiByte:				.byte $01, $01, $00, $00, $00
		MedByte:			.byte $50, $00, $75, $50, $20
		LowByte:			.byte $00, $00, $00, $00, $00

		Minutes:			.byte 9
		TenSeconds:			.byte 5
		Seconds:			.byte 9
		Hundreds:			.byte 0

* = $a500 "Game ZP Backup"
	
GameZP:		.fill 256, 0
KernalZP:	.fill 256, 0



		
	#import "data/assets.asm"