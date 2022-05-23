PLEXOR: {

	SpriteIndex:
		.byte $00
	SpriteIndexOrig:	.byte 0

	VicSpriteIndex:
		.byte $00

	POT:
		.byte 1,2,4,8,16,32,64,128
	IPOT:
		.byte 254,253,251,247,239,223,191,127

	NoSprites:
		.byte 1


	DoneD011: .byte 0

	NextLine: .byte 0
	FirstSpriteY:	.byte 0


.align $100
	* = * "VicSpriteTable"
	VicSpriteTable:
		.word MP_IRQ.LoopStart[0].Unrolled
		.word MP_IRQ.LoopStart[1].Unrolled
		.word MP_IRQ.LoopStart[2].Unrolled
		.word MP_IRQ.LoopStart[3].Unrolled
		.word MP_IRQ.LoopStart[4].Unrolled
		.word MP_IRQ.LoopStart[5].Unrolled
		.word MP_IRQ.LoopStart[6].Unrolled
		.word MP_IRQ.LoopStart[7].Unrolled

	
	Initialise: {

	ldx #$00
	!:
		lda __DATA, x
		sta SpriteX, x

		inx
		cpx #[__DATAEND - __DATA]
		bne !-

		rts

	}


	__DATA:
		_SpriteX:
			.fill MAX_SPRITES,0
		_SpriteY:
			.var yy = 10
			.for(var i=0; i<MAX_SPRITES; i++) {
				.byte yy
			}
		_SpriteColor:
			.fill MAX_SPRITES, random() * 15 + 1
		_SpritePointer:
			.fill MAX_SPRITES, 16
			
		_SpriteOrder:
			.fill MAX_SPRITES, i


	__DATAEND:



*=* "IRQ"
MP_IRQ: {
		pha
		txa 
		pha 
		tya 
		pha 

		lda DoneD011
		bne Skip32

		lda #0
		sta VIC.SPRITE_MULTICOLOR

		inc DoneD011
		jmp Skip32

		lda SpriteOrder
		tax
		lda SpriteCopyY, x
		cmp #58
		bcs Skip32

		inc DoneD011


		Skip32:



		// lda DoneD011
		// bne NotFirst

		// inc DoneD011
		// inc $d020
		// lda SCROLLER.D011Copy
		// sta $d011


		// and #%00000111
		// bne NotSwap

		


		// NotSwap:

		// clc
		// adc #48
		// sta SCREEN_RAM + 40
		// sta SCREEN_RAM_2 + 40
		// dec $d020

		// NotFirst:


		//lda NoSprites
		//beq AreSprites
		//bpl AreSprites

		//lda #BLUE
		//sta $d020

		//jmp NoSpritesExit

		AreSprites:

			lda VicSpriteIndex
			and #$07
			asl 
			sta SelfMod + 1
		SelfMod:

			jmp (VicSpriteTable)

		LoopStart:
			
			.for(var i=0; i<8; i++) {
		Unrolled:	
					//inc $d020
					ldx SpriteIndex
					lda SpriteOrder, x
					tax

					lda SpriteCopyY, x
					cmp #50
					bcs SpriteOkay

					jmp SkipSprite

				SpriteOkay:

					sta $d001 + i * 2

					lda PointerCopy, x
					sta SPRITE_POINTERS + i
					sta SPRITE_POINTERS_2 + i

					lda ColourCopy, x
					sta $d027 + i

					bpl !nomsb+
				!msb:
					lda $d010 
					ora #[pow(2,i)]
					sta $d010
					jmp !msbdone+
				!nomsb:
					lda $d010 
					and #[255 - pow(2,i)]
					sta $d010

				!msbdone:

					lda SpriteCopyX, x
					sta $d000 + i * 2

					inc VicSpriteIndex

				SkipSprite:

					ldx SpriteIndex
					inx 
					stx SpriteIndex

					cpx #MAX_SPRITES
					bne !+
					jmp !Finish+
				!:


					lda SpriteOrder, x
					tax
					lda SpriteCopyY, x
					sec 
					sbc #PADDING * 4
					cmp $d012
					bcc !+
					jmp !nextRaster+
				!:
			}	
			jmp AreSprites


			!nextRaster:
				clc
				adc #PADDING * 2
				sta $d012
				sta ZP.NextLine
				cmp #232
				bcs NoSpritesExit
				jmp !ExitRaster+

		
		!Finish:


			lda #0
			sta SpriteIndex

		NoSpritesExit:

			lda #0
			sta VicSpriteIndex

			lda #<IRQ.MainIRQ
			ldx #>IRQ.MainIRQ
			ldy #IRQ.MainIRQLine
			jsr IRQ.SetNextInterrupt

		//	lda #<IRQ.D011_IRQ
		//	ldx #>IRQ.D011_IRQ
		//	ldy #IRQ.MainIRQLine - 20
		//	jsr IRQ.SetNextInterrupt



//
			jmp FinalExit


	!ExitRaster:


		lda $d011
		and #%01111111
		sta $d011
		lda #<MP_IRQ
		sta $fffe	 
		lda #>MP_IRQ
		sta $ffff

	FinalExit:
		asl $d019
		pla
		tay 
		pla 
		tax
		pla


		rti
}



CopyData: {

	.for(var i=0; i<MAX_SPRITES*4; i++) {
			
			lda SpriteX + i
			sta SpriteCopyX + i
	}

	rts
}


Sort: {	
		
		jsr CopyData

		// Loop2:

		// 	inx
		// 	cpx #MAX_SPRITES
		// 	bcc Loop2

		// 	restart:
		// 		//SWIV adapted SORT
  //               ldx #$00 
  //               txa 
		// sortloop:       
		// 		ldy SpriteOrder,x 
  //               cmp SpriteCopyY,y 
  //               beq noswap2 
  //               bcc noswap1 
  //               stx ZP.Temp1 
  //               sty ZP.Temp4
  //               lda SpriteY,y 
  //               ldy SpriteOrder - 1,x 
  //               sty SpriteOrder,x 
  //               dex 
  //               beq swapdone 
		// swaploop:       
		// 		ldy SpriteOrder - 1,x 
  //               sty SpriteOrder,x 
  //               cmp SpriteCopyY,y 
  //               bcs swapdone 
  //               dex 
  //               bne swaploop 
		// swapdone:       
		// 		ldy ZP.Temp4
  //               sty SpriteOrder, x 
  //               ldx ZP.Temp1
  //               ldy SpriteOrder, x 
		// noswap1:
		//         lda SpriteCopyY, y 
		// noswap2:
		//         inx 
  //               cpx #MAX_SPRITES
  //               bne sortloop 

  //     lda #0

  //     .for(var i=0; i<8; i++) {

  
  //     	sta $d000 + i * 2

  //     }


  //      ldx #0
  //      stx SpriteIndex
  //      stx DoneD011



  //     Loop:

  //    	lda SpriteOrder, x
  //    	tay
  //     	lda SpriteCopyY, y
  //     	cmp #11
  //     	bcc EndLoop
      	
  //     	sec
  //     	sbc #7
  //     	sta FirstSpriteY

  //     	stx SpriteIndex



  //     	jmp Finish

  //     EndLoop:

  //     	inx
  //     	cpx #MAX_SPRITES
  //     	bcc Loop

	 //     //	inc NoSprites

	 //   Finish:



		lda #255
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

        rts
}




}