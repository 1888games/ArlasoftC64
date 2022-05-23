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
	#import "common/maploader.asm"
	#import "game/system/multiplexor.asm"
	#import "common/random.asm"
	#import "common/plot.asm"

	#import "arcade/defines.asm"


	* = $1400
	#import "common/text.asm"
	#import "game/system/disk.asm"
	#import "game/system/score.asm"

	#import "common/sfx.asm"


	#import "game/system/startup.asm"
	#import "game/gameplay/game.asm"
	#import "game/gameplay/wave.asm"
	#import "game/system/functions.asm"
	#import "game/gameplay/asteroid.asm"
	#import "game/system/pre_game.asm"
	#import "game/system/text.asm"
	#import "game/gameplay/ship.asm"
	#import "game/gameplay/saucer.asm"
	#import "game/gameplay/bullet.asm"
	#import "game/gameplay/object.asm"
	#import "game/gameplay/draw.asm"

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

	//	jmp ShowTitleScreen	

		jmp RESET

	}


	InitGame: {


		jsr SilenceSFX
		jsr InitGameVars

	Waves:

		jsr InitWaveVars

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
			//lda #TEXT.PAUSE

			jsr TEXT.Draw

			dec GameActive
	
		

		Exit:

		:RestoreState()

		rti
	}


	ShowTitleScreen: {


	
		//jsr TITLE.Initialise
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
 		//ora #%00010000
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



// .label FireSw           =$E004   //Fire button status.
// .label DiagStep         =$E005   //Diagnostic step. Draws diagonal lines on screen.
// .label SlamSw           =$E006   //Slam switch status.
// .label SelfTestSw       =$E007   //Self test DIP switch status.

// .label LeftCoinSw       =$E400   //Left coin switch status.
// .label CntrCoinSw       =$E401   //Center coin switch status.
// .label RghtCoinSw       =$E402   //Right coin switch status.
// .label Player1Sw        =$E403   //Player 1 button status.
// .label Player2Sw        =$E404   //Player 2 button status.
// .label ThrustSw         =$E405   //Thrust button status.
// .label RotRghtSw        =$E406   //Rotation right button status.
// .label RotLeftSw        =$E407   //Rotation left button status.


	TransferInputToSwitches: {

		ldy #1

		lda INPUT.JOY_FIRE_NOW, y
		beq NotFire

		lda #255

	NotFire:

		sta FireSw
		sta Player1Sw

		lda INPUT.JOY_LEFT_NOW, y
		beq NotLeft

		lda #255
		
	NotLeft:

		sta RotLeftSw

		lda INPUT.JOY_RIGHT_NOW, y
		beq NotRight

		lda #255

	NotRight:

		sta RotRghtSw

		lda INPUT.JOY_UP_NOW, y
		beq NotUp

		lda #255

	NotUp:

		sta ThrustSw



		rts
	}


	RunFrame: {



			jsr ChkPreGameStuff

			L683F:  bcc ContinueGoing           //Branch if attract mode is starting.

		StartAttractMode:

			pla
			pla
			jmp InitGame

		ContinueGoing:	


			//L6841:  jsr CheckHighScore      //($765C)Check if player just got the high score.
			//L6844:  jsr ChkHighScrMsg       //($6D90)Do high score and initial entry message if appropriate.
			//L6847:  bpl DoScreenText        //Is game not in progress? If not, branch.

			//L6849:  jsr ChkHghScrList       //($73C4)Check if high score list needs to be displayed.
			//L684C:  bcs DoScreenText        //Is high scores list being displayed? If so, branch.

			L684E:  lda PlyrDispTimer       //Is player not active?
			L6850:  bne DoAsteroids         //If not, branch.
			
			L6852:  jsr CheckFire         //($6CD7)Update ship firing and position.
			//L6855:  jsr EnterHyprspc        //($6E74)Check if player entered hyperspace.
			L6858:  jsr UpdateShip       //($703F)Check if coming out of hyperspace.
			//L685B:  jsr UpdateScr           //($6B93)Update saucer Status.

		DoAsteroids:

			L685E:  jsr UpdateObjects       //($6F57)Update objects(asteroids, ship, saucer and bullets).
			//L6861:  jsr Hitdectection       //($69F0)Do hit detection calculations for all objects.

		DoScreenText:
			//L6864:  jsr UpdateScreenText    //($724F)Update in-game screen text and reserve lives.
			//L6867:  jsr ChkUpdateSFX        //($7555)Check if SFX needs to be updated.

			//L686A:  lda #$7F                //X beam coordinate 4 * $7F = $1D0 = 464.
			//L686C:  tax                     //Y beam coordinate 4 * $7F = $1D0 = 464.
			//L686D:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

			//L6870:  jsr GetRandNum          //($77B5)Get a random number.

			//L6873:  jsr VecHalt             //($7BC0)Halt the vector state machine.

			L6876:  lda ThmpSpeedTmr        //
			L6879:  beq ChkGameRunning      //Is thump Speed timer running? If so, decrement it.
			L687B:  dec ThmpSpeedTmr        //

		ChkGameRunning:

			L687E:  ora CurAsteroids        //Is the game running?
			L6881:  beq StopGame    //If so, branch to keep it going.

					jmp Loop
		StopGame:
					pla
					pla
			L6883:  jmp InitGame.Waves           //Game not running, branch to initialize variables.

	}

	FrameCode: {

		lda #0
		sta PerformFrameCodeFlag

		jsr TransferInputToSwitches
		jsr PLEXOR.Sort
			


	Repeat:

		L6828:  inc FrameTimerLo        //
		L682A:  bne SetVecRamPtr        //increment frame counter.
		L682C:  inc FrameTimerHi        //

	SetVecRamPtr:

			jsr RunFrame
		
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
		
			lda #0
            sta $d404               // Sid silent 
            sta $d404+7 
            sta $d404+14 

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