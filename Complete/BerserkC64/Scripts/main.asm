  //exomizer sfx sys -t 64 -x "inc $d020" -o berzerk.prg main.prg

  //exomizer sfx sys -t 64 -x "lda #14 sta $d021 inc $d020" -o galaga.prg bin/main.prg

//.var sid = LoadSid("../assets/goattracker/galaga.sid")

MAIN: {

	#import "data/zeropage.asm"

	BasicUpstart2(Entry)

	*=$843 "Modules"

	#import "data/labels.asm"
	#import "data/vic.asm"
	#import "system/irq.asm"
	#import "common/utility.asm"
	#import "common/macros.asm"
	#import "common/input.asm"

	#import "common/maploader.asm"

	#import "system/multiplexor.asm"

	#import "system/title.asm"
	#import "system/disk.asm"
	#import "system/score.asm"
	#import "system/lives.asm"

	#import "common/random.asm"
	#import "common/plot.asm"

	#import "system/map.asm"
	#import "system/map_scroll.asm"
	#import "data/wall_data.asm"
	#import "gameplay/player/player.asm"
	#import "gameplay/bullets/fire.asm"
	#import "gameplay/bullets/bullet.asm"
	#import "gameplay/bullets/bullet_robot.asm"
	#import "gameplay/bullets/bullet_collision.asm"
	#import "gameplay/bullets/bullet_spawn.asm"
	#import "gameplay/robot/robot.asm"
	#import "gameplay/robot/collision.asm"
	#import "gameplay/robot/generate.asm"
	#import "system/sampler.asm"
	#import "gameplay/robot/ai.asm"
	#import "system/bonus.asm"
	#import "system/hi_score.asm"
	#import "gameplay/progression.asm"
	#import "gameplay/otto.asm"

	* = * "Main"

	GameActive: 			.byte FALSE
	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 07
	Cooldown:				.byte 0

	Loading:		.byte L,o,a,d,i,n,g,Dot,Dot,Dot
	Saving:			.byte S,a,v,i,n,g,Dot,Dot,Dot
	
	Entry: {

		lda $2A6
		sta MachineType

		jsr IRQ.DisableCIA

		lda #0
		sta ZP.Died


		jsr SaveKernalZPOnly

		jsr UTILITY.BankOutKernalAndBasic

		jsr RANDOM.init
		jsr PLEXOR.Initialise
		jsr IRQ.SetupInterrupts
		jsr SetGameColours	
		jsr SetupVIC

		
		jsr DrawLoading

	
		jsr LoadScores

		jmp ShowTitleScreen

		jmp InitialiseGame

	}


	DrawLoading: {

		ldx #0

		.label Row = 11

		Loop:

			lda Loading, x
			sta SCREEN_RAM + (Row * 40) + 15, x

			clc
			adc #16
			sta SCREEN_RAM + ((Row + 1) * 40) + 15, x

			inx
			cpx #10
			bcc Loop



		rts
	}

	DrawSaving: {

		ldx #0

		.label Row = 11

		Loop:

			lda Saving, x
			sta SCREEN_RAM + (Row * 40) + 15, x

			clc
			adc #16
			sta SCREEN_RAM + ((Row + 1) * 40) + 15, x

			lda #WHITE
			sta VIC.COLOR_RAM + (Row * 40) + 15, x
			sta VIC.COLOR_RAM + ((Row + 1) * 40) + 15, x

			inx
			cpx #9
			bcc Loop

		rts


	}


	LoadHiScore: {

		lda #0
		sta VIC.SPRITE_ENABLE

		jsr HI_SCORE.Initialise
		jmp Loop


	}
	
	LoadScores: {
	
		jsr DISK.LOAD

		lda LowByte
		sta SCORE.Best + 0

		lda MedByte 
		sta SCORE.Best + 1

		lda HiByte 
		sta SCORE.Best + 2

	
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

		
		rts
	}


	nmi: {

			lda Cooldown
			beq Okay

	
			rts

		Okay:

			lda #10
			sta Cooldown

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
			sta $d020

			dec GameActive
	


		Exit:


		rts
	}


	SetupTitleScreen: {

		lda #$0B 
		sta $d011

		jsr UTILITY.ClearScreen
	

		lda #1
		sta MAPLOADER.CurrentMapID

		jsr MAPLOADER.DrawMap

		jsr TITLE.Initialise
	
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
			


		rts
	}

	ShowTitleScreen: {

		jsr SetupTitleScreen
		jmp Loop

	}





	ResetSprites: {


		ldx #0

		Loop:

			lda #0
			sta SpriteY, x
			sta SpriteCopyY, x

			inx
			cpx #MAX_SPRITES


		rts
	}



	ResetGame: {

		lda #0
		sta GameActive
		sta SCORE.ScoreInitialised

		jsr UTILITY.ClearScreen

		
		lda #255
		sta PLAYER.SpawnSide

		jsr OTTO.NewGame
		jsr ROBOT.KillAll
		jsr SCORE.Reset
		jsr PROGRESSION.NewGame
		jsr MAP_GENERATOR.Generate
	
	
		jsr FIRE.Initialise
		
		jsr LIVES.NewGame
			
		ldx #0

		Loop:

			lda #40
			sta SpritePointer, x
			sta PointerCopy, x

			inx
			cpx #MAX_SPRITES
			bcc Loop


		lda #1
		sta GameActive

		
		lda #GAME_MODE_PLAY
		sta GameMode

	

		
		
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

		lda #ALL_ON
		sta VIC.SPRITE_ENABLE

		lda #0
		sta VIC.SPRITE_MULTICOLOR

		lda #%00000110
		sta VIC.MEMORY_SETUP

		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		and #%11111100
		sta VIC.BANK_SELECT

		lda #%00000000
		sta VIC.SPRITE_PRIORITY


		rts
	}

	SetGameColours: {

		lda #BLACK
		sta VIC.BACKGROUND_COLOR

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_1
		sta VIC.SPRITE_MULTICOLOR_1
	 	lda #GREEN
	 	sta VIC.EXTENDED_BG_COLOR_2
	 	sta VIC.SPRITE_MULTICOLOR_2

		rts

	}







	GameCode: {

		DoPalMode:	

			jsr PLEXOR.Sort

			lda MAP_GENERATOR.Scrolling
			beq NotMap

			IsMap:

				jsr MAP_GENERATOR.FrameUpdate
				jsr PLAYER.FrameUpdate	
				jsr SPEECH.FrameUpdate	

			
				jmp Loop

			NotMap:

				
				jsr BULLET.FrameUpdate
				jsr PLAYER.FrameUpdate		
				jsr FIRE.FrameUpdate

				lda $d012
				cmp #180
				bcc Okay2

				jmp Skip

			Okay2:

				jsr ROBOT.FrameUpdate
				jsr OTTO.FrameUpdate

				jsr BONUS.FrameUpdate
				jsr SPEECH.FrameUpdate

			Skip:


			jmp Loop

	}

	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		lda Cooldown
		beq Okay

		dec Cooldown

		Okay:

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
		
		cmp #GAME_MODE_SCORE
		beq Score

		cmp #GAME_MODE_SWITCH_TITLE
		bne TitleScreen


		jmp ShowTitleScreen

		GameOver:

			jsr PLEXOR.Sort
			
			jmp Loop
		
		TitleScreen:

			jsr PLEXOR.Sort
			jsr TITLE.FrameUpdate
			jsr SPEECH.FrameUpdate

			lda GameMode
			cmp #GAME_MODE_PLAY
			beq Loop

			jmp Loop

		
		Score:

			jsr HI_SCORE.FrameUpdate
			jmp Loop

		Playing:	

			jmp GameCode

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
		FirstInitials:		.byte M,E,I,E,A,H,H,L
		SecondInitials:		.byte A,M,S,R,T,I,A,O
		ThirdInitials:		.byte M,E,T,E,S,S,T,L

		HiByte:				.byte $01, $00, $00, $00, $00, $00, $00, $00
		MedByte:			.byte $00, $75, $50, $40, $30, $20, $10, $05
		LowByte:			.byte $00, $00, $00, $00, $00, $00, $00, $00

		* = * "EndScore"
* = $4D00 "Game ZP Backup"
	
	GameZP:		.fill 256, 0
	KernalZP:	.fill 256, 0




	//#import "game/system/sampler.asm"	
	#import "data/assets.asm"
	
	#import "system/speech.asm"

* = SCREEN_RAM "Screen RAM"


	.fill 1000, 0

	* = SCREEN_RAM + $3f8 + 7 "Pointer"
