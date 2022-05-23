
//.var sid = LoadSid("../assets/sfx/Beaten2.sid")


MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=* "Lookups"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"

*=* "Common"

#import "common/macros.asm"
#import "common/input.asm"
#import "common/random.asm"
#import "common/maploader.asm"
#import "common/plot.asm"

*=* "Game"

#import "game/irq.asm"
#import "game/hud.asm"
#import "game/map.asm"
#import "game/control.asm"
#import "game/player.asm"


GameOverTimer: 			.byte 0
GameActive: 			.byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:				.byte 0
MachineType:			.byte 0
MusicOn:				.byte 1
TitleTimer:				.byte 0, 10
 

//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	

	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalandBasic

	jsr VIC.SetupRegisters
	jsr VIC.SetupColours
	jsr RANDOM.init
  
	jsr DetectMachine
	jsr IRQ.SetupInterrupts
	//jsr set_sfx_routine


	Finish:

	//jmp Instructions
		
	jmp StartGame
	//jmp TitleScreen

 
DetectMachine: {

	w0:  lda $D012
	w1:  cmp $D012
    beq w1
    bmi w0
    and #$03
    sta MachineType

    cmp #2
    bne PAL

    NTSC:

     jmp Finish
  
    PAL:


    Finish:

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



	//jsr SCORE.CheckScoreToAdd

	lda GameActive
	beq GamePaused

	jmp Loop

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		bne Loop

		//lda #GameOverTimeOut
		sta GameOverTimer

		//jmp GameOverLoop

}	
 



StartGame: {

	jsr GameScreen
	jmp Loop


}



SetGameColours: {




	rts
}

GameScreen:{

	lda #ALL_ON
	sta VIC.SPRITE_ENABLE

	lda #%00001100
	sta VIC.MEMORY_SETUP

	jsr HUD.Load
	jsr ResetGame

	rts	

}







ResetGame: {

	
	lda #ONE
	sta MAIN.GameActive

	lda #ZERO
	sta MAIN.GameIsOver

	jsr MAP.Reset
	jsr PLAYER.Reset

	rts

}




#import "common/assets.asm"
}