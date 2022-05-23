.var sid = LoadSid("/../assets/pillars.sid")
MAIN: {


	#import "/lookups/zeropage.asm"

	* = $0800 "Upstart"

	PerformFrameCodeFlag:	.byte 0

	BasicUpstart2(Entry)
	* = $080d "End Of Basic"


	#import "/common/macros.asm"
	#import "/common/sfx.asm"
	#import "/lookups/labels.asm"
	#import "/lookups/vic.asm"
	#import "/game/irq.asm"
	#import "/game/draw.asm"
	#import "/common/input.asm"
	#import "/game/grid.asm"
	#import "/game/bean.asm"
	#import "/common/rnd.asm"
	#import "/game/explosions.asm"
	#import "/game/rocks.asm"
	#import "/game/panel.asm"
	#import "/game/player.asm"
	#import "/game/title.asm"
	#import "/game/grid_visuals.asm"
	#import "/game/rockford.asm"
	#import "/game/menu.asm"




	* = $a033
	#import "/game/opponents.asm"
	#import "/game/text.asm"
	#import "/game/settings.asm"
	#import "/game/instructions.asm"
	#import "/game/scoring.asm"
	#import "/game/hi_score.asm"
	

	* = $6900 "RoundOver"

	#import "/game/roundOver.asm"


	* = $3700 "Disk"
		//#import "/scripts/game/disk.asm"
		#import "/game/disk2.asm"



	* = $3e00
	* = * "Main"

	GameActive: 			.byte 0
	GameMode:				.byte 0
	MachineType:			.byte 0
	Paused:					.byte 0
	


	//exomizer sfx sys -t 64 -x "inc $d020 lda #$7B sta $d011" -o oyup.prg main.prg
	Entry: {

		
		jsr IRQ.DisableCIAInterrupts
		jsr BackupKernalZP
		jsr BankOutKernalAndBasic
		jsr set_sfx_routine
		jsr DetectMachine

		ldx 8
        stx $ba

		jsr IRQ.Setup
		//jsr DISK.SAVE
		
		jsr SetupVIC


		jsr DISK.LOAD

		lda #0
		jsr sid.init

		jsr SetupRestoreKey

		//.break


		//jsr DISK.SAVE
		jmp TITLE.Show
		// jmp SETTINGS.Show	
		//jmp MENU.Show
		//jmp CAMPAIGN.Show
		lda #PLAY_MODE_PRACTICE
		sta MENU.SelectedOption


		jmp StartGame


	}

	Unpause: {

		dec Paused

		ldy #BLACK
		sty $d020

		

		rts
	}


	nmi: {

		:StoreState()

	

		CanPause:

			lda Paused
			beq Pause

			jsr Unpause
		
			jmp Exit

		Pause:

			lda #0
			sta $D418

			lda #RED
			sta $d020

			inc Paused
	
		

		Exit:

		:RestoreState()

		rti
	}


	SetupRestoreKey: {

		lda #<nmi
		sta $fffa
		lda #>nmi
		sta $fffb

		rts
	}
   
	DetectMachine: {

		w0:  lda $D012
		w1:  cmp $D012
	    beq w1
	    bmi w0
	    and #$03
	    sta MAIN.MachineType

	    cmp #2
	    bne PAL

	    NTSC:

	    lda #60
	    sta ROCKS.FramesPerSecond

	    jsr SETTINGS.SetSpeedsNTSC

	    jmp Finish
	  
	    PAL:


	    Finish:

	    rts

	}




	

	StartGame: {

	

		lda #0
		sta IRQ.Mode

		jsr SetupGameColours
		jsr SetupVIC
		jsr SetupSprites

		jsr DRAW.GameScreen
		 	
		jsr EXPLOSIONS.Reset
		jsr GRID.Reset
		jsr PANEL.Reset
		jsr PLAYER.Reset
		jsr ROCKS.Reset
		jsr SCORING.Reset
		jsr ROUND_OVER.Reset


		jmp Loop


	}


	SetupVIC: {  

		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		
		and #%11111100
		sta VIC.BANK_SELECT

		// multicolour mode on
		lda VIC.SCREEN_CONTROL_2
		and #%01101111
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2

		lda #%00001100
		sta VIC.MEMORY_SETUP	

		rts


	}


	SetupSprites: {

		lda #%11001111
		sta VIC.SPRITE_ENABLE

		lda #%00000000
		sta VIC.SPRITE_PRIORITY


		lda #%11111111
		sta VIC.SPRITE_MULTICOLOR


		lda #LIGHT_RED
		sta VIC.SPRITE_MULTICOLOR_1

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_2

		lda #0
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

	SetupGameColours: {


		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

		lda #BLACK
		sta VIC.BORDER_COLOUR

		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_1
		lda #LIGHT_BLUE
		sta VIC.EXTENDED_BG_COLOR_2


 
		rts

	
	}


	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		dec PerformFrameCodeFlag

		jmp CheckSwitchMode
	}




	CheckSwitchMode: {

		lda GameMode
	
			cmp #GAME_MODE_SWITCH_MENU
			bne NotMenu

		SwitchMenu:

			//lda #2
			//jsr ChangeTracks

			jsr HI_SCORE.Check

			lda GameMode
			cmp #GAME_MODE_SWITCH_SCORE
			bne NoHighScore

			HiScore:

				lda #0
				sta GameMode

				lda #1
				jmp HI_SCORE.Show

			NoHighScore:

				lda #0
				sta GameMode

			jmp MENU.Show

		NotMenu:

			cmp #GAME_MODE_SWITCH_GAME
			bne NotGame

			lda #0
			sta GameMode

			jmp StartGame

		NotGame:

		jmp FrameCode



	}

	FrameCode: {


		jsr sfx_cooldown

		lda MAIN.Paused
		bne Skip
	
		lda MAIN.GameActive
		beq Skip
		
		lda IRQ.SidTimer
		cmp #1
		beq Skip

		jsr PLAYER.FrameUpdate
		jsr GRID.FrameUpdate
		jsr EXPLOSIONS.FrameUpdate
		jsr PANEL.FrameUpdate
		jsr ROCKS.FrameUpdate
		jsr SCORING.FrameUpdate
		jsr ROUND_OVER.FrameUpdate
		jsr OPPONENTS.FrameUpdate
		jsr ROCKFORD.FrameUpdate
		//jsr DRAW.CycleChars


		Skip:




		jmp Loop

	}


	BankOutKernalAndBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}



	BankInKernal: {

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta PROCESSOR_PORT
		rts

	}

	SaveKernalZP: {

		ldx #2

		Loop:

			lda $02, x
			sta KernalZP, x

			lda GameZP, x
			sta $02, x

			inx
			bne Loop

		rts
	}


	BackupKernalZP: {

		ldx #2

		Loop:

			lda $02, x
			sta KernalZP, x

			inx
			bne Loop

		rts
	}


	SaveGameZP: {

		ldx #2

		Loop:

			lda $02, x
			sta GameZP, x

			lda KernalZP, x
			sta $02, x

			inx
			bne Loop

		rts
	}
	

	#import "/game/assets.asm"

	* = $3a00 "Game ZP Backup"
	
	GameZP:		.fill 256, 0
	KernalZP:	.fill 256, 0




}  