KEYBOARD: {
					// 		   shop feat path queu hire attr inve mood bank sett  opti     
					//	  r    s    f    p    q    h    a    i    m    b    g     o
	KeysToCheck:	.byte $12, $13, $06, $10, $11, $08, $01, $09, $0d, $02, $07, $0f
	HudXMatch:		.byte 21,  12,  15,  3,   6,   18,  9,   24,  27,  30,  37,  34  




	.label CooldownTime = 2

	CooldownTimer: .byte 0

	Check:  {

		SetDebugBorder(7)

		lda CooldownTimer
		beq Okay

		dec CooldownTimer
		jmp Finish

		Okay:

		jsr KeyboardScan
		bcs Finish

		.break

		pha

		tya
		asl
		bcc NoRunStop

		jsr Runstop
		pla
		jmp Finish

		NoRunStop:

		pla

		
			ldy #CooldownTime
			sty CooldownTimer
		

			//jsr NEW_GAME.KeyPressed

		Finish:

		rts

	}


	   // +=================================================+
    //     |             Returned in Accumulator             |
    //     +===========+===========+=============+===========+
    //     |  $00 - @  |  $10 - p  |  $20 - SPC  |  $30 - 0  |
    //     |  $01 - a  |  $11 - q  |  $21 -      |  $31 - 1  |
    //     |  $02 - b  |  $12 - r  |  $22 -      |  $32 - 2  |
    //     |  $03 - c  |  $13 - s  |  $23 -      |  $33 - 3  |
    //     |  $04 - d  |  $14 - t  |  $24 -      |  $34 - 4  |
    //     |  $05 - e  |  $15 - u  |  $25 -      |  $35 - 5  |
    //     |  $06 - f  |  $16 - v  |  $26 -      |  $36 - 6  |
    //     |  $07 - g  |  $17 - w  |  $27 -      |  $37 - 7  |
    //     |  $08 - h  |  $18 - x  |  $28 -      |  $38 - 8  |
    //     |  $09 - i  |  $19 - y  |  $29 -      |  $39 - 9  |
    //     |  $0a - j  |  $1a - z  |  $2a - *    |  $3a - :  |
    //     |  $0b - k  |  $1b -    |  $2b - +    |  $3b - ;  |
    //     |  $0c - l  |  $1c - £  |  $2c - ,    |  $3c -    |
    //     |  $0d - m  |  $1d -    |  $2d - -    |  $3d - =  |
    //     |  $0e - n  |  $1e - ^  |  $2e - .    |  $3e -    |
    //     |  $0f - o  |  $1f - <- |  $2f - /    |  $3f -    |
    //     +-----------+-----------+-------------+-----------+


	Runstop: {



		rts

	}

}