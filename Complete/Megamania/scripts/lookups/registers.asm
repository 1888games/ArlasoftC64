REGISTERS:{

	.label PROCESSOR_PORT = $01
	.label RASTER_INTERRUPT_VECTOR = $fffe
	.label JOY_PORT_2 = $dc00


	BankOutKernalAndBasic:{

		lda REGISTERS.PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta REGISTERS.PROCESSOR_PORT
		rts
	}
	
}