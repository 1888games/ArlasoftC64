TASK: {


	.label MAX_FUNCTIONS = 128

	FunctionLowByte:	.fill MAX_FUNCTIONS, 0
	FunctionHighByte:	.fill MAX_FUNCTIONS, 0
	FunctionParam:		.fill MAX_FUNCTIONS, 0
	LastFunctionID:		.byte 255

	FunctionLookup1:		.fill 64, i * 2
	FunctionLookup2:		.fill 64, (i * 2) + 1



	// permanent tasks

	// player update







	// entity tasks





	ClearFunctions: {

		lda #255
		sta LastFunctionID

		ldx #0
		lda #0
		sta ZP.CurrentFunctionID

		Loop:

			sta FunctionHighByte, x
			sta FunctionLowByte, x
			
			inx
			cpx #MAX_FUNCTIONS
			bcc Loop


		rts
	}


	Process: {

		lda LastFunctionID
		cmp #255
		bne Ready

			jmp MAIN.Loop


		Ready: 

			
			lda ZP.Counter
			and #%00000001
			beq TableOne

		TableTwo:

			lda #<FunctionLookup2
			sta TableAddress + 1

			lda #>FunctionLookup2
			sta TableAddress + 2
			jmp CheckRasterLSB

		TableOne:

			lda #<FunctionLookup1
			sta TableAddress + 1

			lda #>FunctionLookup1
			sta TableAddress + 2

		CheckRasterLSB:

			lda $d012
			cmp #240
			bcc TimeLeft

			jmp MAIN.Loop

		AllDone:

			lda #0
			sta ZP.CurrentFunctionID

			jmp MAIN.Loop

		TimeLeft:

			ldx ZP.CurrentFunctionID

		TableAddress:

			lda $BEEF, x
			tax

			lda FunctionHighByte, x
			beq AllDone
			sta Function + 2

			lda FunctionLowByte, x
			sta Function + 1

		Function:

			jsr $BEEF

			inc ZP.CurrentFunctionID
			
			jmp CheckRasterLSB
		
	}

	AddFunction: {

		// a = low byte address
		// y = high byte address
		// pla = function param

		ldx LastFunctionID
		cpx #255
		bne Okay

		ldx #0
		stx LastFunctionID

		Okay:

		sta FunctionLowByte, x
		tya
		sta FunctionHighByte, x

		lda ZP.Amount
		sta FunctionParam, x

		inc LastFunctionID

		rts
	}




}