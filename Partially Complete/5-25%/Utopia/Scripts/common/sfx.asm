
*=* "---Sound"

.macro sfx(sfx_id)
{
			txa
			pha

			ldx #sfx_id
			jsr sfx_play

			pla
			tax
}

music_on:	.byte 0


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

			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
			dex
			bpl !skp+			
			ldx #2
		!skp:
			stx channel
			pha
			lda times7,x
			tax
			pla
			jsr sid.init + 6	
			rts		
			
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
			jsr sid.init + 6
			rts
			
}



//effects must appear in order of priority, lowest priority first.
.label SFX_BULLDOZE = 0
.label SFX_PLACE =1
.label SFX_SELECT_HUD = 2
.label SFX_CANCEL = 3
.label SFX_BUILD = 4
.label SFX_CLICK = 5
.label SFX_ERROR = 6
.label SFX_CLEAN = 7
.label SFX_FIX = 8



bulldoze:
.import binary "../../Assets/sfx/destroy_path.sfx"

place:
.import binary "../../Assets/sfx/build_path.sfx"


select_hud:
.import binary "../../Assets/sfx/select_long.sfx"

cancel:
.import binary "../../Assets/sfx/soft_thud_step.sfx"

error:
.import binary "../../Assets/sfx/potential/error.sfx"

build:
.import binary "../../Assets/sfx/build.sfx"

click:
.import binary "../../Assets/sfx/low_tap.sfx"

clean:
.import binary "../../Assets/sfx/select_low_high.sfx"


fix:
.import binary "../../Assets/sfx/select_low_high.sfx"


wavetable_l:
.byte <bulldoze, <place, <select_hud, <cancel, <build, <click, <error, <clean, <fix

wavetable_h:
.byte >bulldoze, >place, >select_hud, >cancel, >build, >click, >error, >clean, >fix


