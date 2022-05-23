
.var debug = false

MAIN: {
		#import "tetrawall/zeropage.asm"





	BasicUpstart2(Entry)


	*= * "Modules"
	#import "lookups/labels.asm"
	#import "lookups/vic.asm"
	#import "lookups/registers.asm"
	#import "common/macros.asm"
	#import "common/random.asm"
	#import "common/draw.asm"
	#import "tetrawall/game.asm"


	* = * "MAIN"
	
	//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
	Entry: {
		
		
		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT

		jsr RANDOM.init

		Finish:
			

		jmp StartGame

	}


	
	
	Loop: {

		lda VIC.RASTER_Y
		cmp #250
		bne Loop

		FrameCode: 

			jsr CheckControls
			jmp Loop

	}	



	CheckControls: {

		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount

		CheckLeft:

			and #JOY_LEFT
			bne	CheckRight

			lda #LEFT
			//jmp (ZP.ControlAddress)

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			lda #RIGHT
			//jmp (ZP.ControlAddress)

		CheckUp:

			lda ZP.Amount
			and #JOY_UP
			bne	CheckDown

			lda #UP
			//jmp (ZP.ControlAddress)


		CheckDown:

			lda ZP.Amount
			and #JOY_DOWN
			bne	CheckFire

			lda #DOWN  
			//jmp (ZP.ControlAddress)


		CheckFire:

			lda ZP.Amount
			and #JOY_FIRE
			bne	Finish

			lda #FIRE
			//jmp (ZP.ControlAddress)


		Finish:



		rts


	}	

	


	StartGame: {
		
		lda #BLACK
		sta VIC.BACKGROUND_COLOR
		
		lda #BLACK
		sta VIC.BORDER_COLOR 
	
		jsr DRAW.ClearScreen

		jmp Loop
	}



	#import "tetrawall/assets.asm"
	 
	//* = $400 "Screen Ram" virtual
	///.fill $400, 4


	* = 1024 "Screen Ram"



* = 1304
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$01,$29,$03,$01,$02,$03,$01,$04,$03,$01
.byte $05,$03,$01,$06,$03,$01,$07,$03,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0c,$28
.byte $0e,$14,$2a,$0e,$14,$2b,$0e,$14,$15,$0e,$14,$2b,$0e,$14,$2b,$0e
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$16,$17,$18,$16,$17,$18,$16,$17,$18,$16
.byte $17,$18,$16,$17,$18,$16,$17,$18,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$01,$08
.byte $03,$01,$1c,$03,$01,$1d,$03,$1e,$1f,$03,$01,$21,$03,$01,$22,$03
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$14,$15,$0e,$14,$2b,$0e,$14,$2b,$0e,$2c
.byte $2d,$0e,$14,$2e,$0e,$14,$2f,$0e,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$16,$17
.byte $18,$16,$17,$18,$16,$17,$18,$16,$17,$18,$16,$17,$18,$16,$17,$18
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$01,$23,$03,$01,$29,$03,$01,$30,$03,$01
.byte $31,$03,$01,$32,$03,$01,$33,$03,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$14,$34
.byte $0e,$14,$34,$0e,$35,$36,$0e,$35,$37,$0e,$35,$38,$0e,$35,$37,$0e
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$16,$17,$18,$16,$17,$18,$39,$3a,$18,$39
.byte $3a,$18,$39,$3a,$18,$39,$3a,$18,$01,$1d,$03,$1e,$1f,$03,$01,$21
.byte $03,$01,$22,$03,$01,$23,$03,$20,$20,$20,$20,$20,$20,$20,$01,$3b
.byte $03,$01,$3c,$03,$01,$3d,$03,$01,$3e,$03,$3f,$40,$03,$01,$41,$03
.byte $0c,$0f,$0e,$24,$25,$0e,$0c,$26,$0e,$0c,$27,$0e,$0c,$28,$0e,$20
.byte $20,$20,$20,$20,$20,$20,$35,$37,$0e,$35,$38,$0e,$35,$37,$0e,$35
.byte $37,$0e,$42,$43,$0e,$35,$44,$0e,$16,$17,$18,$16,$17,$18,$16,$17
.byte $18,$16,$17,$18,$16,$17,$18,$20,$20,$20,$20,$20,$20,$20,$39,$3a
.byte $18,$39,$3a,$18,$39,$3a,$18,$39,$3a,$18,$39,$3a,$18,$39,$3a,$18
.byte $01,$02,$03,$01,$04,$03,$01,$05,$03,$01,$06,$03,$01,$07,$03,$01
.byte $08,$03,$01,$1c,$03,$20,$01,$45,$03,$01,$46,$03,$01,$47,$03,$01
.byte $30,$03,$01,$31,$03,$01,$32,$03,$0c,$0d,$0e,$0c,$0f,$0e,$0c,$10
.byte $0e,$0c,$0f,$0e,$0c,$0f,$0e,$0c,$10,$0e,$0c,$0f,$0e,$20,$35,$48
.byte $0e,$35,$49,$0e,$35,$49,$0e,$35,$4a,$0e,$35,$4b,$0e,$35,$4c,$0e
.byte $16,$17,$18,$16,$17,$18,$16,$17,$18,$16,$17,$18,$16,$17,$18,$16
.byte $17,$18,$16,$17,$18,$20,$39,$3a,$18,$39,$3a,$18,$39,$3a,$18,$4d
.byte $4e,$18,$4d,$4e,$18,$4d,$4e,$18,$20,$20,$20,$20,$20,$20,$20,$01
.byte $33,$03,$01,$3b,$03,$01,$3c,$03,$01,$3d,$03,$01,$3e,$03,$3f,$40
.byte $03,$01,$41,$03,$01,$45,$03,$01,$46,$03,$01,$47,$03,$09,$0a,$0b
.byte $20,$20,$20,$20,$20,$20,$20,$35,$4b,$0e,$35,$4b,$0e,$35,$4c,$0e
.byte $35,$4b,$0e,$35,$4b,$0e,$4f,$50,$0e,$35,$51,$0e,$35,$52,$0e,$35
.byte $53,$0e,$35,$53,$0e,$11,$12,$13,$20,$20,$20,$20,$20,$20,$20,$4d
.byte $4e,$18,$4d,$4e,$18,$4d,$4e,$18,$4d,$4e,$18,$4d,$4e,$18,$4d,$4e
.byte $18,$4d,$4e,$18,$4d,$4e,$18,$4d,$4e,$18,$4d,$4e,$18,$19,$1a,$1b





* = $0fff "End Of Memory" virtual
.byte 0
}