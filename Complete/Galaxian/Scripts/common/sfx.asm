
.macro sfx(sfx_id)
{		
		:StoreState()

		ldx #sfx_id
		jsr sfx_play

		:RestoreState()
}

.macro sfxFromA() {

		sta ZP.SoundID

		:StoreState()

		ldx ZP.SoundID
		jsr sfx_play

		:RestoreState()

}

* = * "-Sound"

music_on: .byte 0
channel:	.byte 0
allow_channel_1: .byte 1

drone_delay:	.byte 255
drone_max:		.byte 255
dive_time:		.byte 255
diving_enemy:	.byte 255
dive_mode:		.byte 255

.label startDelay = 65


play_background: {

	lda FORMATION.Mode
	bne PlayBack

	lda #SUBTUNE_BLANK
	jmp Play

	PlayBack:

	lda #SUBTUNE_DANGER


	Play:

	jsr sid.init
	lda #1
	sta allow_channel_1


	rts
}

StartDive: {

	lda #0
	sta dive_time
	sta dive_mode

	stx diving_enemy



	sfx(SFX_DIVE)

	rts
}

StartDrone: {


	lda #startDelay
	sta drone_max

	lda #1
	sta drone_delay

	rts
}

StopDrone: {

	lda #255
	sta drone_delay



	rts
}


HandleDive: {

	lda dive_time
	bmi Finish

	lda ZP.Counter
	and #%00000011
	bne Finish

	inc dive_time

	lda dive_mode
	beq Wheew


	cmp #1
	beq PartTwo


	PartThree:

		lda dive_time
		cmp #62
		bcc Finish

		sfx(SFX_DIVE_3)

		lda #0
		sta dive_time

		inc dive_mode

		rts

	PartTwo:

		lda dive_time
		cmp #62
		bcc Finish

		
		sfx(SFX_DIVE_3)

		lda #0
		sta dive_time

		inc dive_mode

		rts

	Wheew:

		lda dive_time
		cmp #36
		bcc Finish

	StartPart2:

		sfx(SFX_DIVE_2)

		inc dive_mode

		lda #0
		sta dive_time

	Finish:

		rts

}


KillDive: {

	lda CHARGER.HaveAggressiveAliens
	beq NotAggressive

	lda FORMATION.EnemiesLeftInStage
	bne Finish

	NotAggressive:

	cpx diving_enemy
	bne Finish

	Force:

	sfx(SFX_EMPTY)

	lda #255
	sta dive_time
	sta dive_mode

	Finish:


	rts
}

SFX: {

 	FrameUpdate: {

 		jsr HandleDive


 		lda drone_delay
 		bmi Finish

 		beq Ready

 		NotReady:

 			lda drone_max
 			cmp #8
 			bcs Okay2	

 			lda #8
 			sta drone_max


 		Okay2:

	 		dec drone_delay
	 		rts

 		Ready:

	 		lda drone_max
	 		sta drone_delay

	 		sfx(SFX_SWARM)




 		Finish:

		rts

	}
}

set_sfx_routine:
{
			lda music_on
			bne !on+
			
			lda #<play_no_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_no_music
			sta sfx_play.sfx_routine + 2
			rts
			
		!on:
			lda #<play_with_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_with_music
			sta sfx_play.sfx_routine + 2
			rts	
}

sfx_play:
{			
	sfx_routine:
			jmp play_with_music
}


//when sid is not playing, we can use any of the channels to play effects
play_no_music:
{			
			lda channels, x
			sta channel

			bne NoOneCheck

			lda allow_channel_1
			bne NoOneCheck

			inc channel

			NoOneCheck:
			
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
			pha
			lda times7,x
			tax
			pla
			jmp sid.init + 6			
			

times7:
.fill 3, 7 * i			
}


play_with_music:
{
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx #7 * 2
			jmp sid.init + 6
			rts
}


StopChannel0: {

	lda #0
	sta $d404

	rts


}


StopChannel1: {

	lda #0
	sta $d40B
	rts
}







//effects must appear in order of priority, lowest priority first.


.label SFX_DIVE = 5
.label SFX_FIRE = 0
.label SFX_COIN = 6
.label SFX_EXTRA = 7
.label SFX_DEAD = 8
.label SFX_THEME = 9
.label SFX_SWARM = 10
.label SFX_DIVE_2 = 11
.label SFX_EMPTY = 12
.label SFX_DIVE_3 = 13

channels:	.byte 0, 0, 0, 0, 0, 1, 2, 1, 0, 2, 2, 1, 1, 1

sfx_fire: .import binary "../../Assets/goattracker/fire.sfx"
sfx_hitG1: .import binary "../../Assets/goattracker/hitG1.sfx"
sfx_hit2: .import binary "../../Assets/goattracker/hitG2.sfx"

sfx_dive2:	.import binary "../../Assets/goattracker/divept2.sfx"
sfx_dive3:	.import binary "../../Assets/goattracker/divept3.sfx"
sfx_dive: .import binary "../../Assets/goattracker/diveg4.sfx"


sfx_coin: .import binary "../../Assets/goattracker/coing.sfx"
sfx_extra: .import binary "../../Assets/goattracker/extra.sfx"
sfx_dead: .import binary "../../Assets/goattracker/dead2.sfx"
sfx_theme: .import binary "../../Assets/goattracker/galax.sfx"
sfx_swarm: .import binary "../../Assets/goattracker/swarm3.sfx"
sfx_empty: .import binary "../../Assets/goattracker/empty.sfx"
//.import binary "../../Assets/sfx/high_blip.sfx"








wavetable_l:
.byte <sfx_fire,<sfx_hit2, <sfx_hitG1, <sfx_hitG1, <sfx_hitG1, <sfx_dive,  <sfx_coin, <sfx_extra, <sfx_dead, <sfx_theme, <sfx_swarm, <sfx_dive2, <sfx_empty, <sfx_dive3

wavetable_h:
.byte >sfx_fire,>sfx_hit2, >sfx_hitG1, >sfx_hitG1, >sfx_hitG1, >sfx_dive,  >sfx_coin, >sfx_extra, >sfx_dead, >sfx_theme, >sfx_swarm,  >sfx_dive2, >sfx_empty, >sfx_dive3

