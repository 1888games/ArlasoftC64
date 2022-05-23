//exomizer sfx sys -t 64 -x "inc $d020" -o pacman_FH.prg main.prg 

.var sid = LoadSid("../assets/sfx/pac2.sid")
.var game = "Plus"

MAIN: {

	#import "data/zeropage.asm"

	BasicUpstart2(Entry)

	*=$80e "Modules"

	#import "data/labels.asm"
	#import "data/vic.asm"
	#import "system/irq.asm"
	#import "common/utility.asm"
	#import "common/macros.asm"
	#import "common/input.asm"
	//#import "common/maploader.asm"
	#import "common/plot.asm"
	#import "common/random.asm"
	#import "system/screen/score.asm"
	#import "common/sfx.asm"	
	
	#import "system/map/scroller.asm"
	#import "system/map/scroll_down.asm"
	#import "system/map/scroll_up.asm"
	#import "system/map/map.asm"

	#import "gameplay/actor/actor.asm"
	#import "gameplay/actor/actor_data.asm"

	#import "gameplay/ghost/ghost.asm"
	#import "gameplay/ghost/ghost_home.asm"
	#import "gameplay/ghost/ghost_commander.asm"
	#import "gameplay/ghost/ghost_sprite.asm"
	#import "gameplay/ghost/ghost_move.asm"
	#import "gameplay/ghost/ghost_lookup.asm"
	#import "gameplay/ghost/ghost_ai.asm"
	#import "gameplay/ghost/ghost_releaser.asm"


	#import "gameplay/player/player.asm"
	#import "gameplay/player/player_collision.asm"
	#import "gameplay/player/player_sprite.asm"
	#import "gameplay/player/player_control.asm"
	#import "gameplay/player/player_move.asm"
	#import "gameplay/player/player_sound.asm"
	#import "gameplay/player/player_dead.asm"
                                                      
	#import "gameplay/energizer.asm"
	#import "gameplay/game.asm"
	#import "gameplay/fruit.asm"
	
	#import "system/multiplexor.asm"
	#import "system/screen/top_hud.asm"
	#import "system/screen/bottom_hud.asm"
	#import "system/screen/game_sprites.asm"
	#import "system/state/title.asm"
	#import "system/state/ready.asm"
	#import "system/state/intermission.asm"

	* = $7500 
	#import "system/state/complete.asm"
	#import "system/pacrand.asm"
	#import "system/disk.asm"

	#import "gameplay/direction.asm"
	//#import "system/map/kill.asm"

	* = * "Main"

	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	GameActive: 			.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	PreviousMode:			.byte 0
	Timer:					.byte 50
	KickOff:				.byte 0

	DebugMode:				.byte 0

	.label StartWait = 5

	.label SONG_BLANK = 4
	.label SONG_TUNE = 0
	.label SONG_ALARM_1 = 1
	.label SONG_ALARM_2 = 2
	.label SONG_ALARM_3 = 3
	.label SONG_ALARM_4 = 5
	.label SONG_INTERMISSION = 6


	.text "noggerinos is a massive cunt"
	.text "so is jason @codingandthings"

	Loading:	.text @"loading...\$00"
	Saving:		.text @"saving...\$00"

	Entry: {

		lda $2A6
		sta MachineType
		
		lda $d011
		and #%01111111
		sta SCROLLER.D011


		jsr IRQ.DisableCIA
		jsr SaveKernalZPOnly
		jsr UTILITY.BankOutKernalAndBasic


		lda #GAME_MODE_TITLE
		sta GameMode


		lda #0
		sta KickOff

		jsr set_sfx_routine
		jsr RANDOM.init
		jsr PLEXOR.Initialise
			
		jsr IRQ.SetupInterrupts

		jsr SetGameColours
		jsr SetupVIC

		jsr DrawLoading

		
		jsr DISK.LOAD

		

		.if (game == "Plus") {

			lda #CYAN
			sta COMPLETE.MainColour

			lda #BLUE
			sec
			sbc COMPLETE.MainColour
			sta COMPLETE.ColourOffset
		}


		jmp TitleScreen

		jmp InitialiseGame

	}


	DrawLoading: {

		ldx #0

		.label Row = 11

		Loop:

			lda Loading, x
			sta SCREEN_RAM + (Row * 40) + 15, x

			lda #WHITE
			sta VIC.COLOR_RAM + (Row * 40) + 15, x


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

			lda #WHITE
			sta VIC.COLOR_RAM + (Row * 40) + 15, x

			inx
			cpx #9
			bcc Loop

		rts


	}


	TitleScreen: {
		

		jsr SFX_KIT_INIT
		jsr SFX_KIT_CLR
		//jsr $3000

		lda #SONG_BLANK
		jsr sid.init


		
		lda #0
		sta GameActive
		sta GAME.Started
		sta TOP_HUD.FlashCounter
		
 		jsr SetGameColours

 		jsr TITLE.Initialise

 		lda #GAME_MODE_TITLE
		sta GameMode


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






	WaitForVBlank: {

		lda $d012
		cmp #5
		bne WaitForVBlank

		rts


	}
	ResetGame: {

		
	//	jsr WaitForVBlank


		lda #0
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		lda #%11101111
		sta IRQ.ScreenOff	

		
		lda #0
		sta VIC.BORDER_COLOR
		sta VIC.BACKGROUND_COLOR
		sta GameActive
		sta VIC.SPRITE_ENABLE
	
 		
 		jsr SCORE.Reset
 		
 		jsr NewGame

		lda #StartWait
		sta Timer
		

		lda GAME.AttractMode
		bne NoSong

		lda #SONG_TUNE
		jsr sid.init

		NoSong:


	//	jsr WaitForVBlank
		jsr SetGameColours


		lda #%11111111
		sta IRQ.ScreenOff

		rts

	}


	NewGame: {

		lda #%00000000
		sta VIC.SPRITE_PRIORITY

		jsr UTILITY.ClearScreen

		jsr MAP.RefreshColourMap


		lda COMPLETE.MainColour
		jsr MAP.ColourScreen

		jsr CommonReset
		jsr READY.NewGame
		jsr GAME.New
 		jsr ACTOR.GHOST.SetupCommander
	
		jsr ENERGIZER.NewGame

		rts
	}


	CommonReset: {

		jsr SCROLLER.InitialSetup	
		
		
 		jsr MAP.DisplayInitialScreen

		lda #GAME_MODE_READY
		sta GameMode

		lda #1
		sta KickOff
		sta GameActive

		ldy GAME.AttractMode
		bne IsAttractMode

		sta BOTTOM_HUD.ShowLives

		IsAttractMode:

		rts
	}
	


	NewLevel: {


		lda #%11101111
		sta IRQ.ScreenOff

		lda #0
		sta VIC.SPRITE_ENABLE	

		//jsr WaitForVBlank

		jsr INTERMISSION.CheckIfIntermission

		lda GameMode
		cmp #GAME_MODE_INTERMISSION
		beq Finish

		jsr GAME.NewLevel

		jsr ACTOR.PLAYER.NewLevel
		jsr ENERGIZER.NewGame
		jsr FRUIT.NewLevel
		jsr ACTOR.GHOST.SetupCommander

		lda COMPLETE.CurrentColour
		jsr MAP.ColourScreen

		jsr MAP.RefreshColourMap

		jmp ResetLevel


		Finish:	

		//	jsr WaitForVBlank

			lda #%11111111
			sta IRQ.ScreenOff

	
			rts


	}

	ResetLevel: {

		jsr CommonReset	
		jsr READY.ResetLevel
		jsr ACTOR.PLAYER.ResetPacman
		jsr ACTOR.GHOST.ResetAll
		jsr ENERGIZER.ResetLevel
		jsr ACTOR.GHOST.ReleaseRestartLevel
		jsr FRUIT.RestartLevel
		
		jsr WaitForVBlank

		lda #%11111111
		sta IRQ.ScreenOff


	
		rts
	}


	


	InitialiseGame: {
		
		jsr ResetGame

		jmp Loop

	}



	
	SetupVIC: {

		lda #ALL_ON
		sta VIC.SPRITE_ENABLE

		lda #%00001110
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

		lda #PURPLE
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #YELLOW
	 	sta VIC.EXTENDED_BG_COLOR_2

		rts

	}


	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		jmp FrameCode

	}

	IntermissionMode: {

		jsr ACTOR.PLAYER.FrameUpdate
		jsr ACTOR.PLAYER.GhostCollision
		jsr ACTOR.GHOST.FrameUpdate
		jsr ACTOR.PLAYER.GhostCollision
		jsr INTERMISSION.FrameUpdate


		rts
	}


	ReadyMode: {

		inc TOP_HUD.FlashCounter

		jsr GAME.FrameUpdate
		jsr ACTOR.GHOST.FrameUpdate

		rts
	}


	EatenMode: {

		lda PreviousMode
		cmp #GAME_MODE_PLAY
		bne NoFlash1Up

		inc TOP_HUD.FlashCounter
		jsr ENERGIZER.CheckFlash

		NoFlash1Up:

		jsr ACTOR.GHOST.DuringEaten
		

		rts
	}

	PlayMode: {

	
		inc TOP_HUD.FlashCounter

		jsr ACTOR.GHOST.ReleaseUpdate
		jsr ACTOR.GHOST.CommanderUpdate
		jsr ACTOR.GHOST.CheckElroy

		jsr ENERGIZER.FrameUpdate
		jsr ACTOR.PLAYER.FrameUpdate
		jsr SCROLLER.FrameUpdate
		jsr FRUIT.FrameUpdate
		jsr ACTOR.PLAYER.GhostCollision
		jsr ACTOR.GHOST.FrameUpdate
		jsr ACTOR.PLAYER.GhostCollision
		jsr WakaUpdate


	
		rts
	}

	DeadMode: {

		inc TOP_HUD.FlashCounter

		jsr ENERGIZER.CheckFlash
		jsr ACTOR.PLAYER.DeadUpdate
		jsr ACTOR.GHOST.DeadUpdate


		rts
	}

	TitleMode: {

		jsr TITLE.FrameUpdate


		rts
	}

	CompleteMode: {

		inc TOP_HUD.FlashCounter
		jsr COMPLETE.FrameUpdate


		rts
	}

	GameCode: {

		ldy #0
		sty ZP.Repeated

			jsr SCROLLER.ScreenSwap

		Repeat:	

			

			lda GameMode
			cmp #GAME_MODE_PLAY
			bne NotPlayMode

			jsr PlayMode
			jmp CheckPAL

		NotPlayMode:

			cmp #GAME_MODE_COMPLETE
			bne NotComplete

			jsr CompleteMode
			jmp CheckPAL


		NotComplete:

			cmp #GAME_MODE_DEAD
			bne NotDead

			jsr DeadMode
			jmp CheckPAL

		NotDead:

			cmp #GAME_MODE_EATEN
			bne NotEaten

			jsr EatenMode
			jmp CheckPAL


		NotEaten:
				
			cmp #GAME_MODE_TITLE
			bne NotTitle

			jsr TitleMode
			jmp CheckPAL


		NotTitle:

			cmp #GAME_MODE_READY
			bne NotReady

			jsr ReadyMode
			jmp CheckPAL


		NotReady:

			cmp #GAME_MODE_INTERMISSION
			bne NotInter

			jsr IntermissionMode
			jmp CheckPAL


		NotInter:

			cmp #GAME_MODE_OVER
			bne NotOver

			lda Timer
			beq BackToTitle

			jmp CheckPAL

		BackToTitle:	

			lda SCORE.GotHighScore
			beq NoHighScore

			jsr UTILITY.ClearScreen
			jsr SCROLLER.SetToScreen0
	
			jsr MAIN.DrawSaving

			jsr DISK.SAVE


			NoHighScore:

			jmp TitleScreen


		NotOver:

		CheckPAL:

			lda IRQ.Frame
			sec
			sbc MAIN.MachineType
			adc ZP.Repeated
			bpl DontRepeat

			inc ZP.Repeated

			jmp Repeat
			
		DontRepeat:


			jsr SCORE.FrameUpdate
			
			lda IRQ.Frame
			clc
			adc #1
			cmp #5
			bcc Okay

			lda #0

		Okay:

			sta IRQ.Frame

			lda ZP.Repeated
			bne DontScroll


			jsr SCROLLER.ScreenShift

		DontScroll:

		jmp Loop
	}



	FrameCode: {

		lda #0
		sta PerformFrameCodeFlag

		lda Timer
		beq Ready

		dec Timer

		jmp NotReady

		Ready:

		//lda #255
		//sta VIC.SPRITE_ENABLE

		PrepareSprites:

		CheckNTSC:

			ldy IRQ.SidTimer
			bmi NoSkip
			
			dey
			sty IRQ.SidTimer
			bne NoSkip

			lda #IRQ.SidTime
			sta IRQ.SidTimer
			
		NoSkip:


	

		NotReady:

		jsr PLEXOR.Sort

		lda MAIN.GameActive
		beq NotActive

		jmp GameCode


		NotActive:

			lda KickOff
			beq PreStage

			lda #1
			sta MAIN.GameActive
		
		PreStage:

		
			jmp Loop

		
			jmp TitleScreen


		GamePaused:

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


* = $ED00 "Game ZP Backup"
	
	GameZP:		.fill 256, 0
	KernalZP:	.fill 256, 0


#import "data/assets.asm"
#import "system/map/map_data.asm"
#import "data/rand.asm"