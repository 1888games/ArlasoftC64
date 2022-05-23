
*=* "---Random"

RANDOM: {

	RandomAdd: .byte 0


	Get: {

		jsr Get2
		adc Mouse.PosX_LSB
		adc $d012

		rts

	}

	init2: {
			
 
        lda #$13
        sta $dc05
        lda #$ff
        sta $dd05
        lda #$7f
        sta $dc04
        lda #$37
        sta $dd04

        lda #$91
        sta $dc0e
        sta $dd0e
        rts
	}

	Get2: {
	  	lda seed
        beq doEor
        asl
        beq noEor
        bcc noEor
    doEor:    
        eor #$1d
        // eor $dc04
        // eor $dd04	
    noEor:  
        sta seed
        rts
    seed:
        .byte $62

	}



	Change: {


		lda RandomAdd
		adc #2
		sta RandomAdd

		rts
	}
    
    init: 

    	jsr init2
       
        lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register
		rts
		

	}



