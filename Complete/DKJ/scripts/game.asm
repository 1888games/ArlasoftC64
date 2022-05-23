MAIN: {

#import "lookups/zeropage.asm"

BasicUpstart2(Entry)

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/sid.asm"
#import "lookups/registers.asm"
#import "interrupts/irq.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "interrupts/monkey.asm"
#import "interrupts/key.asm"
#import "interrupts/cage.asm"
#import "interrupts/score.asm"
#import "interrupts/lives.asm"
#import "interrupts/enemies.asm"
#import "interrupts/pineapple.asm"
#import "setup/titleloader.asm"


PerformFrameCodeFlag: .byte $00
						// current, currentMax, startValue
GameCounter:		.byte 24, 24, 27
GameTickFlag:	.byte $00
SpeedIncreaseCounter: .byte 48, 48
InitialCooldown: .byte 30, 30
.label MaxSpeed = 13

GameIsActive: .byte 0
GameOverTimer: .byte 0
GameIsOver: .byte 0
.label GameOverTimeOut = 60

Entry:
		

		jsr IRQ.DisableCIA
		jsr REGISTERS.BankOutKernalAndBasic
		jsr VIC.SetupRegisters
		jsr VIC.SetupColours
		jsr SID.Initialise
	
		jsr IRQ.SetupInterrupts
		jsr Random.init

		


		jmp TitleScreen
		jsr NewGame
		jmp MainLoop

NewGame: {

	
	

		lda GameCounter + 2
		sta GameCounter + 1
		sta GameCounter

		lda VIC.SCREEN_CONTROL_2
		and #%11101111
	 	ora #%00010000
	 	sta VIC.SCREEN_CONTROL_2

 		lda #CYAN
		sta VIC.BACKGROUND_COLOR
		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #LIGHT_GREEN
		sta VIC.EXTENDED_BG_COLOR_1
		lda #GREEN
		sta VIC.EXTENDED_BG_COLOR_2

			//Set screen and character memory
		lda #%00001100
		sta VIC.MEMORY_SETUP	



		jsr MAPLOADER.DrawMap
		jsr VIC.ColourLastRow

		jsr MONKEY.Initialise
		jsr KEY.Initialise

		jsr SCORE.Reset
		jsr LIVES.Reset
 		jsr ENEMIES.Reset
 		jsr CAGE.LockCage



		ldx #0
		stx GameIsOver
		jsr PINEAPPLE.MovePineapple

		lda #1
		sta GameIsActive





		//jsr PINEAPPLE.StartFall

		rts
	
}


StartGame: {

	jsr NewGame
	jmp MainLoop


}



CheckWhetherToUpdateScore: {

		lda ZP_COUNTER
		and #3
		bne NoScoreAdd

		jsr SCORE.CheckScoreToAdd

		NoScoreAdd:
			jmp MainLoop
}


TitleScreen: {

		
	lda #0
	sta VIC.SPRITE_ENABLE
	sta GameIsActive
		
	lda #%00001110
	sta VIC.MEMORY_SETUP

	lda #YELLOW
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

	lda #RED
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2

//multicolour mode on7
	// lda VIC.SCREEN_CONTROL_2
	// and #%11101111
 // 	ora #%00010000
 // 	sta VIC.SCREEN_CONTROL_2

 	jsr TITLELOADER.DrawMap


		lda InitialCooldown + 1
		sta InitialCooldown

		jmp TitleLoop

}




TitleLoop: {

	
	lda InitialCooldown
	beq Okay

	dec InitialCooldown
	jmp WaitForRaster

	Okay:

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne WaitForRaster

	jmp StartGame

	WaitForRaster:
		lda $d012
		cmp #100
		beq TitleLoop

		jmp WaitForRaster


}


FrameCode: {


	lda #0
	sta PerformFrameCodeFlag
	inc ZP_COUNTER

	lda GameIsActive
	beq GamePaused

	jsr PINEAPPLE.Update
	jsr CheckWhetherToUpdateScore

	jmp MainLoop
 
	GamePaused:

		lda GameIsOver
		beq MainLoop

		lda GameOverTimer
		beq GameOverLoop

		dec GameOverTimer
		jmp MainLoop

		jmp GameOverLoop
		
	



}	

MainLoop: {

		lda PerformFrameCodeFlag
		beq GameTick
		dec PerformFrameCodeFlag
		jmp FrameCode
}

CheckGameSpeed:{

		dec SpeedIncreaseCounter
		bne NoSpeedIncrease

		lda SpeedIncreaseCounter + 1
		sta SpeedIncreaseCounter

		lda GameCounter + 1
		cmp #MaxSpeed
		beq NoSpeedIncrease

		dec GameCounter + 1
		dec GameCounter +1

		NoSpeedIncrease:

			rts
}


CheckSpawn:{


		jsr Random
		cmp #45
		bcc DoZero
		cmp #210
		bcs Finish

		ldy #ONE
		jsr ENEMIES.Spawn
		jmp Finish

		DoZero:
			ldy #ZERO
		 	jsr ENEMIES.Spawn

		 Finish:

		rts
}


GameOverLoop: {

	jmp TitleScreen

	Okay:


	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne WaitForRaster

	jmp TitleScreen

	WaitForRaster:
		lda $d012
		cmp #100
		beq GameOverLoop

		jmp WaitForRaster

}



GameTick: {

		
		lda GameTickFlag
		beq MainLoop
		dec GameTickFlag

		jsr KEY.Update
		jsr CAGE.Update
		jsr ENEMIES.Update
		
		lda KEY.Active
		beq Finish

		jsr CheckGameSpeed
		jsr CheckSpawn

		Finish:
		
		lda MONKEY.DisableControl
		bne MainLoop

		jsr SID.TickSound
		jmp MainLoop
}


Random: {
        lda seed
        beq doEor
        asl
        beq noEor
        bcc noEor
    doEor:    
        eor #$1d
        eor $dc04
        eor $dd04
    noEor:  
        sta seed
        rts
    seed:
        .byte $62


    init:
        lda #$ff
        sta $dc05
        sta $dd05
        lda #$7f
        sta $dc04
        lda #$37
        sta $dd04

        lda #$91
        sta $dc0e
        sta $dd0e
        rts
}


#import "setup/assets.asm"

} 