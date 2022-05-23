VIRUS: {


	Level:				.byte 0
	Number:				.byte 0, 0
	NumberToGenerate:	.byte 0, 0


	Queue:		.fill 128, 0

	
	MinimumRows:	.fill 15, 6
					.byte 5, 5, 4, 3


	ColourTable:	.byte CELL_YELLOW, CELL_RED, CELL_BLUE, CELL_BLUE, CELL_RED, CELL_YELLOW, CELL_YELLOW, CELL_RED
					.byte CELL_BLUE, CELL_BLUE, CELL_RED, CELL_YELLOW, CELL_YELLOW, CELL_RED, CELL_BLUE, CELL_RED


	MinimumRow:		.byte 0

	ColoursPresent:	.byte 0, 0, 0

	VirusSwitch:	.byte VIRUS_BLUE, VIRUS_YELLOW. VIRUS_RED


	NewGame: {

		jsr NewLevel

		lda #0
		sta ZP.PlayerOffset

		clc
		adc #GRID.CellsPerSide
		sta ZP.EndOfGrid



		rts
	}

	NewLevel: {


		GetVirusNumber:

			lda Level
			asl
			asl
			clc
			adc #4
			sta Number
			sta Number + 1
			sta NumberToGenerate 
			sta NumberToGenerate + 1

		CalculateMinRow:

			ldx Level
			cpx #20
			bcc Okay

			ldx #19

		Okay:

			lda MinimumRows, x
			sta MinimumRow


		rts
	}


	
	ConvertRowColumnToCell: {

		lda ZP.CellRow
		asl
		asl
		asl
		clc
		adc ZP.CellColumn
		clc
		adc ZP.PlayerOffset
		sta ZP.CellID

		rts
	}


	Generate: {



		jsr GetXY
		jsr GetColour
		jsr ValidatePosition


		






		Exit:


			jmp GenerateAll.Return


		rts
	}


	GenerateAll: {

		jmp Generate



		Return:

			ldy ZP.CurrentPlayer
			lda NumberToGenerate, y
			beq Complete

			jmp GenerateAll

		Complete:



		rts
	}

	ValidatePosition: {

		lda #0
		sta ColoursPresent
		sta ColoursPresent + 1
		sta ColoursPresent + 2

		CheckCell:
		
			ldy ZP.CellID
			lda PlayerOne, y
			bmi OkayToPlace

		ThisIsTaken:

			inc ZP.CellColumn
			lda ZP.CellColumn
			cmp #8
			bcc OkayColumn

			lda #0
			sta ZP.CellColumn

			inc ZP.CellRow

		OkayColumn:

			inc ZP.CellID
			lda ZP.CellID
			cmp ZP.EndOfGrid
			beq Exit

			jmp CheckCell

		OkayToPlace:


		CheckRight:

			lda ZP.CellColumn
			cmp #6
			bcs OkayRight

			lda ZP.CellID
			clc
			adc #2
			tay

			lda PlayerOne, y
			bmi OkayRight

			cmp ZP.CellColour
			bne NotMatchingRight




		NotMatchingRight:

			and #%00000011
			tax

			inc ColoursPresent

		OkayRight:






		rts
	}

	// Check in all four cardinal directions 2 cells away from the candidate virus position the virus contents of the bottle.
// If all three colors are present in the four checked cells, go back to step 7.1 (don't do step 7).
// If the four checked cells in step 8 lacks the currently selected virus color, go to step 13.
// If the currently selected virus type is yellow, change the currently selected virus color to blue; if the currently selected virus type is red, change the currently selected virus color to yellow; if the currently selected virus color is blue, change the currently selected virus color to red.
// Go to step 8.
// Set the candidate virus position in the bottle to the currently selected virus color.
// Return the number of remaining viruses less one.


	GetColour: {

		GetRemainderDivide4:

			lda NumberToGenerate
			lsr
			lsr
			asl
			asl
			sta ZP.Amount

			lda NumberToGenerate
			sec
			sbc ZP.Amount

		DetermineColour:
		
			cmp #3
			bcc UseFixed

			jsr RANDOM.Get
			and #%00001111
			tay
			lda ColourTable, y

		UseFixed:

			clc
			adc #VIRUS_ADD
			sta ZP.CellColour


		rts
	}


	GetXY: {

		GetY:

			jsr RANDOM.Get
			and #%00001111
			cmp MinimumRow
			bcc Generate

			sta ZP.CellRow

		GetX:

			jsr RANDOM.Get
			and #%00000111
			sta ZP.CellColumn

			jmp ConvertRowColumnToCell

	}

	//Generate a random number in range [1,16].

// If the random number in step 1 is greater than the maximum allowed row (seed the "Virus Level"/"Maximum Row" table above), go back to step 1.
// Generate a random number in range [1,8] and use for the candidate virus X coordinate, with 1 on the left and 8 on the right.
// Use the number generated in step 1 as the candidate virus Y coordinate, with 1 on the bottom and 16 the top.
// Using the number of remaining viruses as the numerator, take the remainder of division by 4.
// Using the remainder calculated in step 5, set the currently selected virus color: Yellow if 0, Red if 1, and Blue if 2. Otherwise,if the remainder was 3, do the following:
// Randomly generate an integer in range [0,15].
// Select from the "PRNG Output" table above the virus color matching the integer generated in step 6.1.
// Do repeatedly the following while the current candidate virus position is filled:
// Increment the candidate virus X position.
// If the candidate virus X position is now 9:
// Set the candidate virus X position to 1 and increment the candidate virus Y position
// If the candidate virus Y position is now 17:
// Return the number of remaining viruses to generate.
// Check in all four cardinal directions 2 cells away from the candidate virus position the virus contents of the bottle.
// If all three colors are present in the four checked cells, go back to step 7.1 (don't do step 7).
// If the four checked cells in step 8 lacks the currently selected virus color, go to step 13.
// If the currently selected virus type is yellow, change the currently selected virus color to blue; if the currently selected virus type is red, change the currently selected virus color to yellow; if the currently selected virus color is blue, change the currently selected virus color to red.
// Go to step 8.
// Set the candidate virus position in the bottle to the currently selected virus color.
// Return the number of remaining viruses less one.
// 
}