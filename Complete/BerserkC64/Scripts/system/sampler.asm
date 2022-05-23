.const NTSCorPAL = $02a6

.macro playSample(sampleStart, sampleEnd) {


			sei
			lda #<sampleStart
			sta SAMPLER.nmi.offset + 1
			lda #>sampleStart
			sta SAMPLER.nmi.offset + 2
			lda #>sampleEnd
			sta SAMPLER.nmi.endOffset + 1
			jsr SAMPLER.Init
}


CheckReduce: {

		lda ZP.Counter
		and #%00001111
		bne NotPlayingDead
	
		lda ZP.CurrentSample
		cmp #S_DIE
		bne NotPlayingDead	

		lda $dd04
		sec
		sbc #1
		sta $dd04


	NotPlayingDead:

		

	rts
	}



SAMPLER: {		
		Init:{
				sei

				// lda #%00001111	// set generic volume to 15
				// sta $d418

				// lda #$00		// ADSR voice 3
				// sta $d413
				// lda #$ff
				// sta $d414

				lda #<nmi		// set NMI vector
				sta $fffa	

				lda #>nmi
				sta $fffb

				lda #RTI
				sta $dd0c		

				lda #$ff
			sta $d406
			sta $d406+7
			sta $d496+14
			lda #$49
			sta $d404
			sta $d404+7
			sta $d404+14


			isPAL:				
				lda ZP.Frequency
				sta $dd04		// set NMI timer to 122 cycles (129 for NTSC)

				lda ZP.Frequency + 1
				sta $dd05

				lda #$00
				sta SampleComplete
				lda #$81		// start the NMI timer
				sta $dd0d
				lda #$01
				sta $dd0e

				cli
				rts
		}
		wait:
			.byte $00
		SampleComplete:
			.byte 255
// !:			
// .label wait = * + 1
// 				lda #$00		// wait for sample to be finished
// 				beq !-

// 				sei
// 				lda #$37		// turn back on basic and kernal rom
// 				sta $01

// 				// wait a little
// 				ldy #$30
// rep:			ldx #$00
// !:				dex
// 				bne !-
// 				dey
// 				bne rep
// 				jmp 64738		// reset


	.pc = * "NMI's"
	SkipSamples: .byte $00
	MusicTime: .byte $00
	nmi:	{		
			pha
			txa
			pha

		// 	lda $d012
		// 	and #%00000001
		// 	bne DontSkip

		// 	inc offset + 1
		// 	bne notatend
		// 	inc offset + 2

		// DontSkip:

			//lda #$04
		  	//sta $dd05

		 	bit $d011
		 	bmi !DoSample+


			lda ZP.NextLine
			sec
			sbc $d012
			cmp #1
			bcc notatend

		
			//inc $d020

		!DoSample:
	
			lda SampleComplete
			bne next

			inc offset + 1
			bne PlayNow
			inc offset + 2

			lda offset + 2
		endOffset:
			cmp #>SMP_Destroy
			bcc PlayNow
		
		EndHere:				

			lda #$01
			sta SampleComplete
			lda #$ff
			sta $dd05
			lda #<exit
			sta $fffa
			lda #>exit
			sta $fffb				
			jmp next

		PlayNow:
			lda $d418
			and #$f0
			sta SamplerTemp
		offset:	
			lda SMP_Fire		// step 4 (set high byte of frequency with sample data)
		play:
			lsr
			lsr
			lsr
			lsr
			ora SamplerTemp
			sta $d418

		!Skip:

		next:

			//dec $d020

		notatend:			

		

			pla
			tax
			pla
		exit:
			
			jmp $dd0c
	}
}





///from main.asm -- assets






