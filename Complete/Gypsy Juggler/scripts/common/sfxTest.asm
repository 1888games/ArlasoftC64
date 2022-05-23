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



channels:	.byte 2, 0, 1, 1, 0, 0, 0, 0, 0, 0


S0: .import binary "../../Assets/sfx/bear.snd"
S2: .import binary "../../Assets/sfx/bonus.snd" 
S3: .import binary "../../Assets/sfx/click_bloop.sfx"
S4: .import binary "../../Assets/sfx/die_bleep.sfx" 
S5: .import binary "../../Assets/sfx/double_high_tink.sfx"   // chick?
S6: .import binary "../../Assets/sfx/eating.snd"  // clear
S7: .import binary "../../Assets/sfx/error_dee_doo.sfx"  
S8: .import binary "../../Assets/sfx/error_down_melodic.sfx"
S9: .import binary "../../Assets/sfx/error.sfx"
S10: .import binary "../../Assets/sfx/gun_shot_with_bass.sfx"   // land  egg?
S11: .import binary "../../Assets/sfx/gun_shot.sfx"
S12: .import binary "../../Assets/sfx/hammer_hit.sfx"  // land bass
S13: .import binary "../../Assets/sfx/high_blip.sfx"    // chick?
S14: .import binary "../../Assets/sfx/hit_hiss.sfx"  // lang egg
S15: .import binary "../../Assets/sfx/igloo.snd" 
S16: .import binary "../../Assets/sfx/jump.snd"
S17: .import binary "../../Assets/sfx/landing.snd"
S18: .import binary "../../Assets/sfx/long_click_flute.sfx"
S19: .import binary "../../Assets/sfx/low_bang_up.sfx"   
S20: .import binary "../../Assets/sfx/low_noise_hit.sfx"  //bassy
S21: .import binary "../../Assets/sfx/low_to_high_bounce.sfx"
S22: .import binary "../../Assets/sfx/noise_medium.sfx"
S23: .import binary "../../Assets/sfx/noise_thud_high.sfx"  
S24: .import binary "../../Assets/sfx/select_long.sfx" 
S25: .import binary "../../Assets/sfx/select_low_high.sfx" 
S26: .import binary "../../Assets/sfx/short_low_blip.sfx"
S27: .import binary "../../Assets/sfx/short_med_alert.sfx"  
S28: .import binary "../../Assets/sfx/soft_thud_step.sfx" 
S29: .import binary "../../Assets/sfx/splash.snd"
S30: .import binary "../../Assets/sfx/spring.sfx"
S31: .import binary "../../Assets/sfx/toggle.sfx"
S32: .import binary "../../Assets/sfx/very_low_jump.sfx"
S33: .import binary "../../Assets/sfx/whoosh.sfx"


wavetable_l:
.byte  <S0, <S2, <S3, <S4, <S5, <S6, <S7, <S8, <S9, <S10, <S11, <S12, <S13, <S14, <S15, <S16, <S17, <S18, <S19, <S20, <S21, <S22, <S23, <S24, <S25, <S26, <S27, <S28, <S29, <S30, <S31, <S32, <S33


wavetable_h:
.byte  >S0, >S2, >S3, >S4, >S5, >S6, >S7, >S8, >S9, >S10, >S11, >S12, >S13, >S14, >S15, >S16, >S17, >S18, >S19, >S20, >S21, >S22, >S23, >S24, >S25, >S26, >S27, >S28, >S29, >S30, >S31, >S32, >S33




