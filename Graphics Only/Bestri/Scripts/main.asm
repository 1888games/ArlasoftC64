//exomizer sfx sys -t 64 -x "inc $d020" -o mike.prg main.prg

//.var sid = LoadSid("../assets/sfx/blank.sid")

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
	//#import "common/sfx.asm"	


	* = * "Main"

	PerformFrameCodeFlag:	.byte FALSE
	GameIsOver:				.byte FALSE
	GameActive: 			.byte FALSE
	MachineType: 			.byte PAL

	GameMode:				.byte 0
	GameOverTimer:			.byte 30

	Entry: {


		jsr IRQ.DisableCIA
		jsr UTILITY.BankOutKernalAndBasic

		jsr RANDOM.init
		
		jsr IRQ.SetupInterrupts

		jsr $2000

		jsr SetGameColours
		jsr SetupVIC

		
		jmp ResetGame

	}


	PlayChannel2: {

		sta SFX_CHANNEL_2

		
		rts
	}

	PlayConveyor: {

		lda #SFX_CONVEYOR
		sta SFX_CHANNEL_1

		
		rts
	}
	ResetGame: {

		lda #0
		sta GameActive
		sta VIC.SPRITE_PRIORITY
		
 		jsr SetGameColours

 		jsr UTILITY.ClearScreen
		//jsr MAPLOADER.DrawMap

		

		lda #GAME_MODE_PLAY
		sta GameMode

		lda #255
		sta VIC.SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR
		sta VIC.SPRITE_5_Y

		inc GameActive

		jmp Loop  

	}

	

	
	SetupVIC: {

		//lda #0
		//sta $bfff

		lda #%00001100
		sta VIC.MEMORY_SETUP

		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		and #%11111100
		sta VIC.BANK_SELECT

	SwitchOnMulticolourMode:

		lda VIC.SCREEN_CONTROL_2
 		and #%11101111
 		ora #%00010000
 		sta VIC.SCREEN_CONTROL_2

		rts
	}
	  
	SetGameColours: {

		lda #DARK_GRAY
		sta VIC.BORDER_COLOR

		lda #BLACK
		sta VIC.SPRITE_MULTICOLOR_1
		sta VIC.EXTENDED_BG_COLOR_1
		
		sta VIC.BACKGROUND_COLOR
		
	 	lda #WHITE
	 	sta VIC.EXTENDED_BG_COLOR_2
	 	sta VIC.SPRITE_MULTICOLOR_2

		rts

	}


	
	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		lda #0
		sta PerformFrameCodeFlag

		lda GameActive
		beq GamePaused

		lda GameMode
		cmp #GAME_MODE_PLAY
		beq Playing

		cmp #GAME_MODE_DEAD
		beq GameOver

		HandleDead:

			lda ZP.Counter
			and #%00000001
			bne NoFlash

			//jsr PLAYER.GameOver.Text

		NoFlash:

			lda GameOverTimer
			beq ReadyTitle

			dec GameOverTimer
			jmp NoFire

			ReadyTitle:

			ldy #1
			lda INPUT.JOY_FIRE_NOW, y
			beq NoFire

			jmp ResetGame

		NoFire:

			jmp Loop

		Playing:	

			

			jmp Loop

		GameOver:

			

		GamePaused:

			jmp Loop

	}	
 
}



#import "data/assets.asm"