
.var sid = LoadSid("../assets/sfx/empty.sid")
.var d64 = false
//segmentdef SaveFile [start=$8000]

MAIN: {

	#import "data & labels/zeropage.asm"

	* = $0800 "Upstart"
	PerformFrameCodeFlag:	.byte 0

	BasicUpstart2(Entry)

	* = $080d "End Of Basic"
	GameActive: 			.byte 0

	#import "data & labels/lookups.asm"
	#import "common/common.asm"
	#import "game/ui/keyboard.asm"
	#import "game/system/irq.asm"
	#import "game/locals.asm"
	#import "game/menu.asm"

	* =$0600 "Main"

	MachineType:			.byte 0
	FrameTimer:				.byte 25,25
	GameMode:				.byte 0
	CharSetReversed:		.byte 0
	GameLoaded:				.byte 0

	//exomizer sfx sys -t 64 -x "inc $d020" -o funfair.prg main.prg
	Entry: {

		jsr IRQ.DisableCIA
		jsr REGISTERS.BankOutKernalandBasic
		jsr REGISTERS.DetectMachine

		jsr VIC.SetupRegisters
		jsr RANDOM.init
	  
		jsr set_sfx_routine

		lda FrameTimer + 1
		sta FrameTimer 


		Finish:
		

		jmp StartGame

	}


	
	


	StartGame: {

	

		jsr IRQ.SetupInterrupts
		jsr Setup
		jmp Loop

	}

	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		lda #0
		sta PerformFrameCodeFlag

		ldy #2
		jsr INPUT.ReadJoystick	// 5) orange	 
		jsr KEYBOARD.Check	// 2) yellow

		jmp Loop
		


		rts
	}



	Setup:{

		lda #ALL_ON
		sta VIC.SPRITE_ENABLE

		//Set VIC BANK 3, last two bits = 00
		lda VIC.VIC_BANK_SELECT
		and #%11111100
		sta VIC.VIC_BANK_SELECT

		
		lda #%00001100
		sta VIC.MEMORY_SETUP

	 	lda VIC.SCREEN_CONTROL_2
	 	and #%11101111
	 	ora #%00010000
	 	sta VIC.SCREEN_CONTROL_2

		lda #LIGHT_GREEN
		sta VIC.BACKGROUND_COLOR

		lda #BLUE
		sta VIC.EXTENDED_BG_COLOR_1

		lda #GREEN
		sta VIC.EXTENDED_BG_COLOR_2

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #ONE
		sta GameActive

		lda #GAME_MODE_MENU
		sta GameMode

		jsr MENU.Show


		rts	

	}

	


	#import "common/assets.asm"
}