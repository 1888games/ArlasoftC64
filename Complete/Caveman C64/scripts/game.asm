
#import "lookups/zeropage.asm"

MAIN: {

BasicUpstart2(Entry)

#import "setup/loadModules.asm"

PerformFrameCodeFlag: 	.byte $00
GameCounter:			.byte 60, 35, 40 // curr,currMax,Max
GameTickFlag:			.byte $00
GameMode: 				.byte 0
BackgroundColour:		.byte 0
GameIsActive:			.byte 0
InitialCooldown:		.byte 250
GameOverTimer:			.byte 0, 2
GameOver:				.byte 1
LevelCompleteTimer:		.byte 0, 5
WaitingForFire: 		.byte 1

//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

Entry:
		
		ldx #0
		jsr SOUND.SetupSidAddresses


		lda #BLACK
		sta BackgroundColour

		jsr IRQ.DisableCIA
		jsr REGISTERS.BankOutKernalAndBasic
		jsr VIC.SetupRegisters
		jsr VIC.SetupColours

		jsr Random.init
		jsr IRQ.SetupInterrupts


	//	ldx #0
	//	jsr SOUND.InitialiseSid

		jmp TitleScreen
		jmp LoadGame


TitleScreen: {

	ldx #0
	//sta SOUND.CurrentSid
	jsr SOUND.InitialiseSid


	lda #ZERO
	sta VIC.SPRITE_ENABLE

	lda #%00001110
	sta VIC.MEMORY_SETUP

	ldx #BLACK
	jsr VIC.ColourLastRow

	lda #BLACK
	sta $d020

	lda #BLACK
	sta $d021

	lda #CYAN
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2

	jsr TITLELOADER.DrawMap

	jmp TitleLoop

}



Instructions:{

	lda VIC.SCREEN_CONTROL
	and #%11101111
	sta VIC.SCREEN_CONTROL

	ldx #CYAN
	jsr VIC.ColourLastRow

	lda #CYAN
	sta $d020

//	jsr TITLELOADER.DrawMap
	jsr INSLOADER.DrawMap

	jsr VIC.ColourTextRow

	WaitForRaster:
		lda $d012
		cmp #200
		beq ShowScreen
		jmp WaitForRaster

	ShowScreen:

		lda VIC.SCREEN_CONTROL
		ora #%00010001
		sta VIC.SCREEN_CONTROL


	jmp InstructionsLoop

}


TitleLoop: {

	dec InitialCooldown
	beq WaitForRaster

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	beq Instructions

	WaitForRaster:
		lda $d012
		cmp #100
		beq TitleLoop

		jmp WaitForRaster

}


InstructionsLoop:{

	dec InitialCooldown
	beq WaitForRaster

	lda REGISTERS.JOY_PORT_2
	and #JOY_LEFT
	beq Amateur

	lda REGISTERS.JOY_PORT_2
	and #JOY_RIGHT
	beq Pro

	jmp WaitForRaster

	Pro:

		lda #ONE
		sta GameMode
		jmp LoadGame

	Amateur:

		lda #ZERO
		sta GameMode
		jmp LoadGame

	WaitForRaster:
		lda $d012
		cmp #220
		beq InstructionsLoop
		jmp WaitForRaster



}

	


LoadGame: {

	//lda #ZERO
	//sta SOUND.MusicActive

	ldx #ONE
	jsr SOUND.InitialiseSid
	
	lda VIC.SCREEN_CONTROL
	and #%11101111
	sta VIC.SCREEN_CONTROL

	jsr VIC.SetupRegisters
	jsr VIC.SetupColours

	jsr MAPLOADER.DrawMap

	ldx #BROWN
	jsr VIC.ColourLastRow

	lda #BLACK
	sta BackgroundColour
		
	jsr NewGame

	WaitForRaster:
		lda $d012
		cmp #1
		beq ShowScreen
		jmp WaitForRaster

	ShowScreen:

	lda VIC.SCREEN_CONTROL
	ora #%00010001
	sta VIC.SCREEN_CONTROL

	

	jsr IRQ.SetupInterrupts

	jmp MainLoop

}


NextLevel:{	

	lda #ZERO
	sta GameIsActive

	jsr SCORE.LevelComplete
	ldx #ONE
	jsr SOUND.InitialiseSid

	lda LevelCompleteTimer + 1
	sta LevelCompleteTimer



	rts
}

GotoNextLevel: {

	jsr Reset
	jsr LEVELDATA.SetupNextLevel



	lda #ONE
	sta GameIsActive

	jsr CAVE.Reset
		

	rts


}

CheckNextLevel:{

	lda LevelCompleteTimer
	beq Finish

	dec LevelCompleteTimer
	bne Finish

	jsr GotoNextLevel

	Finish:
		rts

}

NewGame: {	


		jsr CHAR_DRAWING.ClearAll

		lda #ONE
		sta VIC.SPRITE_ENABLE
		sta LEVELDATA.Ones


		lda #ZERO
		sta LEVELDATA.NextLevelID
		sta LEVELDATA.Tens
		sta GameOver
		sta GameIsActive

		jsr LEVELDATA.SetupNextLevel

		jsr Reset
		jsr SCORE.Reset
		jsr LIVES.Reset
		jsr CAVE.Reset

		lda #30
		sta WaitingForFire
		sta CAVEMAN.Cooldown

		ldx #55
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		rts
	
}


Reset:{

		lda #BLACK
		sta BackgroundColour

		jsr CAVEMAN.Reset
		
		jsr AXE.Reset
		jsr DINO.Reset
		jsr BIRD.Reset
		jsr VOLCANO.Start
		jsr EGG.Reset
		jsr CAVE.RemoveStoolEgg
		jsr LAVA.Reset

		rts

}

NextLife: {

	lda #ONE
	sta GameIsActive

	lda LIVES.Value
	cmp #1
	bcs NotDead

	jsr SetGameOver
	jmp Finish


	NotDead:

	jsr Reset

	Finish:

	rts

}




SetGameOver:{

	lda #ZERO
	sta GameIsActive

	lda #ONE
	sta GameOver

	lda GameOverTimer+1
	sta GameOverTimer
	
	rts

}


GameOverUpdate: {

	lda GameOver
	beq MainLoop

	lda GameOverTimer
	cmp #1
	bcs Waiting

	jmp MainLoop


	Waiting:

	dec GameOverTimer
	jmp MainLoop

}

MainLoop: {

		lda PerformFrameCodeFlag
		beq GameTick
		dec PerformFrameCodeFlag
		jmp FrameCode
}

CheckWhetherToUpdateScore: {

		//lda ZP_COUNTER
		//and #1
		//bne NoScoreAdd

		jsr SCORE.CheckScoreToAdd

		NoScoreAdd:
			rts
}




FrameCode: {

		lda GameIsActive
		beq GamePaused

		inc ZP_COUNTER
		
		jsr AXE.FrameCode
		jsr STARS.Update
		jsr LAVA.CheckHitCaveman
		jsr CAVEMAN.CheckKilledByDino

		GamePaused:

			jsr CheckWhetherToUpdateScore

			lda GameOver
			beq MainLoop

			lda GameOverTimer
			bne MainLoop

			ldx #55
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

			lda REGISTERS.JOY_PORT_2
			and #JOY_FIRE
			bne MainLoop

			jmp TitleScreen

	

}	



GameTick: {

		

		lda GameTickFlag
		beq MainLoop
		dec GameTickFlag

		lda GameIsActive
		beq NotRunning

		jsr EGG.Update
		jsr BIRD.Update
		jsr DINO.Update
		jsr VOLCANO.Update
		jsr LAVA.Update

		jmp Finish

		NotRunning:

			jsr DINO.DeathUpdate
			jsr CheckNextLevel
			jmp GameOverUpdate

	

		Finish:
		
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
