PLEXOR: {

	* = * "Plexor"

	SpriteIndex:
		.byte $00
	VicSpriteIndex:
		.byte $00

	POT:
		.byte 1,2,4,8,16,32,64,128
	IPOT:
		.byte 254,253,251,247,239,223,191,127

	NoSprites:
		.byte 1


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

		lda #$00
		sta $d020
		sta $d021

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
			.fill MAX_SPRITES, $c0
		_SpriteOrder:
			.fill MAX_SPRITES, i
	__DATAEND:



*=* "Plexor"
MP_IRQ: {
		pha
		txa 
		pha 
		tya 
		pha 

	//	inc $d020

		//lda NoSprites
		//beq AreSprites
		//bpl AreSprites

	//	jmp NoSpritesExit

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
					ldx SpriteIndex
					lda SpriteOrder, x
					tax

					lda SpriteY, x
					cmp #15
					bcc SkipSprite

				SpriteOkay:

					sta $d001 + i * 2

					lda SpritePointer, x
					sta SPRITE_POINTERS + i

					lda SpriteColor, x
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


					NoMSB:
				
					lda SpriteX, x
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
					lda SpriteY, x
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
				adc #PADDING
				sta $d012
				cmp #243
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

	

			//dec $d020

			jmp FinalExit


	!ExitRaster:
		//dec $d020

		lda $d011
		and #$7f
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

Sort: {	


		//lda #11
		//sta $d020



		SetDebugBorder(BROWN)

		ldx #0 
	
		
		Loop2:

			

			inx
			cpx #MAX_SPRITES
			bcc Loop2

			restart:
				//SWIV adapted SORT
                ldx #$00 
                txa 
		sortloop:       
				ldy SpriteOrder,x 
                cmp SpriteY,y 
                beq noswap2 
                bcc noswap1 
                stx ZP.Sort2
                sty ZP.Sort1
                lda SpriteY,y 
                ldy SpriteOrder - 1,x 
                sty SpriteOrder,x 
                dex 
                beq swapdone 
		swaploop:       
				ldy SpriteOrder - 1,x 
                sty SpriteOrder,x 
                cmp SpriteY,y 
                bcs swapdone 
                dex 
                bne swaploop 
		swapdone:       
				ldy ZP.Sort1
                sty SpriteOrder, x 
                ldx ZP.Sort2
                ldy SpriteOrder, x 
		noswap1:

			
		DontStart:


		       // stx SpriteIndex
		noswap2:

				lda SpriteY, y
		        inx 
                cpx #MAX_SPRITES
                bne sortloop 


      // .for(var i=0; i<8; i++) {

      // 	lda #0
      // 	sta $d000 + i * 2

      // }


      ldx #0
      stx NoSprites
      stx SpriteIndex
      stx ZP.StartCollisionID
		stx ZP.EndCollisionID
		stx ZP.FoundCollision
		stx ZP.QuitCollision


      Loop:

     	lda SpriteOrder, x
     	tay
      	lda SpriteY, y
      	cmp #11
      	bcc increaseBoth

    	lda SpriteIndex
    	bne NoIndex

      	stx SpriteIndex
      	
      	NoIndex:

	        lda SpriteY, y 
	        sec
	        sbc SpriteY + PLAYER.PlayerSprite
	       	clc
	       	adc #8
	       	bmi increaseBoth

	     	cmp #16
	       	bcs Finish

	       	inc ZP.FoundCollision
	     
	increaseBoth:

			inc ZP.EndCollisionID

			lda ZP.FoundCollision
			bne EndLoop

			inc ZP.StartCollisionID

      EndLoop:


      	inx
      	cpx #MAX_SPRITES - 1
      	bcc Loop

	     	inc NoSprites

	   Finish:


		// lda #0
		// sta VIC.SPRITE_0_X
		// sta VIC.SPRITE_1_X
		// sta VIC.SPRITE_2_X
		// sta VIC.SPRITE_3_X
		// sta VIC.SPRITE_4_X
		// sta VIC.SPRITE_5_X
		// sta VIC.SPRITE_6_X
		// sta VIC.SPRITE_7_X


		lda #255
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		SetDebugBorder(DARK_GRAY)
	 // 	lda #0
	 // 	sta $d020

        rts
}




}