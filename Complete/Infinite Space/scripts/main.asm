
.var sid = LoadSid("../assets/sfx/music.sid")


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
#import "game/ship.asm"
#import "game/stars.asm"
#import "game/enemies.asm"


GameOverTimer: 			.byte 0
GameActive: 			.byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:	.byte 0

 
.label GameOverTimeOut = 120
.label LifeLostTimeOut = 30

ScreenColour:	.byte 0

TitleText:		.text "infinite space" 
FireText:		.text "hit fire"
ArlaText:		.text "arlasoft"
MusicText:		.text "music by richard bayliss"

WrittenText:	.text "made on 5 oct 2020 for ludum dare 47"

.label TitleRow = 9
.label FireRow = 13

.label WrittenRow = 23

.label ArlaRow = 7
.label MusicRow = 22
			
	

MusicOn:	.byte 1
 
//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry: {
	
	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalAndBasic

	jsr VIC.SetupRegisters
	jsr VIC.SetupColours
	jsr RANDOM.init

	jsr IRQ.SetupInterrupts
	
	jsr set_sfx_routine

	Finish:


			
	jmp TitleScreen
	jmp StartGame

}




TitleLoop: {	


	WaitForRaster:

		lda VIC.RASTER_Y
		cmp #250
		bne WaitForRaster

	jsr STARS.FrameUpdate

	lda GameOverTimer
	beq Okay

	dec GameOverTimer
	jmp NoFire

	Okay:

	ldy #1
	lda INPUT.FIRE_UP_THIS_FRAME, y
	beq NoFire

	jmp StartGame

	NoFire:

	jmp TitleLoop
}


TitleScreen: {


	lda #0
	sta GameActive

	lda #ALL_ON
	sta VIC.SPRITE_ENABLE

	lda #%00001100
	sta VIC.MEMORY_SETUP

	lda #LIGHT_BLUE
	sta VIC.EXTENDED_BG_COLOR_1
	lda #RED
	sta VIC.EXTENDED_BG_COLOR_2

	jsr DRAW.ClearScreen
	jsr MAPLOADER.DrawMap

	jsr SCORE.DrawScores
	jsr SHIP.Reset

	lda #0
	sta VIC.SPRITE_ENABLE


	ldx #0
	lda #16
	sta TextColumn

	Loop4:		

		stx StoredXReg

		ldy #ArlaRow
		
		lda ArlaText, x
		clc
		adc #2

		ldx TextColumn
		inc TextColumn

		
		jsr PLOT.PlotCharacter

		lda #DARK_GRAY
		jsr PLOT.ColorCharacter

		ldx StoredXReg

		inx
		cpx #8
		bcc Loop4


	GameTitle:

	ldx #0
	lda #13
	sta TextColumn

	Loop:		

		stx StoredXReg

		ldy #TitleRow
		
		lda TitleText, x
		clc
		adc #2

		ldx TextColumn
		inc TextColumn

		
		jsr PLOT.PlotCharacter

		lda #YELLOW
		jsr PLOT.ColorCharacter

		ldx StoredXReg

		inx
		cpx #14
		bcc Loop

	lda #16
	sta GameOverTimer
	sta TextColumn
	ldx #0

	Loop2:		

		stx StoredXReg

		ldy #FireRow
		
		lda FireText, x
		clc
		adc #2

		ldx TextColumn
		inc TextColumn
		
		jsr PLOT.PlotCharacter

		lda #CYAN
		jsr PLOT.ColorCharacter

		ldx StoredXReg

		inx
		cpx #8
		bcc Loop2




	ldx #0
	lda #2
	sta TextColumn

	Loop3:		

		stx StoredXReg

		ldy #WrittenRow
		
		lda WrittenText, x
		clc
		adc #2

		ldx TextColumn
		inc TextColumn

		
		jsr PLOT.PlotCharacter

		lda #GREEN
		jsr PLOT.ColorCharacter

		ldx StoredXReg

		inx
		cpx #36
		bcc Loop3

	ldx #0
	lda #9
	sta TextColumn

	Loop32:		

		stx StoredXReg

		ldy #MusicRow
		
		lda MusicText, x
		clc
		adc #2

		ldx TextColumn
		inc TextColumn
		
		jsr PLOT.PlotCharacter

		lda #LIGHT_BLUE
		jsr PLOT.ColorCharacter

		ldx StoredXReg

		inx
		cpx #24
		bcc Loop32


	jmp TitleLoop



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

	jsr CONTROL.Update
	jsr SCORE.CheckScoreToAdd

	//jsr ENEMIES.FrameUpdate
	jsr STARS.FrameUpdate
	jsr SHIP.FrameUpdate

	lda GameActive
	beq GamePaused

	jmp Loop

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		beq GameOver

		dec GameOverTimer
		jmp Loop

		GameOver:

		jmp TitleScreen

}	
 


StartGame: {

	jsr GameScreen
	jmp Loop


}


GameScreen:{

	
	jsr ResetGame

	rts	

}



ResetGame: {

	lda ScreenColour
	sta VIC.BACKGROUND_COLOR
	
	lda #DARK_GRAY
	
	sta VIC.BORDER_COLOR 
	
	lda #ONE
	sta MAIN.GameActive

	lda #ZERO
	sta MAIN.GameIsOver

	jsr CONTROL.Reset
	jsr DRAW.ClearScreen

	jsr MAPLOADER.DrawMap
	jsr SCORE.Reset
	jsr SHIP.Reset
	jsr ENEMIES.Reset

	rts

}







#import "common/assets.asm"
}