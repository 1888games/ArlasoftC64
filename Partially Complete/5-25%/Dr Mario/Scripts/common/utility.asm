UTILITY: {

	* = * "Utility"

	BankOutKernalAndBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}

	BankInKernal: {

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta PROCESSOR_PORT
		rts

	}
	


}