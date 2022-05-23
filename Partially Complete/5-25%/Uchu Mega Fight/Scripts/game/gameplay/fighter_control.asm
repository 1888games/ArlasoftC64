.namespace FIGHTER {



	FunctionLSB:	.byte <Control_Idle
	FunctionMSB:	.byte >Control_Idle


	Control_Idle: {

		ldy #1


		lda INPUT.JOY_FIRE_NOW, y
		beq Finish


		FireDown:

		lda AnimationID
		cmp #2
		bcs Finish

		inc $d020

		lda #5
		ldx #0
		stx ZP.PlayerID
		jsr SetupAnimation




		Finish:






		rts

	}





	Control: {

		lda State, x
		tay

		lda FunctionLSB, y
		sta ZP.FunctionAddress 

		lda FunctionMSB, y
		sta ZP.FunctionAddress + 1

		jmp (ZP.FunctionAddress)

	}





}