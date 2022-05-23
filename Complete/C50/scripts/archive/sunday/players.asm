PLAYERS: {


	* = $530 "TEAMS"

Teams2:
 .text "CASSETTE"
 .text "CPUNITED"
 .text "THE SWAN"
 .text "RED STAR"
 .text "ATHLETIC"
 .text "EVERTONE"
 .text "LEAD UTD"
 .text "CHORLTON"




* = * "PLAYER DATA"

Data2:
.byte 3, 2, 4, 1, 2, 2, 7, 4, 5, 3, 3, 3, 1, 2, 3, 3, 2, 1, 6, 2, 1, 4, 5, 5, 3, 0, 1, 4, 0, 2, 4, 6, 5, 0, 6, 7, 2, 4, 7, 0, 2, 0, 5, 5, 6, 0, 7, 2


* = * "PLAYER SETUP"

	Reset2: {

		lda #13
		sta ZP.NumberPlayers

		ldx #64

		Loop:

			jsr RANDOM.Get
			and #%00111111

			sta ZP.SkillsLookup - 1, x
			dex
			bne Loop

		jsr RANDOM.Get
		and #%00111111	
		sta ZP.SquadStart



		SetSelection:

			txa
			clc
			adc ZP.SquadStart
			cmp #64
			bcc Okay

			sec
			sbc #64

			Okay:

			sta ZP.Selection, x
			inx
			cpx #16
			bcc SetSelection

		lda #1
		sta ZP.Formation

		lda #5
		sta ZP.Formation + 1

		lda #9
		sta ZP.Formation + 2

		lda #11
		sta ZP.Formation + 3

		lda #20
		sta ZP.Formation + 4


		rts
	}


* = * "PLAYERS"

Names2:
.text "NICK"
.text "LEON"
.text "EDDY"
.text "KANE"
.text "WADE"
.text "IMRE"
.text "JAKE"
.text "JOEL"
.text "LIAM"
.text "RUSS"
.text "JOHN"
.text "ROSS"
.text "WILF"
.text "KARL"
.text "DALE"
.text "DAVY"
.text "MAXI"
.text "GARY"
.text "CARL"
.text "DANE"
.text "LUKE"
.text "MIKE"
.text "TONY"
.text "SETH"
.text "EWAN"
.text "JOEY"
.text "NEIL"
.text "TODD"
.text "WILL"
.text "JODI"
.text "BILL"
.text "JOCK"
.text "KOFI"
.text "MATT"
.text "OWEN"
.text "ANDY"
.text "CHAD"
.text "DEAN"
.text "GLEN"
.text "BRAD"
.text "SEAN"
.text "EARL"
.text "RORY"
.text "MICK"
.text "LUIS"
.text "FINN"
.text "RYAN"
.text "DREW"
.text "STAN"
.text "GENE"
.text "ALEC"
.text "JACK"
.text "SCOT"
.text "ADAM"
.text "LYLE"
.text "FINN"
.text "MARK"
.text "BERT"
.text "TOBY"
.text "RHYS"
.text "JOSH"
.text "PAUL"
.text "PHIL"
.text "THEO"

* = * "Commentary"


	Commentary2: .text "FALLS OVER\$00"
				.text "PASSES\$00"
				.text "PLAYS\$00"
				.text "FLICKS\$00"
				.text "BRINGS\$00"
				.text "IT\$00"
				.text "INSIDE\$00"
				.text "FORWARD\$00"
				.text "WITH THE\$00"
				.text "CROSS\$00"
				.text "DUMMY\$00"
				.text "CORNER\$00"
				.text "LONG BALL\$00"
				.text "TRIPS\$00"
				.text "MISCONTROLS\$00"
				.text "SHOOTS\$00"
				.text "HEADS\$00"
				.text "WIDE!\$00"
				.text "OVER!\$00"
				.text "SAVED!\$00"
				.text "POST!\$00"
				.text "BAR!\$00"
				.text "GOAL!!!\$00"

			





	* = $130 virtual 
	Teams: .byte 0
	* = $170 virtual
	Data: .byte 0
	* = $1a0 virtual
	Reset: .byte 0
	* = $1de virtual
	Names: .byte 0
	* = $2de virtual
	Commentary: .byte 0


	
}

