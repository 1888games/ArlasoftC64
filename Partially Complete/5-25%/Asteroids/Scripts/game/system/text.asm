	WriteText: {


				tya
				pha
				asl
				tay

		L7816:  lda TextPosTbl,Y        //Get the screen position for the desired text.
				lsr
				lsr
				lsr
				sta TextColumn

		L7819:  lda TextPosTbl + 1,Y   
				lsr
				lsr
				lsr   
				sta TextRow

				lda #26
				sec
				sbc TextRow
				sta TextRow

				ldx #WHITE
				pla
			
				jsr TEXT.Draw


				rts

	}


	DrawDigit: {

		clc
		adc #48
		sta ZP.CharID

		ldx TextColumn
		ldy TextRow

		jsr PLOT.GetCharacter

		ldy #0
		lda ZP.CharID

		sta (ZP.ScreenAddress), y

		lda #WHITE
		sta (ZP.ColourAddress), y

		rts


	}


	TextPosTbl:
	L7871:  .byte $64, $B6          //X=4*$64=$190=400. Y=4*$B6=$2D8=728.
	L7873:  .byte $64, $B6          //X=4*$64=$190=400. Y=4*$B6=$2D8=728.
	L7875:  .byte $0C, $AA          //X=4*$0C=$30 =48.  Y=4*$AA=$2A8=680.
	L7877:  .byte $0C, $A2          //X=4*$0C=$30 =48.  Y=4*$A2=$288=648.
	L7879:  .byte $0C, $9A          //X=4*$0C=$30 =48.  Y=4*$9A=$268=616.
	L787B:  .byte $0C, $92          //X=4*$0C=$30 =48.  Y=4*$92=$248=584.
	L787D:  .byte $64, $C6          //X=4*$64=$190=400. Y=4*$C6=$318=792.
	L787F:  .byte $64, $9D          //X=4*$64=$190=400. Y=4*$9D=$274=628.
	L7881:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.
	L7883:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.
	L7885:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.



	EnglishTextTbl:
	L571E: .byte $0B                //HIGH SCORES 
	L571F: .byte $13                //PLAYER
	L5720: .byte $19                //YOUR SCORE IS ONE OF THE TEN BEST 
	L5721: .byte $2F                //PLEASE ENTER YOUR INITIALS
	L5722: .byte $41                //PUSH ROTATE TO SELECT LETTER 
	L5723: .byte $55                //PUSH HYPERSPACE WHEN LETTER IS CORRECT 
	L5724: .byte $6F                //PUSH START 
	L5725: .byte $77                //GAME OVER
	L5726: .byte $7D                //1 COIN 2 PLAYS 
	L5727: .byte $87                //1 COIN 1 PLAY 

