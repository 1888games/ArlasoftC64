
.var sid = LoadSid("../assets/sfx/blank.sid")
//.var music = LoadSid("../assets/sfx/music.sid")



MAIN:{


#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=$1000 "Modules"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"
#import "interrupts/irq.asm"


#import "interrupts/input.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "interrupts/plot.asm"
#import "interrupts/score.asm"
//#import "interrupts/sound.asm"
#import "interrupts/random.asm"
#import "interrupts/mouse.asm"
#import "interrupts/grid.asm"
#import "interrupts/pieceData.asm"
#import "interrupts/piece.asm"
#import "interrupts/selection.asm"
#import "interrupts/sfx.asm"



GameOverTimer: .byte 0
GameActive: .byte 0
LifeLostTimer: .byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:	.byte 0
InitialCooldown: .byte 60, 60

MachineType: .byte 0

 
.label GameOverTimeOut = 120
.label LifeLostTimeOut = 30

ScreenColour:	.byte 0


//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	

	lda #0
	jsr sid.init


	jsr set_sfx_routine

	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalAndBasic


	jsr VIC.SetupRegisters
	jsr VIC.SetupColours


	//jsr SOUND.Initialise
	jsr MOUSE.Initialise
	
	jsr RANDOM.init

	jsr DetectMachine
	
	jsr IRQ.SetupInterrupts



	Finish:


		
	jmp TitleScreen


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

  

    lda #5
    sta MOUSE.MoveSpeed

    PAL:

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
	beq GamePaused

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		bne Loop

		jmp TitleScreen

	

}	



StartGame: {

	jsr GameScreen
	jmp Loop


}

GameScreen:{

	lda #%00001100
	sta VIC.MEMORY_SETUP

	lda #BLACK
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

	 lda VIC.SCREEN_CONTROL_2
	 and #%11101111
	 sta VIC.SCREEN_CONTROL_2

	 lda #0
	 sta MAPLOADER.CurrentMapID

	 jsr MAPLOADER.DrawMap

	jsr ResetGame

	rts	

}

TitleScreen: {

	 lda #1
	 sta MAPLOADER.CurrentMapID

	lda #0
	sta GameActive

	lda #%00001110
	sta VIC.MEMORY_SETUP

	lda #LIGHT_GREY
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

	 lda #WHITE
	 sta VIC.EXTENDED_BG_COLOR_1
	 lda #DARK_GREY
	 sta VIC.EXTENDED_BG_COLOR_2

//multicolour mode on
	 lda VIC.SCREEN_CONTROL_2
	 and #%11101111
	 ora #%00010000
	 sta VIC.SCREEN_CONTROL_2

	jsr MAPLOADER.DrawMap	


	


	jmp TitleLoop
}



TitleLoop: {

	dec InitialCooldown
	beq WaitForRaster

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	beq StartGame

	WaitForRaster:
		lda $d012
		cmp #100
		beq TitleLoop

		jmp WaitForRaster

}




ResetGame: {



	lda ScreenColour
	sta VIC.BORDER_COLOR 

	lda ScreenColour
	sta VIC.BACKGROUND_COLOR



	jsr SCORE.Reset
	jsr GRID.Reset
	jsr PIECE.Reset
	jsr SELECTION.Reset

	lda #ONE
	sta MAIN.GameActive

	lda #ZERO
	sta MAIN.GameIsOver



	rts

}

GameOver: {

	lda #RED
	sta VIC.BORDER_COLOR 

	lda #GameOverTimeOut
	sta GameOverTimer

	lda #ZERO
	sta GameActive

	lda #ONE
	sta GameIsOver

		sfx(1)


	jsr PIECE.HideSprites

	rts

}





#import "setup/assets.asm"
}