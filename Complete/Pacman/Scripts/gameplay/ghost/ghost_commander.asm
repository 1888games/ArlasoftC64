.namespace ACTOR {
.namespace GHOST {

	* = * "-Commander"

	Timer_LSB:	.byte 0
	Timer_MSB:	.byte 0
	CommandMode:		.byte GHOST_SCATTER

	CurrentTimeID:	.byte 0

	.label Short1 = (7*60) -1 
	.label Short2 = (5*60) - 1
	.label Long1 = (20*60) - 1
	.label Long2 = (1033*60) - 1
	.label Long3 = (1037*60) - 1
	.label Short3 = 1

	.label NUM_TIMES = 7

	Times_0_LSB:	.byte <Short1, <Long1, <Short1, <Long1, <Short2, <Long1, <Short2
	Times_0_MSB:	.byte >Short1, >Long1, >Short1, >Long1, >Short2, >Long1, >Short2

	Times_1_LSB:	.byte <Short1, <Long1, <Short1, <Long1, <Short2, <Long2, <Short3
	Times_1_MSB:	.byte >Short1, >Long1, >Short1, >Long1, >Short2, >Long2, >Short3

	Times_2_LSB:	.byte <Short2, <Long1, <Short2, <Long1, <Short2, <Long3, <Short3
	Times_2_MSB:	.byte >Short2, >Long1, >Short2, >Long1, >Short2, >Long3, >Short3


	Times_LSB:		.fill NUM_TIMES, 0
	Times_MSB:		.fill NUM_TIMES, 0

	SetupCommander: {

		lda #GHOST_SCATTER
		sta CommandMode

		lda #0
		sta Timer_LSB
		sta Timer_MSB
		sta CurrentTimeID

		lda GAME.Level
		cmp #2
		bcc Zero

		cmp #5
		bcc One

		Two:

			lda #<Times_2_LSB
			sta ZP.DataAddress

			lda #>Times_2_LSB
			sta ZP.DataAddress + 1

			jmp Copy

		One:

			lda #<Times_1_LSB
			sta ZP.DataAddress

			lda #>Times_1_LSB
			sta ZP.DataAddress + 1

			jmp Copy



		Zero:

			lda #<Times_0_LSB
			sta ZP.DataAddress

			lda #>Times_0_LSB
			sta ZP.DataAddress + 1

		Copy:

		ldy #0

		Loop:

			lda (ZP.DataAddress), y
			sta Times_LSB, y

			tya
			clc
			adc #7
			tay

			lda (ZP.DataAddress), y
			pha

			tya
			sec
			sbc #7
			tay

			pla

			sta Times_MSB, y

			iny
			cpy #7
			bcc Loop

		rts
	}		


	CommanderUpdate: {

		lda ENERGIZER.Scared
		bne Finish


		//lda CommandMode
		//sta $d020

		lda GAME.Active
		beq Finish

		ldx CurrentTimeID
		cpx #NUM_TIMES
		beq Finish

		lda Timer_LSB
		clc
		adc #1
		sta Timer_LSB

		lda Timer_MSB
		adc #0
		sta Timer_MSB
		
		lda Times_LSB, x
		cmp Timer_LSB
		bne Finish

		lda Times_MSB, x
		cmp Timer_MSB
		bne Finish

		ChangeMode:

			lda #0
			sta Timer_LSB
			sta Timer_MSB

			inc CurrentTimeID

			lda CommandMode
			eor #%00000001
			sta CommandMode

			
			lda #1
			sta SignalReverse + 1
			sta SignalReverse + 2
			sta SignalReverse + 3
			sta SignalReverse + 4

		DoNotReverse:



		Finish:


		rts
	}
	

}
}