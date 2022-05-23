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


			isPAL:				
				// lda #$7a		// set NMI timer to 122 cycles (129 for NTSC)
				lda #$f4 
				sta $dd04
				lda #$00
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
			.byte $01
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


//	.pc = * "NMI's"
	SkipSamples: .byte $00
	MusicTime: .byte $00
	nmi:	{		
			pha
			txa
			pha


			bit $d011
			bmi !+

			lda $d012
			cmp #$f0
			bcs !Skip+
			cmp #$38
			bcs !+
			cmp #$28
			bcc !+
		!Skip:
			lda #$04
			sta $dd05
			jmp next


		!:
			lda #$00
			sta $dd05

		!DoSample:
			lda #$00
			sta MusicTime
			lda SampleComplete
			bne next

			inc offset + 1
			bne PlayNow
			inc offset + 2
			lda offset + 2
		endOffset:
			cmp #>__Round
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
			lda Round		// step 4 (set high byte of frequency with sample data)
		play:
			lsr
			lsr
			lsr
			lsr
			ora SamplerTemp
			sta $d418
		!Skip:

		next:
		notatend:		

			pla
			tax
			pla
		exit:
			jmp $dd0c
	}
}





///from main.asm -- assets

* = $8c00 "8-bit sample data"
.align $100
Round:			
	.fill 100, 0
	.import binary "../assets/samples/round.raw"
__Round:
One:			
.fill 100, 0
	.import binary "../assets/samples/one.raw"
__One:
Fight:		
.fill 100, 0	
	.import binary "../assets/samples/fight2.raw"
__Fight:
Two:		
.fill 100, 0	
	.import binary "../assets/samples/two.raw"
__Two:
Three:			
	.import binary "../assets/samples/three.raw"
__Three:



