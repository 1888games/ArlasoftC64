
MAIN: {

#import "lookups/zeropage.asm"

* = $1d00 "Code1"
#import "setup/upstart.asm"
#import "setup/loadModules.asm" 

GameCounter:		.byte 32, 32, 32
SpeedIncreaseCounter: .byte 48, 48
FrameSwitch: .byte 0
TitleCooldown: .byte 30, 255

BASICStub(0,"Entry")

.label MaxSpeed = 13

Entry:	
	
		//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

		//sei 

		jsr VIC.Setup
		jsr SOUND.Setup

		jmp TitleScreen



Loop:

		
	jmp Loop


TitleScreen: {

		jsr SOUND.StopAll
		
		
		DrawMap:

		jsr TITLELOADER.DrawMap


		lda TitleCooldown + 1
		sta TitleCooldown

		jmp TitleLoop

}




TitleLoop: {

		lda TitleCooldown
		beq GetJoystick

		dec TitleCooldown
		jmp TitleLoop

		GetJoystick:


		jsr $FFE4
		bne Loop

		jmp GetJoystick

		Loop:

			lda TitleCooldown
			beq NewGame
			dec TitleCooldown
			ldx #1
			jsr WaitForRasterLine
			jmp Loop




}



NewGame:{
	
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

TestLoop: {



	jmp TestLoop
}



WaitForRasterLine: {


	ldx #ZERO
	ldy #ZERO

	xLoop:

		inx
		cpx #240
		beq EndxLoop

		jmp xLoop

		EndxLoop:

		ldx #ZERO
		iny	
		cpy #9

		beq Finish
		jmp xLoop

	Finish:

		rts



	.label RasterTarget = TEMP1

	Loop: 

		lda VIC.RASTER_LINE
		eor VIC.RASTER_MASK
		and VIC.RASTER_MASK
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


TestByte: .byte 0






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

		//.break


		
		ldx #1
		jsr WaitForRasterLine
		jmp MonkeyIRQ


PreviousCellID: .byte 0

 		
MonkeyIRQ: {



		jsr MONKEY.Control
		jsr MONKEY.Update

		lda MONKEY.CellID
		cmp PreviousCellID
		
		bne MoveMonkey

		jmp NoMove

		MoveMonkey:

			ldx PreviousCellID
			jsr MONKEY.Delete
			jsr MONKEY.Draw

			lda MONKEY.CellID


		NoMove:

		lda MONKEY.CellID
		sta PreviousCellID
		
		jsr SOUND.Update
		jsr GameTick
		jsr CheckWhetherToUpdateScore
		jsr PINEAPPLE.Update

		jmp MainLoop

		

}


Random: {

	jsr RANDOM_NUMBER.Get

	

	rts

}
 #import "setup/assets.asm"

}
