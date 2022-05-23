BASE: {


	.label OriginalAddress =	$f000 + 688
	.label Base1Address	=	$f000 + 720
	.label Base2Address =		$f000 + 752


	Masks:		.byte %00001111, %10000111, %11100001, %11110000
	Opposite:	.byte %11110000, %01111000, %00011110, %00001111
	CopyBase: {

		ldx #7

		Loop:

			lda OriginalAddress, x
			sta Base2Address, x
			sta Base1Address, x

			dex
			bpl Loop



		rts
	}




	HitByBomb: {

		sty StartID
		sty EndID

		jsr RANDOM.Get
		and #%00000011
		clc
		adc #3
		adc EndID
		sta EndID

		Loop:

			ldx BombID
			lda BOMBS.OffsetX, x
			tax

			lda (TableAddress), y
			sta Amount

			lda #0
			sta RandomMask

			cpy StartID
			beq NoRandom

			Randomise:

				jsr RANDOM.Get
				and Opposite, x
				sta RandomMask

			NoRandom:

				lda Masks, x
				ora RandomMask
				sta RandomMask

				lda Amount
				and RandomMask
				sta (TableAddress), y

				iny
				cpy #8
				beq Finish

				cpy EndID
				beq Finish


			jmp Loop 


		Finish:


		rts
	}



}