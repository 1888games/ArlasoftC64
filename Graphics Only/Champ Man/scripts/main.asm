
.var sid = LoadSid("../assets/sfx/Beaten2.sid")


MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=$1000 "Modules"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"
#import "game/irq.asm"

#import "common/input.asm"
#import "common/macros.asm"
#import "common/maploader.asm"
#import "common/plot.asm"
#import "game/score.asm"
#import "common/random.asm"
#import "common/sfx.asm"
#import "game/control.asm"
#import "game/draw.asm"
#import "game/deck.asm"
#import "game/table.asm"
#import "game/player.asm"
#import "game/slots.asm"
#import "game/sprite.asm"


GameOverTimer: .byte 0
GameActive: .byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:	.byte 0
InitialCooldown: .byte 30, 30

MachineType: .byte 0
 
.label GameOverTimeOut = 120
.label LifeLostTimeOut = 30

ScreenColour:	.byte 5

GameOverSequenceID: .byte 0
GameOverSequences:	.byte 2

MusicOn:	.byte 1
 
TitleTimer:	.byte 0, 10
   
//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	
	


	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalandBasic

	jsr VIC.SetupRegisters
	jsr VIC.SetupColours
	jsr RandOM.init
  
	jsr DetectMachine


	
	jsr IRQ.SetupInterrupts

	
	jsr set_sfx_routine

	Finish:

	//jmp Instructions
		
	jmp startGame
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



	jsr SCORE.CheckScoreToAdd

	lda GameActive
	beq GamePaused

	jmp Loop

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		bne Loop

		lda #GameOverTimeOut
		sta GameOverTimer

		jmp GameOverLoop

}	
 





startGame: {

	jsr GameScreen
	jmp Loop


}


GameScreen:{

	lda #ALL_ON
	sta VIC.SPRITE_ENABLE

	lda #%00001100
	sta VIC.MEMORY_SETUP

 	lda VIC.SCREEN_CONTROL_2
 	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2

	lda #GREEN
	sta VIC.BACKGROUND_COLOR
	lda #GREEN
	sta VIC.BORDER_COLOR

 	lda #0
 	sta MAPLOADER.CurrentMapID
	
	 lda #RED
	 sta VIC.EXTENDED_BG_COLOR_1
	 lda #WHITE
	 sta VIC.EXTENDED_BG_COLOR_2

	 //multicolour mode on7
	lda VIC.SCREEN_CONTROL_2
	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2


	jsr MAPLOADER.DrawMap
	jsr DrawBottomRow

	//jsr HideGameOver


	jsr ResetGame

	rts	

}




BottomRow: .byte 17,  17, 22
			.fill 22, 19
			.byte 23
			.fill 14, 17

DrawBottomRow: {

	lda #12
	ldx #0

	Loop:
	
		lda #74
		sta SCREEN_RAM + 960, x

		lda #0
		sta VIC.COLOR_RAM + 960, x

		inx 
		cpx #40
		beq Finish
		jmp Loop

	Finish:

	rts



}



TitleScreen: {



	lda InitialCooldown + 1
	sta InitialCooldown

	lda #1
	sta MAPLOADER.CurrentMapID

	lda #0
	sta GameActive
	sta VIC.SPRITE_ENABLE

	lda #%00001110
	sta VIC.MEMORY_SETUP

	lda #BLACK
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

	lda #RED
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2

//multicolour mode on7
	lda VIC.SCREEN_CONTROL_2
	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2

	jsr MAPLOADER.DrawMap	

	lda SCREEN_RAM
	tay

	lda VIC.COLOR_RAM

	//.break

 	ldx #0
	lda #0

	Loop:

		lda #0
		sta SCREEN_RAM + 960, x

		sta VIC.COLOR_RAM+960, x


		inx
		cpx #40
		beq Done
		jmp Loop

	Done:

	lda #0
	jsr sid.init

	jmp TitleLoop
}



Instructions:{

	sfx(6)

	lda InitialCooldown + 1
	sta InitialCooldown

	lda VIC.SCREEN_CONTROL
	and #%11101111
	sta VIC.SCREEN_CONTROL

	lda #%00001010
	sta VIC.MEMORY_SETUP


	//ldx #
	//jsr VIC.ColourLastRow

	lda #BLACK
	sta VIC.BORDER_COLOR

	lda #RED
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2


	lda #2
	sta MAPLOADER.CurrentMapID

	lda VIC.SCREEN_CONTROL_2
	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2


	jsr MAPLOADER.DrawMap	

	ldx #0
	lda #0

	Loop:
		sta SCREEN_RAM + 960, x
		inx
		cpx #40
		beq Done
		jmp Loop

	Done:

	//jsr VIC.ColourTextRow

	WaitForRaster:
		lda $d012
		cmp #1
		beq ShowScreen
		jmp WaitForRaster

	ShowScreen:

		lda VIC.SCREEN_CONTROL
		ora #%00010001
		sta VIC.SCREEN_CONTROL


	jmp InstructionsLoop

}



InstructionsLoop:{


	lda InitialCooldown
	beq Okay

	dec InitialCooldown
	jmp WaitForRaster

	Okay:

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne NotFire

	jmp startGame

	NotFire:

	WaitForRaster:
		lda $d012
		cmp #100
		bne WaitForRaster
		jmp InstructionsLoop



}



TitleLoop: {



	lda InitialCooldown
	beq Okay

	dec InitialCooldown
	jmp WaitForRaster

	Okay:


	ldx #0

	lda TitleTimer
	beq CycleChars

	dec TitleTimer
	jmp Finish


	CycleChars:

	lda TitleTimer + 1
	sta TitleTimer

	Loop:

		lda TITLE_CHAR_SET + (4 * 8), x
		asl
		adc #00
		asl
		adc #00
		sta TITLE_CHAR_SET + ( 4* 8), x


		lda TITLE_CHAR_SET + (215 * 8), x
		asl
		adc #00
		asl
		adc #00
		sta TITLE_CHAR_SET + ( 215* 8), x

		inx
		cpx #8
		beq Finish
		jmp Loop

	Finish:

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne WaitForRaster

	jmp startGame

	WaitForRaster:
		lda $d012
		cmp #100
		beq TitleLoop

		jmp WaitForRaster

}



Simon: .text "Tony"


ResetGame: {



	lda #CYAN
	sta VIC.BORDER_COLOR 

	lda ScreenColour
	sta VIC.BACKGROUND_COLOR
	
	lda #ONE
	sta MAIN.GameActive

	lda #ZERO
	sta MAIN.GameIsOver

	jsr SCORE.Reset
	jsr CONTROL.Reset
	jsr DRAW.Reset

	rts

}

GameOver: {

	
	lda #15
	sta GameOverTimer

	jsr ShowGameOver

	lda #ZERO
	sta GameActive
	sta VIC.SPRITE_ENABLE
	sta GameOverSequenceID


	ldx #0	// reset sprite positions so that unused sprites won't be seen
	stx VIC.SPRITE_0_X + 2
	stx VIC.SPRITE_0_X + 4			
	stx VIC.SPRITE_0_X + 6
	stx VIC.SPRITE_0_X + 8
	stx VIC.SPRITE_0_X + 10
	stx VIC.SPRITE_0_X + 12
	stx VIC.SPRITE_0_X + 14

	lda VIC.SPRITE_MSB
	and #%00000001		// reset MSB positions
	sta VIC.SPRITE_MSB

	lda #ONE
	sta GameIsOver

	

	rts

}


GameOverChars:		.byte 44, 45, 43, 40, 1, 42, 46, 40, 47, 48
GameOverColours:	.byte 5,2, 6, 7, 0, 2, 5, 7, 4, 3

HideGameOver: {

	
	ldx #0
	
	Loop:

		lda #16
		sta SCREEN_RAM + 489, x

		inx
		cpx #10
		beq Finish
		jmp Loop


	Finish:



	rts
}


ShowGameOver: {

	
	ldx #0
	
	Loop:

		lda GameOverChars, x
		sta SCREEN_RAM + 489, x

		lda GameOverColours, x
		sta VIC.COLOR_RAM +489, x

		inx
		cpx #10
		beq Finish
		jmp Loop


	Finish:




	rts
}


GameOverLoop: {

	lda GameOverTimer
	beq UpdateGameOver

	dec GameOverTimer
	jmp Okay

	UpdateGameOver:

		lda #GameOverTimeOut
		sta GameOverTimer

	increaseID:

		inc GameOverSequenceID
		lda GameOverSequenceID
		cmp GameOverSequences
		bne Okay

		lda #0
		sta GameOverSequenceID

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



#import "common/assets.asm"
}