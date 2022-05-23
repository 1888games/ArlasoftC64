.namespace ENEMY {

	* = * "Spawn"

	SpecialColours:		.byte WHITE, CYAN, WHITE, GREEN, YELLOW, WHITE
	TransformColours:	.byte CYAN, GREEN, YELLOW

	GetNextAvailable: {

		ldx #0

		Loop:

			lda Plan, x
			cmp #PLAN_INACTIVE
			beq Found

			inx
			cpx #MAX_ENEMIES
			bcc Loop

		Found:

			stx ZP.CurrentID


		rts
	}
	


}