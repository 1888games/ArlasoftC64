.namespace ACTOR {
.namespace PLAYER {


	* = * "--Sound"

	ClearAllSID: {

		lda #0
		ldx #0

		Loop:

			sta $d400, x
			inx
			cpx #28
			bcc Loop



		rts
	}

	SetAlarm: {

		lda GAME.AttractMode
		bne NotYet

		lda ENERGIZER.Scared
		bne NotYet

		//jsr SFX_KIT_OFF
		jsr ClearAllSID

		jsr SFX_KIT_CLR


		ldx AlarmStatus
		lda Alarms, x
		jsr sid.init


		NotYet:

		rts
	}

	CheckAlarmStatus: {

		txa
		pha

		inc PelletsEaten


		ldx AlarmStatus
		cpx #3
		bcs NoChange

		lda PelletsEaten
		cmp AlarmPellets, x
		bcc NoChange

		inx
		stx AlarmStatus

		lda GAME.AttractMode
		bne NoChange

		lda Alarms, x
		jsr sid.init

		NoChange:

		pla
		tax

		lda PelletsEaten
		cmp #PelletsToEat
		bcc NotComplete

		jsr COMPLETE.Initialise

		NotComplete:

		rts
	}



}
}