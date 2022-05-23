.var musicList = List()
.eval musicList.add(LoadSid("../assets/Sid/OnTheFarm3.sid"))
.eval musicList.add(LoadSid("../assets/Sid/startgame.sid"))
.eval musicList.add(LoadSid("../assets/Sid/gameover.sid"))
.eval musicList.add(LoadSid("../assets/Sid/loselife.sid"))

Bonus: .import binary "../assets/Sfx/jump.bin"
Hit: .import binary "../assets/Sfx/sfx_boom.bin"
Steal: .import binary "../assets/Sfx/pickup.bin"
Low: .import binary "../assets/Sfx/lowsound.bin"
High: .import binary "../assets/Sfx/highsound.bin"

.label StoreX = TEMP1


SOUND: {
	
	MusicActive:  .byte 1
	SFXActive: .byte 1

	InitLowBytes: .byte 0, 0, 0, 0
	InitHighBytes: .byte 0, 0, 0, 0
	PlayLowBytes: .byte 0, 0, 0, 0
	PlayHighBytes: .byte 0, 0 , 0, 0

	CurrentSid: .byte 0

	SetupSidAddresses: {

		.var i = 0

		.for(var i=0;i<4;i++) {


			lda #<musicList.get(i).init
			sta InitLowBytes + i
			lda #>musicList.get(i).init
			sta InitHighBytes + i

			lda #<musicList.get(i).play
			sta PlayLowBytes + i
			lda #>musicList.get(i).play
			sta PlayHighBytes + i

		}

		rts

	}

	InitialiseSid:

		sei 

		stx CurrentSid
		lda InitLowBytes, x
		sta Init+ 1
		lda InitHighBytes, x
		sta Init + 2

		lda #ZERO

		Init:
			jsr $FEED

		cli

		rts
	
	PlayMusic: {

		lda MusicActive
		beq Finish

		ldx CurrentSid
		lda PlayLowBytes, x
		sta Play + 1
		lda PlayHighBytes, x
		sta Play + 2

		Play:
			jsr $FEED

		Finish:
			rts

	}
	

	currChannelIndex:
		.byte $00
	channelList:
		.byte $00,$07,$0e

	getNextChannel: {


			ldx SFXActive
			beq !+
			ldx #$0e
			rts
		!:
			ldx currChannelIndex
			inx
			cpx #$03
			bne !+
			ldx #$00
		!:
			stx currChannelIndex
			pha
			lda channelList, x
			tax 
			pla 
			rts 
	}


	PlaySound: {

		stx StoreX
		pha

		ldx CurrentSid
		lda InitLowBytes, x
		clc
		adc #6
		sta Go + 1
		lda InitHighBytes, x
		sta Go + 2

	
		jsr getNextChannel
		pla

		Go:

			jsr $FEED

		//.break

		ldx StoreX
		
		rts

	}

	


	SFX_LOW:{

		lda #<Low
		ldy #>Low
		jsr PlaySound

		rts

	}




	SFX_HIGH:{

		lda #<High
		ldy #>High
		jsr PlaySound

		rts

	}



	SFX_HIT: {

		lda #<Hit
		ldy #>Hit
		jsr PlaySound

		rts
	}	

	SFX_STEAL: {

		lda #<Steal
		ldy #>Steal
		jsr PlaySound

		rts
	}	

	SFX_BONUS: {



		lda #<Bonus
		ldy #>Bonus 
		jsr PlaySound

		rts
	}	
}