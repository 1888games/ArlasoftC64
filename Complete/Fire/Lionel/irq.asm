IRQ: {

	C64: {

		.label INTERRUPT_CONTROL = $d01a
		.label INTERRUPT_STATUS = $d019

		Init: {


			.if (target == "C64") {

				sei 	// disable interrupt flag
				lda VIC.INTERRUPT_CONTROL
				ora #%00000001		// turn on raster interrupts
				sta VIC.INTERRUPT_CONTROL

				lda #<MainIRQ
				ldx #>MainIRQ
				ldy #MainIRQLine
				jsr SetNextInterrupt

				asl VIC.INTERRUPT_STATUS
				cli

			}

			rts

		}



	}


	Initialise: {

		.if (target == "C64") {

			C64.Init

		}


		rts
	}
		






}