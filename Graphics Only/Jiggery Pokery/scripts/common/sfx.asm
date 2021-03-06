.macro sfx(sfx_id)
{		
		:StoreState()

		ldx #sfx_id
		jsr PlaySfx

		:RestoreState()
}
	

PlaySfx: {

	lda cooldown
	beq Okay

	cpx lastSfX
	beq Skip

	Okay:

	stx lastSfX
	lda #10
	sta cooldown
	jsr sfx_play

	Skip:

	rts


}

.macro sfxFromX() {

		:StoreState()

		jsr sfx_play

		:RestoreState()

}

music_on: .byte 1
nextTrack:	.byte 0
currentVolume:	.byte 15
fadingOut:		.byte 0
fadingIn:		.byte 0
lastSfX:		.byte 0
cooldown:		.byte 0


sfx_cooldown: {

	lda cooldown
	beq Okay

	dec cooldown

	Okay:	


	rts
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


SidFrameUpdate: {

	jsr sid.play

	lda fadingIn
	beq CheckFadeOut

	FadeIn:

		inc currentVolume
		lda currentVolume
		cmp #15
		bcc ChangeVolume

		lda #0
		sta fadingIn
		jmp ChangeVolume

	CheckFadeOut:

		lda fadingOut
		beq Finish

	FadeOut:

		dec currentVolume
		lda currentVolume
		bne ChangeVolume

		lda #1
		sta fadingIn

		lda #0
		sta fadingOut

		lda nextTrack
		jsr sid.init

	ChangeVolume:
		lda currentVolume
		jsr sid.init +9

	Finish:



	rts
}

ChangeTracks: {

	sta nextTrack

	lda #1
	sta fadingOut

	lda #0
	sta fadingIn

	rts


}

//when sid is not playing, we can use any of the channels to play effects
play_no_music:
{
			lda channels, x
			sta channel
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
			pha
			lda times7,x
			tax
			pla
			//jmp sid.init + 6			
			
channel:
.byte 2
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




//effects must appear in order of priority, lowest priority first.

.label SFX_EXPLODE = 0
.label SFX_LAND = 1
.label SFX_BLOOP = 2
.label SFX_MOVE = 3
.label SFX_ROTATE = 4
.label SFX_CHICK = 5

channels:	.byte 2, 0, 1, 1, 0, 0, 0, 0, 0, 0

sfx_land:
.import binary "../../Assets/sfx/low_noise_hit.sfx"

sfx_bloop:
.import binary "../../Assets/sfx/click_bloop.sfx"


whoosh:
.import binary "../../Assets/sfx/toggle.sfx"


blip:
.import binary "../../Assets/sfx/short_low_blip.sfx"
// .import binary "../../Assets/sfx/bonus.snd" 


hiss:
.import binary "../../Assets/sfx/bear.snd"

chick:
.import binary ".../../Assets/sfx/double_high_tink.sfx"


wavetable_l:
.byte  <whoosh, <sfx_land, <sfx_bloop, <blip, <hiss, <chick
wavetable_h:
.byte  >whoosh, >sfx_land, >sfx_bloop, >blip, >hiss, >chick



