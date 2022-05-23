RANDOM:{


    RandomAdd: .byte 0 
    CurrentIndex: .byte 0

     Sequence:
    .if(target == "PET") {
 
         .byte 29,61,10,138,52,207,52,178,0,168,192,236,42,44,36,42,224,37,39,68,183,60,168,188,246,67,24,18,159,56,24,238,172,103,212,17,24,170,202,50,118,95,33,219,36,169,99,26,242,79,85,138,61,118,50,210,128,110,61,53,44,70,183,212, 101,45,118,124,5,34,212,173,193,83,57,153,200,102,68,40,157,118,59,231,7,237,98,205,14,247,121,19,133,40,20,97,121,133,76,210,247,136,112,54,252,122,253,25,58,148,46,39,58,186,125,173,250,229,251,93,85,39,74,89,104,215,180,173,126,245,197,53,139,110,160,38,242,78,116,189,233,27,37,109,163,11,125,33,114,128,179,129,51,11,67,54,145,7,119,225,186,140,19,169,134,139,227,211,74,254,76,7,206,218,17,224,186,186,137,198,85,103,192,169,142,75,68,194,181,16,66,234,105,193,106,137,86,93,70,244,152,75,22,119,108,154,79,250,239,9,203,191,35,16,249,72,193,122,236,64,244,160,3,235,60,143,8,58,208,155,53,97,206,193,232,183,28,179,121,21,33,59,173,224,249,8,141,215,250,87,204,240,137,119,143,182
    }

    PET:{

       .if(target == "PET") {
            .label RandomNumber = TEMP7
            txa
            pha

            ldx CurrentIndex
            lda Sequence, x
            sta RandomNumber
            inx
            stx CurrentIndex

            pla
            tax
            lda RandomNumber
            adc RandomAdd
       }   

        rts
     
    }

	C64: {


        .if (target == "C64") {
            lda seed
            beq doEor
            
            beq noEor
            bcc noEor
        doEor:    
            eor #$1d
            eor $dc04
            eor $dd04
        noEor: 
            sta seed
            adc RandomAdd
            rts
        seed:
            .byte $62

        }
    }


    VIC:{

        .if(target == "VIC") {

            lda #$01
            asl               
            bcc Skip         
            eor #$4d  

            Skip:            
            sta VIC+1
            eor $9124

        }

         adc RandomAdd

        rts

    }

    Initialise: {

    	.if (target == "C64") {

    	    lda #$ff
            sta $dc05
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


    	rts

    }



    Get: {

       .if(target == "C64") {

            jsr C64
       }  

       .if(target == "VIC") {
            jsr VIC
       }

       .if(target == "264") {
        
            lda $ff1e
            adc RandomAdd
       }

       .if(target == "PET") {

            jsr PET
       }

       rts

    }



}