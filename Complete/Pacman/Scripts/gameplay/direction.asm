.namespace ACTOR {

	* = * "-Direction"
	//.label DIR_UP = 0
//.label DIR_LEFT = 1
//.label DIR_DOWN = 2
//.label DIR_RIGHT = 3

	XLookup:	.byte 0, -1, 0, 1
	YLookup:	.byte -1, 0, 1, 0
	DirectionReverse:	.byte 2, 3, 0, 1



	SetDirectionFromEnum: {

		lda Direction, x
		tay

		lda XLookup, y
		sta DirX, x

		lda YLookup, y
		sta DirY, x

		lda DirectionReverse, y
		sta GHOST.OppositeDirection, x

		rts
	}


	

}