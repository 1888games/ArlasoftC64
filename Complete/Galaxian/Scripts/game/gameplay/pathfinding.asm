.namespace ENEMY {

	* = * "Pathfinding"



	 CalculateRequiredSpeed: {


	 	lda #BOTTOM_RIGHT
	 	sta Quadrant

	 	lda MoveX
	 	bpl XNotReverse

	 	MinusX:

		 	eor #%11111111
		 	clc
		 	adc #1
		 	sta MoveX

		 	lda #BOTTOM_LEFT
		 	sta Quadrant

		 	lda MoveY
		 	bpl CheckMagnitude

		 BothMinus:

		 	eor #%11111111
		 	clc
		 	adc #1
		 	sta MoveY

		 	lda #TOP_LEFT
		 	sta Quadrant
		 	jmp CheckMagnitude
	 	
	 	XNotReverse:

		 	lda MoveY
		 	bpl CheckMagnitude

		 	eor #%11111111
		 	clc
		 	adc #1
		 	sta MoveY

		 	lda #TOP_RIGHT
		 	sta Quadrant


	 	CheckMagnitude:

		 	lda MoveX
		 	cmp #16
		 	bcc XOkay

		 	lsr MoveX

		 	lda MoveY
		 	cmp #1
		 	beq NoChangeY
		 	lsr MoveY

		 	NoChangeY:

		 	jmp CheckMagnitude

	 	XOkay:

	 		lda MoveY
	 		cmp #16
	 		bcc CalculateXSpeed

	 		lsr MoveY

	 	
	 		lda MoveX
	 		cmp #1
	 		beq NoChangeX

	 		lsr MoveX

	 		NoChangeX:

	 		jmp XOkay


		 CalculateXSpeed:

			lda MoveX
			asl
			asl
			asl
			asl
			clc
			adc MoveY
			tay

			lda Quadrant
			beq TopRightAngle

			cmp #BOTTOM_RIGHT
			beq BottomRightAngle

			cmp #BOTTOM_LEFT
			beq BottomLeftAngle

			TopLeftAngle:

			lda TopLeftLookup, y
			jmp Finish

		BottomLeftAngle:

			lda BottomLeftLookup, y
			jmp Finish


		BottomRightAngle:

			lda BottomRightLookup, y
			jmp Finish

		TopRightAngle:

			lda TopRightLookup, y


		Finish:

			sta Angle, x

			jmp AddIt

			beq Done
			bcc DecAngle

		IncAngle:

			inc Angle, x
			jmp CalcFrame

		DecAngle:

			dec Angle, x

		CalcFrame:

			lda Angle, x

		AddIt:
			clc
			adc BasePointer, x
			sta SpritePointer, x


		Done:


		rts


	 }


	
	
	







}