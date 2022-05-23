REGISTERS:{

	*=* "---Registers"
	.label PROCESSOR_PORT = $01
	.label RASTER_INTERRUPT_VECTOR = $fffe
	.label JOY_PORT_2 = $dc00


	BankOutKernalandBasic:{

		lda REGISTERS.PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta REGISTERS.PROCESSOR_PORT
		rts
	}


	BankInKernal: {

		lda REGISTERS.PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta REGISTERS.PROCESSOR_PORT
		rts

	}


	DetectMachine: {

		w0:  lda $D012
		w1:  cmp $D012
	    beq w1
	    bmi w0
	    and #$03
	    sta MAIN.MachineType

	    cmp #2
	    bne PAL

	    NTSC:

	     jmp Finish
	  
	    PAL:


	    Finish:

	    rts

	}
	
}