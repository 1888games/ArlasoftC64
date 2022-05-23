


MAIN: {

#import "lookups/zeropage.asm"

* = $2000
#import "setup/upstart.asm"
#import "setup/loadModules.asm"

GameCounter:		.byte 32, 32, 32
SpeedIncreaseCounter: .byte 48, 48
FrameSwitch: .byte 0
TitleCooldown: .byte 30, 30

BASICStub(8,"Entry")


.label MaxSpeed = 13

Entry:	
		// 0-2 Border 4-7 Background 3 Invert

		sei 

		jsr VIC.Setup
		jsr VIC.ConvertCharacterSet
	
		jmp TitleScreen
	


TitleScreen: {

		jsr SOUND.StopAll
		
		lda VIC.CHAR_RAM
		and #%11110000
		ora #%00001101  // $1C00
		sta VIC.CHAR_RAM

		DrawMap:

		jsr TITLELOADER.DrawMap

		lda #%01111000
		sta VIC.BORDER_BACKGROUND

		lda TitleCooldown + 1
		sta TitleCooldown

		jmp TitleLoop

}




TitleLoop: {

		lda TitleCooldown
		beq CheckFire

		dec TitleCooldown
		jmp TitleLoop

		CheckFire:

		sta $9113
		lda #127
		sta $9122

		lda REGISTERS.JOY_PORT_UDLF
		and #JOY_FIRE
		bne TitleLoop

		lda #2
		sta TitleCooldown

		Loop:

			lda TitleCooldown
			beq NewGame
			dec TitleCooldown
			ldx #1
			jsr WaitForRasterLine
			jmp Loop


}



NewGame:{

		lda VIC.CHAR_RAM
		ora #%00001111  // $1C00
		sta VIC.CHAR_RAM

		lda #%00111101
		sta VIC.BORDER_BACKGROUND


		jsr MAPLOADER.DrawMap

		lda GameCounter + 2
		sta GameCounter + 1
		sta GameCounter

		jsr CHAR_DRAWING.ClearAll
		jsr MONKEY.Reset
		jsr SCORE.Reset
		jsr KEY.Reset
		jsr LIVES.Reset
		jsr PINEAPPLE.Reset
		jsr CAGE.Reset
		jsr CAGE.LockCage
		 jsr ENEMIES.Reset





		jmp MainLoop

}



WaitForRasterLine: {

	.label RasterTarget = TEMP1
	stx RasterTarget

	Loop: 

		lda VIC.RASTER_LINE
		cmp RasterTarget
		bne Loop

		rts

}



CheckWhetherToUpdateScore: {

		lda ZP_COUNTER
		and #3
		bne NoScoreAdd

		jsr SCORE.CheckScoreToAdd

		NoScoreAdd:

		rts
}


CheckSpawn:{



		jsr Random

		adc #128
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

CheckGameSpeed:{

		dec SpeedIncreaseCounter
		bne NoSpeedIncrease

		lda SpeedIncreaseCounter + 1
		sta SpeedIncreaseCounter

		lda GameCounter + 1
		cmp #MaxSpeed
		bcc NoSpeedIncrease

		dec GameCounter + 1
		dec GameCounter + 1

		NoSpeedIncrease:

			rts
}



GameTick: {

		inc ZP_COUNTER

		lda GameCounter
		cmp #ONE
		bcc PerformTick

		dec GameCounter
		rts

		PerformTick:

			lda FrameSwitch
			beq FlipOn

			lda #ZERO 
			sta FrameSwitch

			jmp RestoreCounter

			FlipOn:

				lda #ONE
				sta FrameSwitch

			RestoreCounter:

			lda GameCounter + 1
			sta GameCounter

			asl 
			sta MONKEY.DropTime

			jsr ENEMIES.Update
			jsr KEY.Update
			jsr KEY.DrawKey
			jsr CAGE.Update
			jsr CAGE.Draw

		
			lda KEY.Active
			beq Finish

			jsr CheckGameSpeed
			jsr CheckSpawn

		Finish:
		
		lda MONKEY.DisableControl
		bne NoSound

		jsr SOUND.PlayTick

		NoSound:
		rts
}


MainLoop: 
		
		ldx #1
		jsr WaitForRasterLine
		jmp MonkeyIRQ

 		
MonkeyIRQ: {



	
		jsr MONKEY.Delete
		jsr MONKEY.Control
		jsr MONKEY.Draw
		jsr SOUND.Update
		jsr GameTick
		jsr CheckWhetherToUpdateScore
		jsr PINEAPPLE.Update

		ldx #150
		jsr WaitForRasterLine

		jmp MainLoop

		

}


Random: {

 		//Random	subroutine
	lda	#$01
	asl               
	bcc	Skip         
	eor	#$4d  

Skip:            
	sta	Random+1
	eor	$9124

    
	rts

}

#import "setup/assets.asm"

}
