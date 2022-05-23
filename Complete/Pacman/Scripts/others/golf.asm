//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $0000

//Start of disassembled code
* = $0400 "Base Address"

        .byte $00,$00,$00,$74,$ef,$ea,$70,$d0,$0e,$3c,$35,$00,$60,$20,$43,$a9

    L_0410:
        .byte $81,$1f,$f0,$3f,$07
        .byte $01,$df,$ff,$68,$c5,$1f,$03,$81,$c3,$13,$3f,$df,$e2,$8e,$03,$1c
        .byte $e0,$ee,$76,$c3,$70,$3f,$fc,$bb,$cf,$c0,$f0,$1f,$fc,$74

    L_0433:
        bit.a SCREEN_BUFFER_1 + $02
        sty SCREEN_BUFFER_1 + $60
        tya 
        adc SCREEN_BUFFER_1 + $3a
        cpx SCREEN_BUFFER_0 + $33c
        inx 
        adc (SCREEN_BUFFER_1 + $34),y

        .byte $43,$2c,$00,$80,$d1,$39,$7f,$27,$f4,$86,$c6,$e4,$74,$bf,$1e,$07
        .byte $67,$33,$13,$10,$c1,$45,$b0,$9a,$fa,$f8,$e8,$64,$37,$c9,$31,$e6
        .byte $f0,$f9,$3c,$60,$34,$74,$27,$0e,$b6,$c8,$d2,$a0,$7f,$b0,$d8,$4d
        .byte $63,$87,$83,$81,$03,$45,$27,$05,$dc,$8c,$cc,$f7,$ec,$3f,$0f,$23
        .byte $70,$b0,$1a,$90,$e5,$57,$f8,$f1,$03,$00

    L_048b:
        bcc L_0410
        inc SCREEN_BUFFER_1 + $c7
        cpx L_30ef + $9

        .byte $2b,$d5,$07,$cb,$f1,$70,$89,$c0,$5e,$a6,$3c,$39,$e0,$02,$ed,$9c
        .byte $ae,$1c,$25,$20,$e8

    L_04a7:
        sed 

        .byte $52,$10,$fc,$a6,$0e,$11,$82,$c8,$47,$e7,$28,$58,$f5,$f4,$1a,$50
        .byte $4e,$05,$27,$07,$00,$01,$7a,$d6,$91,$6e,$c0,$dc,$b8,$85,$db,$00
        .byte $c2,$bd,$4e,$a4,$70,$bd,$21,$1c,$e4,$c8,$d2,$38,$1e,$e2,$4d,$75
        .byte $1f,$29,$30,$2f,$94,$18,$00,$78,$27,$49,$30,$d7,$45,$0c,$04,$01
        .byte $3a,$3e,$2a,$c9,$0c,$06,$22,$02,$7c,$d3,$05,$0e,$67,$79,$a5,$e0
        .byte $a0,$54,$e6,$c5,$42,$a0,$23,$73

    L_0500:
        ora (SCREEN_BUFFER_1 + $01,x)

        .byte $02,$03,$04,$04,$05,$04,$05,$06,$03,$01,$05,$01,$03,$00,$00,$05
        .byte $03,$04,$06,$07,$06,$05,$08,$08,$07,$08,$07,$0a,$0a,$0b,$00,$02
        .byte $02,$02,$03,$04,$02,$05,$04,$06,$07,$05,$00,$05,$08,$08,$00,$00
        .byte $01,$02,$01,$03,$05,$09,$11,$21,$31,$51,$61,$81,$c1,$c9,$cb,$eb
        .byte $ed,$f5,$01,$02,$22,$2a,$3a,$7a,$fa,$3a,$5a,$5a,$5a,$da,$da,$5a
        .byte $5a,$5a,$01,$02,$06,$0a,$0e,$16,$26,$2a,$4a,$5a,$9a,$1a,$3a,$3b
        .byte $5b,$5b,$01,$02,$03,$05
        .fill $17, $0
        .byte $01,$01,$02,$03,$03,$04,$05,$09,$0d,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$01,$01,$01,$01

    L_0597:
        .byte $02,$00,$00,$00,$00
        .fill $1c, $20
        .byte $12,$15,$0e,$3a

    L_05bc:
        .fill $40, $20
        .byte $20,$20,$80,$00

    L_0600:
        jsr L_0701 + $6
        tsx 
        stx SCREEN_BUFFER_0 + $26a
        ldy #$00
        ldx #$03
    L_060b:
        jsr L_07b8
        bcs L_0669
        sta SCREEN_BUFFER_1 + $78,x
        dex 
        bne L_060b
    L_0615:
        inx 
        tya 
        and #$0f
        beq L_062f
        txa 
        lsr 
        ldx SCREEN_BUFFER_0 + $ff,y
    L_0620:
        rol 
        rol SCREEN_BUFFER_1 + $78
        dex 
        bpl L_0620
        adc SCREEN_BUFFER_0 + $133,y
        tax 
        lda SCREEN_BUFFER_1 + $78
        adc SCREEN_BUFFER_0 + $167,y
    L_062f:
        sta SCREEN_BUFFER_0 + $168,y
        txa 
        sta SCREEN_BUFFER_0 + $134,y
        ldx #$04
        jsr L_0647
        sta SCREEN_BUFFER_0 + $100,y
        iny 
        cpy #$34
        bne L_0615
        ldy #$00
        beq L_0684
    L_0647:
        lda #$00
        sta SCREEN_BUFFER_1 + $78
        cpx #$01
        bcc L_0667
    L_064f:
        lsr SCREEN_BUFFER_1 + $79
        bne L_0661
        pha 
    L_0654:
        php 
        jsr L_07b8
        bcs L_0669
        plp 
        bcc L_0675
        ror 
        sta SCREEN_BUFFER_1 + $79
        pla 
    L_0661:
        rol 
        rol SCREEN_BUFFER_1 + $78
        dex 
        bne L_064f
    L_0667:
        rts 


    L_0668:
        clc 
    L_0669:
        ldx #$f0
        txs 
        rts 


    L_066d:
        dex 
        dec SCREEN_BUFFER_1 + $7b
        dec SCREEN_BUFFER_1 + $76
    L_0672:
        dey 
        bcc L_0654
    L_0675:
        jsr L_07fc
        bcc L_067c
        lda (SCREEN_BUFFER_1 + $75),y
    L_067c:
        sta (SCREEN_BUFFER_1 + $7a),y
        jsr L_0809
    L_0681:
        tya 
        bne L_0672
    L_0684:
        txa 
        bne L_066d
        inx 
        jsr L_0647
        tay 
        bne L_06a1
    L_068e:
        inx 
        jsr L_064f
        lsr 
        iny 
        bcc L_068e
        cpy #$11
        bcc L_06a9
        beq L_0668
        ldx #$10
        jsr L_0647
    L_06a1:
        sta SCREEN_BUFFER_1 + $74
        ldx SCREEN_BUFFER_1 + $78
        ldy #$00
        bcc L_06d0
    L_06a9:
        ldx SCREEN_BUFFER_0 + $ff,y
        jsr L_0647
        adc SCREEN_BUFFER_0 + $133,y
        sta SCREEN_BUFFER_1 + $74
        lda SCREEN_BUFFER_1 + $78
        adc SCREEN_BUFFER_0 + $167,y
        pha 
        bne L_06c2
        ldy SCREEN_BUFFER_1 + $74
        cpy #$04
        bcc L_06c4
    L_06c2:
        ldy #$03
    L_06c4:
        ldx SCREEN_BUFFER_0 + $300,y
        jsr L_0647
        adc SCREEN_BUFFER_0 + $303,y
        tay 
        lda SCREEN_BUFFER_1 + $74
    L_06d0:
        sbc SCREEN_BUFFER_1 + $7a
        bcc L_06d6
        dec SCREEN_BUFFER_1 + $7b
    L_06d6:
        eor #$ff
        sta SCREEN_BUFFER_1 + $7a
        cpy #$01
        bcc L_06fc
        ldx SCREEN_BUFFER_0 + $100,y
        jsr L_0647
        adc SCREEN_BUFFER_0 + $134,y
        bcc L_06ec
        inc SCREEN_BUFFER_1 + $78
        clc 
    L_06ec:
        adc SCREEN_BUFFER_1 + $7a
        sta SCREEN_BUFFER_1 + $75
        lda SCREEN_BUFFER_1 + $78
        adc SCREEN_BUFFER_0 + $168,y
        adc SCREEN_BUFFER_1 + $7b
        sta SCREEN_BUFFER_1 + $76
        pla 
        tax 
        sec 
    L_06fc:
        ldy SCREEN_BUFFER_1 + $74
        jmp L_0681

    L_0701:
         .byte $02,$04,$04,$30,$20,$10,$a5
        .byte $7e,$f0,$01,$60,$86,$74,$84,$75,$e6,$7e,$ad,$ee,$09,$d0,$20,$a8
        .byte $20,$16,$08

    L_071b:
        iny 
        lda (SCREEN_BUFFER_1 + $74),y
        bne L_071b
        tya 
        ldx SCREEN_BUFFER_1 + $74
        ldy SCREEN_BUFFER_1 + $75
        jsr L_ffbd
        lda #$02
        ldy #$00
        jsr L_0811
        jsr L_ffc0
        ldx #$02
        jmp L_ffc6
    L_0737:
        jsr L_0838
        ldy #$00
    L_073c:
        lda (SCREEN_BUFFER_1 + $74),y
        sta SCREEN_BUFFER_1 + $7c
        pha 
        ldx #$08
    L_0743:
        bit cCia2PortA
        bpl L_0743
        bvc L_0743
        lsr SCREEN_BUFFER_1 + $7c
        lda #$10
        ora cCia2PortA
        bcc L_0755
        eor #$30
    L_0755:
        sta cCia2PortA
        lda #$c0
    L_075a:
        bit cCia2PortA
        bne L_075a
        lda #$cf
        and cCia2PortA
        sta cCia2PortA
        dex 
        bne L_0743
        iny 
        pla 
        bne L_073c
        sta L_d06f + $b
    L_0771:
        dex 
        bne L_0771
    L_0774:
        sta L_d06f + $b
    L_0777:
        bit cCia2PortA
        bvc L_0777
        pha 
        pla 
        pha 
        pla 
        ldx #$00
    L_0782:
        nop 
        nop 
        nop 
        ldy #$08
    L_0787:
        nop 
        lda #$10
        eor cCia2PortA
        sta cCia2PortA
        asl 
        ror SCREEN_BUFFER_0 + $00,x
        dey 
        bne L_0787
        inx 
        bne L_0782
        stx SCREEN_BUFFER_1 + $7d
        ldx #$fe
        lda SCREEN_BUFFER_0 + $00
        bne L_07b1
        ldx SCREEN_BUFFER_0 + $01
        bne L_07b0
        stx SCREEN_BUFFER_1 + $7e
        lda SCREEN_BUFFER_0 + $02
        sta SCREEN_BUFFER_0 + $3b5
    L_07b0:
        dex 
    L_07b1:
        stx SCREEN_BUFFER_0 + $3ce
    L_07b4:
        lda #$00
        sec 
        rts 


    L_07b8:
        lda SCREEN_BUFFER_1 + $7e
        beq L_07b4
        stx SCREEN_BUFFER_0 + $3da
        sty SCREEN_BUFFER_0 + $3dc
        lda $09ee
        beq L_07de
        ldx SCREEN_BUFFER_1 + $7d
        lda SCREEN_BUFFER_0 + $02,x
        inx 
        cpx #$ff
        stx SCREEN_BUFFER_1 + $7d
        bcc L_07d9
        pha 
        jsr L_0774
        pla 
    L_07d8:
        clc 
    L_07d9:
        ldx #$01
        ldy #$09
        rts 


    L_07de:
        jsr L_ffcf
        ldx SCREEN_BUFFER_1 + $90
        beq L_07d8
        pha 
        txa 
        and #$03
        sta SCREEN_BUFFER_0 + $3b5
        dec SCREEN_BUFFER_1 + $7e
        jsr L_0826
        pla 
        ldx SCREEN_BUFFER_0 + $3b5
        cpx #$01
        bcc L_07d9
        txa 
        bcs L_07d9
    L_07fc:
        pha 
        lda SCREEN_BUFFER_1 + $01
    L_07ff:
        sta $080b
        lda #$34
        sei 
        sta SCREEN_BUFFER_1 + $01
        pla 
        rts 


    L_0809:
        pha 
        lda #$36
        sta SCREEN_BUFFER_1 + $01
        cli 
        pla 
        rts 


    L_0811:
        ldx SCREEN_BUFFER_1 + $ba
        jmp L_ffba
    L_0816:
        lda SCREEN_BUFFER_1 + $01
        sta $082f
        lda $09ef
        sta L_09f0
        lda #$36
        sta SCREEN_BUFFER_1 + $01
        rts 


    L_0826:
        lda #$02
        jsr L_ffc3
        jsr L_ffcc
    L_082e:
        lda #$36
        sta SCREEN_BUFFER_1 + $01
        lda #$00
        sta L_09f0
    L_0837:
        rts 


    L_0838:
        lda $09ee
        beq L_0837
        lda SCREEN_BUFFER_1 + $7f
        bne L_0837
        inc SCREEN_BUFFER_1 + $7f
        lda #$aa
        ldx #$08
        ldy #$0a
    L_0849:
        sta $086c
        stx $086d
        sty SCREEN_BUFFER_1 + $7c
        jsr L_0816
        lda #$05
        sta $09e4
        ldy #$00
        sty $09e5
        beq L_0885
    L_0860:
        lda L_09e3,x
        jsr L_ffa8
        dex 
        bpl L_0860
        ldx #$20
    L_086b:
        lda $09aa,y
        jsr L_ffa8
        iny 
        bne L_0877
        inc $086d
    L_0877:
        inc $09e5
        bne L_087f
        inc $09e4
    L_087f:
        dex 
        bne L_086b
        jsr L_ffae
    L_0885:
        lda SCREEN_BUFFER_1 + $ba
        jsr L_ffb1
        lda SCREEN_BUFFER_1 + $90
        cmp #$c0
        beq L_08a7
        lda #$6f
        jsr L_ff93
        ldx #$05
        dec SCREEN_BUFFER_1 + $7c
        bpl L_0860
    L_089b:
        lda $09e8,x
        jsr L_ffa8
        dex 
        bne L_089b
        jsr L_ffae
    L_08a7:
        jmp L_082e
        cli 
    L_08ab:
        lda #$00
        sta $1800
        ldx #$00
    L_08b2:
        ldy #$08
    L_08b4:
        lda $1800
        bpl L_08bc
        jmp L_0597 + $2
    L_08bc:
        and #$05
        beq L_08b4
        lsr 
        lda #$02
        bcc L_08c7
        lda #$08
    L_08c7:
        ror SCREEN_BUFFER_0 + $239,x
        sta $1800
    L_08cd:
        lda $1800
        and #$05
        cmp #$05
        beq L_08cd
        lda #$00
        sta $1800
        dey 
        bne L_08b4
        sei 
        inx 
        lda SCREEN_BUFFER_0 + $238,x
        bne L_08b2
        lda #$08
        sta $1800
        ldx SCREEN_BUFFER_0 + $236
        ldy SCREEN_BUFFER_0 + $237
    L_08f0:
        jsr L_05bc + $3d
        bcs L_0936
        ldy #$02
    L_08f7:
        lda SCREEN_BUFFER_0 + $00,y
        and #$83
        cmp #$82
        bne L_0925
        ldx #$03
        sty SCREEN_BUFFER_0 + $168
        lda #$a0
        sta SCREEN_BUFFER_0 + $13,y
    L_090a:
        lda SCREEN_BUFFER_0 + $236,x
        cmp #$2a
        beq L_094b
        lda SCREEN_BUFFER_0 + $00,x
        cmp SCREEN_BUFFER_0 + $236,x
        bne L_091c
        inx 
        bne L_090a
    L_091c:
        cmp #$a0
        bne L_0925
        lda SCREEN_BUFFER_0 + $236,x
        beq L_094b
    L_0925:
        tya 
        clc 
        adc #$20
        tay 
        bcc L_08f7
        ldy SCREEN_BUFFER_0 + $01
        ldx SCREEN_BUFFER_0 + $00
        bne L_08f0
        ldx #$02
    L_0936:
        stx SCREEN_BUFFER_0 + $02
        lda #$00
        sta SCREEN_BUFFER_0 + $00
        sta SCREEN_BUFFER_0 + $01
        beq L_095a
        ldx #$00
        bne L_094a
        jmp vSprite2Y
    L_094a:
        rts 


    L_094b:
        iny 
    L_094c:
        ldx SCREEN_BUFFER_0 + $00,y
        beq L_0936
        lda SCREEN_BUFFER_0 + $01,y
        tay 
        jsr L_05bc + $3d
        bcs L_0936
    L_095a:
        lda #$04
        ldx #$00
        stx $1800
    L_0961:
        ldx SCREEN_BUFFER_0 + $00
        stx SCREEN_BUFFER_1 + $06
        tay 
    L_0967:
        ldx #$00
        lsr SCREEN_BUFFER_1 + $06
        bcs L_096f
        ldx #$02
    L_096f:
        bit $1800
        bne L_096f
        stx $1800
        ldx #$00
        lsr SCREEN_BUFFER_1 + $06
        bcs L_097f
        ldx #$02
    L_097f:
        bit $1800
        beq L_097f
        stx $1800
        dey 
        bne L_0967
        inc SCREEN_BUFFER_0 + $1b8
        bne L_0961
    L_098f:
        bit $1800
        bne L_098f
        asl 
        sta $1800
        lda SCREEN_BUFFER_0 + $00
        ora SCREEN_BUFFER_0 + $01
        bne L_094c
        jmp L_0500
        jsr L_0615
        stx.a SCREEN_BUFFER_1 + $08
    L_09a9:
        sty.a SCREEN_BUFFER_1 + $09
        ldy #$05
    L_09ae:
        lda #$80
        ldx #$01
        jsr $061e
        cmp #$02
        bcc L_09be
        dey 
        bne L_09ae
        
        ldx #$01
    L_09be:
        sei 
    L_09bf:
        lda #$08
        eor L_1bf5 + $b
        sta L_1bf5 + $b
        rts 


        sta SCREEN_BUFFER_1 + $01
        cli 
    L_09cb:
        lda SCREEN_BUFFER_1 + $01
        bmi L_09cb
        pha 
        lda SCREEN_BUFFER_1 + $16
        sta SCREEN_BUFFER_1 + $12
        lda SCREEN_BUFFER_1 + $17
        sta SCREEN_BUFFER_1 + $13
        pla 
        rts 


        jsr $ff54
        lda SCREEN_BUFFER_1 + $03
        rts 



        .byte $12,$01,$03

    L_09e3:
        jsr $4006

        .byte $57,$2d,$4d,$05,$00,$45,$2d,$4d,$01,$01

    L_09f0:
        .byte $00

    L_09f1:
        sta L_d06f + $10
        lda #$00
        sta SCREEN_BUFFER_1 + $9d
        sta SCREEN_BUFFER_1 + $7f
        sta SCREEN_BUFFER_1 + $7e
        lda #$aa
        sta SCREEN_BUFFER_1 + $a5
        lda #$dd
        ldx #$0a
        ldy #$02
        jsr L_0849
        lda SCREEN_BUFFER_1 + $90
        cmp #$c0
        beq L_0a53
        ldx #$00
        ldy #$00
    L_0a13:
        inx 
        bne L_0a13
        iny 
        bpl L_0a13
        lda SCREEN_BUFFER_1 + $ba
        jsr L_ffb1
        lda #$6f
        jsr L_ff93
        ldx #$05
    L_0a25:
        lda L_0b1a,x
        jsr L_ffa8
        dex 
        bpl L_0a25
        jsr L_ffae
        lda SCREEN_BUFFER_1 + $ba
        jsr L_ffb4
        lda #$6f
        jsr L_ff96
        lda #$00
        jsr L_ffa5
        pha 
        jsr L_ffa5
        tax 
        jsr L_ffab
        pla 
        cmp #$aa
        beq L_0a57
        lda SCREEN_BUFFER_1 + $a5
        cmp #$aa
        bne L_0a56
    L_0a53:
        dec $09ef
    L_0a56:
        rts 


    L_0a57:
        inc $09ee
        stx $0a7f
        stx $0944
        lda L_0b25 + $8,x
        sta $0a72
        lda L_0b31,x
        sta $0a77
        ldy #$0c
    L_0a6e:
        ldx $0b20,y
        lda #$00
        sta L_08ab,x
        lda #$18
        sta $08ac,x
        dey 
        bpl L_0a6e
        ldx #$00
        lda L_0b35,x
        sta $08eb
        lda L_0b39,x
        sta $08ec
        lda L_0b3b + $2,x
        sta $08ee
        lda L_0b41,x
        sta $08ef
        lda L_0b45,x
        sta $09b3
        lda $0b49,x
        sta $09b4
        lda L_0b4d,x
        sta $09a7
        clc 
        adc #$01
        sta $09aa
        lda L_0b51,x
        sta $09a8
        adc #$00
        sta $09ab
        lda L_0b55,x
        sta $0965
        sta $096a
        sta $097a
        lda $0b59,x
        sta L_09bf
        lda L_0b5d,x
        sta $09c0
        lda L_0b60 + $1,x
        sta $09c3
        sta $09c6
        rts 


        asl SCREEN_BUFFER_0 + $13b
        lda L_fea0
        ldx #$03
    L_0ae5:
        cmp SCREEN_BUFFER_0 + $12e,x
        beq L_0aef
        dex 
        bne L_0ae5
        beq L_0b08
    L_0aef:
        lda SCREEN_BUFFER_0 + $131,x
        sta SCREEN_BUFFER_0 + $11f
        lda SCREEN_BUFFER_0 + $134,x
        sta SCREEN_BUFFER_0 + $120
        lda L_fea4
        ldx #$03
    L_0b00:
        cmp SCREEN_BUFFER_0 + $137,x
        beq L_0b08
        dex 
        bne L_0b00
    L_0b08:
        stx SCREEN_BUFFER_0 + $13c
        rts 



        .byte $43,$0d,$ff,$a4,$c6,$e9,$fe,$e5,$a6,$38,$46,$48,$55,$00

    L_0b1a:
        .byte $02
        .byte $05,$3b,$52,$2d,$4d,$03,$0a,$20,$23,$2e

    L_0b25:
        .byte $3d,$b4,$c5,$ca,$d5,$da,$e5,$eb,$00
        .byte $01,$01,$00

    L_0b31:
        clc 
        rti 
        rti 

        .byte $80

    L_0b35:
        rol SCREEN_BUFFER_1 + $2b,x

        .byte $54,$a7

    L_0b39:
        asl SCREEN_BUFFER_1 + $02

    L_0b3b:
         .byte $00,$2b,$37
        .byte $38,$56,$a9

    L_0b41:
        asl SCREEN_BUFFER_1 + $06

        .byte $00,$2b

    L_0b45:
        asl L_3040 + $14,x
        lsr $ff06
        asl SCREEN_BUFFER_1 + $ff
    L_0b4d:
        php 
        ora SCREEN_BUFFER_1 + $20d

    L_0b51:
         .byte $00,$00,$00
        .byte $28

    L_0b55:
        asl SCREEN_BUFFER_1 + $0b

        .byte $0b,$06,$a9,$a9,$a9,$60

    L_0b5d:
        php 
        rti 
        rti 

    L_0b60:
         .byte $00,$1c
        .byte $40,$40,$40
        .fill $9b, $0
        .byte $20,$f1,$09,$a5,$01,$29,$fe,$85,$01,$a9,$00,$8d,$20,$d0,$8d,$21
        .byte $d0,$20,$68,$0d,$20,$23,$0e

    L_0c17:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $bd,$00,$dc,$29,$04,$d0,$01,$60

    L_0c2a:
        lda cCia1PortA,x
        and #$08
        rts 


        lda cCia1PortA,x
        and #$01
        bne L_0c38
        rts 


    L_0c38:
        lda cCia1PortA,x
        and #$02
        rts 


        lda #$00
        sta L_0c17,x
        sta L_0c17 + $2,x
        sta L_0c17 + $4,x
        sta L_0c17 + $6,x
        sta L_0c17 + $8,x
        rts 



    L_0c50:
         .byte $01,$00,$00,$00,$00,$02,$00,$00,$00,$00,$04,$00,$00,$00,$00
        .byte $08,$00,$00,$00,$00

    L_0c64:
        asl SCREEN_BUFFER_1 + $01

        .byte $00,$00,$00,$02,$03,$00,$00,$00,$04,$06,$00,$00,$00,$08,$02,$01
        .byte $00,$00,$06,$05,$02,$00,$00,$02,$01,$05,$00,$00,$04,$02,$00,$01
        .byte $00,$08,$04,$00,$02,$00,$06,$09,$00,$04,$00,$02,$09,$01,$08,$00
        .byte $04,$08,$03,$06,$01,$08,$06,$07,$02,$03

    L_0ca0:
        ora (SCREEN_BUFFER_1 + $02,x)

        .byte $04,$08,$10,$20,$40,$80

    L_0ca8:
        inc L_fbfd,x

    L_0cab:
         .byte $f7,$ef,$df,$bf,$7f,$00,$00,$00,$00,$00,$00
        .byte $a2,$04,$a9,$00

    L_0cba:
        sta L_0cab + $5,x
        dex 
        bpl L_0cba
        lda #$0f
        sta L_0cab + $a
        ldx #$00
    L_0cc7:
        lsr SCREEN_BUFFER_1 + $03
        ror SCREEN_BUFFER_1 + $02
        bcc L_0cee
        ldy #$00
        clc 
    L_0cd0:
        lda L_0cab + $5,y
        adc L_0c50,x
        cmp #$0a
        bcc L_0cdc
        sbc #$0a
    L_0cdc:
        sta L_0cab + $5,y
        inx 
        iny 
        php 
        cpy #$05
        beq L_0cea
        plp 
        jmp L_0cd0
    L_0cea:
        plp 
        jmp L_0cf3
    L_0cee:
        txa 
        clc 
        adc #$05
        tax 
    L_0cf3:
        dec L_0cab + $a
        bpl L_0cc7
        ldx #$04
    L_0cfa:
        lda L_0cab + $5,x
        bne L_0d02
        dex 
        bpl L_0cfa
    L_0d02:
        inx 
    L_0d03:
        bne L_0d06
        inx 
    L_0d06:
        rts 



    L_0d07:
         .byte $00,$00

    L_0d09:
        lda #$00
        sta L_0d07 + $1
        sta L_0d07
    L_0d11:
        ldx L_0d07 + $1
        inx 
        cpx SCREEN_BUFFER_1 + $04
        bcc L_0d21
        lda L_0d07
        beq L_0d4e
        jmp L_0d09
    L_0d21:
        ldy L_0d07 + $1
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $05
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $06
        jsr L_ffcc
        bcc L_0d48
        ldy L_0d07 + $1
        lda (SCREEN_BUFFER_1 + $02),y
        tax 
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        pha 
        txa 
        sta (SCREEN_BUFFER_1 + $02),y
        dey 
        pla 
        sta (SCREEN_BUFFER_1 + $02),y
        lda #$01
        sta L_0d07
    L_0d48:
        inc L_0d07 + $1
        jmp L_0d11
    L_0d4e:
        rts 


        pha 
        lsr 
        pla 
        ror 
        pha 
        lsr 
        pla 
        ror 
        rts 


        ldy #$00
        dex 
    L_0d5b:
        lda L_0cab + $5,x
        clc 
        adc #$30
        sta (SCREEN_BUFFER_1 + $02),y
        iny 
        dex 
        bpl L_0d5b
        rts 


    L_0d68:
        lda cCia2DDRA
        ora #$03
        sta cCia2DDRA
        lda cCia2PortA
        and #$fc
        ora #$00
        sta cCia2PortA
        lda #$00
        ora #$08
        sta vMemControl
        jsr L_0d85
        rts 


    L_0d85:
        lda #$00
        sta SCREEN_BUFFER_1 + $1a
        lda #$e0
        sta SCREEN_BUFFER_1 + $1b
        lda #$00
        ldx #$1f
        ldy #$00
    L_0d93:
        sta (SCREEN_BUFFER_1 + $1a),y
        iny 
        bne L_0d93
        inc SCREEN_BUFFER_1 + $1b
        dex 
        beq L_0d9f
        bne L_0d93
    L_0d9f:
        ldy #$3f
    L_0da1:
        sta (SCREEN_BUFFER_1 + $1a),y
    L_0da3:
        dey 
        bpl L_0da1
        rts 


        ldx #$00
    L_0da9:
        lda #$75
        sta L_c280,x
        sta $c320,x
        lda #$0e
        sta vColorRam + $280,x
        sta vColorRam + $320,x
        inx 
        cpx #$a0
        bne L_0da9
        ldx #$00
    L_0dc0:
        lda #$c5
        sta $c0a0,x
        sta $c190,x
        lda #$0c
        sta vColorRam + $a0,x
        sta vColorRam + $190,x
        inx 
        cpx #$f0
        bne L_0dc0
        rts 


        lda #$00
        sta SCREEN_BUFFER_1 + $02
        lda #$fe
        sta SCREEN_BUFFER_1 + $03
        ldy #$00
        lda #$ff
    L_0de2:
        sta (SCREEN_BUFFER_1 + $02),y
        iny 
        bne L_0de2
        inc SCREEN_BUFFER_1 + $03
        ldy #$00
    L_0deb:
        sta (SCREEN_BUFFER_1 + $02),y
        iny 
        cpy #$40
        bne L_0deb
        ldx #$27
    L_0df4:
        lda #$0f
        sta L_c3c0,x
        lda #$00
        sta vColorRam + $3c0,x
        dex 
        bpl L_0df4
        rts 



        .byte $00,$50,$52,$45,$4c,$55,$44,$45,$2e,$50,$52

    L_0e0d:
        .byte $47,$00
        .byte $50,$4c,$41,$59,$2e,$50,$52,$47,$00,$53,$50,$4c,$41,$53,$48,$2e
        .byte $50,$52,$47,$00

    L_0e23:
        jsr L_0e34
        jsr L_0e3f
        ldx #$0f
        ldy #$0e
        jsr L_0600
        jmp (L_2000)
        rts 


    L_0e34:
        ldx #$18
        ldy #$0e
        jsr L_0600
        jmp (L_2000)
        rts 


    L_0e3f:
        ldx #$03
        ldy #$0e
        jsr L_0600
        jmp (L_2000)
        rts 



    L_0e4a:
         .fill $b6, $ea

    L_0f00:
        .fill $183, $0
        .byte $bd,$00,$0f,$38,$fd,$10,$10,$9d,$00,$0f,$bd,$10,$0f,$e9,$00,$9d
        .byte $10,$0f,$b0,$08,$a9,$00,$9d,$00,$0f,$9d,$10,$0f

    L_109f:
        rts 


        lda L_0f00,x
        clc 
        adc L_0f00 + $110,x
        sta L_0f00,x
        lda L_0f00 + $10,x
        adc #$00
        sta L_0f00 + $10,x
        rts 


        lda L_0f00 + $20,x
        sec 
        sbc L_0f00 + $120,x
        bcc L_10bf
        jmp L_10c1
    L_10bf:
        lda #$00
    L_10c1:
        sta L_0f00 + $20,x
        rts 


        lda L_0f00 + $20,x
        clc 
        adc L_0f00 + $120,x
        bcs L_10d1
        jmp L_10d3
    L_10d1:
        lda #$ff
    L_10d3:
        sta L_0f00 + $20,x
        rts 


        lda L_0f00 + $70,x
        clc 
        adc L_0f00 + $30,x
        sta L_0f00 + $70,x
        lda L_0f00 + $40,x
        bcc L_10e9
        clc 
        adc #$01
    L_10e9:
        sta L_0f00 + $110,x
        rts 


        lda L_0f00 + $80,x
        clc 
        adc L_0f00 + $50,x
        sta L_0f00 + $80,x
        lda L_0f00 + $60,x
        bcc L_10ff
        clc 
        adc #$01
    L_10ff:
        sta L_0f00 + $120,x
        rts 


        rts 


        rts 


        lda L_0f00 + $10,x
        bne L_1118
        lda L_0f00,x
        cmp L_0f00 + $181
        bcs L_1118
        lda L_0f00 + $181
        sta L_0f00,x
    L_1118:
        rts 


        clc 
        inc L_0f00 + $181
        lda L_0f00,x
        cmp L_0f00 + $181
        bcc L_112e
        dec L_0f00 + $181
        lda L_0f00 + $181
        sta L_0f00,x
    L_112e:
        rts 


        lda #$00
        sta L_0f00 + $182
        dec L_0f00 + $e0,x
        bne L_115a
        lda L_0f00 + $f0,x
        sta L_0f00 + $e0,x
        lda L_0f00 + $100,x
        cmp L_0f00 + $c0,x
        bne L_1149
        sec 
        rts 


    L_1149:
        inc L_0f00 + $182
        lda L_0f00 + $d0,x
        beq L_1157
        inc L_0f00 + $100,x
        jmp L_115a
    L_1157:
        dec L_0f00 + $100,x
    L_115a:
        clc 
        rts 


        dec L_0f00 + $e0,x
        beq L_1162
        rts 


    L_1162:
        lda L_0f00 + $f0,x
        sta L_0f00 + $e0,x
        lda L_0f00 + $100,x
        cmp L_0f00 + $c0,x
        bne L_1177
        lda L_0f00 + $b0,x
        sta L_0f00 + $100,x
        rts 


    L_1177:
        inc L_0f00 + $100,x
        rts 


        lda L_0f00 + $10,x
        beq L_118a
        lda L_0ca0,x
        ora vSpriteXMSB
        sta vSpriteXMSB
        rts 


    L_118a:
        lda L_0ca0,x
        eor #$ff
        and vSpriteXMSB
        sta vSpriteXMSB
        rts 


        lda #$00
        sta vSpriteXMSB
        ldx #$07
    L_119d:
        sta L_0f00 + $10,x
        dex 
        bpl L_119d
        rts 


        lda L_0f00 + $140,y
        beq L_11b1
        lda L_0ca0,x
        ora vSprExpandY
        bne L_11b7
    L_11b1:
        lda L_0ca8,x
        and vSprExpandY
    L_11b7:
        sta vSprExpandY
        lda L_0f00 + $150,y
        beq L_11c7
        lda L_0ca0,x
        ora vSprExpandX
        bne L_11cd
    L_11c7:
        lda L_0ca8,x
        and vSprExpandX
    L_11cd:
        sta vSprExpandX
        lda L_0f00 + $160,y
        beq L_11dd
        lda L_0ca0,x
        ora vSprPriority
        bne L_11e3
    L_11dd:
        lda L_0ca8,x
        and vSprPriority
    L_11e3:
        sta vSprPriority
        txa 
        asl 
        tax 
        lda L_0f00,y
        sta vSprite0X,x
        lda L_0f00 + $20,y
        sta vSprite0Y,x
        txa 
        lsr 
        tax 
        lda L_0f00 + $10,y
        beq L_1209
        lda L_0ca0,x
        ora vSpriteXMSB
        sta vSpriteXMSB
        jmp L_1214
    L_1209:
        lda L_0ca0,x
        eor #$ff
        and vSpriteXMSB
        sta vSpriteXMSB
    L_1214:
        lda L_0f00 + $130,y
        sta vSpr0Col,x
        lda L_0f00 + $170,y
        beq L_1228
        lda L_0ca8,x
        and vSprMCM
        jmp L_122e
    L_1228:
        lda L_0ca0,x
        ora vSprMCM
    L_122e:
        sta vSprMCM
        lda L_0f00 + $100,y
        sta L_c3e9 + $f,x
        rts 


        ldx #$2f
        lda #$00
    L_123c:
        sta L_0f00 + $140,x
        dex 
        bpl L_123c
        rts 



    L_1243:
         .byte $00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47,$80
        .byte $81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$00
        .byte $01,$02,$03,$04,$05,$06,$07

    L_130b:
        cpx #$e0
        cpx #$e0
        cpx #$e0
        cpx #$e0
        sbc (SCREEN_BUFFER_1 + $e1,x)
        sbc (SCREEN_BUFFER_1 + $e1,x)
        sbc (SCREEN_BUFFER_1 + $e1,x)
        sbc (SCREEN_BUFFER_1 + $e1,x)

        .byte $e2,$e2,$e2,$e2,$e2,$e2,$e2,$e2,$e3,$e3,$e3,$e3,$e3,$e3,$e3,$e3
        .byte $e5,$e5,$e5,$e5,$e5,$e5,$e5,$e5,$e6,$e6,$e6,$e6,$e6,$e6,$e6,$e6
        .byte $e7,$e7,$e7,$e7,$e7,$e7,$e7,$e7,$e8,$e8,$e8,$e8,$e8,$e8,$e8,$e8
        .byte $ea,$ea,$ea,$ea,$ea,$ea,$ea,$ea,$eb,$eb,$eb,$eb,$eb,$eb,$eb,$eb
        .byte $ec,$ec,$ec,$ec,$ec,$ec,$ec,$ec,$ed,$ed,$ed,$ed

    L_1367:
        sbc L_eded
        sbc $efef

        .byte $ef,$ef,$ef,$ef,$ef,$ef,$f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0,$f1,$f1
        .byte $f1,$f1,$f1,$f1,$f1,$f1,$f2,$f2,$f2,$f2,$f2,$f2,$f2,$f2,$f4,$f4
        .byte $f4,$f4,$f4,$f4,$f4,$f4,$f5,$f5,$f5,$f5,$f5,$f5,$f5,$f5,$f6,$f6
        .byte $f6,$f6,$f6,$f6,$f6,$f6,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$f9,$f9
        .byte $f9,$f9,$f9,$f9,$f9,$f9,$fa,$fa,$fa,$fa,$fa,$fa,$fa,$fa,$fb,$fb
        .byte $fb,$fb,$fb,$fb,$fb,$fb,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fc,$fe,$fe
        .byte $fe,$fe,$fe,$fe,$fe,$fe,$00,$00,$00,$00,$08,$08,$08,$08,$10,$10

    L_13dd:
        bpl L_13ef
    L_13df:
        clc 
        clc 
        clc 
        clc 

        .byte $20,$20,$20,$20,$28,$28,$28,$28,$30,$30

    L_13ed:
        bmi L_141f
    L_13ef:
        sec 
        sec 
        sec 
        sec 
        rti 
        rti 
        rti 
        rti 
        pha 
        pha 
        pha 
        pha 
        bvc L_144d
        bvc L_144f
        cli 
        cli 
        cli 
        cli 
        rts 


        rts 


        rts 


        rts 



        .byte $68,$68,$68,$68,$70,$70,$70,$70

    L_140f:
        sei 
        sei 
        sei 
        sei 

        .byte $80,$80,$80,$80,$88,$88,$88,$88

    L_141b:
        .byte $90,$90,$90,$90

    L_141f:
        tya 
        tya 
        tya 
        tya 
        ldy #$a0
        ldy #$a0
        tay 
        tay 
        tay 
        tay 
        bcs L_13dd
        bcs L_13df
        clv 
        clv 
        clv 
        clv 
        cpy #$c0
        cpy #$c0
        iny 
        iny 
        iny 
        iny 

        .byte $d0,$d0

    L_143d:
        bne L_140f
    L_143f:
        cld 
        cld 
        cld 
        cld 
        cpx #$e0
        cpx #$e0
        inx 
        inx 
        inx 
        inx 
        beq L_143d
    L_144d:
        beq L_143f
    L_144f:
        sed 
        sed 
        sed 
        sed 

        .byte $00,$00,$00,$00,$08,$08,$08,$08,$10,$10,$10,$10,$18,$18,$18,$18
        .byte $20,$20,$20,$20,$28,$28

    L_1469:
        .byte $28,$28,$30,$30,$30,$30

    L_146f:
        sec 
        sec 
        sec 
        sec 

    L_1473:
         .fill $80, $0
        .fill $20, $1

    L_1513:
        .byte $3f,$cf,$f3,$fc,$00
        .byte $40,$80,$c0,$00,$10,$20,$30,$00,$04,$08,$0c,$00,$01,$02,$03,$00
        .byte $55,$aa

    L_152a:
        .byte $ff,$00
        .byte $28,$50,$78,$a0,$c8,$f0,$18,$40,$68,$90,$b8

    L_1537:
        cpx #$08
        bmi L_1593

        .byte $80,$a8,$d0,$f8,$20,$48,$70

    L_1542:
        .byte $98,$c0,$d8,$d8,$d8,$d8,$d8,$d8,$d8,$d9,$d9,$d9,$d9,$d9,$d9,$da

    L_1552:
        .byte $da,$da,$da,$da,$da,$da,$db,$db,$db,$db,$db,$00
        .byte $28

    L_155f:
        bvc L_15d9
        ldy #$c8
        beq L_1574 + $9
        rti 

    L_1566:
         .byte $68,$90,$b8,$e0,$08,$30,$58,$80
        .byte $a8,$d0,$f8,$20,$48,$70

    L_1574:
        .byte $98,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c1,$c1,$c1,$c1,$c1,$c1,$c2

    L_1584:
        .byte $c2,$c2,$c2,$c2,$c2,$c2,$c3,$c3,$c3,$c3,$c3,$00
        .byte $08,$10,$18

    L_1593:
        jsr L_3028
        sec 
        rti 
        pha 
        bvc L_15f3
        rts 



        .byte $68,$70,$78,$80,$88,$90,$98

    L_15a3:
        ldy #$a8
        bcs L_155f
    L_15a7:
        cpy #$c8

        .byte $d0,$d8

    L_15ab:
        cpx #$e8
        beq L_15a7

        .byte $00,$08,$10,$18,$20,$28,$30,$38,$40,$48,$50,$58,$60,$68,$70,$78
        .byte $80,$88,$90,$98,$a0,$a8,$b0,$b8

    L_15c7:
        cpy #$c8
        bne L_15a3
    L_15cb:
        cpx #$e8
        beq L_15c7
    L_15cf:
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
    L_15d9:
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
    L_15f3:
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)
        cmp (SCREEN_BUFFER_1 + $c1,x)

    L_160f:
         .byte $00,$00,$00

    L_1612:
        sta L_160f + $2
        lda L_1243,y
        clc 
        adc $13d3,x
        sta SCREEN_BUFFER_1 + $1a
        lda L_130b,y
        adc L_1473,x
        sta SCREEN_BUFFER_1 + $1b
        txa 
        and #$03
        tax 
        lda L_1513,x
        sta L_160f + $1
        txa 
        asl 
        asl 
        clc 
        adc L_160f + $2
        tax 
        lda L_1513 + $4,x
        sta L_160f + $2
        lda SCREEN_BUFFER_1 + $01
        and #$fd
        sta SCREEN_BUFFER_1 + $01
        ldy #$00
        lda (SCREEN_BUFFER_1 + $1a),y
        and L_160f + $1
        ora L_160f + $2
        sta (SCREEN_BUFFER_1 + $1a),y
        lda SCREEN_BUFFER_1 + $01
        ora #$02
        sta SCREEN_BUFFER_1 + $01
        rts 


        pha 
        lda L_1243,y
        clc 
        adc $13d3,x
        sta SCREEN_BUFFER_1 + $1a
        lda L_130b,y
        adc L_1473,x
        sta SCREEN_BUFFER_1 + $1b
        ldy #$00
        pla 
        sta (SCREEN_BUFFER_1 + $1a),y
        rts 



    L_166f:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $8d,$7a,$16,$8c,$0f,$16,$a9,$00,$8d,$77,$16,$a9,$01,$8d,$78,$16
        .byte $8d,$79,$16,$a9,$f0,$8d,$79,$17,$8d,$90,$17,$a9,$90,$8d,$7b,$17
        .byte $8d,$92,$17,$a5,$2e,$38,$e5,$2c,$8d,$6f,$16,$b0,$22,$ad,$6f,$16
        .byte $49,$ff,$18,$69,$01,$8d,$6f,$16,$ad,$77,$16,$09,$20,$8d,$77,$16
        .byte $a9,$ff,$8d,$79,$16,$a9,$b0,$8d,$90,$17,$a9,$24,$8d,$92,$17

    L_16ca:
        lda SCREEN_BUFFER_1 + $2f
        sec 
        sbc SCREEN_BUFFER_1 + $2d
        sta L_166f + $1
        bcs L_16f6
        lda L_166f + $1
        eor #$ff
        clc 
        adc #$01
        sta L_166f + $1
        lda L_166f + $8
        ora #$40
        sta L_166f + $8
        lda #$ff
        sta L_166f + $9
        lda #$b0
        sta L_1779
        lda #$24
        sta L_177b
    L_16f6:
        lda L_166f
        asl 
        sta L_166f + $4
        lda #$00
        rol 
        sta L_166f + $5
        lda L_166f + $1
        asl 
        sta L_166f + $2
        lda #$00
        rol 
        sta L_166f + $3
        lda L_166f
        cmp L_166f + $1
        bcs L_1739
        ldx L_166f + $2
        ldy L_166f + $3
        lda L_166f + $4
        sta L_166f + $2
        lda L_166f + $5
        sta L_166f + $3
        stx L_166f + $4
        sty L_166f + $5
        lda L_166f + $1
        sta $174f
        jmp L_174a
    L_1739:
        lda L_166f + $8
        ora #$80
        sta L_166f + $8
        lda L_166f
        sta $174f
        jsr L_1802
    L_174a:
        lda L_166f + $2
        sec 
        sbc #$00
        sta L_166f + $6
        lda L_166f + $3
        sbc #$00
        sta L_166f + $7
    L_175b:
        ldx SCREEN_BUFFER_1 + $2c
        ldy SCREEN_BUFFER_1 + $2d
        lda L_166f + $b
        jsr L_1612
        lda L_166f + $8
        bmi L_1780
        jsr L_1802
        lda SCREEN_BUFFER_1 + $2d
        clc 
        adc L_166f + $9
        sta SCREEN_BUFFER_1 + $2d
        lda SCREEN_BUFFER_1 + $2d
        cmp SCREEN_BUFFER_1 + $2f
    L_1779:
        beq L_1797
    L_177b:
        bcc L_1797
        jmp L_17fe
    L_1780:
        lda SCREEN_BUFFER_1 + $2c
        clc 
        adc L_166f + $a
        sta SCREEN_BUFFER_1 + $2c
        cmp #$ff
        beq L_17fe
        lda SCREEN_BUFFER_1 + $2c
        cmp SCREEN_BUFFER_1 + $2e
    L_1790:
        beq L_1797
    L_1792:
        bcc L_1797
        jmp L_17fe
    L_1797:
        lda L_166f + $6
        clc 
        adc L_166f + $2
        sta L_166f + $6
        lda L_166f + $7
        adc L_166f + $3
        sta L_166f + $7
        bpl L_17af
        jmp L_175b
    L_17af:
        lda L_166f + $8
        bmi L_17ce
        lda SCREEN_BUFFER_1 + $2c
        clc 
        adc L_166f + $a
        sta SCREEN_BUFFER_1 + $2c
        cmp #$ff
        bne L_17c5
        inc SCREEN_BUFFER_1 + $2c
        jmp L_17e8
    L_17c5:
        cmp #$a0
        bne L_17cb
        dec SCREEN_BUFFER_1 + $2c
    L_17cb:
        jmp L_17e8
    L_17ce:
        jsr L_1802
        lda SCREEN_BUFFER_1 + $2d
        clc 
        adc L_166f + $9
        sta SCREEN_BUFFER_1 + $2d
        cmp #$ff
        bne L_17e2
        inc SCREEN_BUFFER_1 + $2d
        jmp L_17e8
    L_17e2:
        cmp #$c8
        bne L_17e8
        dec SCREEN_BUFFER_1 + $2d
    L_17e8:
        lda L_166f + $6
        sec 
        sbc L_166f + $4
        sta L_166f + $6
        lda L_166f + $7
        sbc L_166f + $5
        sta L_166f + $7
        jmp L_175b
    L_17fe:
        ldy L_160f
        rts 


    L_1802:
        ldy L_160f
        lda SCREEN_BUFFER_1 + $2c
        sta (SCREEN_BUFFER_1 + $30),y
        inc L_160f
        rts 


        ldx SCREEN_BUFFER_1 + $0a
        lda L_152a + $1,x
        clc 
        adc SCREEN_BUFFER_1 + $0b
        sta SCREEN_BUFFER_1 + $02
        lda L_1542 + $2,x
        adc #$00
        sta SCREEN_BUFFER_1 + $03
        ldy #$00
        lda SCREEN_BUFFER_1 + $0c
        sta (SCREEN_BUFFER_1 + $02),y
        rts 


        ldx SCREEN_BUFFER_1 + $0a
        lda L_1552 + $b,x
        clc 
        adc SCREEN_BUFFER_1 + $0b
        sta SCREEN_BUFFER_1 + $02
        lda L_1574 + $2,x
        adc #$00
        sta SCREEN_BUFFER_1 + $03
        ldy #$00
        lda SCREEN_BUFFER_1 + $0c
        sta (SCREEN_BUFFER_1 + $02),y
        rts 


        lda #$00
        sta SCREEN_BUFFER_1 + $09
        lda #$c0
        bit SCREEN_BUFFER_1 + $08
        bne L_184b
        ora SCREEN_BUFFER_1 + $09
        sta SCREEN_BUFFER_1 + $09
    L_184b:
        lda #$30
        bit SCREEN_BUFFER_1 + $08
        bne L_1855
        ora SCREEN_BUFFER_1 + $09
        sta SCREEN_BUFFER_1 + $09
    L_1855:
        lda #$0c
        bit SCREEN_BUFFER_1 + $08
        bne L_185f
        ora SCREEN_BUFFER_1 + $09
        sta SCREEN_BUFFER_1 + $09
    L_185f:
        lda #$03
        bit SCREEN_BUFFER_1 + $08
        bne L_1869
        ora SCREEN_BUFFER_1 + $09
        sta SCREEN_BUFFER_1 + $09
    L_1869:
        rts 


        lda #$ff
        adc #$00
        sta SCREEN_BUFFER_1 + $0f
        ldx SCREEN_BUFFER_1 + $04
        ldy SCREEN_BUFFER_1 + $05
        lda L_1243,x
        clc 
        adc $13d3,y
        sta SCREEN_BUFFER_1 + $06
        lda L_130b,x
        adc L_1473,y
        sta SCREEN_BUFFER_1 + $07
        lda SCREEN_BUFFER_1 + $04
        lsr 
        lsr 
        lsr 
        tax 
        lda SCREEN_BUFFER_1 + $05
        lsr 
        lsr 
        clc 
        adc L_1552 + $b,x
        sta SCREEN_BUFFER_1 + $0d
        lda L_1574 + $2,x
        adc #$00
        sta SCREEN_BUFFER_1 + $0e
        ldy #$00
        sty SCREEN_BUFFER_1 + $0a
    L_18a0:
        lda (SCREEN_BUFFER_1 + $02),y
        tax 
        lda L_1584 + $b,x
        sta SCREEN_BUFFER_1 + $0b
        lda L_15cf,x
        sta SCREEN_BUFFER_1 + $0c
        ldy #$07
    L_18af:
        lda (SCREEN_BUFFER_1 + $0b),y
        eor SCREEN_BUFFER_1 + $0f
        sta (SCREEN_BUFFER_1 + $06),y
        dey 
        bpl L_18af
        ldy SCREEN_BUFFER_1 + $0a
        iny 
        cpy SCREEN_BUFFER_1 + $08
        beq L_18d1
        sty SCREEN_BUFFER_1 + $0a
        lda SCREEN_BUFFER_1 + $06
        clc 
        adc #$08
        sta SCREEN_BUFFER_1 + $06
        lda SCREEN_BUFFER_1 + $07
        adc #$00
        sta SCREEN_BUFFER_1 + $07
        jmp L_18a0
    L_18d1:
        rts 



        .byte $0a,$09,$02,$00,$06,$04,$02,$0f,$01,$00,$00,$0a,$14,$1e,$28,$ef
        .byte $f9,$03,$0d,$18,$18,$19,$19,$30,$45,$19,$19,$45,$3d
        .fill $28, $20
        .byte $00,$00

    L_1919:
        .byte $00,$00,$00,$00
        .byte $01,$02,$03

    L_1920:
        .fill $40, $0
        .byte $01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ef,$ef,$ef,$ef,$ef,$ff,$ef,$ff,$bf,$bf,$bf,$ba
        .byte $fe,$fb,$fa
        .fill $19, $ff
        .byte $ef,$eb,$af,$bf,$af,$eb,$ef,$ff,$ef,$ef,$ef,$ff,$ff,$ff,$ff,$fa
        .byte $ef,$bf,$bf,$bf,$bf,$bf,$eb,$eb,$fe,$fe,$fe,$fe,$fe,$fb,$af,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ef,$ef,$ab,$ef,$ef,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ef,$bf,$ff,$ff,$ff,$ff,$ff,$ab,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ef,$ef,$ff,$fb,$fb,$ef,$ef,$ef,$bf,$bf,$ff
        .byte $ef,$bb,$bb,$bb,$bb,$bb,$ef,$ff,$ef,$af,$ef,$ef,$ef,$ef,$ab,$ff
        .byte $ef,$bb,$fb,$ef,$bf,$bf,$ab,$ff,$ef,$bb,$fb,$ef,$fb,$bb,$ef,$ff
        .byte $ff,$bf,$bf,$bb,$ab,$fb,$fb,$ff,$ab,$bf,$af,$fb,$fb,$bb

    L_1a1a:
        .byte $ef,$ff,$eb,$bf,$af,$bb,$bb,$bb,$ef,$ff,$ab,$bb,$fb,$ef,$ab,$ef
        .byte $ef,$ff,$ef,$bb,$bb,$ef,$bb,$bb,$ef,$ff,$eb,$bb,$bb,$ab,$fb,$fb
        .byte $fb,$ff,$ff,$ef,$ef,$ff,$ef,$ef,$ff,$ff,$ff,$ef,$ef,$ff,$ef,$bf
        .byte $ff,$ff,$fb,$ef,$bf,$bf,$ef,$fb,$ff,$ff,$ff,$ff,$ab,$ff,$ab,$ff
        .byte $ff,$ff,$bf,$ef,$fb,$fb,$ef,$bf,$ff,$ff,$ef,$bb,$fb,$ef,$ef,$ff
        .byte $ef,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$eb,$bb,$bb,$ab,$bb,$bb
        .byte $bb,$ff,$eb,$bb,$bb,$af,$bb,$bb,$af,$ff,$eb,$bb,$bf,$bf,$bf,$bb
        .byte $af,$ff,$ef,$bb,$bb,$bb,$bb,$bb,$af,$ff,$eb,$bb,$bf,$af,$bf,$bb
        .byte $ab,$ff,$eb,$bb,$bf,$af,$bf,$bf,$bf,$ff,$eb,$bb,$bf,$bb,$bb,$bb
        .byte $af,$ff,$fb,$bb,$bb,$ab,$bb,$bb,$bb,$ff,$eb,$ab,$ef,$ef,$ef,$ab
        .byte $ab,$ff,$eb,$fb,$fb,$fb,$fb,$bb,$af,$ff,$fb,$bb,$af,$af,$bb,$bb
        .byte $bb,$ff,$bf,$bf,$bf,$bf,$bf,$bb,$ab,$ff,$eb,$ab,$ab,$ab,$bb,$bb
        .byte $bb,$ff,$eb,$bb,$bb,$bb,$bb,$bb,$bb,$ff,$ef,$bb,$bb,$bb,$bb,$bb
        .byte $ef,$ff,$eb,$bb,$bb,$af,$bf,$bf,$bf,$ff,$ef,$bb,$bb,$bb,$bb,$ef
        .byte $eb,$ff,$eb,$bb,$bb,$ab,$af,$bb,$bb,$ff,$eb,$bb,$bf,$ab,$fb,$bb
        .byte $af,$ff,$eb,$ab,$ef,$ef,$ef,$ef,$ef,$ff,$fb,$bb,$bb,$bb,$bb,$bb
        .byte $af,$ff,$fb,$bb,$bb,$bb,$bb,$ef,$ef,$ff,$fb,$bb,$bb,$ab,$ab,$ab
        .byte $af,$ff,$fb,$bb,$ef,$ef,$bb,$bb,$bb,$ff,$fb,$bb,$bb,$ef,$ef,$ef
        .byte $ef,$ff,$ab,$fb,$fb,$ef,$bf,$bb,$af
        .fill $32, $ff
        .byte $eb,$bb,$fb,$ab,$bb,$af,$ff,$bf,$bf,$ab,$bb,$bb,$bb,$af,$ff,$ff
        .byte $eb,$bb,$bf,$bf,$bb,$af,$ff,$fb,$fb,$eb,$bb,$bb,$bb,$af,$ff,$ff

    L_1b95:
        .byte $eb,$bb,$ab,$bf,$bb,$af,$ff,$fb,$ef,$eb,$ef,$ef,$ef,$ef,$ff,$ff
        .byte $eb,$bb,$ab,$fb,$bb,$af,$ff,$bf,$bf,$af,$bb,$bb,$bb,$bb,$ff,$ef
        .byte $ff,$ef,$ef,$ef,$ef,$ef,$ff,$ff,$fb,$ff,$fb,$fb,$bb,$af,$ff,$bf
        .byte $bf,$bb,$af,$bb,$bb,$bb,$ff,$bf,$bf,$bf,$bf,$bf,$bb,$af,$ff,$ff
        .byte $eb,$ab,$ab,$ab,$bb,$bb,$ff,$ff,$eb,$bb,$bb,$bb,$bb,$bb,$ff,$ff
        .byte $eb,$bb,$bb,$bb,$bb,$af,$ff,$ff,$eb,$bb,$bb,$af,$bf,$bf,$ff,$ff

    L_1bf5:
        .byte $eb,$bb,$bb,$ab,$fb,$fb,$ff,$ff,$eb,$bb,$bf,$bf,$bf,$bf,$ff,$ff

    L_1c05:
        .byte $eb,$bf,$ab,$fb,$bb,$af,$ff,$bf,$bf,$af,$bf,$bf,$bb,$af,$ff,$ff

    L_1c15:
        .byte $fb,$bb,$bb,$bb,$bb,$af,$ff,$ff,$fb,$bb,$bb,$bb,$ef,$ef,$ff,$ff
        .byte $fb,$bb,$ab,$ab,$ab,$af,$ff,$ff,$fb,$bb,$ef,$ef,$bb,$bb,$ff,$ff
        .byte $fb,$bb,$ab,$fb,$bb,$af,$ff,$ff,$ab,$fb,$ef,$bf,$bb,$af,$6b,$73
        .byte $7b,$83,$8b,$93,$9b,$a3,$ab,$b3,$bb,$c3,$cb,$d3,$db,$e3,$eb,$f3
        .byte $fb,$03,$0b,$13,$1b,$23,$2b,$33,$3b,$43,$4b,$53,$5b,$63,$6b,$73
        .byte $7b,$83,$8b,$93,$9b,$a3,$ab,$b3,$bb,$c3,$cb,$d3,$db,$e3,$eb,$f3

    L_1c75:
        .byte $fb,$03,$0b,$13,$1b,$23,$2b,$33,$3b,$43,$4b,$53,$5b,$63,$6b,$73
        .byte $7b,$83,$8b,$93,$9b,$a3,$ab,$b3,$bb,$c3,$cb,$d3,$db,$e3,$eb,$f3
        .byte $fb,$03,$0b,$13,$1b,$23,$2b,$33,$3b
        .fill $13, $19
        .fill $20, $1a
        .fill $20, $1b
        .byte $1c,$1c,$1c,$1c,$1c,$1c,$1c,$1c

    L_1cf9:
        lsr 
        lsr 
        ora #$c0
    L_1cfd:
        lda SCREEN_BUFFER_1 + $06
        bne L_1d02
        rts 


    L_1d02:
        ldx SCREEN_BUFFER_1 + $04
        lda L_1243,x
        sta SCREEN_BUFFER_1 + $1a
        lda L_130b,x
        sta SCREEN_BUFFER_1 + $1b
        ldx SCREEN_BUFFER_1 + $05
        lda SCREEN_BUFFER_1 + $1a
        clc 
        adc $13d3,x
        sta SCREEN_BUFFER_1 + $1a
        lda SCREEN_BUFFER_1 + $1b
        adc L_1473,x
        sta SCREEN_BUFFER_1 + $1b
        ldy #$00
    L_1d21:
        sty SCREEN_BUFFER_1 + $0c
        lda (SCREEN_BUFFER_1 + $02),y
        tax 
        lda L_1c15 + $e,x
        sta SCREEN_BUFFER_1 + $1c
        lda L_1c75 + $9,x
        sta SCREEN_BUFFER_1 + $1d
        ldy #$07
    L_1d32:
        lda (SCREEN_BUFFER_1 + $1c),y
    L_1d34:
        nop 
        nop 
        nop 
        nop 
        sta (SCREEN_BUFFER_1 + $1a),y
        dey 
        bpl L_1d32
        lda SCREEN_BUFFER_1 + $1a
        clc 
        adc #$08
        sta SCREEN_BUFFER_1 + $1a
        lda SCREEN_BUFFER_1 + $1b
        adc #$00
        sta SCREEN_BUFFER_1 + $1b
        ldy SCREEN_BUFFER_1 + $0c
        iny 
        cpy SCREEN_BUFFER_1 + $06
        bne L_1d21
        rts 


        ldx SCREEN_BUFFER_1 + $02
        lda L_1552 + $b,x
        clc 
        adc SCREEN_BUFFER_1 + $03
        sta SCREEN_BUFFER_1 + $0a
        lda L_1574 + $2,x
        adc #$00
        sta SCREEN_BUFFER_1 + $0b
        lda L_152a + $1,x
        clc 
        adc SCREEN_BUFFER_1 + $03
        sta SCREEN_BUFFER_1 + $0c
        lda L_1542 + $2,x
        adc #$00
        sta SCREEN_BUFFER_1 + $0d
        ldy #$00
    L_1d74:
        lda SCREEN_BUFFER_1 + $04
        sta (SCREEN_BUFFER_1 + $0a),y
        lda SCREEN_BUFFER_1 + $05
        sta (SCREEN_BUFFER_1 + $0c),y
        iny 
        cpy SCREEN_BUFFER_1 + $06
        bne L_1d74
        rts 


        ldx #$03
    L_1d84:
        lda L_1cf9,x
        sta L_1d34,x
        dex 
        bpl L_1d84
        rts 


        ldx #$03
        lda #$ea
    L_1d92:
        sta L_1d34,x
        dex 
        bpl L_1d92
        rts 


        lda SCREEN_BUFFER_1 + $04
        sta SCREEN_BUFFER_1 + $0d
        ldy #$00
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $04
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $05
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $13
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $12
        asl 
        asl 
        asl 
        sta SCREEN_BUFFER_1 + $1c
        iny 
        lda (SCREEN_BUFFER_1 + $02),y
        sta SCREEN_BUFFER_1 + $1d
        ldx SCREEN_BUFFER_1 + $04
        lda L_1243,x
        sta SCREEN_BUFFER_1 + $1a
        lda L_130b,x
        sta SCREEN_BUFFER_1 + $1b
        ldx SCREEN_BUFFER_1 + $05
        lda SCREEN_BUFFER_1 + $1a
        clc 
        adc $13d3,x
        sta SCREEN_BUFFER_1 + $1a
        lda SCREEN_BUFFER_1 + $1b
        adc L_1473,x
        sta SCREEN_BUFFER_1 + $1b
        lda SCREEN_BUFFER_1 + $02
        clc 
        adc #$05
        sta SCREEN_BUFFER_1 + $02
        lda SCREEN_BUFFER_1 + $03
        adc #$00
        sta SCREEN_BUFFER_1 + $03
        ldx SCREEN_BUFFER_1 + $13
    L_1de8:
        ldy SCREEN_BUFFER_1 + $1c
    L_1dea:
        dey 
        cpy #$ff
        beq L_1df6
        lda (SCREEN_BUFFER_1 + $02),y
        sta (SCREEN_BUFFER_1 + $1a),y
        jmp L_1dea
    L_1df6:
        lda SCREEN_BUFFER_1 + $02
        clc 
        adc SCREEN_BUFFER_1 + $1c
        sta SCREEN_BUFFER_1 + $02
        lda SCREEN_BUFFER_1 + $03
        adc #$00
        sta SCREEN_BUFFER_1 + $03
        dex 
        beq L_1e16
        lda SCREEN_BUFFER_1 + $1a
        clc 
        adc #$40
        sta SCREEN_BUFFER_1 + $1a
        lda SCREEN_BUFFER_1 + $1b
        adc #$01
        sta SCREEN_BUFFER_1 + $1b
        jmp L_1de8
    L_1e16:
        lsr SCREEN_BUFFER_1 + $04
        lsr SCREEN_BUFFER_1 + $04
        lsr SCREEN_BUFFER_1 + $04
        lsr SCREEN_BUFFER_1 + $05
    L_1e1e:
        lsr SCREEN_BUFFER_1 + $05
        ldx SCREEN_BUFFER_1 + $04
        lda L_1552 + $b,x
        sta SCREEN_BUFFER_1 + $06
        lda L_1574 + $2,x
        sta SCREEN_BUFFER_1 + $07
        lda L_152a + $1,x
        sta SCREEN_BUFFER_1 + $08
        lda L_1542 + $2,x
        sta SCREEN_BUFFER_1 + $09
        lda SCREEN_BUFFER_1 + $06
        clc 
        adc SCREEN_BUFFER_1 + $05
        sta SCREEN_BUFFER_1 + $06
        lda SCREEN_BUFFER_1 + $07
        adc #$00
        sta SCREEN_BUFFER_1 + $07
        lda SCREEN_BUFFER_1 + $08
        clc 
        adc SCREEN_BUFFER_1 + $05
        sta SCREEN_BUFFER_1 + $08
        lda SCREEN_BUFFER_1 + $09
        adc #$00
        sta SCREEN_BUFFER_1 + $09
        lda SCREEN_BUFFER_1 + $02
        clc 
        adc SCREEN_BUFFER_1 + $1d
        sta SCREEN_BUFFER_1 + $0a
        lda SCREEN_BUFFER_1 + $03
        adc #$00
        sta SCREEN_BUFFER_1 + $0b
        ldx SCREEN_BUFFER_1 + $13
    L_1e5f:
        ldy #$00
    L_1e61:
        lda (SCREEN_BUFFER_1 + $02),y
        sta (SCREEN_BUFFER_1 + $06),y
        lda SCREEN_BUFFER_1 + $0d
        bpl L_1e6b
        lda (SCREEN_BUFFER_1 + $0a),y
    L_1e6b:
        sta (SCREEN_BUFFER_1 + $08),y
        iny 
        cpy SCREEN_BUFFER_1 + $12
        bne L_1e61
        dex 
        beq L_1eac
        lda SCREEN_BUFFER_1 + $06
        clc 
        adc #$28
        sta SCREEN_BUFFER_1 + $06
        lda SCREEN_BUFFER_1 + $07
        adc #$00
        sta SCREEN_BUFFER_1 + $07
        lda SCREEN_BUFFER_1 + $08
        clc 
        adc #$28
        sta SCREEN_BUFFER_1 + $08
        lda SCREEN_BUFFER_1 + $09
        adc #$00
        sta SCREEN_BUFFER_1 + $09
        lda SCREEN_BUFFER_1 + $02
        clc 
        adc SCREEN_BUFFER_1 + $12
        sta SCREEN_BUFFER_1 + $02
        lda SCREEN_BUFFER_1 + $03
        adc #$00
        sta SCREEN_BUFFER_1 + $03
        lda SCREEN_BUFFER_1 + $0a
        clc 
        adc SCREEN_BUFFER_1 + $12
        sta SCREEN_BUFFER_1 + $0a
        lda SCREEN_BUFFER_1 + $0b
        adc #$00
        sta SCREEN_BUFFER_1 + $0b
        jmp L_1e5f
    L_1eac:
        rts 



        .byte $4f,$75,$74,$20,$6f,$66,$20,$62,$6f,$75,$6e,$64,$73,$21,$4c,$6f
        .byte $61,$64,$69,$6e,$67,$20,$73,$63,$6f,$72,$65,$20,$63,$61,$72,$64
        .byte $73,$47,$6f,$6e,$65,$20,$66,$69,$73,$68,$69,$6e,$67,$21,$43,$6f
        .byte $6e,$63,$65,$64,$65,$20,$68,$6f,$6c,$65,$3f,$20,$4e,$6f,$20,$59
        .byte $65

    L_1eee:
        .byte $73

    L_1eef:
        lda L_ceb4 + $7

        .byte $db

    L_1ef3:
        asl L_1e1e,x
        asl $130e,x
        ora.a SCREEN_BUFFER_1 + $14
        jsr L_1f31
        lda #$00
        sta SCREEN_BUFFER_1 + $05
        lda #$c0
        sta SCREEN_BUFFER_1 + $04
        lda SCREEN_BUFFER_1 + $06
        sta $1efb
        jsr L_1cfd
        rts 


        jsr L_1f31
        lda L_1eef,x
        sta SCREEN_BUFFER_1 + $02
        lda L_1ef3,x
        sta SCREEN_BUFFER_1 + $03
        lda #$c0
        sta SCREEN_BUFFER_1 + $04
        lda #$00
        sta SCREEN_BUFFER_1 + $05
        lda $1ef7,x
        sta SCREEN_BUFFER_1 + $06
        sta $1efb
        jsr L_1cfd
        rts 


    L_1f31:
        lda $1efb
        beq L_1f58
        lda #$00
        sta SCREEN_BUFFER_1 + $0a
        lda #$fe
        sta SCREEN_BUFFER_1 + $0b
        lda #$a0
        sta SCREEN_BUFFER_1 + $0c
        lda #$fe
        sta SCREEN_BUFFER_1 + $0d
        ldy #$00
        lda #$ff
    L_1f4a:
        sta (SCREEN_BUFFER_1 + $0a),y
        sta (SCREEN_BUFFER_1 + $0c),y
        iny 
        cpy #$a0
        bne L_1f4a
        lda #$00
        sta $1efb
    L_1f58:
        rts 



        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00

    L_2000:
        bit.a SCREEN_BUFFER_1 + $43

    L_2003:
         .fill $56, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$1f,$c0,$00

    L_2063:
        .byte $00,$00,$00,$00,$00
        .byte $c0,$60

    L_206a:
        .fill $f6, $0
        .byte $03,$0e,$00,$00,$00,$01,$1f,$f0,$c0,$00,$00,$00,$00,$ff,$80,$00
        .byte $00,$00,$00,$00,$00,$ff,$3f,$70,$e0,$e0,$00,$00,$00,$00,$e0,$1c
        .byte $03,$00,$00,$00,$00,$00,$00,$00,$c0,$3f,$00,$00,$00,$00,$00,$00
        .byte $00,$81,$03,$06,$0c,$0c,$00,$00,$00,$ff,$00,$00,$00,$00,$01,$07
        .byte $3f,$f0,$10,$30,$30,$60,$e0,$c0
        .fill $ed, $0
        .byte $01,$03,$06,$0e,$18,$18,$70,$c0,$80,$00,$00,$00,$01,$20,$20,$60
        .byte $e0,$c0,$c0,$80,$80,$01,$01,$03,$07,$07,$06,$0e,$0c,$c0,$c0,$80
        .fill $15, $0
        .byte $7e,$00,$00,$00,$00,$00,$00,$00,$0e,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$06,$06,$0c,$1c,$18,$18
        .fill $18, $0
        .byte $04,$04,$0c,$0c,$18,$38,$30,$30
        .fill $c8, $0
        .byte $18,$30,$20,$20,$30,$30,$38,$1f,$03,$07,$06,$0e,$1c,$38,$70,$e0
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$1c,$18,$38,$30,$70,$60,$60,$c0
        .fill $2e, $0
        .byte $01,$01,$30,$30,$60,$60,$40,$c0,$80,$80
        .fill $15, $0
        .byte $01,$03,$03,$60,$60,$c0,$c0,$80,$80
        .fill $ca, $0
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$01,$01,$01,$03,$03,$07,$06,$c0,$80,$80
        .fill $18, $0
        .byte $08,$18,$18,$30,$30,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$03,$02,$06,$0e,$0c,$08,$18,$10
        .fill $18, $0

    L_257a:
        asl SCREEN_BUFFER_1 + $04

        .byte $0c,$1c,$18,$10,$30,$30
        .fill $2f, $0

    L_25b1:
        ora (SCREEN_BUFFER_1 + $ff,x)

        .byte $ff,$fc,$f0,$e0,$c0,$80,$00,$c0,$00,$00,$00,$00,$00,$00,$00,$3f
        .byte $01,$00,$07,$00,$00,$00,$00,$00,$00,$c0,$e0,$30,$f8,$ec,$e6,$00

    L_25d3:
        .fill $8f, $0
        .byte $0e,$0c,$1c,$1c,$18,$18,$30,$30,$00,$00,$00,$01,$01,$07,$06,$0e
        .byte $0f,$3f,$ec,$cc,$8c,$04,$07,$03,$00,$80,$80,$81,$81,$81,$83,$87
        .byte $63,$4d,$d8,$b0,$a0,$c0,$c0,$80,$c0,$e0,$20,$20,$27

    L_268f:
        rts 


        rts 


        rts 



        .byte $00,$00,$00,$3c,$f0,$00

    L_2698:
        ora (SCREEN_BUFFER_1 + $03,x)
    L_269a:
        and (SCREEN_BUFFER_1 + $37),y

        .byte $64,$e8,$f8,$f0,$c0,$80,$e0,$f0,$10,$10,$10,$13,$33,$67,$07,$1e
        .byte $74,$e4,$c6,$86,$01,$01,$c0,$e0,$40,$e0,$e0,$c1,$c3,$c7,$60

    L_26bb:
        rti 

        .byte $c0,$80,$80,$00,$00,$00,$00,$00,$01,$02,$06,$0c,$19,$36,$40,$e0
        .byte $a0,$40,$00,$80

    L_26d0:
        .fill $1a, $0
        .byte $02,$01,$02,$05,$06,$07,$0f,$0f,$7f,$be,$50,$a0,$00,$00,$00,$00
        .byte $7f,$07,$00,$00,$00,$00,$00,$00,$ff,$ff,$0f,$01,$00,$00,$00,$00
        .byte $06,$02,$01,$01,$00,$00,$00,$00,$00,$80,$c0,$60,$20,$20,$30,$fc

    L_271a:
        .fill $1e, $0
        .byte $03,$0f,$00,$00,$00,$00,$1f,$ff,$ff,$ff,$fc,$f8,$c0,$00,$00,$00
        .byte $00,$00,$80,$c0,$e0,$f0,$f0,$f0,$f0,$c0
        .fill $3e, $0
        .byte $3f,$ff,$00,$00,$00,$00,$00,$00,$e0,$f0,$00,$00,$00,$00,$00,$00
        .byte $01,$01,$30,$60,$60,$e0,$c0,$c0,$80,$80,$0c,$18,$18,$18,$18,$18
        .byte $1e,$0f,$03,$03,$06,$0c,$08,$18,$f0,$80,$8f,$fe,$5c,$19,$1b,$33
        .byte $23,$61,$00,$00,$00,$01,$03,$06,$9c,$f0,$40,$80,$80,$00,$00,$00
        .byte $00,$00,$0f,$1b,$62,$06,$04,$0c,$18,$30,$80,$01,$01,$03,$06,$04
        .byte $07,$03,$c6,$8c,$8c,$1c,$1c,$6c,$cf,$87,$01,$01,$03,$02,$04,$0c
        .byte $78

    L_27f1:
        cpy #$c6
        ror $0c24,x

        .byte $0c,$0c,$0e,$07,$00,$00,$01,$01,$07,$0c,$f0,$80,$38,$60

    L_2804:
        cpx #$e0
        rti 
        jsr L_0f00 + $3c

        .byte $00,$00,$06,$0c,$0c,$30,$e0,$80

    L_2812:
        .fill $18, $0
        .byte $e0,$e0,$c0,$c0,$c0,$80,$80,$00,$00,$01,$03,$0f,$1f,$3f,$3f,$7f
        .byte $ff,$fc,$f0,$80,$03,$06,$07,$00,$80,$00,$0c,$fc,$80,$00,$00,$00
        .byte $ff,$0f,$00,$00,$00,$00,$00,$00,$ff,$dc,$db,$42,$05,$09,$01,$09
        .fill $13, $0
        .byte $01,$03,$07,$07,$07,$e0,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$08,$0c,$04,$06,$8f,$83,$80,$c0,$40,$70,$30,$30,$00,$00,$00
        .byte $00,$80,$80,$80,$80
        .fill $30, $0
        .byte $01,$03,$07,$06,$0c

    L_28c7:
        .byte $0c,$0c
        .byte $0e,$c1,$01,$00,$00,$00,$00,$00,$00,$f0,$c0,$c0,$00,$00,$00,$00
        .byte $00,$03,$06,$0e,$0c,$18,$30,$70,$e0
        .fill $12, $0
        .byte $01,$01,$03,$03,$03,$07,$e0,$e0,$c0,$c0,$80,$80
        .fill $19, $0
        .byte $7e
        .fill $17, $0
        .byte $01,$00,$10,$30,$20,$60,$40,$c0,$80,$00,$00,$00,$00,$01,$01,$03
        .byte $06,$00,$00,$80,$80,$80
        .fill $29, $0
        .byte $c0,$e0,$03,$03,$04,$00,$01,$03,$03,$01,$00,$00,$c0,$c0,$c0,$00
        .byte $00,$01,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$03,$03,$03,$03,$03,$03,$01,$00,$00,$00,$00,$00,$00,$07
        .byte $0f,$7f,$e0,$c0,$c0,$00,$00,$00,$00,$00,$c0,$80,$00,$00,$00,$00
        .byte $00,$00,$07,$03,$03,$01,$00,$00,$00,$00,$83,$c1,$61,$18,$05,$03
        .byte $06,$8f,$e0,$80,$80,$80,$00,$00,$00,$00,$80,$80,$c0,$c0,$c0,$c0
        .byte $c0,$c0
        .fill $30, $0
        .byte $0e,$06,$07,$03,$00,$00,$00,$00,$00,$00,$00,$80,$f9,$7f,$00,$00
        .byte $01,$07,$1e,$7c,$f0,$c0,$00,$00,$80

    L_2a1b:
        .fill $17, $0
        .byte $06,$0e,$0c,$18,$18,$38,$31,$63,$00,$00,$00,$00,$00,$00,$e0,$e0
        .byte $00,$00,$00,$00,$00,$01,$03,$06,$07,$0f,$18,$70,$e0,$c0,$00,$00
        .byte $e7,$03,$03,$03,$02,$06,$0c,$18,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$03,$03,$02,$06,$0c,$0c,$18
        .byte $80,$00,$00,$00,$00,$00,$00,$00,$06,$0c,$0c,$0f,$3e,$f0,$30,$20
        .byte $00,$00,$00,$f8
        .fill $2c, $0
        .byte $7f,$3f,$1f,$0f,$07,$03,$01,$00,$87,$87,$c0,$e0,$e0,$e0,$f8,$fe
        .byte $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$07,$03,$03,$03,$00,$00,$01,$ff,$ff,$f8,$f8,$60,$00,$00,$07
        .byte $00,$00,$00,$80,$e0,$ff

    L_2ae8:
        .byte $ff,$ff,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$0f,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$83,$c7
        .byte $ff,$ff,$3f,$07,$01,$00,$00,$00,$00,$00,$00,$00,$00,$80,$e0,$f8
        .byte $f8,$fe
        .fill $58, $0
        .byte $66,$66,$c2,$83,$81,$00,$00,$00,$20,$00,$00,$00,$ff,$01,$03,$07
        .byte $1c,$18,$70,$78,$ff,$c0,$80,$00,$00,$03,$0e,$f8,$c0,$00,$00,$00
        .byte $70,$c0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$1f
        .byte $00,$00,$00,$00,$00,$00,$00,$01,$10,$30,$70,$60,$40,$c0,$c0,$80
        .byte $00,$00,$00,$01,$01,$03,$03,$06,$60,$40,$c0,$80,$80
        .fill $2e, $0
        .byte $01,$03,$07,$1f,$3f,$f0,$80,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $00,$00,$00,$00,$00,$ff,$ff,$1f,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$fe,$ff,$ff,$ff,$00,$00,$00,$00,$00,$80,$c0,$f0,$03,$01,$01
        .byte $00,$00,$00,$00,$00,$0f,$07,$05,$00

    L_2c26:
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $c0,$f0,$fc,$ff,$1f,$07,$07,$07,$03,$03,$03,$03,$00,$00,$40,$c0
        .byte $c0,$e3,$ff,$f8,$00,$00,$00,$00,$00,$fa,$80,$02,$e0,$78,$1c,$0e
        .byte $03,$03,$01,$01,$00,$00,$00,$00,$00,$00,$40,$c0,$ff,$3f,$0f,$03
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$c0,$f0,$f8
        .fill $50, $0
        .byte $06,$0e,$1c,$18,$18,$30,$30,$70,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$01,$01,$03,$07,$0e,$1e,$00,$c1,$83,$83,$8e,$0c,$1c,$18
        .byte $7f,$d9,$9b,$1b,$0b,$0f,$07,$07,$81,$03,$82,$82,$04,$0c,$1c,$98
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$04,$0c,$08,$18,$38,$30,$60,$c0
        .fill $2e, $0
        .byte $01,$01,$80,$80,$80,$80
        .fill $1c, $0
        .byte $07,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$03,$07,$ff,$ff,$ff,$fc,$80,$00,$00,$00
        .byte $ff,$ff,$f0,$00,$00,$00,$00,$00,$3f,$c0
        .fill $19, $0
        .byte $01,$01,$03,$03,$03,$7f,$3f,$1f,$0f,$07,$03,$01,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $c0,$f0,$f8,$fc,$fe
        .fill $48, $0
        .byte $70,$30,$18,$18,$1f,$0f,$03,$00,$00,$00,$00,$01,$07,$ff,$f0,$00
        .byte $1c,$34,$e8,$c8,$10,$10,$10,$20,$10,$30,$30,$30,$30,$1d,$1f,$00
        .byte $07,$0c,$08,$10,$30,$e0,$00,$00,$f8

    L_2e23:
        .byte $f0,$30,$30,$30,$3b
        .byte $1e,$00,$01

    L_2e2b:
        .byte $03,$0f,$1b,$73
        .byte $c6,$04,$0c

    L_2e32:
        cpy #$80

        .byte $80
        .fill $24, $0
        .byte $01,$00,$00,$00,$00,$03,$0f,$7c,$e0,$03,$0f,$3f,$f3,$c3,$03,$03
        .byte $03
        .fill $2b, $0
        .byte $01,$01,$03,$07,$0f,$e0,$80,$80
        .fill $28, $0
        .byte $01,$03,$07,$0f,$1f,$f8,$f0,$e0,$e0,$c0,$c0,$80,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$3f,$1f,$0f,$07,$03,$03,$01,$00

    L_2ee2:
        .fill $12, $0
        .byte $c0,$e0,$f0,$f8,$fc,$fe
        .fill $2c, $0
        .byte $01,$03,$06,$04,$00,$00,$00,$7e,$ff,$07,$0f,$07,$00,$00,$00,$00
        .byte $00,$00,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01,$03,$02,$60,$60,$c0,$c0,$80,$80
        .fill $11, $0
        .byte $03,$00,$00,$00,$00,$00,$01,$79,$e3,$18,$10,$30,$60,$c0,$c0,$80
        .fill $17, $0
        .byte $01,$07,$00,$00,$00,$03,$0f,$7c,$e0,$80,$07,$3e,$f0,$c0,$00,$00
        .byte $00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$80,$c0,$c0
        .fill $1b, $0
        .byte $01,$01,$01,$03,$03,$f0,$e0,$e0,$e0,$c0,$80,$80,$80
        .fill $24, $0
        .byte $01,$03,$0f,$7f,$fc,$f8

    L_3004:
        .byte $f0,$c0,$00,$00,$00,$00,$fc,$80,$00,$00,$00,$00,$00,$00
        .byte $f8,$f8,$f0,$f0,$e0,$e0,$c0,$c0,$0f,$f8,$60

    L_301d:
        .byte $00,$00,$00,$00,$00
        .byte $e0,$e0,$e0,$c0,$c0,$c0

    L_3028:
        rts 


        rts 



    L_302a:
         .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$01,$03,$1f,$00,$00,$80,$80,$80,$80

    L_3040:
        .fill $22, $0
        .byte $0c

    L_3063:
        php 
        php 
        clc 
        clc 
        clc 
        php 

        .byte $0c,$03
        .fill $15, $0
        .byte $01,$07,$06,$0c,$18,$10,$60,$e0,$80,$80,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$06,$1c,$30,$60,$c0,$c0
        .byte $80,$83,$06,$0c,$08,$18,$30,$60,$c0,$80,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$01,$07,$1e,$00,$01,$07,$1f,$7c,$e0
        .byte $80,$00,$3e,$f8,$c0
        .fill $25, $0
        .byte $1f,$0f,$07,$01,$00

    L_30ef:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$f0,$f0,$00,$00,$00,$00,$00
        .byte $00,$00,$3f,$00,$00,$00,$00,$00,$01,$0e,$f8,$03,$03,$01,$01,$c1
        .byte $81,$00,$00,$57,$2a,$04,$00,$80,$00,$05,$fe,$fe,$b0,$00,$01,$03
        .byte $0f,$f8,$00,$00,$00,$00,$00,$07,$7f,$ff,$ff,$ff,$ff,$fc,$e0,$00

    L_312f:
        .byte $00,$00,$00
        .byte $fe,$e0,$00,$00,$00,$00,$00,$00,$0c,$06,$03,$01,$01,$00,$00,$00
        .byte $00,$00,$00,$00,$80,$80,$c0,$68,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $20,$00,$20,$00,$00,$00,$00,$07,$00,$00,$00,$00,$00,$00,$1f,$ff
        .byte $fe,$fc,$f0,$e0,$c0,$80
        .fill $2a, $0
        .byte $06,$03,$00,$00,$00,$00,$00,$00,$00,$00,$c0,$7c,$0f,$00,$00,$00
        .byte $00,$00,$01,$07,$fe,$00,$00,$00,$0e,$3c,$f8,$c0
        .fill $14, $0
        .byte $03,$03,$03,$01,$00,$00,$00,$00,$07,$1c,$f0,$c0,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$01,$07,$1e,$78,$00,$03,$0f,$3c,$e0,$80,$00,$00
        .byte $78

    L_31f3:
        cpy #$00

    L_31f5:
         .fill $3d, $0
        .byte $07,$03,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80
        .byte $00,$03,$00,$00,$00,$00,$00,$00,$f1,$83,$00,$00,$00,$00,$00,$00
        .byte $ff,$f8

    L_3254:
        .byte $70,$00,$00,$00,$00,$00,$ff
        .fill $11, $0
        .byte $01,$02,$04,$08,$08,$10,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$74,$3a,$15,$1a,$0d,$0e,$05,$06,$01,$07
        .byte $07,$0f,$0f,$0f,$1f,$1f,$00,$00,$80,$80,$80,$e0,$fc,$fb,$00,$00
        .byte $00,$00,$00,$2b,$7f,$ff,$ff,$ff,$fe,$f8,$80,$00,$00,$00,$f8,$80
        .byte $00,$00,$00,$00,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$00,$ff,$07
        .byte $03
        .fill $54, $0
        .byte $03,$00,$00,$00,$01,$07,$1e,$f8,$e0,$03,$0f,$7c,$f0,$80,$00,$00
        .byte $00,$e0,$80
        .fill $56, $0
        .byte $c0,$e0,$e0,$f0,$f0,$f0,$f8,$f8
        .fill $12, $0
        .byte $01,$01,$00,$05,$03,$55,$00,$00,$81,$01,$81,$82,$84,$08,$80,$80
        .byte $80,$01,$00,$00,$00,$00,$20,$40,$c0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00,$06,$03
        .byte $01,$01,$01,$00,$00,$00,$c0,$80,$00,$80

    L_33ce:
        cpy #$e0
        cpx #$f0

        .fill $6d, $0
        .byte $01,$07,$7c,$00,$00,$01,$07,$7e,$f8,$e0,$00,$0f,$7c,$f0,$80
        .fill $4b, $0
        .byte $1f,$00,$00,$00,$00,$00,$00,$ff,$ff,$00,$00,$00,$00,$1f,$7f,$ff
        .byte $ff,$ff,$ff,$fc,$80,$00,$00,$00,$00,$ff,$c0,$00,$00,$00,$00,$00
        .byte $00,$03,$03,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80
        .byte $80,$00,$00,$02,$01,$02,$00,$01,$01,$2a,$54,$a8,$40,$80,$c0,$00
        .byte $01,$08,$10,$10,$20,$40,$40,$80,$00,$00,$00,$00,$00,$00,$01,$06
        .byte $08,$00,$00,$10,$61,$82,$0e,$10,$70,$18,$20,$40,$80
        .fill $14, $0
        .byte $07,$07,$03,$03,$01,$00

    L_3510:
        .fill $5d, $0
        .byte $03,$1f,$3f,$3f,$7f,$fe,$c0,$01,$03,$01,$00,$00,$00,$f0,$80,$00
        .byte $00,$00,$00,$80,$c0
        .fill $1f, $0
        .byte $1f,$00,$00,$00,$00,$00,$0f,$ff,$ff,$00,$00,$00,$00,$0f,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$f0,$00,$00,$00,$00,$ff,$ff,$fe,$00,$00,$00,$00
        .byte $00,$ff,$ff,$00,$00,$00,$00,$00,$00,$fc,$80
        .fill $36, $0
        .byte $80,$c0,$c0,$c0,$e0,$e0,$f0,$f0,$02,$02,$04,$0c,$08,$08,$10,$10
        .byte $02,$02,$04,$08,$08,$08,$10,$20,$00,$00,$00,$00,$00,$01,$02

    L_3621:
        .byte $02,$10,$11,$22,$44
        .byte $88,$10,$20,$40,$c0,$80
        .fill $26, $0
        .byte $80,$80,$80,$c0,$c0,$c0,$c0,$e0
        .fill $28, $0
        .byte $ff,$80,$00,$00,$00,$00,$00,$00,$ff,$1f,$00,$00,$00,$00,$00,$00
        .byte $ff,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$01,$01,$01,$01,$01,$01,$10,$2a,$14,$0f,$1b,$17,$3d,$17
        .byte $fc,$f0,$e0,$e0,$c0,$c0,$e0,$e0,$1f,$0f,$0f,$07,$03,$01,$01,$01
        .byte $ff,$0c,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00
        .byte $fe
        .fill $6f, $0
        .byte $0f,$0f,$0f,$07,$07,$07,$03,$01,$00,$00,$20,$20,$20,$40,$40,$40
        .byte $40,$40,$40,$40,$80,$80,$80,$80,$04,$05,$0a,$12,$14,$20,$40,$80
        .byte $80
        .fill $2f, $0

    L_3792:
        cpx #$e0
        cpx #$e0

        .byte $f0,$f0,$f0,$f8
        .fill $48, $0
        .byte $01,$01,$01,$01,$00,$00,$00,$00,$e0,$f0,$e4,$f0,$e8,$e4,$e0,$60

    L_37f2:
        .byte $c0,$c0,$e0,$e0,$e0,$e0,$f0,$f0,$01,$01,$01,$01,$03,$03,$07,$07

    L_3802:
        .fill $80, $0
        .byte $01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$c0,$c0,$c0,$c0
        .byte $00,$01,$01,$02,$02,$02,$04,$08,$80
        .fill $37, $0
        .byte $07,$07,$07,$03,$01,$01,$01
        .fill $51, $0
        .byte $3f,$3f,$0f,$0f,$07,$03,$01,$00,$0f,$0f,$0f,$07,$07,$01,$03,$c1
        .byte $f8,$f0,$f0,$f0,$e0,$e0,$c0,$c0
        .fill $88, $0
        .byte $80,$80,$c0,$c0,$c0,$c0,$c0,$e0,$08,$08,$10,$10,$20,$20,$20,$20
        .fill $44, $0
        .byte $80,$80,$80,$c0
        .fill $28, $0
        .byte $ff,$37,$36,$34,$34,$24,$0c,$1e,$00,$00,$ef,$2d,$2c,$ec,$0c,$ec
        .byte $00,$00,$1c

    L_3a5d:
        ldx SCREEN_BUFFER_1 + $30,y
        rol L_3de2 + $20,x

        .byte $00,$c0,$0e,$db,$d9,$d9,$db,$ce,$00,$00,$71,$78,$68,$68,$68,$69
        .byte $00,$c1,$c1,$c1,$c0,$c1,$cd,$ec,$00,$f0,$80,$e0,$30,$90,$b6,$e6
        .byte $00,$70,$d8,$c8,$18,$70,$c0,$f8
        .fill $80, $0
        .byte $e0,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$40,$40,$40,$40,$80,$80,$80
        .fill $41, $0
        .byte $c0,$e0,$e0,$e0,$e0,$f0,$f0,$f0
        .fill $29, $0
        .byte $6e,$db,$d8,$d8,$d8,$db,$6e,$00,$c3,$66,$66,$60,$63,$66,$c7,$00
        .byte $8e,$db,$59,$d9,$99,$1b

    L_3ba1:
        dec L_37f2 + $e
        adc L_0c64
        sec 
        rts 



        .byte $7d,$00,$c0,$c0,$c0,$c0,$c0,$c0,$e0,$ff,$3b,$02,$03,$2a,$2a,$3a
        .byte $3b,$00,$06,$e7,$36,$f6,$96,$96,$f6,$00,$66,$76,$67,$66,$66,$66
        .byte $66,$00,$00,$0f,$99,$d9,$5f,$58,$4f,$00,$00,$62,$62,$6a,$6a,$7e
        .byte $1c,$00,$39,$6d,$61,$61,$61,$6d,$38,$00,$80,$8f,$81,$8f,$8c,$ac
        .byte $e7,$00,$00,$3c,$b6,$b0,$b0,$b0,$b0,$ff,$3f,$26,$0c,$24,$34,$34
        .byte $36,$00,$00,$e0,$20,$20,$e0,$00,$e0
        .fill $2f, $0
        .byte $50
        .fill $18, $0
        .byte $c0,$c0,$c0,$c0,$c0,$c0,$80,$80
        .fill $17, $0
        .byte $01,$00,$00,$00,$03,$0c,$10,$60,$80,$00,$00,$60,$c0,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$03,$7f
        .byte $ff,$ff,$ff,$ff,$f8,$80,$00,$00,$00,$ff,$fe,$c0,$00,$00,$00,$00
        .byte $00,$0f,$07,$07,$07,$07,$07,$07,$07
        .fill $29, $0
        .byte $c0,$c3,$c6,$c6,$c6,$c6,$f3,$00,$00,$9e,$c3,$5f,$59,$d9,$8f,$00
        .byte $04,$04,$3d,$65,$65,$6d,$38,$00,$00,$f7,$96,$96,$f6,$86,$f6,$04
        .byte $08,$88,$d3,$16,$26,$26,$43,$00,$40,$4f,$d9,$59,$5f,$d8,$8f,$00
        .byte $00,$39,$6c,$65,$6d,$79,$60,$00,$00,$e3,$36,$f6,$96,$96,$f3,$00
        .byte $18,$9b,$de,$1b,$19,$d9,$99,$00,$00,$3d,$65,$65,$7d,$61,$3d,$00
        .byte $00,$e3,$b3,$83,$83,$9b,$9b,$00,$07,$2d,$2c,$21,$67,$cc,$8f,$00
        .byte $03,$86,$86,$80,$03,$36,$b7,$ff,$70,$27,$a1,$24,$66,$e4,$31,$00
        .byte $03,$06,$06,$06,$06,$06,$03,$ff,$89,$24,$3c,$3c,$3c,$24,$89,$00
        .byte $30,$31,$30,$31,$31,$31,$3c,$00,$00,$e3,$36,$f6,$97,$90,$77,$00
        .byte $00

    L_3d5c:
        stx $18db

        .byte $df,$41,$df,$00,$00,$3c,$64,$64,$7c,$60,$3c,$fe,$8f,$26,$34,$34
        .byte $34,$24,$8e,$40,$00,$cf,$6d,$2c,$2c,$6c,$cc,$00,$00,$3c,$b6,$32
        .byte $32,$32,$32,$00,$c0,$00,$c0,$c0,$c1,$c1,$c1,$80,$80,$80,$80,$80
        .byte $80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03
        .byte $0e,$10,$30,$0e,$18,$60,$c0,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$01,$07,$00,$00,$01,$07,$1f,$3f,$ff,$ff,$e0,$80
        .fill $1e, $0
        .byte $07,$07,$07,$07,$07,$07,$07,$07

    L_3de2:
        .fill $58, $0
        .byte $60
        .fill $1f, $0
        .byte $30
        .fill $67, $0
        .byte $01,$03,$03,$03,$03,$03,$03,$03,$00,$00,$00,$80,$80,$80,$c0,$c0
        .byte $00,$00,$01,$01,$04,$08,$18,$20,$40,$80

    L_3edc:
        .byte $00,$00,$00,$00
        .byte $01,$03,$00,$00,$01,$03,$0f,$7f,$ff,$ff,$f0,$ea,$d0,$e5,$d0,$a1
        .byte $d4,$a9,$00,$40,$00,$40,$08,$00,$20
        .fill $21, $0
        .byte $f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0
        .fill $20, $0

    L_3f42:
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror $ee6e
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        inc L_6ee9 + $5
        ror L_6ee9 + $5
        inc L_eee7 + $7
        ror L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6ee9 + $5
        ror L_6ee9 + $5
        inc L_eee7 + $7
        inc L_6ee9 + $5
        ror L_eee7 + $7
        ror $ee6e
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
    L_3fde:
        inc L_eee7 + $7
        inc L_eee7 + $7
        ror L_6ee9 + $5
        ror L_eee7 + $7
        ror L_eee7 + $7
        ror L_eee7 + $7
        inc $ee6e
        inc L_eee7 + $7
        inc $e10e
        sbc (SCREEN_BUFFER_1 + $e1,x)
        asl L_eee7 + $7,x
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        inc L_eee7 + $7
        asl L_0f00 + $110

        .byte $10,$e1,$1e,$ee,$ee,$ee,$1e,$1e,$e9,$9e,$ee,$ee,$ee,$ee,$ee,$ee
        .byte $ee
        .fill $11, $6e
        .byte $ee,$ee,$ee,$e0,$20,$2a,$2a,$0a,$2a,$ee,$ee,$1e,$e1,$f1,$f1,$1e
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$ee,$ee

    L_4060:
        ror $ee6e
        inc $ee6e
        inc L_6e69 + $5
        ror $ee6e
        inc L_eee7 + $7
        cpx #$a2
        rol 
        rol 
        tax 
        nop 
        asl L_2ae8 + $2

        .byte $1a,$f1,$f1,$1e,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$ee,$ee
        .byte $6e,$6e,$6e,$6e,$6e,$ee,$ee,$6e,$6e,$6e,$6e,$ee,$ee,$ee,$ee,$ee
        .byte $2e,$2a,$2a,$aa,$2a,$06,$ea,$2a,$aa,$fa,$a1,$ea,$ae,$ee,$ee,$ee
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$6e,$6e,$6e,$6e
        .byte $6e,$6e,$ee,$ee,$ee,$ee,$ee,$6e,$e6,$26,$a6,$6a,$6a,$0a,$e6,$6e
        .byte $2e,$2a,$2a,$2a,$2a,$ea,$ae,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee
        .byte $ee,$6e,$ee,$6e,$6e,$6e,$6e,$ee,$6e,$ee,$ee,$ee,$ee,$ee,$6e,$e6
        .byte $66,$66,$66,$06,$06,$a6,$6a,$6a,$2a,$aa,$aa,$ea,$ae,$aa,$ea,$ae
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$6e,$6e,$6e
        .byte $6e,$ee,$ee,$ee,$0e,$0e,$0e,$66,$66,$66,$66,$66,$a6,$0a,$aa,$aa
        .byte $aa,$aa,$2a,$ae,$ee,$ae,$aa,$aa,$ae,$ee,$ee,$ee,$ee,$ee,$6e,$6e
        .byte $6e,$ee,$6e,$6e,$ee,$6e,$6e,$6e,$ee,$ee,$0e,$0e,$0e,$0e,$6e,$e6
        .byte $66,$66,$66,$06,$0a,$aa,$aa,$aa,$aa,$6a

    L_4142:
        ldx SCREEN_BUFFER_1 + $e6
        ror 
        rol 
        rol 
        tax 
        rol 
        ldx L_eee7 + $7
        inc L_6ee9 + $5
    L_414f:
        ror L_6ee9 + $5
    L_4152:
        ror L_6ee9 + $5
        ror $ee6e
        asl L_0e0d + $1
        inc L_eee7 + $7
        inc $e66e
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $a2
        ldx #$6a
        ldx SCREEN_BUFFER_1 + $a6
        asl SCREEN_BUFFER_1 + $06
        ror SCREEN_BUFFER_1 + $6a
        tax 
        rol 
        rol 
        rol L_eee7 + $7
        inc L_eee7 + $7
        ror L_6e69 + $5
        ror L_eee7 + $7
        ror L_0e4a + $24
        asl $ee0e
        inc L_eee7 + $7
        inc L_eee7 + $7
        ror SCREEN_BUFFER_0 + $2e6
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $66
        asl SCREEN_BUFFER_1 + $06
        ror SCREEN_BUFFER_1 + $06
        rol SCREEN_BUFFER_1 + $2a

        .byte $5a,$a5,$25,$e5,$e5,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$0e,$0e
        .byte $0e,$0e,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$e6,$66,$66,$06
        .byte $06,$06,$06,$06,$66,$06,$65,$55,$55,$55,$55,$55,$55,$ee,$ee,$ee
        .byte $ee,$ee,$ee,$ee,$be,$be,$0e,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$5e
        .byte $5e,$5e,$e5,$e5,$65,$e6,$06,$06,$06,$06,$06,$06,$66,$66,$56,$55
        .byte $55,$55,$55,$55,$55,$ee,$ee,$ee,$ee,$ee,$0e,$e0,$be,$ee,$ee,$ee
        .byte $5e,$5e,$5e,$e5,$e5,$e5,$e5,$55,$55,$55,$55,$55,$55,$56,$06,$06
        .byte $06,$06,$06,$66,$66,$66,$66,$65,$55,$55,$55,$55,$55,$e5,$e5,$e5
        .byte $e5,$05,$b0,$0c,$5c,$e5,$e5,$e5,$55,$55,$55,$55,$55,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$65,$06,$06,$06,$06,$66

    L_4230:
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        ora SCREEN_BUFFER_1 + $0b
        ldy L_5555 + $7,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $65,x
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $56
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $cb,x
        cmp SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $06,x
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $65,x
        adc SCREEN_BUFFER_1 + $65
        adc SCREEN_BUFFER_1 + $65
        adc SCREEN_BUFFER_1 + $65
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $06,x
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $b5,x
        lda SCREEN_BUFFER_1 + $b5,x
        lda SCREEN_BUFFER_1 + $59,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $59,x
        sta SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $66,x
        ror SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        ldx SCREEN_BUFFER_1 + $b6,y

        .byte $6b,$6b,$5b,$55,$55,$55,$55,$55,$65,$65,$65,$65,$65,$65,$65,$65
        .byte $65,$65,$65,$65,$65,$56,$b5,$5b,$b5,$b5,$b5,$b5,$5b,$b5,$b5,$b5
        .byte $06,$66,$06,$06,$06,$b6,$6b,$bb,$bb,$bb,$5b,$55,$55,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$65,$55,$55,$55,$65,$55,$55,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$55,$05,$06,$06,$06,$06,$0b,$0b,$bb,$bb
        .byte $bb,$bb,$b5,$55,$55,$55,$55,$00

    L_432b:
        .byte $00
        .byte $ad,$11,$d0,$09,$20,$29,$7f,$8d,$11,$d0,$a9,$08,$8d,$18,$d0,$a9
        .byte $00,$8d,$2b,$43,$a9,$02,$85,$0a,$a9,$20,$85,$0b,$a9,$00,$85,$0c
        .byte $a9,$e0,$85,$0d,$a2,$00,$a0,$00

    L_4354:
        lda (SCREEN_BUFFER_1 + $0a),y
        sta (SCREEN_BUFFER_1 + $0c),y
        iny 
        bne L_4354
        inx 
        cpx #$20
        beq L_4367
        inc SCREEN_BUFFER_1 + $0b
        inc SCREEN_BUFFER_1 + $0d
        jmp L_4354
    L_4367:
        ldx #$00
    L_4369:
        lda L_3f42,x
        sta L_c000,x
        lda $403c,x
        sta $c0fa,x
        lda $4136,x
        sta $c1f4,x
        lda L_4230,x
        sta L_c2ee,x
        inx 
        cpx #$fa
        bne L_4369
        lda #$00
        sta vBorderCol
        jsr L_43ea
    L_438e:
        lda L_432b
        beq L_438e
        rts 


    L_4394:
        ldx #$00
        lda cCia1PortA,x
        and #$10
        bne L_43a3
        jsr L_43d5
        inc L_432b
    L_43a3:
        rts 



    L_43a4:
         .byte $fa,$00,$00
        .byte $ad,$19,$d0,$10,$23,$20,$94,$43,$4c,$b2,$43

    L_43b2:
        ldy L_43a4 + $2
        iny 
    L_43b6:
        lda (SCREEN_BUFFER_1 + $5f),y
        bne L_43be
        ldy #$00
        beq L_43b6
    L_43be:
        sty L_43a4 + $2
        sta vRaster
        lda vScreenControl1
        and #$7f
        sta vScreenControl1
        asl vIRQFlags
    L_43cf:
        pla 
        tay 
        pla 
        tax 
        pla 
        rti 
    L_43d5:
        sei 
        lda #$00
        sta vIRQMasks
        lda #$e7
        sta SCREEN_BUFFER_1 + $314
        lda #$43
        sta SCREEN_BUFFER_1 + $315
        cli 
        rts 


        jmp L_43cf
    L_43ea:
        sei 
        lda #$a7
        sta SCREEN_BUFFER_1 + $314
        lda #$43
        sta SCREEN_BUFFER_1 + $315
        lda #$a4
        sta SCREEN_BUFFER_1 + $5f
        lda #$43
        sta SCREEN_BUFFER_1 + $60
        lda #$01
        sta vIRQMasks
        lda #$7f
        sta cCia1IntControl
        ldy #$00
        sty L_43a4 + $2
        lda (SCREEN_BUFFER_1 + $5f),y
        sta vRaster
        lda vScreenControl1
        and #$7f
        sta vScreenControl1
        cli 
        rts 



        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_454b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$f7,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$f7,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$bf,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$02,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4a3b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$02,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4c4b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4ddb:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4e3b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4e4b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ef,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_4f3b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_502b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_50eb:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_50fb:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_523b:
        .byte $00,$00,$02,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_524b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_531b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_544b:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$f7,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$08,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$80,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_5545:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_5555:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ef,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$bf,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_5935:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_59d5:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$df,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff

    L_5e4f:
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$fd,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_5f59:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_5fd9:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6009:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6039:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6079:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6169:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$80,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6369:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6559:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6569:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6669:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_66d9:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_66f9:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$fb,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $fb,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6e69:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6ee9:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6f49:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_6f59:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7009:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7039:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$20,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$f7,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$20,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff

    L_79c7:
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$04,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$fd,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$20,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00

    L_7e2d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_7ffd:
        .byte $00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_801d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_803d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_809d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_80ed:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$fe,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$01,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8618:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8758:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_87c8:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8818:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8968:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8988:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_8cc8:
        .byte $00,$00,$ff,$fb,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$fd,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff

    L_8fce:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_90fe:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_91be:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$02,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_927e:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_92fe:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$df,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$fb,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_9b8e:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$80,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_9d1e:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$bf,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_9dfe:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff

    L_9e1e:
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        .byte $00,$2a

    L_a000:
        eor $00,x

    L_a002:
         .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a042:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$bf,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a222:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a402:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$fb,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a432:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a442:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a452:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$bf,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a472:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_a4f2:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$fd,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00

    L_a527:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$fe,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a635:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a645:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a655:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a675:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a685:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a6e5:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a935:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_a9f5:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_ab15:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$01,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff

    L_ad7b:
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff

    L_ad9b:
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$01,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_ae8a:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_ae9a:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_aeea:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_aefa:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_b0ca:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_b0da:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_b1aa:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$08
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$40,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$7f,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00

    L_b6a1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$f7,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $04,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b791:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b7f1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b841:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b851:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b861:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_b8d1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_ba21:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$fd,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00

    L_bab7:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bac7:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bb07:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bb97:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bbc7:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bc07:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bc27:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bc97:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$80,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bcc7:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00

    L_bdc7:
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$04,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$01,$00

    L_beba:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_bfaa:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00

    L_c000:
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror $ee6e
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        inc L_6ee9 + $5
        ror L_6ee9 + $5
        inc L_eee7 + $7
        ror L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6ee9 + $5
        ror L_6ee9 + $5
        inc L_eee7 + $7
        inc L_6ee9 + $5
        ror L_eee7 + $7
        ror $ee6e
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        ror L_6ee9 + $5
        ror L_eee7 + $7
        ror L_eee7 + $7
        ror L_eee7 + $7
        inc $ee6e
        inc L_eee7 + $7
        inc $e10e
        sbc (SCREEN_BUFFER_1 + $e1,x)
        asl L_eee7 + $7,x
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        inc L_eee7 + $7
        asl L_0f00 + $110

        .byte $10,$e1,$1e,$ee,$ee,$ee,$1e,$1e,$e9,$9e,$ee,$ee,$ee,$ee,$ee,$ee

    L_c0f0:
        inc L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        ror L_6e69 + $5
        inc L_eee7 + $7
        cpx #$20
        rol 
        rol 
        asl 
        rol 
        inc L_1eee
        sbc (SCREEN_BUFFER_1 + $f1,x)
        sbc (SCREEN_BUFFER_1 + $1e),y
        inc L_eee7 + $7
        inc L_eee7 + $7
        ror L_6e69 + $5
        ror L_eee7 + $7
        ror $ee6e
        inc $ee6e
        inc L_6e69 + $5
        ror $ee6e
        inc L_eee7 + $7
        cpx #$a2
        rol 
        rol 
        tax 
        nop 
        asl L_2ae8 + $2

        .byte $1a,$f1,$f1,$1e,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$ee,$ee
        .byte $6e,$6e,$6e,$6e,$6e,$ee,$ee,$6e,$6e,$6e,$6e,$ee,$ee,$ee,$ee,$ee
        .byte $2e,$2a,$2a,$aa,$2a,$06,$ea,$2a,$aa,$fa,$a1,$ea,$ae,$ee,$ee,$ee
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$6e,$6e,$6e,$6e
        .byte $6e,$6e,$ee,$ee,$ee,$ee,$ee,$6e,$e6,$26,$a6,$6a,$6a,$0a,$e6,$6e
        .byte $2e,$2a,$2a,$2a,$2a,$ea,$ae,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee
        .byte $ee,$6e,$ee,$6e,$6e,$6e,$6e,$ee,$6e,$ee,$ee,$ee,$ee,$ee,$6e,$e6
        .byte $66,$66,$66,$06,$06,$a6,$6a,$6a,$2a,$aa,$aa,$ea,$ae,$aa,$ea,$ae
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$6e,$6e,$6e,$6e,$6e,$6e,$6e
        .byte $6e,$ee,$ee,$ee,$0e,$0e,$0e,$66,$66,$66,$66,$66,$a6,$0a,$aa,$aa
        .byte $aa,$aa,$2a,$ae,$ee,$ae,$aa,$aa,$ae,$ee,$ee,$ee,$ee,$ee,$6e,$6e
        .byte $6e,$ee,$6e,$6e,$ee,$6e,$6e,$6e,$ee,$ee,$0e,$0e,$0e,$0e,$6e,$e6
        .byte $66,$66,$66,$06,$0a,$aa,$aa,$aa,$aa,$6a,$a6,$e6,$6a,$2a,$2a,$aa
        .byte $2a,$ae,$ee,$ee,$ee,$ee,$6e,$6e,$ee,$6e,$6e,$ee,$6e,$6e,$6e,$ee
        .byte $0e,$0e,$0e,$ee,$ee,$ee,$ee,$6e,$e6,$06,$06,$06,$a2,$a2,$6a,$a6
        .byte $a6,$06,$06,$66,$6a,$aa,$2a,$2a,$2e,$ee,$ee,$ee,$ee,$ee,$6e,$6e
        .byte $6e,$6e,$ee,$ee,$6e,$6e,$0e,$0e,$0e,$ee,$ee,$ee,$ee,$ee,$ee,$ee
        .byte $6e,$e6,$06,$06,$06,$06,$66,$06,$06,$66,$06,$26,$2a,$5a,$a5,$25
        .byte $e5,$e5,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$0e,$0e,$0e,$0e,$ee
        .byte $ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$ee,$e6,$66,$66,$06,$06,$06,$06
        .byte $06,$66,$06,$65,$55,$55,$55,$55,$55,$55

    L_c280:
        inc L_eee7 + $7
        inc L_eee7 + $7
        inc L_beba + $4
        asl L_eee7 + $7
        inc L_eee7 + $7
        inc L_eee7 + $7
        lsr L_5e4f + $f,x
        sbc SCREEN_BUFFER_1 + $e5
        adc SCREEN_BUFFER_1 + $e6
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        ror SCREEN_BUFFER_1 + $66
        lsr SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $ee,x
        inc L_eee7 + $7
        inc L_e00e
        ldx L_eee7 + $7,y
        inc L_5e4f + $f
        lsr $e5e5,x
        sbc SCREEN_BUFFER_1 + $e5
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $06,x
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        sbc SCREEN_BUFFER_1 + $e5
        sbc SCREEN_BUFFER_1 + $e5
        ora SCREEN_BUFFER_1 + $b0

        .byte $0c,$5c,$e5,$e5,$e5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55
        .byte $55,$55,$65,$06,$06,$06,$06,$66

    L_c2ee:
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        ora SCREEN_BUFFER_1 + $0b
        ldy L_5555 + $7,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $65,x
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $56
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $cb,x
        cmp SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $06,x
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $65,x
        adc SCREEN_BUFFER_1 + $65
        adc SCREEN_BUFFER_1 + $65
        adc SCREEN_BUFFER_1 + $65
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $06,x
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        ror SCREEN_BUFFER_1 + $66
        adc SCREEN_BUFFER_1 + $55
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $b5,x
        lda SCREEN_BUFFER_1 + $b5,x
        lda SCREEN_BUFFER_1 + $59,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $95,x
        sta SCREEN_BUFFER_1 + $59,x
        sta SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lda SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        lsr SCREEN_BUFFER_1 + $66,x
        ror SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        ldx SCREEN_BUFFER_1 + $b6,y

        .byte $6b,$6b,$5b,$55,$55,$55,$55,$55,$65,$65,$65,$65,$65,$65,$65,$65
        .byte $65,$65,$65,$65,$65,$56,$b5,$5b,$b5,$b5,$b5,$b5,$5b,$b5,$b5,$b5
        .byte $06,$66,$06,$06,$06,$b6,$6b,$bb,$bb,$bb,$5b,$55,$55,$55,$55

    L_c3c0:
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $65,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $65,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        eor SCREEN_BUFFER_1 + $55,x
        ora SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $06
        asl SCREEN_BUFFER_1 + $0b

        .byte $0b,$bb,$bb,$bb,$bb,$b5,$55,$55,$55,$55,$ff

    L_c3e9:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ef,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$08,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$40,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_c8b4:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_c924:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_cb44:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$fb,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $10,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_ceb4:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$02,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_cff4:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc

    L_d06f:
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $3b,$c2,$00,$00,$00,$c8,$00,$09,$70,$f1,$00,$00,$00,$00,$ff,$f0
        .byte $f0,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $400, $0
        .fill $3e7, $e
        .byte $01
        .fill $18, $0
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00,$01,$00,$01,$01,$08

    L_dcc0:
        .byte $7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00
        .byte $01,$00,$01,$01,$08,$7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00
        .byte $01,$00,$01,$01,$08,$7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00
        .byte $01,$00,$01,$01,$08,$7f,$ff,$ff,$00,$a3,$1c,$ff,$04,$00,$00,$00
        .byte $01,$00,$01,$01,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$c4,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08
        .fill $200, $0
        .byte $85,$56,$20,$0f,$bc,$a5,$61,$c9,$88,$90,$03

    L_e00b:
        jsr L_bac7 + $d
    L_e00e:
        jsr L_bcc7 + $5
        lda SCREEN_BUFFER_1 + $07
        clc 
        adc #$81
        beq L_e00b
        sec 
        sbc #$01
        pha 
        ldx #$05
    L_e01e:
        lda SCREEN_BUFFER_1 + $69,x
        ldy SCREEN_BUFFER_1 + $61,x
        sta SCREEN_BUFFER_1 + $61,x
        sty SCREEN_BUFFER_1 + $69,x
        dex 
        bpl L_e01e
        lda SCREEN_BUFFER_1 + $56
        sta SCREEN_BUFFER_1 + $70
        jsr L_b851 + $2
        jsr L_bfaa + $a
        lda #$c4
        ldy #$bf
        jsr L_e059
        lda #$00
        sta SCREEN_BUFFER_1 + $6f
        pla 
        jsr L_bab7 + $2
        rts 


    L_e043:
        sta SCREEN_BUFFER_1 + $71
        sty SCREEN_BUFFER_1 + $72
        jsr L_bbc7 + $3
        lda #$57
        jsr L_ba21 + $7
        jsr L_e05d
        lda #$57
        ldy #$00
        jmp L_ba21 + $7
    L_e059:
        sta SCREEN_BUFFER_1 + $71
        sty SCREEN_BUFFER_1 + $72
    L_e05d:
        jsr L_bbc7
    L_e060:
        lda (SCREEN_BUFFER_1 + $71),y
        sta SCREEN_BUFFER_1 + $67
        ldy SCREEN_BUFFER_1 + $71
        iny 
        tya 
        bne L_e06c
        inc SCREEN_BUFFER_1 + $72
    L_e06c:
        sta SCREEN_BUFFER_1 + $71
        ldy SCREEN_BUFFER_1 + $72
    L_e070:
        jsr L_ba21 + $7
        lda SCREEN_BUFFER_1 + $71
        ldy SCREEN_BUFFER_1 + $72
        clc 
        adc #$05
        bcc L_e07d
        iny 
    L_e07d:
        sta SCREEN_BUFFER_1 + $71
        sty SCREEN_BUFFER_1 + $72
        jsr L_b861 + $6
        lda #$5c
        ldy #$00
        dec SCREEN_BUFFER_1 + $67
        bne L_e070
        rts 



        .byte $98,$35,$44,$7a,$00,$68,$28,$b1,$46,$00,$20,$2b,$bc,$30,$37,$d0
        .byte $20,$20,$f3,$ff,$86,$22,$84,$23

    L_e0a5:
        ldy #$04
        lda (SCREEN_BUFFER_1 + $22),y
        sta SCREEN_BUFFER_1 + $62
        iny 
        lda (SCREEN_BUFFER_1 + $22),y
        sta SCREEN_BUFFER_1 + $64
        ldy #$08
        lda (SCREEN_BUFFER_1 + $22),y
        sta SCREEN_BUFFER_1 + $63
        iny 
        lda (SCREEN_BUFFER_1 + $22),y
        sta SCREEN_BUFFER_1 + $65
        jmp L_e0e3
    L_e0be:
        lda #$8b
        ldy #$00
        jsr L_bb97 + $b
        lda #$8d
        ldy #$e0
        jsr L_ba21 + $7
        lda #$92
        ldy #$e0
        jsr L_b861 + $6
    L_e0d3:
        ldx SCREEN_BUFFER_1 + $65
        lda SCREEN_BUFFER_1 + $62
        sta SCREEN_BUFFER_1 + $65
        stx SCREEN_BUFFER_1 + $62
        ldx SCREEN_BUFFER_1 + $63
        lda SCREEN_BUFFER_1 + $64
        sta SCREEN_BUFFER_1 + $63
        stx SCREEN_BUFFER_1 + $64
    L_e0e3:
        lda #$00
        sta SCREEN_BUFFER_1 + $66
        lda SCREEN_BUFFER_1 + $61
        sta SCREEN_BUFFER_1 + $70
        lda #$80
        sta SCREEN_BUFFER_1 + $61
        jsr L_b8d1 + $6
        ldx #$8b
        ldy #$00
    L_e0f6:
        jmp L_bbc7 + $d
    L_e0f9:
        cmp #$f0
        bne L_e104
        sty SCREEN_BUFFER_1 + $38
        stx SCREEN_BUFFER_1 + $37
        jmp L_a655 + $e
    L_e104:
        tax 
        bne L_e109
        ldx #$1e
    L_e109:
        jmp L_a432 + $5
        jsr L_ffd2
        bcs L_e0f9
        rts 


        jsr L_ffcf
        bcs L_e0f9
        rts 


        jsr $e4ad
        bcs L_e0f9
        rts 


        jsr L_ffc6
        bcs L_e0f9
        rts 


        jsr L_ffe4
        bcs L_e0f9
        rts 


        jsr L_ad7b + $f
        jsr L_b7f1 + $6
        lda #$e1
        pha 
        lda #$46
        pha 
        lda SCREEN_BUFFER_1 + $30f
        pha 
        lda SCREEN_BUFFER_1 + $30c
        ldx SCREEN_BUFFER_1 + $30d
        ldy SCREEN_BUFFER_1 + $30e
        plp 

        .byte $6c,$14,$00,$08,$8d,$0c,$03,$8e,$0d,$03,$8c,$0e,$03,$68,$8d,$0f
        .byte $03,$60,$20,$d4,$e1,$a6,$2d,$a4,$2e,$a9,$2b,$20,$d8,$ff,$b0,$95
        .byte $60,$a9,$01,$2c,$a9,$00,$85,$0a,$20,$d4,$e1,$a5,$0a,$a6,$2b,$a4
        .byte $2c,$20,$d5,$ff,$b0,$57,$a5,$0a,$f0,$17,$a2,$1c,$20,$b7,$ff,$29
        .byte $10,$d0,$17,$a5,$7a,$c9,$02,$f0,$07,$a9,$64,$a0,$a3,$4c,$1e,$ab

    L_e194:
        rts 


    L_e195:
        jsr L_ffb7
        and #$bf
        beq L_e1a1
        ldx #$1d
    L_e19e:
        jmp L_a432 + $5
    L_e1a1:
        lda SCREEN_BUFFER_1 + $7b
        cmp #$02
        bne L_e1b5
        stx SCREEN_BUFFER_1 + $2d
        sty SCREEN_BUFFER_1 + $2e
        lda #$76
        ldy #$a3
        jsr L_ab15 + $9
        jmp L_a527 + $3
    L_e1b5:
        jsr L_a685 + $9
        jsr L_a527 + $c
        jmp L_a675 + $2
        jsr L_e219
        jsr L_ffc0
        bcs L_e1d1
        rts 


        jsr L_e219
        lda SCREEN_BUFFER_1 + $49
        jsr L_ffc3
        bcc L_e194
    L_e1d1:
        jmp L_e0f9
    L_e1d4:
        lda #$00
        jsr L_ffbd
        ldx #$01
        ldy #$00
        jsr L_ffba
        jsr L_e206
        jsr L_e257
        jsr L_e206
        jsr L_e200
        ldy #$00
        stx SCREEN_BUFFER_1 + $49
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        txa 
        tay 
        ldx SCREEN_BUFFER_1 + $49
        jmp L_ffba
    L_e200:
        jsr L_e20e
        jmp L_b791 + $d
    L_e206:
        jsr.a $0079
        bne L_e20d
        pla 
        pla 
    L_e20d:
        rts 


    L_e20e:
        jsr L_aefa + $3
    L_e211:
        jsr.a $0079
        bne L_e20d
        jmp L_aefa + $e
    L_e219:
        lda #$00
        jsr L_ffbd
        jsr L_e211
        jsr L_b791 + $d
        stx SCREEN_BUFFER_1 + $49
        txa 
        ldx #$01
        ldy #$00
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        stx SCREEN_BUFFER_1 + $4a
        ldy #$00
        lda SCREEN_BUFFER_1 + $49
        cpx #$03
        bcc L_e23f
        dey 
    L_e23f:
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        txa 
        tay 
        ldx SCREEN_BUFFER_1 + $4a
        lda SCREEN_BUFFER_1 + $49
        jsr L_ffba
        jsr L_e206
        jsr L_e20e
    L_e257:
        jsr L_ad9b + $3
        jsr L_b6a1 + $2
        ldx SCREEN_BUFFER_1 + $22
        ldy SCREEN_BUFFER_1 + $23
        jmp L_ffbd
        lda #$e0
        ldy #$e2
        jsr L_b861 + $6
    L_e26b:
        jsr L_bc07 + $5
        lda #$e5
        ldy #$e2
        ldx SCREEN_BUFFER_1 + $6e
        jsr L_bb07
        jsr L_bc07 + $5
        jsr L_bcc7 + $5
        lda #$00
        sta SCREEN_BUFFER_1 + $6f
        jsr L_b851 + $2
        lda #$ea
        ldy #$e2
        jsr L_b841 + $f
        lda SCREEN_BUFFER_1 + $66
        pha 
        bpl L_e29d
        jsr L_b841 + $8
        lda SCREEN_BUFFER_1 + $66
        bmi L_e2a0
        lda SCREEN_BUFFER_1 + $12
        eor #$ff
        sta SCREEN_BUFFER_1 + $12
    L_e29d:
        jsr L_bfaa + $a
    L_e2a0:
        lda #$ea
        ldy #$e2
        jsr L_b861 + $6
        pla 
        bpl L_e2ad
        jsr L_bfaa + $a
    L_e2ad:
        lda #$ef
        ldy #$e2
        jmp L_e043
        jsr L_bbc7 + $3
        lda #$00
        sta SCREEN_BUFFER_1 + $12
        jsr L_e26b
        ldx #$4e
        ldy #$00
        jsr L_e0f6
        lda #$57
        ldy #$00
        jsr L_bb97 + $b
        lda #$00
        sta SCREEN_BUFFER_1 + $66
        lda SCREEN_BUFFER_1 + $12
        jsr L_e2dc
        lda #$4e
        ldy #$00
        jmp L_bb07 + $8
    L_e2dc:
        pha 
        jmp L_e29d

        .byte $81,$49,$0f,$da,$a2,$83,$49,$0f,$da,$a2,$7f,$00,$00,$00,$00,$05
        .byte $84,$e6,$1a,$2d,$1b,$86,$28,$07,$fb,$f8,$87,$99,$68,$89,$01,$87
        .byte $23,$35,$df,$e1,$86,$a5,$5d,$e7,$28,$83,$49,$0f,$da,$a2,$a5,$66
        .byte $48,$10,$03,$20,$b4,$bf

    L_e316:
        lda SCREEN_BUFFER_1 + $61
        pha 
        cmp #$81
        bcc L_e324
        lda #$bc
        ldy #$b9
        jsr L_bb07 + $8
    L_e324:
        lda #$3e
        ldy #$e3
        jsr L_e043
        pla 
        cmp #$81
        bcc L_e337
        lda #$e0
        ldy #$e2
        jsr L_b841 + $f
    L_e337:
        pla 
        bpl L_e33d
        jmp L_bfaa + $a
    L_e33d:
        rts 



        .byte $0b,$76,$b3,$83,$bd,$d3,$79,$1e,$f4,$a6,$f5,$7b,$83,$fc,$b0,$10
        .byte $7c,$0c,$1f,$67,$ca,$7c,$de,$53,$cb,$c1,$7d,$14,$64,$70,$4c,$7d
        .byte $b7,$ea,$51,$7a,$7d,$63,$30,$88,$7e,$7e,$92,$44,$99,$3a,$7e,$4c
        .byte $cc,$91,$c7,$7f,$aa,$aa,$aa,$13,$81,$00,$00,$00,$00,$20,$cc,$ff
        .byte $a9,$00,$85,$13,$20,$7a,$a6,$58

    L_e386:
        ldx #$80
        jmp ($0300)
        txa 
        bmi L_e391
        jmp L_a432 + $8
    L_e391:
        jmp L_a472 + $2
        jsr L_e453
        jsr L_e3bf
        jsr L_e422
        ldx #$fb
        txs 
        bne L_e386
    L_e3a2:
        inc SCREEN_BUFFER_1 + $7a
        bne L_e3a8
        inc SCREEN_BUFFER_1 + $7b
    L_e3a8:
        lda $ea60
        cmp #$3a
        bcs L_e3b9
        cmp #$20
        beq L_e3a2
        sec 
        sbc #$30
        sec 
        sbc #$d0
    L_e3b9:
        rts 



        .byte $80,$4f,$c7,$52,$58

    L_e3bf:
        lda #$4c
        sta SCREEN_BUFFER_1 + $54
        sta SCREEN_BUFFER_1 + $310
        lda #$48
        ldy #$b2
        sta SCREEN_BUFFER_1 + $311
        sty SCREEN_BUFFER_1 + $312
        lda #$91
        ldy #$b3
        sta SCREEN_BUFFER_1 + $05
        sty SCREEN_BUFFER_1 + $06
        lda #$aa
        ldy #$b1
        sta SCREEN_BUFFER_1 + $03
        sty SCREEN_BUFFER_1 + $04
        ldx #$1c
    L_e3e2:
        lda L_e3a2,x
        sta SCREEN_BUFFER_1 + $73,x
        dex 
        bpl L_e3e2
        lda #$03
        sta SCREEN_BUFFER_1 + $53
        lda #$00
        sta SCREEN_BUFFER_1 + $68
        sta SCREEN_BUFFER_1 + $13
        sta SCREEN_BUFFER_1 + $18
        ldx #$01
        stx SCREEN_BUFFER_1 + $1fd
        stx SCREEN_BUFFER_1 + $1fc
        ldx #$19
        stx SCREEN_BUFFER_1 + $16
        sec 
        jsr L_ff9c
        stx SCREEN_BUFFER_1 + $2b
        sty SCREEN_BUFFER_1 + $2c
        sec 
        jsr L_ff99
        stx SCREEN_BUFFER_1 + $37
        sty SCREEN_BUFFER_1 + $38
        stx SCREEN_BUFFER_1 + $33
        sty SCREEN_BUFFER_1 + $34
        ldy #$00
        tya 
        sta (SCREEN_BUFFER_1 + $2b),y
        inc SCREEN_BUFFER_1 + $2b
        bne L_e421
        inc SCREEN_BUFFER_1 + $2c
    L_e421:
        rts 


    L_e422:
        lda SCREEN_BUFFER_1 + $2b
        ldy SCREEN_BUFFER_1 + $2c
        jsr L_a402 + $6
        lda #$73
        ldy #$e4
        jsr L_ab15 + $9
        lda SCREEN_BUFFER_1 + $37
        sec 
        sbc SCREEN_BUFFER_1 + $2b
        tax 
        lda SCREEN_BUFFER_1 + $38
        sbc SCREEN_BUFFER_1 + $2c
        jsr L_bdc7 + $6
        lda #$60
        ldy #$e4
        jsr L_ab15 + $9
        jmp L_a635 + $f

    L_e447:
         .byte $8b,$e3,$83
        .byte $a4,$7c,$a5,$1a,$a7,$e4,$a7,$86,$ae

    L_e453:
        ldx #$0b
    L_e455:
        lda L_e447,x
        sta SCREEN_BUFFER_1 + $300,x
        dex 
        bpl L_e455
        rts 



        .byte $00,$20,$42,$41,$53,$49,$43,$20,$42,$59,$54,$45,$53,$20,$46,$52
        .byte $45,$45,$0d,$00,$93

    L_e474:
        ora L_2003 + $1d
        jsr L_2a1b + $5
        rol 
        rol 
        rol 
        jsr L_4f3b + $8

        .byte $4d,$4d,$4f,$44,$4f,$52,$45,$20,$36,$34,$20,$42,$41,$53,$49,$43
        .byte $20,$56,$32,$20,$2a,$2a,$2a,$2a,$0d,$0d,$20,$36,$34,$4b,$20,$52
        .byte $41,$4d,$20,$53,$59,$53,$54,$45,$4d,$20,$20,$00,$81,$48,$20,$c9
        .byte $ff,$aa,$68,$90,$01,$8a

    L_e4b6:
        rts 


        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
    L_e4d3:
        sta SCREEN_BUFFER_1 + $a9
        lda #$01
        sta SCREEN_BUFFER_1 + $ab
        rts 


    L_e4da:
        lda SCREEN_BUFFER_1 + $286
        sta (SCREEN_BUFFER_1 + $f3),y
        rts 


    L_e4e0:
        adc #$02
    L_e4e2:
        ldy SCREEN_BUFFER_1 + $91
        iny 
        bne L_e4eb
        cmp SCREEN_BUFFER_1 + $a1
        bne L_e4e2
    L_e4eb:
        rts 



        .byte $19,$26,$44,$19,$1a,$11,$e8,$0d,$70,$0c,$06,$06,$d1,$02,$37,$01
        .byte $ae,$00,$69,$00

    L_e500:
        ldx #$00
        ldy #$dc
        rts 


    L_e505:
        ldx #$28
        ldy #$19
        rts 


    L_e50a:
        bcs L_e513
        stx SCREEN_BUFFER_1 + $d6
        sty SCREEN_BUFFER_1 + $d3
        jsr L_e56c
    L_e513:
        ldx SCREEN_BUFFER_1 + $d6
        ldy SCREEN_BUFFER_1 + $d3
        rts 


    L_e518:
        jsr L_e5a0
        lda #$00
        sta SCREEN_BUFFER_1 + $291
        sta SCREEN_BUFFER_1 + $cf
        lda #$48
        sta SCREEN_BUFFER_1 + $28f
        lda #$eb
        sta SCREEN_BUFFER_1 + $290
        lda #$0a
        sta SCREEN_BUFFER_1 + $289
        sta SCREEN_BUFFER_1 + $28c
        lda #$0e
        sta SCREEN_BUFFER_1 + $286
        lda #$04
        sta SCREEN_BUFFER_1 + $28b
        lda #$0c
        sta SCREEN_BUFFER_1 + $cd
        sta SCREEN_BUFFER_1 + $cc
    L_e544:
        lda SCREEN_BUFFER_1 + $288
        ora #$80
        tay 
        lda #$00
        tax 
    L_e54d:
        sty SCREEN_BUFFER_1 + $d9,x
        clc 
        adc #$28
        bcc L_e555
        iny 
    L_e555:
        inx 
        cpx #$1a
        bne L_e54d
        lda #$ff
        sta SCREEN_BUFFER_1 + $d9,x
        ldx #$18
    L_e560:
        jsr L_e9ff
        dex 
        bpl L_e560
    L_e566:
        ldy #$00
        sty SCREEN_BUFFER_1 + $d3
        sty SCREEN_BUFFER_1 + $d6
    L_e56c:
        ldx SCREEN_BUFFER_1 + $d6
        lda SCREEN_BUFFER_1 + $d3
    L_e570:
        ldy SCREEN_BUFFER_1 + $d9,x
        bmi L_e57c
        clc 
        adc #$28
        sta SCREEN_BUFFER_1 + $d3
        dex 
        bpl L_e570
    L_e57c:
        jsr L_e9f0
        lda #$27
        inx 
    L_e582:
        ldy SCREEN_BUFFER_1 + $d9,x
        bmi L_e58c
        clc 
        adc #$28
        inx 
        bpl L_e582
    L_e58c:
        sta SCREEN_BUFFER_1 + $d5
        jmp L_ea24
    L_e591:
        cpx SCREEN_BUFFER_1 + $c9
        beq L_e598
        jmp L_e6ed
    L_e598:
        rts 


        nop 
        jsr L_e5a0
        jmp L_e566
    L_e5a0:
        lda #$03
        sta SCREEN_BUFFER_1 + $9a
        lda #$00
        sta SCREEN_BUFFER_1 + $99
        ldx #$2f
    L_e5aa:
        lda L_ecb8,x
        sta L_cff4 + $b,x
        dex 
        bne L_e5aa
        rts 


    L_e5b4:
        ldy SCREEN_BUFFER_1 + $277
        ldx #$00
    L_e5b9:
        lda SCREEN_BUFFER_1 + $278,x
        sta SCREEN_BUFFER_1 + $277,x
        inx 
        cpx SCREEN_BUFFER_1 + $c6
        bne L_e5b9
        dec SCREEN_BUFFER_1 + $c6
        tya 
        cli 
        clc 
        rts 


    L_e5ca:
        jsr L_e716
    L_e5cd:
        lda SCREEN_BUFFER_1 + $c6
        sta SCREEN_BUFFER_1 + $cc
        sta SCREEN_BUFFER_1 + $292
        beq L_e5cd
        sei 
        lda SCREEN_BUFFER_1 + $cf
        beq L_e5e7
        lda SCREEN_BUFFER_1 + $ce
        ldx SCREEN_BUFFER_1 + $287
        ldy #$00
        sty SCREEN_BUFFER_1 + $cf
        jsr L_ea13
    L_e5e7:
        jsr L_e5b4
        cmp #$83
        bne L_e5fe
        ldx #$09
        sei 
        stx SCREEN_BUFFER_1 + $c6
    L_e5f3:
        lda L_ece6,x
        sta SCREEN_BUFFER_1 + $276,x
        dex 
        bne L_e5f3
        beq L_e5cd
    L_e5fe:
        cmp #$0d
        bne L_e5ca
        ldy SCREEN_BUFFER_1 + $d5
        sty SCREEN_BUFFER_1 + $d0
    L_e606:
        lda (SCREEN_BUFFER_1 + $d1),y
        cmp #$20
        bne L_e60f
        dey 
        bne L_e606
    L_e60f:
        iny 
        sty SCREEN_BUFFER_1 + $c8
        ldy #$00
        sty SCREEN_BUFFER_1 + $292
        sty SCREEN_BUFFER_1 + $d3
        sty SCREEN_BUFFER_1 + $d4
        lda SCREEN_BUFFER_1 + $c9
        bmi L_e63a
        ldx SCREEN_BUFFER_1 + $d6
        jsr L_e591
        cpx SCREEN_BUFFER_1 + $c9
        bne L_e63a
        lda SCREEN_BUFFER_1 + $ca
        sta SCREEN_BUFFER_1 + $d3
        cmp SCREEN_BUFFER_1 + $c8
        bcc L_e63a
        bcs L_e65d
    L_e632:
        tya 
        pha 
        txa 
        pha 
        lda SCREEN_BUFFER_1 + $d0
        beq L_e5cd
    L_e63a:
        ldy SCREEN_BUFFER_1 + $d3
        lda (SCREEN_BUFFER_1 + $d1),y
        sta SCREEN_BUFFER_1 + $d7
        and #$3f
        asl SCREEN_BUFFER_1 + $d7
        bit SCREEN_BUFFER_1 + $d7
        bpl L_e64a
        ora #$80
    L_e64a:
        bcc L_e650
        ldx SCREEN_BUFFER_1 + $d4
        bne L_e654
    L_e650:
        bvs L_e654
        ora #$40
    L_e654:
        inc SCREEN_BUFFER_1 + $d3
        jsr L_e684
        cpy SCREEN_BUFFER_1 + $c8
        bne L_e674
    L_e65d:
        lda #$00
        sta SCREEN_BUFFER_1 + $d0
        lda #$0d
        ldx SCREEN_BUFFER_1 + $99
        cpx #$03
        beq L_e66f
        ldx SCREEN_BUFFER_1 + $9a
        cpx #$03
        beq L_e672
    L_e66f:
        jsr L_e716
    L_e672:
        lda #$0d
    L_e674:
        sta SCREEN_BUFFER_1 + $d7
        pla 
        tax 
        pla 
        tay 
        lda SCREEN_BUFFER_1 + $d7
        cmp #$de
        bne L_e682
        lda #$ff
    L_e682:
        clc 
        rts 


    L_e684:
        cmp #$22
        bne L_e690
        lda SCREEN_BUFFER_1 + $d4
        eor #$01
        sta SCREEN_BUFFER_1 + $d4
        lda #$22
    L_e690:
        rts 


    L_e691:
        ora #$40
    L_e693:
        ldx SCREEN_BUFFER_1 + $c7
        beq L_e699
    L_e697:
        ora #$80
    L_e699:
        ldx SCREEN_BUFFER_1 + $d8
        beq L_e69f
        dec SCREEN_BUFFER_1 + $d8
    L_e69f:
        ldx SCREEN_BUFFER_1 + $286
        jsr L_ea13
        jsr L_e6b6
    L_e6a8:
        pla 
        tay 
        lda SCREEN_BUFFER_1 + $d8
        beq L_e6b0
        lsr SCREEN_BUFFER_1 + $d4
    L_e6b0:
        pla 
        tax 
        pla 
        clc 
        cli 
        rts 


    L_e6b6:
        jsr L_e8b3
        inc SCREEN_BUFFER_1 + $d3
        lda SCREEN_BUFFER_1 + $d5
        cmp SCREEN_BUFFER_1 + $d3
        bcs L_e700
        cmp #$4f
        beq L_e6f7
        lda SCREEN_BUFFER_1 + $292
        beq L_e6cd
        jmp L_e967
    L_e6cd:
        ldx SCREEN_BUFFER_1 + $d6
        cpx #$19
        bcc L_e6da
        jsr L_e8ea
        dec SCREEN_BUFFER_1 + $d6
        ldx SCREEN_BUFFER_1 + $d6
    L_e6da:
        asl SCREEN_BUFFER_1 + $d9,x
        lsr SCREEN_BUFFER_1 + $d9,x
        inx 
        lda SCREEN_BUFFER_1 + $d9,x
        ora #$80
        sta SCREEN_BUFFER_1 + $d9,x
        dex 
        lda SCREEN_BUFFER_1 + $d5
        clc 
        adc #$28
        sta SCREEN_BUFFER_1 + $d5
    L_e6ed:
        lda SCREEN_BUFFER_1 + $d9,x
        bmi L_e6f4
        dex 
        bne L_e6ed
    L_e6f4:
        jmp L_e9f0
    L_e6f7:
        dec SCREEN_BUFFER_1 + $d6
        jsr L_e87c
        lda #$00
        sta SCREEN_BUFFER_1 + $d3
    L_e700:
        rts 


    L_e701:
        ldx SCREEN_BUFFER_1 + $d6
        bne L_e70b
        stx SCREEN_BUFFER_1 + $d3
        pla 
        pla 
        bne L_e6a8
    L_e70b:
        dex 
        stx SCREEN_BUFFER_1 + $d6
        jsr L_e56c
        ldy SCREEN_BUFFER_1 + $d5
        sty SCREEN_BUFFER_1 + $d3
        rts 


    L_e716:
        pha 
        sta SCREEN_BUFFER_1 + $d7
        txa 
        pha 
        tya 
        pha 
        lda #$00
        sta SCREEN_BUFFER_1 + $d0
        ldy SCREEN_BUFFER_1 + $d3
        lda SCREEN_BUFFER_1 + $d7
        bpl L_e72a
        jmp L_e7d4
    L_e72a:
        cmp #$0d
        bne L_e731
        jmp L_e891
    L_e731:
        cmp #$20
        bcc L_e745
        cmp #$60
        bcc L_e73d
        and #$df
        bne L_e73f
    L_e73d:
        and #$3f
    L_e73f:
        jsr L_e684
        jmp L_e693
    L_e745:
        ldx SCREEN_BUFFER_1 + $d8
        beq L_e74c
        jmp L_e697
    L_e74c:
        cmp #$14
        bne L_e77e
        tya 
        bne L_e759
        jsr L_e701
        jmp L_e773
    L_e759:
        jsr L_e8a1
        dey 
        sty SCREEN_BUFFER_1 + $d3
        jsr L_ea24
    L_e762:
        iny 
        lda (SCREEN_BUFFER_1 + $d1),y
        dey 
        sta (SCREEN_BUFFER_1 + $d1),y
        iny 
        lda (SCREEN_BUFFER_1 + $f3),y
        dey 
        sta (SCREEN_BUFFER_1 + $f3),y
        iny 
        cpy SCREEN_BUFFER_1 + $d5
        bne L_e762
    L_e773:
        lda #$20
        sta (SCREEN_BUFFER_1 + $d1),y
        lda SCREEN_BUFFER_1 + $286
        sta (SCREEN_BUFFER_1 + $f3),y
        bpl L_e7cb
    L_e77e:
        ldx SCREEN_BUFFER_1 + $d4
        beq L_e785
        jmp L_e697
    L_e785:
        cmp #$12
        bne L_e78b
        sta SCREEN_BUFFER_1 + $c7
    L_e78b:
        cmp #$13
        bne L_e792
        jsr L_e566
    L_e792:
        cmp #$1d
        bne L_e7ad
        iny 
        jsr L_e8b3
        sty SCREEN_BUFFER_1 + $d3
        dey 
        cpy SCREEN_BUFFER_1 + $d5
        bcc L_e7aa
        dec SCREEN_BUFFER_1 + $d6
        jsr L_e87c
        ldy #$00
    L_e7a8:
        sty SCREEN_BUFFER_1 + $d3
    L_e7aa:
        jmp L_e6a8
    L_e7ad:
        cmp #$11
        bne L_e7ce
        clc 
        tya 
        adc #$28
        tay 
        inc SCREEN_BUFFER_1 + $d6
        cmp SCREEN_BUFFER_1 + $d5
        bcc L_e7a8
        beq L_e7a8
        dec SCREEN_BUFFER_1 + $d6
    L_e7c0:
        sbc #$28
        bcc L_e7c8
        sta SCREEN_BUFFER_1 + $d3
        bne L_e7c0
    L_e7c8:
        jsr L_e87c
    L_e7cb:
        jmp L_e6a8
    L_e7ce:
        jsr L_e8cb
        jmp L_ec44
    L_e7d4:
        and #$7f
        cmp #$7f
        bne L_e7dc
        lda #$5e
    L_e7dc:
        cmp #$20
        bcc L_e7e3
        jmp L_e691
    L_e7e3:
        cmp #$0d
        bne L_e7ea
        jmp L_e891
    L_e7ea:
        ldx SCREEN_BUFFER_1 + $d4
        bne L_e82d
        cmp #$14
        bne L_e829
        ldy SCREEN_BUFFER_1 + $d5
        lda (SCREEN_BUFFER_1 + $d1),y
        cmp #$20
        bne L_e7fe
        cpy SCREEN_BUFFER_1 + $d3
        bne L_e805
    L_e7fe:
        cpy #$4f
        beq L_e826
        jsr L_e965
    L_e805:
        ldy SCREEN_BUFFER_1 + $d5
        jsr L_ea24
    L_e80a:
        dey 
        lda (SCREEN_BUFFER_1 + $d1),y
        iny 
        sta (SCREEN_BUFFER_1 + $d1),y
        dey 
        lda (SCREEN_BUFFER_1 + $f3),y
        iny 
        sta (SCREEN_BUFFER_1 + $f3),y
        dey 
        cpy SCREEN_BUFFER_1 + $d3
        bne L_e80a
        lda #$20
        sta (SCREEN_BUFFER_1 + $d1),y
        lda SCREEN_BUFFER_1 + $286
        sta (SCREEN_BUFFER_1 + $f3),y
        inc SCREEN_BUFFER_1 + $d8
    L_e826:
        jmp L_e6a8
    L_e829:
        ldx SCREEN_BUFFER_1 + $d8
        beq L_e832
    L_e82d:
        ora #$40
        jmp L_e697
    L_e832:
        cmp #$11
        bne L_e84c
        ldx SCREEN_BUFFER_1 + $d6
        beq L_e871
        dec SCREEN_BUFFER_1 + $d6
        lda SCREEN_BUFFER_1 + $d3
        sec 
        sbc #$28
        bcc L_e847
        sta SCREEN_BUFFER_1 + $d3
        bpl L_e871
    L_e847:
        jsr L_e56c
        bne L_e871
    L_e84c:
        cmp #$12
        bne L_e854
        lda #$00
        sta SCREEN_BUFFER_1 + $c7
    L_e854:
        cmp #$1d
        bne L_e86a
        tya 
        beq L_e864
        jsr L_e8a1
        dey 
        sty SCREEN_BUFFER_1 + $d3
        jmp L_e6a8
    L_e864:
        jsr L_e701
        jmp L_e6a8
    L_e86a:
        cmp #$13
        bne L_e874
        jsr L_e544
    L_e871:
        jmp L_e6a8
    L_e874:
        ora #$80
        jsr L_e8cb
        jmp L_ec4f
    L_e87c:
        lsr SCREEN_BUFFER_1 + $c9
        ldx SCREEN_BUFFER_1 + $d6
    L_e880:
        inx 
        cpx #$19
        bne L_e888
        jsr L_e8ea
    L_e888:
        lda SCREEN_BUFFER_1 + $d9,x
        bpl L_e880
        stx SCREEN_BUFFER_1 + $d6
        jmp L_e56c
    L_e891:
        ldx #$00
        stx SCREEN_BUFFER_1 + $d8
        stx SCREEN_BUFFER_1 + $c7
        stx SCREEN_BUFFER_1 + $d4
        stx SCREEN_BUFFER_1 + $d3
        jsr L_e87c
        jmp L_e6a8
    L_e8a1:
        ldx #$02
        lda #$00
    L_e8a5:
        cmp SCREEN_BUFFER_1 + $d3
        beq L_e8b0
        clc 
        adc #$28
        dex 
        bne L_e8a5
        rts 


    L_e8b0:
        dec SCREEN_BUFFER_1 + $d6
        rts 


    L_e8b3:
        ldx #$02
        lda #$27
    L_e8b7:
        cmp SCREEN_BUFFER_1 + $d3
        beq L_e8c2
        clc 
        adc #$28
        dex 
        bne L_e8b7
        rts 


    L_e8c2:
        ldx SCREEN_BUFFER_1 + $d6
        cpx #$19
        beq L_e8ca
        inc SCREEN_BUFFER_1 + $d6
    L_e8ca:
        rts 


    L_e8cb:
        ldx #$0f
    L_e8cd:
        cmp L_e8da,x
        beq L_e8d6
        dex 
        bpl L_e8cd
        rts 


    L_e8d6:
        stx SCREEN_BUFFER_1 + $286
        rts 



    L_e8da:
         .byte $90,$05,$1c,$9f,$9c
        .byte $1e,$1f,$9e,$81,$95,$96,$97,$98,$99,$9a,$9b

    L_e8ea:
        lda SCREEN_BUFFER_1 + $ac
        pha 
        lda SCREEN_BUFFER_1 + $ad
        pha 
        lda SCREEN_BUFFER_1 + $ae
        pha 
        lda SCREEN_BUFFER_1 + $af
        pha 
    L_e8f6:
        ldx #$ff
        dec SCREEN_BUFFER_1 + $d6
        dec SCREEN_BUFFER_1 + $c9
        dec SCREEN_BUFFER_1 + $2a5
    L_e8ff:
        inx 
        jsr L_e9f0
        cpx #$18
        bcs L_e913
        lda L_ecf1,x
        sta SCREEN_BUFFER_1 + $ac
        lda SCREEN_BUFFER_1 + $da,x
        jsr L_e9c8
        bmi L_e8ff
    L_e913:
        jsr L_e9ff
        ldx #$00
    L_e918:
        lda SCREEN_BUFFER_1 + $d9,x
        and #$7f
        ldy SCREEN_BUFFER_1 + $da,x
        bpl L_e922
        ora #$80
    L_e922:
        sta SCREEN_BUFFER_1 + $d9,x
        inx 
        cpx #$18
        bne L_e918
        lda SCREEN_BUFFER_1 + $f1
        ora #$80
        sta SCREEN_BUFFER_1 + $f1
        lda SCREEN_BUFFER_1 + $d9
        bpl L_e8f6
        inc SCREEN_BUFFER_1 + $d6
        inc SCREEN_BUFFER_1 + $2a5
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        cmp #$fb
        php 
        lda #$7f
        sta cCia1PortA
        plp 
        bne L_e956
        ldy #$00
    L_e94d:
        nop 
        dex 
        bne L_e94d
        dey 
        bne L_e94d
        sty SCREEN_BUFFER_1 + $c6
    L_e956:
        ldx SCREEN_BUFFER_1 + $d6
    L_e958:
        pla 
        sta SCREEN_BUFFER_1 + $af
        pla 
        sta SCREEN_BUFFER_1 + $ae
        pla 
        sta SCREEN_BUFFER_1 + $ad
        pla 
        sta SCREEN_BUFFER_1 + $ac
        rts 


    L_e965:
        ldx SCREEN_BUFFER_1 + $d6
    L_e967:
        inx 
        lda SCREEN_BUFFER_1 + $d9,x
        bpl L_e967
        stx SCREEN_BUFFER_1 + $2a5
        cpx #$18
        beq L_e981
        bcc L_e981
        jsr L_e8ea
        ldx SCREEN_BUFFER_1 + $2a5
        dex 
        dec SCREEN_BUFFER_1 + $d6
        jmp L_e6da
    L_e981:
        lda SCREEN_BUFFER_1 + $ac
        pha 
        lda SCREEN_BUFFER_1 + $ad
        pha 
        lda SCREEN_BUFFER_1 + $ae
        pha 
        lda SCREEN_BUFFER_1 + $af
        pha 
        ldx #$19
    L_e98f:
        dex 
        jsr L_e9f0
        cpx SCREEN_BUFFER_1 + $2a5
        bcc L_e9a6
        beq L_e9a6
        lda $ecef,x
        sta SCREEN_BUFFER_1 + $ac
        lda SCREEN_BUFFER_1 + $d8,x
        jsr L_e9c8
        bmi L_e98f
    L_e9a6:
        jsr L_e9ff
        ldx #$17
    L_e9ab:
        cpx SCREEN_BUFFER_1 + $2a5
        bcc L_e9bf
        lda SCREEN_BUFFER_1 + $da,x
        and #$7f
        ldy SCREEN_BUFFER_1 + $d9,x
        bpl L_e9ba
        ora #$80
    L_e9ba:
        sta SCREEN_BUFFER_1 + $da,x
        dex 
        bne L_e9ab
    L_e9bf:
        ldx SCREEN_BUFFER_1 + $2a5
        jsr L_e6da
        jmp L_e958
    L_e9c8:
        and #$03
        ora SCREEN_BUFFER_1 + $288
        sta SCREEN_BUFFER_1 + $ad
        jsr L_e9e0
        ldy #$27
    L_e9d4:
        lda (SCREEN_BUFFER_1 + $ac),y
        sta (SCREEN_BUFFER_1 + $d1),y
        lda (SCREEN_BUFFER_1 + $ae),y
        sta (SCREEN_BUFFER_1 + $f3),y
        dey 
        bpl L_e9d4
        rts 


    L_e9e0:
        jsr L_ea24
        lda SCREEN_BUFFER_1 + $ac
        sta SCREEN_BUFFER_1 + $ae
        lda SCREEN_BUFFER_1 + $ad
        and #$03
        ora #$d8
        sta SCREEN_BUFFER_1 + $af
        rts 


    L_e9f0:
        lda $ecf0,x
        sta SCREEN_BUFFER_1 + $d1
        lda SCREEN_BUFFER_1 + $d9,x
        and #$03
        ora SCREEN_BUFFER_1 + $288
        sta SCREEN_BUFFER_1 + $d2
        rts 


    L_e9ff:
        ldy #$27
        jsr L_e9f0
        jsr L_ea24
    L_ea07:
        jsr L_e4da
        lda #$20
        sta (SCREEN_BUFFER_1 + $d1),y
        dey 
        bpl L_ea07
        rts 


        nop 
    L_ea13:
        tay 
        lda #$02
        sta SCREEN_BUFFER_1 + $cd
        jsr L_ea24
        tya 
    L_ea1c:
        ldy SCREEN_BUFFER_1 + $d3
        sta (SCREEN_BUFFER_1 + $d1),y
        txa 
        sta (SCREEN_BUFFER_1 + $f3),y
        rts 


    L_ea24:
        lda SCREEN_BUFFER_1 + $d1
        sta SCREEN_BUFFER_1 + $f3
        lda SCREEN_BUFFER_1 + $d2
        and #$03
        ora #$d8
        sta SCREEN_BUFFER_1 + $f4
        rts 


        jsr L_ffea
        lda SCREEN_BUFFER_1 + $cc
        bne L_ea61
        dec SCREEN_BUFFER_1 + $cd
        bne L_ea61
        lda #$14
        sta SCREEN_BUFFER_1 + $cd
        ldy SCREEN_BUFFER_1 + $d3
        lsr SCREEN_BUFFER_1 + $cf
        ldx SCREEN_BUFFER_1 + $287
        lda (SCREEN_BUFFER_1 + $d1),y
        bcs L_ea5c
        inc SCREEN_BUFFER_1 + $cf
        sta SCREEN_BUFFER_1 + $ce
        jsr L_ea24
        lda (SCREEN_BUFFER_1 + $f3),y
        sta SCREEN_BUFFER_1 + $287
        ldx SCREEN_BUFFER_1 + $286
        lda SCREEN_BUFFER_1 + $ce
    L_ea5c:
        eor #$80
        jsr L_ea1c
    L_ea61:
        lda SCREEN_BUFFER_1 + $01
        and #$10
        beq L_ea71
        ldy #$00
        sty SCREEN_BUFFER_1 + $c0
        lda SCREEN_BUFFER_1 + $01
        ora #$20
        bne L_ea79
    L_ea71:
        lda SCREEN_BUFFER_1 + $c0
        bne L_ea7b
        lda SCREEN_BUFFER_1 + $01
        and #$1f
    L_ea79:
        sta SCREEN_BUFFER_1 + $01
    L_ea7b:
        jsr L_ea87
        lda cCia1IntControl
        pla 
        tay 
        pla 
        tax 
        pla 
        rti 
    L_ea87:
        lda #$00
        sta SCREEN_BUFFER_1 + $28d
        ldy #$40
        sty SCREEN_BUFFER_1 + $cb
        sta cCia1PortA
        ldx cCia1PortB
        cpx #$ff
        beq L_eafb
        tay 
        lda #$81
        sta SCREEN_BUFFER_1 + $f5
        lda #$eb
        sta SCREEN_BUFFER_1 + $f6
        lda #$fe
        sta cCia1PortA
    L_eaa8:
        ldx #$08
    L_eaaa:
        pha 
    L_eaab:
        lda cCia1PortB
        cmp cCia1PortB
        bne L_eaab
    L_eab3:
        lsr 
        bcs L_eacc
        pha 
    L_eab7:
        lda (SCREEN_BUFFER_1 + $f5),y
        cmp #$05
        bcs L_eac9
        cmp #$03
        beq L_eac9
        ora SCREEN_BUFFER_1 + $28d
        sta SCREEN_BUFFER_1 + $28d
        bpl L_eacb
    L_eac9:
        sty SCREEN_BUFFER_1 + $cb
    L_eacb:
        pla 
    L_eacc:
        iny 
        cpy #$41
        bcs L_eadc
        dex 
        bne L_eab3
        sec 
        pla 
        rol 
        sta cCia1PortA
        bne L_eaa8
    L_eadc:
        pla 
        jmp ($028f)
    L_eae0:
        ldy SCREEN_BUFFER_1 + $cb
        lda (SCREEN_BUFFER_1 + $f5),y
        tax 
        cpy SCREEN_BUFFER_1 + $c5
        beq L_eaf0
        ldy #$10
        sty SCREEN_BUFFER_1 + $28c
        bne L_eb26
    L_eaf0:
        and #$7f
        bit SCREEN_BUFFER_1 + $28a
        bmi L_eb0d
        bvs L_eb42
        cmp #$7f
    L_eafb:
        beq L_eb26
        cmp #$14
        beq L_eb0d
        cmp #$20
        beq L_eb0d
        cmp #$1d
        beq L_eb0d
        cmp #$11
        bne L_eb42
    L_eb0d:
        ldy SCREEN_BUFFER_1 + $28c
        beq L_eb17
        dec SCREEN_BUFFER_1 + $28c
        bne L_eb42
    L_eb17:
        dec SCREEN_BUFFER_1 + $28b
        bne L_eb42
        ldy #$04
        sty SCREEN_BUFFER_1 + $28b
        ldy SCREEN_BUFFER_1 + $c6
        dey 
        bpl L_eb42
    L_eb26:
        ldy SCREEN_BUFFER_1 + $cb
        sty SCREEN_BUFFER_1 + $c5
        ldy SCREEN_BUFFER_1 + $28d
        sty SCREEN_BUFFER_1 + $28e
        cpx #$ff
        beq L_eb42
        txa 
        ldx SCREEN_BUFFER_1 + $c6
        cpx SCREEN_BUFFER_1 + $289
        bcs L_eb42
        sta SCREEN_BUFFER_1 + $277,x
        inx 
        stx SCREEN_BUFFER_1 + $c6
    L_eb42:
        lda #$7f
        sta cCia1PortA
        rts 


        lda SCREEN_BUFFER_1 + $28d
        cmp #$03
        bne L_eb64
        cmp SCREEN_BUFFER_1 + $28e
        beq L_eb42
        lda SCREEN_BUFFER_1 + $291
        bmi L_eb76
        lda vMemControl
        eor #$02
        sta vMemControl
        jmp L_eb76
    L_eb64:
        asl 
        cmp #$08
        bcc L_eb6b
        lda #$06
    L_eb6b:
        tax 
        lda L_eb79,x
        sta SCREEN_BUFFER_1 + $f5
        lda L_eb79 + $1,x
        sta SCREEN_BUFFER_1 + $f6
    L_eb76:
        jmp L_eae0

    L_eb79:
         .byte $81,$eb,$c2,$eb,$03
        .byte $ec,$78,$ec,$14,$0d,$1d,$88,$85,$86,$87,$11,$33,$57,$41,$34,$5a
        .byte $53,$45,$01,$35,$52,$44,$36,$43,$46,$54,$58,$37,$59,$47,$38,$42
        .byte $48,$55,$56,$39,$49,$4a,$30,$4d,$4b,$4f,$4e,$2b,$50,$4c,$2d,$2e
        .byte $3a,$40,$2c,$5c,$2a,$3b,$13,$01,$3d,$5e,$2f,$31,$5f,$04,$32,$20
        .byte $02,$51,$03,$ff,$94,$8d,$9d,$8c,$89,$8a,$8b,$91,$23,$d7,$c1,$24
        .byte $da,$d3,$c5,$01,$25,$d2,$c4,$26,$c3,$c6,$d4,$d8,$27,$d9,$c7,$28
        .byte $c2,$c8,$d5,$d6,$29,$c9,$ca,$30,$cd,$cb,$cf,$ce,$db,$d0,$cc,$dd
        .byte $3e,$5b,$ba,$3c,$a9,$c0,$5d,$93,$01,$3d,$de,$3f,$21,$5f,$04,$22
        .byte $a0,$02,$d1,$83,$ff,$94,$8d,$9d,$8c,$89,$8a,$8b,$91,$96,$b3,$b0
        .byte $97,$ad,$ae,$b1,$01,$98,$b2,$ac,$99,$bc,$bb,$a3,$bd,$9a,$b7,$a5
        .byte $9b,$bf,$b4,$b8,$be,$29,$a2,$b5,$30,$a7,$a1,$b9,$aa,$a6,$af,$b6
        .byte $dc,$3e,$5b,$a4,$3c,$a8,$df,$5d,$93,$01,$3d,$de,$3f,$81,$5f,$04
        .byte $95,$a0,$02,$ab,$83,$ff

    L_ec44:
        cmp #$0e
        bne L_ec4f
        lda vMemControl
        ora #$02
        bne L_ec58
    L_ec4f:
        cmp #$8e
        bne L_ec5e
        lda vMemControl
        and #$fd
    L_ec58:
        sta vMemControl
    L_ec5b:
        jmp L_e6a8
    L_ec5e:
        cmp #$08
        bne L_ec69
        lda #$80
        ora SCREEN_BUFFER_1 + $291
        bmi L_ec72
    L_ec69:
        cmp #$09
        bne L_ec5b
        lda #$7f
        and SCREEN_BUFFER_1 + $291
    L_ec72:
        sta SCREEN_BUFFER_1 + $291
        jmp L_e6a8

    L_ec78:
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$1c,$17
        .byte $01,$9f,$1a,$13,$05,$ff,$9c,$12,$04,$1e,$03,$06,$14,$18,$1f,$19
        .byte $07,$9e,$02,$08,$15,$16,$12,$09,$0a,$92,$0d,$0b,$0f,$0e,$ff,$10
        .byte $0c,$ff,$ff,$1b,$00,$ff,$1c,$ff,$1d,$ff,$ff,$1f,$1e,$ff,$90,$06
        .byte $ff,$05,$ff,$ff,$11,$ff

    L_ecb8:
        .byte $ff
        .fill $11, $0
        .byte $9b,$37,$00,$00,$00,$08,$00,$14,$0f,$00,$00,$00,$00,$00,$00,$0e
        .byte $06,$01,$02,$03,$04,$00,$01,$02,$03,$04,$05,$06

    L_ece6:
        .byte $07
        .byte $4c,$4f,$41,$44,$0d,$52,$55,$4e,$0d,$00

    L_ecf1:
        plp 
        bvc L_ed62 + $a
        ldy #$c8

        .byte $f0,$18,$40,$68,$90,$b8

    L_ecfc:
        cpx #$08
        bmi L_ed58

        .byte $80,$a8,$d0,$f8,$20,$48,$70,$98,$c0,$09,$40,$2c,$09,$20,$20,$a4
        .byte $f0

    L_ed11:
        pha 
        bit SCREEN_BUFFER_1 + $94
        bpl L_ed20
        sec 
        ror SCREEN_BUFFER_1 + $a3
        jsr L_ed40
        lsr SCREEN_BUFFER_1 + $94
        lsr SCREEN_BUFFER_1 + $a3
    L_ed20:
        pla 
        sta SCREEN_BUFFER_1 + $95
        sei 
        jsr L_ee97
        cmp #$3f
        bne L_ed2e
        jsr L_ee85
    L_ed2e:
        lda cCia2PortA
        ora #$08
        sta cCia2PortA
    L_ed36:
        sei 
        jsr L_ee8e
        jsr L_ee97
        jsr L_eeb3
    L_ed40:
        sei 
        jsr L_ee97
        jsr L_eea9
        bcs L_edad
        jsr L_ee85
        bit SCREEN_BUFFER_1 + $a3
        bpl L_ed5a
    L_ed50:
        jsr L_eea9
        bcc L_ed50
    L_ed55:
        jsr L_eea9
    L_ed58:
        bcs L_ed55
    L_ed5a:
        jsr L_eea9
        bcc L_ed5a
        jsr L_ee8e

    L_ed62:
         .byte $a9,$08,$85,$a5,$ad,$00,$dd,$cd,$00,$dd,$d0,$f8,$0a,$90,$3f
        .byte $66,$95,$b0,$05,$20,$a0,$ee,$d0,$03

    L_ed7a:
        jsr L_ee97
    L_ed7d:
        jsr L_ee85

        .byte $ea,$ea,$ea,$ea,$ad,$00,$dd,$29,$df,$09,$10,$8d,$00,$dd,$c6,$a5

    L_ed90:
        .byte $d0,$d4,$a9,$04,$8d,$07,$dc,$a9,$19,$8d,$0f,$dc,$ad,$0d,$dc,$ad
        .byte $0d,$dc,$29,$02,$d0,$0a,$20,$a9,$ee,$b0,$f4,$58,$60

    L_edad:
        lda #$80
        bit SCREEN_BUFFER_1 + $3a9
    L_edb2:
        jsr L_fe1c
        cli 
        clc 
        bcc L_ee03
    L_edb9:
        sta SCREEN_BUFFER_1 + $95
        jsr L_ed36
    L_edbe:
        lda cCia2PortA
        and #$f7
        sta cCia2PortA
        rts 


    L_edc7:
        sta SCREEN_BUFFER_1 + $95
        jsr L_ed36
    L_edcc:
        sei 
        jsr L_eea0
        jsr L_edbe
        jsr L_ee85
    L_edd6:
        jsr L_eea9
        bmi L_edd6
        cli 
        rts 


    L_eddd:
        bit SCREEN_BUFFER_1 + $94
        bmi L_ede6
        sec 
        ror SCREEN_BUFFER_1 + $94
        bne L_edeb
    L_ede6:
        pha 
        jsr L_ed40
        pla 
    L_edeb:
        sta SCREEN_BUFFER_1 + $95
    L_eded:
        clc 
        rts 


    L_edef:
        sei 
        jsr L_ee8e
        lda cCia2PortA
        ora #$08
        sta cCia2PortA
        lda #$5f
        bit $3fa9
        jsr L_ed11
    L_ee03:
        jsr L_edbe
    L_ee06:
        txa 
        ldx #$0a
    L_ee09:
        dex 
        bne L_ee09
        tax 
        jsr L_ee85
        jmp L_ee97
    L_ee13:
        sei 
        lda #$00
        sta SCREEN_BUFFER_1 + $a5
        jsr L_ee85
    L_ee1b:
        jsr L_eea9
        bpl L_ee1b
    L_ee20:
        lda #$01
        sta cCia1TimerBHi
        lda #$19
        sta cCia1TimerbControl
        jsr L_ee97
        lda cCia1IntControl
    L_ee30:
        lda cCia1IntControl
        and #$02
        bne L_ee3e
        jsr L_eea9
        bmi L_ee30
        bpl L_ee56
    L_ee3e:
        lda SCREEN_BUFFER_1 + $a5
        beq L_ee47
        lda #$02
        jmp L_edb2
    L_ee47:
        jsr L_eea0
        jsr L_ee85
        lda #$40
        jsr L_fe1c
        inc SCREEN_BUFFER_1 + $a5
        bne L_ee20
    L_ee56:
        lda #$08
        sta SCREEN_BUFFER_1 + $a5
    L_ee5a:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_ee5a
        asl 
        bpl L_ee5a
        ror SCREEN_BUFFER_1 + $a4
    L_ee67:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_ee67
        asl 
        bmi L_ee67
        dec SCREEN_BUFFER_1 + $a5
        bne L_ee5a
        jsr L_eea0
        bit SCREEN_BUFFER_1 + $90
        bvc L_ee80
        jsr L_ee06
    L_ee80:
        lda SCREEN_BUFFER_1 + $a4
        cli 
        clc 
        rts 


    L_ee85:
        lda cCia2PortA
        and #$ef
        sta cCia2PortA
        rts 


    L_ee8e:
        lda cCia2PortA
        ora #$10
        sta cCia2PortA
        rts 


    L_ee97:
        lda cCia2PortA
        and #$df
        sta cCia2PortA
        rts 


    L_eea0:
        lda cCia2PortA
        ora #$20
        sta cCia2PortA
        rts 


    L_eea9:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_eea9
        asl 
        rts 


    L_eeb3:
        txa 
        ldx #$b8
    L_eeb6:
        dex 
        bne L_eeb6
        tax 
        rts 


    L_eebb:
        lda SCREEN_BUFFER_1 + $b4
        beq L_eef7 + $f
        bmi L_eef7 + $9
        lsr SCREEN_BUFFER_1 + $b6
        ldx #$00
        bcc L_eec8
        dex 
    L_eec8:
        txa 
        eor SCREEN_BUFFER_1 + $bd
        sta SCREEN_BUFFER_1 + $bd
        dec SCREEN_BUFFER_1 + $b4
        beq L_eed7
        txa 
        and #$04
        sta SCREEN_BUFFER_1 + $b5
        rts 



    L_eed7:
         .byte $a9,$20,$2c,$94,$02,$f0,$14,$30,$1c,$70,$14,$a5,$bd,$d0,$01,$ca

    L_eee7:
        .byte $c6,$b4,$ad,$93,$02,$10,$e3,$c6,$b4,$d0,$df,$e6,$b4,$d0,$f0,$a5

    L_eef7:
        .byte $bd,$f0,$ed,$d0,$ea,$70,$e9,$50,$e6,$e6,$b4,$a2,$ff,$d0,$cb,$ad
        .byte $94,$02,$4a,$90,$07,$2c,$01,$dd,$10,$1d,$50,$1e,$a9,$00,$85,$bd
        .byte $85,$b5,$ae,$98,$02,$86,$b4,$ac,$9d,$02,$cc,$9e,$02,$f0,$13,$b1
        .byte $f9

    L_ef28:
        sta SCREEN_BUFFER_1 + $b6
        inc SCREEN_BUFFER_1 + $29d
        rts 


        lda #$40
        bit $10a9
        ora SCREEN_BUFFER_1 + $297
        sta SCREEN_BUFFER_1 + $297
    L_ef39:
        lda #$01
    L_ef3b:
        sta cCia2IntControl
        eor SCREEN_BUFFER_1 + $2a1
        ora #$80
        sta SCREEN_BUFFER_1 + $2a1
        sta cCia2IntControl
        rts 


    L_ef4a:
        ldx #$09
        lda #$20
        bit SCREEN_BUFFER_1 + $293
        beq L_ef54
        dex 
    L_ef54:
        bvc L_ef58
        dex 
        dex 
    L_ef58:
        rts 


    L_ef59:
        ldx SCREEN_BUFFER_1 + $a9
        bne L_ef90
        dec SCREEN_BUFFER_1 + $a8
        beq L_ef97
        bmi L_ef70
        lda SCREEN_BUFFER_1 + $a7
        eor SCREEN_BUFFER_1 + $ab
        sta SCREEN_BUFFER_1 + $ab
        lsr SCREEN_BUFFER_1 + $a7
        ror SCREEN_BUFFER_1 + $aa
    L_ef6d:
        rts 


    L_ef6e:
        dec SCREEN_BUFFER_1 + $a8
    L_ef70:
        lda SCREEN_BUFFER_1 + $a7
        beq L_efdb
        lda SCREEN_BUFFER_1 + $293
        asl 
        lda #$01
        adc SCREEN_BUFFER_1 + $a8
        bne L_ef6d
    L_ef7e:
        lda #$90
        sta cCia2IntControl
        ora SCREEN_BUFFER_1 + $2a1
        sta SCREEN_BUFFER_1 + $2a1
        sta SCREEN_BUFFER_1 + $a9
        lda #$02
        jmp L_ef3b
    L_ef90:
        lda SCREEN_BUFFER_1 + $a7
        bne L_ef7e
        jmp L_e4d3

    L_ef97:
         .byte $ac,$9b,$02,$c8,$cc,$9c,$02,$f0,$2a
        .byte $8c,$9b,$02,$88,$a5,$aa,$ae,$98,$02

    L_efa9:
        cpx #$09
        beq L_efb1
        lsr 
        inx 
        bne L_efa9
    L_efb1:
        sta (SCREEN_BUFFER_1 + $f7),y
        lda #$20
        bit SCREEN_BUFFER_1 + $294
        beq L_ef6e
        bmi L_ef6d
        lda SCREEN_BUFFER_1 + $a7
        eor SCREEN_BUFFER_1 + $ab

        .byte $f0,$03,$70,$a9,$2c,$50,$a6,$a9,$01,$2c,$a9,$04,$2c,$a9,$80,$2c
        .byte $a9,$02,$0d,$97,$02,$8d,$97,$02,$4c,$7e,$ef

    L_efdb:
        .byte $a5,$aa,$d0,$f1,$f0,$ec

    L_efe1:
        sta SCREEN_BUFFER_1 + $9a
        lda SCREEN_BUFFER_1 + $294
        lsr 
        bcc L_f012
        lda #$02
        bit cCia2PortB
        bpl L_f00d
        bne L_f012
    L_eff2:
        lda SCREEN_BUFFER_1 + $2a1
        and #$02
        bne L_eff2
    L_eff9:
        bit cCia2PortB
        bvs L_eff9
        lda cCia2PortB
        ora #$02
        sta cCia2PortB
    L_f006:
        bit cCia2PortB
        bvs L_f012
        bmi L_f006
    L_f00d:
        lda #$40
        sta SCREEN_BUFFER_1 + $297
    L_f012:
        clc 
        rts 


    L_f014:
        jsr L_f028
    L_f017:
        ldy SCREEN_BUFFER_1 + $29e
        iny 
        cpy SCREEN_BUFFER_1 + $29d
        beq L_f014
        sty SCREEN_BUFFER_1 + $29e
        dey 
        lda SCREEN_BUFFER_1 + $9e
        sta (SCREEN_BUFFER_1 + $f9),y
    L_f028:
        lda SCREEN_BUFFER_1 + $2a1
        lsr 
        bcs L_f04c
        lda #$10
        sta cCia2TimerAControl
        lda SCREEN_BUFFER_1 + $299
        sta cCia2TimerALo
        lda SCREEN_BUFFER_1 + $29a
        sta cCia2TimerAHi
        lda #$81
        jsr L_ef3b
        jsr L_eef7 + $f
        lda #$11
        sta cCia2TimerAControl
    L_f04c:
        rts 


    L_f04d:
        sta SCREEN_BUFFER_1 + $99
        lda SCREEN_BUFFER_1 + $294
        lsr 
        bcc L_f07d
        and #$08
        beq L_f07d
        lda #$02
        bit cCia2PortB
        bpl L_f00d
        beq L_f084
    L_f062:
        lda SCREEN_BUFFER_1 + $2a1
        lsr 
        bcs L_f062
        lda cCia2PortB
        and #$fd
        sta cCia2PortB
    L_f070:
        lda cCia2PortB
        and #$04
        beq L_f070
    L_f077:
        lda #$90
        clc 
        jmp L_ef3b
    L_f07d:
        lda SCREEN_BUFFER_1 + $2a1
        and #$12
        beq L_f077
    L_f084:
        clc 
        rts 


    L_f086:
        lda SCREEN_BUFFER_1 + $297
        ldy SCREEN_BUFFER_1 + $29c
        cpy SCREEN_BUFFER_1 + $29b
        beq L_f09c
        and #$f7
        sta SCREEN_BUFFER_1 + $297
        lda (SCREEN_BUFFER_1 + $f7),y
        inc SCREEN_BUFFER_1 + $29c
        rts 


    L_f09c:
        ora #$08
        sta SCREEN_BUFFER_1 + $297
        lda #$00
        rts 


    L_f0a4:
        pha 
        lda SCREEN_BUFFER_1 + $2a1
        beq L_f0bb
    L_f0aa:
        lda SCREEN_BUFFER_1 + $2a1
        and #$03
        bne L_f0aa
        lda #$10
        sta cCia2IntControl
        lda #$00
        sta SCREEN_BUFFER_1 + $2a1
    L_f0bb:
        pla 
        rts 



    L_f0bd:
         .byte $0d,$49,$2f,$4f
        .byte $20,$45,$52,$52,$4f,$52,$20,$a3,$0d,$53,$45,$41,$52,$43,$48,$49
        .byte $4e,$47,$a0,$46,$4f,$52,$a0,$0d,$50,$52,$45,$53,$53,$20,$50,$4c
        .byte $41,$59,$20,$4f,$4e,$20,$54,$41,$50,$c5,$50,$52,$45,$53,$53,$20
        .byte $52,$45,$43,$4f,$52,$44,$20,$26,$20,$50,$4c

    L_f0fc:
        eor (SCREEN_BUFFER_1 + $59,x)
        jsr L_4e4b + $4
        jsr $4154

        .byte $50,$c5,$0d,$4c,$4f,$41,$44,$49,$4e,$c7,$0d,$53,$41,$56,$49,$4e
        .byte $47,$a0,$0d,$56,$45,$52,$49,$46,$59,$49,$4e,$c7,$0d,$46,$4f,$55
        .byte $4e,$44,$a0,$0d,$4f,$4b,$8d,$24,$9d

    L_f12d:
        bpl L_f13c
    L_f12f:
        lda L_f0bd,y
        php 
        and #$7f
        jsr L_ffd2
        iny 
        plp 
        bpl L_f12f
    L_f13c:
        clc 
        rts 


        lda SCREEN_BUFFER_1 + $99
        bne L_f14a
        lda SCREEN_BUFFER_1 + $c6
        beq L_f155
        sei 
        jmp L_e5b4
    L_f14a:
        cmp #$02
        bne L_f166
    L_f14e:
        sty SCREEN_BUFFER_1 + $97
        jsr L_f086
        ldy SCREEN_BUFFER_1 + $97
    L_f155:
        clc 
        rts 


        lda SCREEN_BUFFER_1 + $99
        bne L_f166
        lda SCREEN_BUFFER_1 + $d3
        sta SCREEN_BUFFER_1 + $ca
        lda SCREEN_BUFFER_1 + $d6
        sta SCREEN_BUFFER_1 + $c9
        jmp L_e632
    L_f166:
        cmp #$03
        bne L_f173
        sta SCREEN_BUFFER_1 + $d0
        lda SCREEN_BUFFER_1 + $d5
        sta SCREEN_BUFFER_1 + $c8
        jmp L_e632
    L_f173:
        bcs L_f1ad
        cmp #$02
        beq L_f1b8
        stx SCREEN_BUFFER_1 + $97
        jsr L_f199
        bcs L_f196
        pha 
        jsr L_f199
        bcs L_f193
        bne L_f18d
        lda #$40
        jsr L_fe1c
    L_f18d:
        dec SCREEN_BUFFER_1 + $a6
        ldx SCREEN_BUFFER_1 + $97
        pla 
        rts 


    L_f193:
        tax 
        pla 
        txa 
    L_f196:
        ldx SCREEN_BUFFER_1 + $97
        rts 


    L_f199:
        jsr L_f80d
        bne L_f1a9
        jsr L_f841
        bcs L_f1b4
        lda #$00
        sta SCREEN_BUFFER_1 + $a6
        beq L_f199
    L_f1a9:
        lda (SCREEN_BUFFER_1 + $b2),y
        clc 
        rts 


    L_f1ad:
        lda SCREEN_BUFFER_1 + $90
        beq L_f1b5
    L_f1b1:
        lda #$0d
    L_f1b3:
        clc 
    L_f1b4:
        rts 


    L_f1b5:
        jmp L_ee13
    L_f1b8:
        jsr L_f14e
        bcs L_f1b4
        cmp #$00
        bne L_f1b3
        lda SCREEN_BUFFER_1 + $297
        and #$60
        bne L_f1b1
        beq L_f1b8
        pha 
        lda SCREEN_BUFFER_1 + $9a
        cmp #$03
        bne L_f1d5
        pla 
        jmp L_e716
    L_f1d5:
        bcc L_f1db
        pla 
        jmp L_eddd
    L_f1db:
        lsr 
        pla 
    L_f1dd:
        sta SCREEN_BUFFER_1 + $9e
        txa 
        pha 
        tya 
        pha 
        bcc L_f208
        jsr L_f80d
        bne L_f1f8
        jsr L_f864
        bcs L_f1fd
        lda #$02
        ldy #$00
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        sty SCREEN_BUFFER_1 + $a6
    L_f1f8:
        lda SCREEN_BUFFER_1 + $9e
        sta (SCREEN_BUFFER_1 + $b2),y
    L_f1fc:
        clc 
    L_f1fd:
        pla 
        tay 
        pla 
        tax 
        lda SCREEN_BUFFER_1 + $9e
        bcc L_f207
        lda #$00
    L_f207:
        rts 


    L_f208:
        jsr L_f017
        jmp L_f1fc
        jsr L_f30f
        beq L_f216
        jmp $f701
    L_f216:
        jsr L_f31f
        lda SCREEN_BUFFER_1 + $ba
        beq L_f233
        cmp #$03
        beq L_f233
        bcs L_f237
        cmp #$02
        bne L_f22a
        jmp L_f04d
    L_f22a:
        ldx SCREEN_BUFFER_1 + $b9
        cpx #$60
        beq L_f233
        jmp $f70a
    L_f233:
        sta SCREEN_BUFFER_1 + $99
        clc 
        rts 


    L_f237:
        tax 
        jsr $ed09
        lda SCREEN_BUFFER_1 + $b9
        bpl L_f245
        jsr L_edcc
        jmp L_f248
    L_f245:
        jsr L_edc7
    L_f248:
        txa 
        bit SCREEN_BUFFER_1 + $90
        bpl L_f233
        jmp $f707
        jsr L_f30f
        beq L_f258
        jmp $f701
    L_f258:
        jsr L_f31f
        lda SCREEN_BUFFER_1 + $ba
        bne L_f262
    L_f25f:
        jmp $f70d
    L_f262:
        cmp #$03
        beq L_f275
        bcs L_f279
        cmp #$02
        bne L_f26f
        jmp L_efe1
    L_f26f:
        ldx SCREEN_BUFFER_1 + $b9
        cpx #$60
        beq L_f25f
    L_f275:
        sta SCREEN_BUFFER_1 + $9a
        clc 
        rts 


    L_f279:
        tax 
        jsr $ed0c
        lda SCREEN_BUFFER_1 + $b9
        bpl L_f286
        jsr L_edbe
        bne L_f289
    L_f286:
        jsr L_edb9
    L_f289:
        txa 
        bit SCREEN_BUFFER_1 + $90
        bpl L_f275
        jmp $f707
        jsr L_f314
        beq L_f298
        clc 
        rts 


    L_f298:
        jsr L_f31f
        txa 
        pha 
        lda SCREEN_BUFFER_1 + $ba
        beq L_f2f1
        cmp #$03
        beq L_f2f1
        bcs L_f2ee
        cmp #$02
        bne L_f2c8
        pla 
        jsr L_f2f2
        jsr L_f483
        jsr L_fe27
        lda SCREEN_BUFFER_1 + $f8
        beq L_f2ba
        iny 
    L_f2ba:
        lda SCREEN_BUFFER_1 + $fa
        beq L_f2bf
        iny 
    L_f2bf:
        lda #$00
        sta SCREEN_BUFFER_1 + $f8
        sta SCREEN_BUFFER_1 + $fa
        jmp L_f47d
    L_f2c8:
        lda SCREEN_BUFFER_1 + $b9
        and #$0f
        beq L_f2f1
        jsr L_f7d0
        lda #$00
        sec 
        jsr L_f1dd
        jsr L_f864
        bcc L_f2e0
        pla 
        lda #$00
        rts 


    L_f2e0:
        lda SCREEN_BUFFER_1 + $b9
        cmp #$62
        bne L_f2f1
        lda #$05
        jsr L_f76a
        jmp L_f2f1
    L_f2ee:
        jsr L_f642
    L_f2f1:
        pla 
    L_f2f2:
        tax 
        dec SCREEN_BUFFER_1 + $98
        cpx SCREEN_BUFFER_1 + $98
        beq L_f30d
        ldy SCREEN_BUFFER_1 + $98
        lda SCREEN_BUFFER_1 + $259,y
        sta SCREEN_BUFFER_1 + $259,x
        lda SCREEN_BUFFER_1 + $263,y
        sta SCREEN_BUFFER_1 + $263,x
        lda SCREEN_BUFFER_1 + $26d,y
        sta SCREEN_BUFFER_1 + $26d,x
    L_f30d:
        clc 
        rts 


    L_f30f:
        lda #$00
        sta SCREEN_BUFFER_1 + $90
        txa 
    L_f314:
        ldx SCREEN_BUFFER_1 + $98
    L_f316:
        dex 
        bmi L_f32e
        cmp SCREEN_BUFFER_1 + $259,x
        bne L_f316
        rts 


    L_f31f:
        lda SCREEN_BUFFER_1 + $259,x
        sta SCREEN_BUFFER_1 + $b8
        lda SCREEN_BUFFER_1 + $263,x
        sta SCREEN_BUFFER_1 + $ba
        lda SCREEN_BUFFER_1 + $26d,x
        sta SCREEN_BUFFER_1 + $b9
    L_f32e:
        rts 


        lda #$00
        sta SCREEN_BUFFER_1 + $98
        ldx #$03
        cpx SCREEN_BUFFER_1 + $9a
        bcs L_f33c
        jsr $edfe
    L_f33c:
        cpx SCREEN_BUFFER_1 + $99
        bcs L_f343
        jsr L_edef
    L_f343:
        stx SCREEN_BUFFER_1 + $9a
        lda #$00
        sta SCREEN_BUFFER_1 + $99
        rts 


    L_f34a:
        ldx SCREEN_BUFFER_1 + $b8
        bne L_f351
        jmp $f70a
    L_f351:
        jsr L_f30f
        bne L_f359
        jmp $f6fe
    L_f359:
        ldx SCREEN_BUFFER_1 + $98
        cpx #$0a
        bcc L_f362
        jmp L_f6fb
    L_f362:
        inc SCREEN_BUFFER_1 + $98
        lda SCREEN_BUFFER_1 + $b8
        sta SCREEN_BUFFER_1 + $259,x
        lda SCREEN_BUFFER_1 + $b9
        ora #$60
        sta SCREEN_BUFFER_1 + $b9
        sta SCREEN_BUFFER_1 + $26d,x
        lda SCREEN_BUFFER_1 + $ba
        sta SCREEN_BUFFER_1 + $263,x
        beq L_f3d3
        cmp #$03
        beq L_f3d3
        bcc L_f384
        jsr L_f3d5
        bcc L_f3d3
    L_f384:
        cmp #$02
        bne L_f38b
        jmp L_f409
    L_f38b:
        jsr L_f7d0
        bcs L_f393
        jmp $f713
    L_f393:
        lda SCREEN_BUFFER_1 + $b9
        and #$0f
        bne L_f3b8
        jsr L_f817
        bcs L_f3d4
        jsr L_f5af
        lda SCREEN_BUFFER_1 + $b7
        beq L_f3af
        jsr L_f7ea
        bcc L_f3c2
        beq L_f3d4
    L_f3ac:
        jmp $f704
    L_f3af:
        jsr L_f72c
        beq L_f3d4
        bcc L_f3c2
        bcs L_f3ac
    L_f3b8:
        jsr L_f838
        bcs L_f3d4
        lda #$04
        jsr L_f76a
    L_f3c2:
        lda #$bf
        ldy SCREEN_BUFFER_1 + $b9
        cpy #$60
        beq L_f3d1
        ldy #$00
        lda #$02
        sta (SCREEN_BUFFER_1 + $b2),y
        tya 
    L_f3d1:
        sta SCREEN_BUFFER_1 + $a6
    L_f3d3:
        clc 
    L_f3d4:
        rts 


    L_f3d5:
        lda SCREEN_BUFFER_1 + $b9
        bmi L_f3d3
        ldy SCREEN_BUFFER_1 + $b7
        beq L_f3d3
        lda #$00
        sta SCREEN_BUFFER_1 + $90
        lda SCREEN_BUFFER_1 + $ba
        jsr $ed0c
        lda SCREEN_BUFFER_1 + $b9
        ora #$f0
        jsr L_edb9
        lda SCREEN_BUFFER_1 + $90
        bpl L_f3f6
        pla 
        pla 
        jmp $f707
    L_f3f6:
        lda SCREEN_BUFFER_1 + $b7
        beq L_f406
        ldy #$00
    L_f3fc:
        lda (SCREEN_BUFFER_1 + $bb),y
        jsr L_eddd
        iny 
        cpy SCREEN_BUFFER_1 + $b7
        bne L_f3fc
    L_f406:
        jmp L_f654
    L_f409:
        jsr L_f483
        sty SCREEN_BUFFER_1 + $297
    L_f40f:
        cpy SCREEN_BUFFER_1 + $b7
        beq L_f41d
        lda (SCREEN_BUFFER_1 + $bb),y
        sta SCREEN_BUFFER_1 + $293,y
        iny 
        cpy #$04
        bne L_f40f
    L_f41d:
        jsr L_ef4a
        stx SCREEN_BUFFER_1 + $298
        lda SCREEN_BUFFER_1 + $293
        and #$0f
        beq L_f446
        asl 
        tax 
        lda SCREEN_BUFFER_1 + $2a6
        bne L_f43a
        ldy L_fec1,x
        lda L_fec0,x
        jmp L_f440
    L_f43a:
        ldy L_e4eb,x
        lda $e4ea,x
    L_f440:
        sty SCREEN_BUFFER_1 + $296
        sta SCREEN_BUFFER_1 + $295
    L_f446:
        lda SCREEN_BUFFER_1 + $295
        asl 
        jsr L_ff2e
        lda SCREEN_BUFFER_1 + $294
        lsr 
        bcc L_f45c
        lda cCia2PortB
        asl 
        bcs L_f45c
        jsr L_f00d
    L_f45c:
        lda SCREEN_BUFFER_1 + $29b
        sta SCREEN_BUFFER_1 + $29c
        lda SCREEN_BUFFER_1 + $29e
        sta SCREEN_BUFFER_1 + $29d
        jsr L_fe27
        lda SCREEN_BUFFER_1 + $f8
        bne L_f474
        dey 
        sty SCREEN_BUFFER_1 + $f8
        stx SCREEN_BUFFER_1 + $f7
    L_f474:
        lda SCREEN_BUFFER_1 + $fa
        bne L_f47d
        dey 
        sty SCREEN_BUFFER_1 + $fa
        stx SCREEN_BUFFER_1 + $f9
    L_f47d:
        sec 
        lda #$f0
        jmp L_fe2d
    L_f483:
        lda #$7f
        sta cCia2IntControl
        lda #$06
        sta cCia2DDRB
        sta cCia2PortB
        lda #$04
        ora cCia2PortA
        sta cCia2PortA
        ldy #$00
        sty SCREEN_BUFFER_1 + $2a1
        rts 


    L_f49e:
        stx SCREEN_BUFFER_1 + $c3
        sty SCREEN_BUFFER_1 + $c4
        jmp ($0330)
        sta SCREEN_BUFFER_1 + $93
        lda #$00
        sta SCREEN_BUFFER_1 + $90
        lda SCREEN_BUFFER_1 + $ba
        bne L_f4b2
    L_f4af:
        jmp $f713
    L_f4b2:
        cmp #$03
        beq L_f4af
        bcc L_f533
        ldy SCREEN_BUFFER_1 + $b7
        bne L_f4bf
        jmp $f710
    L_f4bf:
        ldx SCREEN_BUFFER_1 + $b9
        jsr L_f5af
        lda #$60
        sta SCREEN_BUFFER_1 + $b9
        jsr L_f3d5
        lda SCREEN_BUFFER_1 + $ba
        jsr $ed09
        lda SCREEN_BUFFER_1 + $b9
        jsr L_edc7
        jsr L_ee13
        sta SCREEN_BUFFER_1 + $ae
        lda SCREEN_BUFFER_1 + $90
        lsr 
        lsr 
        bcs L_f530
        jsr L_ee13
        sta SCREEN_BUFFER_1 + $af
        txa 
        bne L_f4f0
        lda SCREEN_BUFFER_1 + $c3
        sta SCREEN_BUFFER_1 + $ae
        lda SCREEN_BUFFER_1 + $c4
        sta SCREEN_BUFFER_1 + $af
    L_f4f0:
        jsr L_f5d2
    L_f4f3:
        lda #$fd
        and SCREEN_BUFFER_1 + $90
        sta SCREEN_BUFFER_1 + $90
        jsr L_ffe1
        bne L_f501
        jmp L_f633
    L_f501:
        jsr L_ee13

        .byte $aa,$a5,$90,$4a,$4a,$b0,$e8,$8a,$a4,$93,$f0,$0c,$a0,$00,$d1,$ae
        .byte $f0,$08,$a9,$10,$20,$1c,$fe,$2c,$91,$ae

    L_f51e:
        inc SCREEN_BUFFER_1 + $ae
        bne L_f524
        inc SCREEN_BUFFER_1 + $af
    L_f524:
        bit SCREEN_BUFFER_1 + $90
        bvc L_f4f3
        jsr L_edef
        jsr L_f642

        .byte $90,$79

    L_f530:
        jmp $f704
    L_f533:
        lsr 
        bcs L_f539
        jmp $f713
    L_f539:
        jsr L_f7d0
        bcs L_f541
        jmp $f713
    L_f541:
        jsr L_f817
        bcs L_f5ae
        jsr L_f5af
    L_f549:
        lda SCREEN_BUFFER_1 + $b7
        beq L_f556
        jsr L_f7ea
        bcc L_f55d
        beq L_f5ae
        bcs L_f530
    L_f556:
        jsr L_f72c
        beq L_f5ae
        bcs L_f530
    L_f55d:
        lda SCREEN_BUFFER_1 + $90
        and #$10
        sec 
        bne L_f5ae
        cpx #$01
        beq L_f579
        cpx #$03
        bne L_f549
    L_f56c:
        ldy #$01
        lda (SCREEN_BUFFER_1 + $b2),y
        sta SCREEN_BUFFER_1 + $c3
        iny 
        lda (SCREEN_BUFFER_1 + $b2),y
        sta SCREEN_BUFFER_1 + $c4
        bcs L_f57d
    L_f579:
        lda SCREEN_BUFFER_1 + $b9
        bne L_f56c
    L_f57d:
        ldy #$03
        lda (SCREEN_BUFFER_1 + $b2),y
        ldy #$01
        sbc (SCREEN_BUFFER_1 + $b2),y
        tax 
        ldy #$04
        lda (SCREEN_BUFFER_1 + $b2),y
        ldy #$02
        sbc (SCREEN_BUFFER_1 + $b2),y
        tay 
        clc 
        txa 
        adc SCREEN_BUFFER_1 + $c3
        sta SCREEN_BUFFER_1 + $ae
        tya 
        adc SCREEN_BUFFER_1 + $c4
        sta SCREEN_BUFFER_1 + $af
        lda SCREEN_BUFFER_1 + $c3
        sta SCREEN_BUFFER_1 + $c1
        lda SCREEN_BUFFER_1 + $c4
        sta SCREEN_BUFFER_1 + $c2
        jsr L_f5d2
        jsr L_f84a
        bit SCREEN_BUFFER_1 + $18
        ldx SCREEN_BUFFER_1 + $ae
        ldy SCREEN_BUFFER_1 + $af
    L_f5ae:
        rts 


    L_f5af:
        lda SCREEN_BUFFER_1 + $9d
        bpl L_f5d1
        ldy #$0c
        jsr L_f12f
        lda SCREEN_BUFFER_1 + $b7
        beq L_f5d1
        ldy #$17
        jsr L_f12f
    L_f5c1:
        ldy SCREEN_BUFFER_1 + $b7
        beq L_f5d1
        ldy #$00
    L_f5c7:
        lda (SCREEN_BUFFER_1 + $bb),y
        jsr L_ffd2
        iny 
        cpy SCREEN_BUFFER_1 + $b7
        bne L_f5c7
    L_f5d1:
        rts 


    L_f5d2:
        ldy #$49
        lda SCREEN_BUFFER_1 + $93
        beq L_f5da
        ldy #$59
    L_f5da:
        jmp $f12b
    L_f5dd:
        stx SCREEN_BUFFER_1 + $ae
        sty SCREEN_BUFFER_1 + $af
        tax 
        lda $00,x
        sta SCREEN_BUFFER_1 + $c1
        lda SCREEN_BUFFER_1 + $01,x
        sta SCREEN_BUFFER_1 + $c2
        jmp ($0332)
        lda SCREEN_BUFFER_1 + $ba
        bne L_f5f4
    L_f5f1:
        jmp $f713
    L_f5f4:
        cmp #$03
        beq L_f5f1
        bcc L_f659
        lda #$61
        sta SCREEN_BUFFER_1 + $b9
        ldy SCREEN_BUFFER_1 + $b7
        bne L_f605
        jmp $f710
    L_f605:
        jsr L_f3d5
        jsr L_f68f
        lda SCREEN_BUFFER_1 + $ba
        jsr $ed0c
        lda SCREEN_BUFFER_1 + $b9
        jsr L_edb9
        ldy #$00
        jsr L_fb8e
        lda SCREEN_BUFFER_1 + $ac
        jsr L_eddd
        lda SCREEN_BUFFER_1 + $ad
        jsr L_eddd
    L_f624:
        jsr L_fcd1
        bcs L_f63f
        lda (SCREEN_BUFFER_1 + $ac),y
        jsr L_eddd
        jsr L_ffe1
        bne L_f63a
    L_f633:
        jsr L_f642
        lda #$00
        sec 
        rts 


    L_f63a:
        jsr L_fcdb
        bne L_f624
    L_f63f:
        jsr $edfe
    L_f642:
        bit SCREEN_BUFFER_1 + $b9
        bmi L_f657
        lda SCREEN_BUFFER_1 + $ba
        jsr $ed0c
        lda SCREEN_BUFFER_1 + $b9
        and #$ef
        ora #$e0
        jsr L_edb9
    L_f654:
        jsr $edfe
    L_f657:
        clc 
        rts 


    L_f659:
        lsr 
        bcs L_f65f
        jmp $f713
    L_f65f:
        jsr L_f7d0
        bcc L_f5f1
        jsr L_f838
        bcs L_f68e
        jsr L_f68f
        ldx #$03
        lda SCREEN_BUFFER_1 + $b9
        and #$01
        bne L_f676
        ldx #$01
    L_f676:
        txa 
        jsr L_f76a
        bcs L_f68e
        jsr L_f867

        .byte $b0,$0d,$a5,$b9,$29,$02,$f0,$06,$a9,$05,$20,$6a,$f7,$24,$18

    L_f68e:
        rts 


    L_f68f:
        lda SCREEN_BUFFER_1 + $9d
        bpl L_f68e
        ldy #$51
        jsr L_f12f
        jmp L_f5c1
    L_f69b:
        ldx #$00
        inc SCREEN_BUFFER_1 + $a2
        bne L_f6a7
        inc SCREEN_BUFFER_1 + $a1
        bne L_f6a7
        inc SCREEN_BUFFER_1 + $a0
    L_f6a7:
        sec 
        lda SCREEN_BUFFER_1 + $a2
        sbc #$01
        lda SCREEN_BUFFER_1 + $a1
        sbc #$1a
        lda SCREEN_BUFFER_1 + $a0
        sbc #$4f
        bcc L_f6bc
        stx SCREEN_BUFFER_1 + $a0
        stx SCREEN_BUFFER_1 + $a1
        stx SCREEN_BUFFER_1 + $a2
    L_f6bc:
        lda cCia1PortB
        cmp cCia1PortB
        bne L_f6bc
        tax 
        bmi L_f6da
        ldx #$bd
        stx cCia1PortA
    L_f6cc:
        ldx cCia1PortB
        cpx cCia1PortB
        bne L_f6cc
        sta cCia1PortA
        inx 
        bne L_f6dc
    L_f6da:
        sta SCREEN_BUFFER_1 + $91
    L_f6dc:
        rts 


    L_f6dd:
        sei 
        lda SCREEN_BUFFER_1 + $a2
        ldx SCREEN_BUFFER_1 + $a1
        ldy SCREEN_BUFFER_1 + $a0
    L_f6e4:
        sei 
        sta SCREEN_BUFFER_1 + $a2
        stx SCREEN_BUFFER_1 + $a1
        sty SCREEN_BUFFER_1 + $a0
        cli 
        rts 


        lda SCREEN_BUFFER_1 + $91
        cmp #$7f
        bne L_f6fa
        php 
        jsr L_ffcc
        sta SCREEN_BUFFER_1 + $c6
        plp 
    L_f6fa:
        rts 


    L_f6fb:
        lda #$01
        bit SCREEN_BUFFER_1 + $2a9
        bit SCREEN_BUFFER_1 + $3a9
        bit SCREEN_BUFFER_0 + $a9
        bit SCREEN_BUFFER_0 + $1a9
        bit SCREEN_BUFFER_0 + $2a9
        bit SCREEN_BUFFER_0 + $3a9
        bit $08a9
        bit L_09a9
        pha 
        jsr L_ffcc
        ldy #$00
        bit SCREEN_BUFFER_1 + $9d
        bvc L_f729
        jsr L_f12f
        pla 
        pha 
        ora #$30
        jsr L_ffd2
    L_f729:
        pla 
        sec 
        rts 


    L_f72c:
        lda SCREEN_BUFFER_1 + $93
        pha 
        jsr L_f841
        pla 
        sta SCREEN_BUFFER_1 + $93
        bcs L_f769
        ldy #$00
        lda (SCREEN_BUFFER_1 + $b2),y
        cmp #$05
        beq L_f769
        cmp #$01
        beq L_f74b
        cmp #$03
        beq L_f74b
        cmp #$04
        bne L_f72c
    L_f74b:
        tax 
        bit SCREEN_BUFFER_1 + $9d
        bpl L_f767
        ldy #$63
        jsr L_f12f
        ldy #$05
    L_f757:
        lda (SCREEN_BUFFER_1 + $b2),y
        jsr L_ffd2
        iny 
        cpy #$15
        bne L_f757
        lda SCREEN_BUFFER_1 + $a1
        jsr L_e4e0
        nop 
    L_f767:
        clc 
        dey 
    L_f769:
        rts 


    L_f76a:
        sta SCREEN_BUFFER_1 + $9e
        jsr L_f7d0
        bcc L_f7cf
        lda SCREEN_BUFFER_1 + $c2
        pha 
        lda SCREEN_BUFFER_1 + $c1
        pha 
        lda SCREEN_BUFFER_1 + $af
        pha 
        lda SCREEN_BUFFER_1 + $ae
        pha 
        ldy #$bf
        lda #$20
    L_f781:
        sta (SCREEN_BUFFER_1 + $b2),y
        dey 
        bne L_f781
        lda SCREEN_BUFFER_1 + $9e
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        lda SCREEN_BUFFER_1 + $c1
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        lda SCREEN_BUFFER_1 + $c2
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        lda SCREEN_BUFFER_1 + $ae
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        lda SCREEN_BUFFER_1 + $af
        sta (SCREEN_BUFFER_1 + $b2),y
        iny 
        sty SCREEN_BUFFER_1 + $9f
        ldy #$00
        sty SCREEN_BUFFER_1 + $9e
    L_f7a5:
        ldy SCREEN_BUFFER_1 + $9e
        cpy SCREEN_BUFFER_1 + $b7
        beq L_f7b7
        lda (SCREEN_BUFFER_1 + $bb),y
        ldy SCREEN_BUFFER_1 + $9f
        sta (SCREEN_BUFFER_1 + $b2),y
        inc SCREEN_BUFFER_1 + $9e
        inc SCREEN_BUFFER_1 + $9f
        bne L_f7a5
    L_f7b7:
        jsr L_f7d7
        lda #$69
        sta SCREEN_BUFFER_1 + $ab
        jsr L_f86b
        tay 
        pla 
        sta SCREEN_BUFFER_1 + $ae
        pla 
        sta SCREEN_BUFFER_1 + $af
        pla 
        sta SCREEN_BUFFER_1 + $c1
        pla 
    L_f7cc:
        sta SCREEN_BUFFER_1 + $c2
        tya 
    L_f7cf:
        rts 


    L_f7d0:
        ldx SCREEN_BUFFER_1 + $b2
        ldy SCREEN_BUFFER_1 + $b3
        cpy #$02
        rts 


    L_f7d7:
        jsr L_f7d0
        txa 
        sta SCREEN_BUFFER_1 + $c1
        clc 
        adc #$c0
        sta SCREEN_BUFFER_1 + $ae
        tya 
        sta SCREEN_BUFFER_1 + $c2
        adc #$00
        sta SCREEN_BUFFER_1 + $af
        rts 


    L_f7ea:
        jsr L_f72c
        bcs L_f80c
        ldy #$05
        sty SCREEN_BUFFER_1 + $9f
        ldy #$00
        sty SCREEN_BUFFER_1 + $9e
    L_f7f7:
        cpy SCREEN_BUFFER_1 + $b7
        beq L_f80b
        lda (SCREEN_BUFFER_1 + $bb),y
        ldy SCREEN_BUFFER_1 + $9f
        cmp (SCREEN_BUFFER_1 + $b2),y
        bne L_f7ea
        inc SCREEN_BUFFER_1 + $9e
        inc SCREEN_BUFFER_1 + $9f
        ldy SCREEN_BUFFER_1 + $9e
        bne L_f7f7
    L_f80b:
        clc 
    L_f80c:
        rts 


    L_f80d:
        jsr L_f7d0
        inc SCREEN_BUFFER_1 + $a6
        ldy SCREEN_BUFFER_1 + $a6
        cpy #$c0
        rts 


    L_f817:
        jsr L_f82e
        beq L_f836
        ldy #$1b
    L_f81e:
        jsr L_f12f
    L_f821:
        jsr L_f8d0
        jsr L_f82e
        bne L_f821
        ldy #$6a
        jmp L_f12f
    L_f82e:
        lda #$10
        bit SCREEN_BUFFER_1 + $01
        bne L_f836
        bit SCREEN_BUFFER_1 + $01
    L_f836:
        clc 
        rts 


    L_f838:
        jsr L_f82e
        beq L_f836
        ldy #$2e
        bne L_f81e
    L_f841:
        lda #$00
        sta SCREEN_BUFFER_1 + $90
        sta SCREEN_BUFFER_1 + $93
        jsr L_f7d7
    L_f84a:
        jsr L_f817
        bcs L_f86e
        sei 
        lda #$00
        sta SCREEN_BUFFER_1 + $aa
        sta SCREEN_BUFFER_1 + $b4
        sta SCREEN_BUFFER_1 + $b0
        sta SCREEN_BUFFER_1 + $9e
        sta SCREEN_BUFFER_1 + $9f
        sta SCREEN_BUFFER_1 + $9c
        lda #$90
        ldx #$0e
        bne L_f875
    L_f864:
        jsr L_f7d7
    L_f867:
        lda #$14
        sta SCREEN_BUFFER_1 + $ab
    L_f86b:
        jsr L_f838
    L_f86e:
        bcs L_f8dc
        sei 
        lda #$82
        ldx #$08
    L_f875:
        ldy #$7f
        sty cCia1IntControl
        sta cCia1IntControl
        lda cCia1TimerAControl
        ora #$19
        sta cCia1TimerbControl
        and #$91
        sta SCREEN_BUFFER_1 + $2a2
        jsr L_f0a4
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        lda SCREEN_BUFFER_1 + $314
        sta SCREEN_BUFFER_1 + $29f
        lda SCREEN_BUFFER_1 + $315
        sta SCREEN_BUFFER_1 + $2a0
        jsr L_fcbd
        lda #$02
        sta SCREEN_BUFFER_1 + $be
        jsr L_fb97
        lda SCREEN_BUFFER_1 + $01
        and #$1f
        sta SCREEN_BUFFER_1 + $01
        sta SCREEN_BUFFER_1 + $c0
        ldx #$ff
    L_f8b5:
        ldy #$ff
    L_f8b7:
        dey 
        bne L_f8b7
        dex 
        bne L_f8b5
        cli 
    L_f8be:
        lda SCREEN_BUFFER_1 + $2a0
        cmp SCREEN_BUFFER_1 + $315
        clc 
        beq L_f8dc
        jsr L_f8d0
        jsr L_f6bc
        jmp L_f8be
    L_f8d0:
        jsr L_ffe1
        clc 
        bne L_f8e1
        jsr L_fc93
        sec 
        pla 
        pla 
    L_f8dc:
        lda #$00
        sta SCREEN_BUFFER_1 + $2a0
    L_f8e1:
        rts 


    L_f8e2:
        stx SCREEN_BUFFER_1 + $b1
        lda SCREEN_BUFFER_1 + $b0
        asl 
        asl 
        clc 
        adc SCREEN_BUFFER_1 + $b0
        clc 
        adc SCREEN_BUFFER_1 + $b1
        sta SCREEN_BUFFER_1 + $b1
        lda #$00
        bit SCREEN_BUFFER_1 + $b0
        bmi L_f8f7
        rol 
    L_f8f7:
        asl SCREEN_BUFFER_1 + $b1
        rol 
        asl SCREEN_BUFFER_1 + $b1
        rol 
        tax 
    L_f8fe:
        lda cCia1TimerBLo
        cmp #$16
        bcc L_f8fe
        adc SCREEN_BUFFER_1 + $b1
        sta cCia1TimerALo
        txa 
        adc cCia1TimerBHi
        sta cCia1TimerAHi
        lda SCREEN_BUFFER_1 + $2a2
        sta cCia1TimerAControl
        sta SCREEN_BUFFER_1 + $2a4
        lda cCia1IntControl
        and #$10
        beq L_f92a
        lda #$f9
        pha 
        lda #$2a
        pha 
        jmp L_ff43
    L_f92a:
        cli 
        rts 


    L_f92c:
        ldx cCia1TimerBHi
        ldy #$ff
        tya 
        sbc cCia1TimerBLo
        cpx cCia1TimerBHi
        bne L_f92c
        stx SCREEN_BUFFER_1 + $b1
        tax 
        sty cCia1TimerBLo
        sty cCia1TimerBHi
        lda #$19
        sta cCia1TimerbControl
        lda cCia1IntControl
        sta SCREEN_BUFFER_1 + $2a3
        tya 
        sbc SCREEN_BUFFER_1 + $b1
        stx SCREEN_BUFFER_1 + $b1
        lsr 
        ror SCREEN_BUFFER_1 + $b1
        lsr 
        ror SCREEN_BUFFER_1 + $b1
        lda SCREEN_BUFFER_1 + $b0
        clc 
        adc #$3c
        cmp SCREEN_BUFFER_1 + $b1
        bcs L_f9ac
        ldx SCREEN_BUFFER_1 + $9c
        beq L_f969
        jmp L_fa60
    L_f969:
        ldx SCREEN_BUFFER_1 + $a3
        bmi L_f988
        ldx #$00
        adc #$30
        adc SCREEN_BUFFER_1 + $b0
        cmp SCREEN_BUFFER_1 + $b1
        bcs L_f993
        inx 
        adc #$26
        adc SCREEN_BUFFER_1 + $b0
        cmp SCREEN_BUFFER_1 + $b1
        bcs L_f997
        adc #$2c
        adc SCREEN_BUFFER_1 + $b0
        cmp SCREEN_BUFFER_1 + $b1
        bcc L_f98b
    L_f988:
        jmp L_fa10
    L_f98b:
        lda SCREEN_BUFFER_1 + $b4
        beq L_f9ac
        sta SCREEN_BUFFER_1 + $a8
        bne L_f9ac
    L_f993:
        inc SCREEN_BUFFER_1 + $a9
        bcs L_f999
    L_f997:
        dec SCREEN_BUFFER_1 + $a9
    L_f999:
        sec 
        sbc #$13
        sbc SCREEN_BUFFER_1 + $b1
        adc SCREEN_BUFFER_1 + $92
        sta SCREEN_BUFFER_1 + $92
        lda SCREEN_BUFFER_1 + $a4
        eor #$01
        sta SCREEN_BUFFER_1 + $a4
        beq L_f9d5
        stx SCREEN_BUFFER_1 + $d7
    L_f9ac:
        lda SCREEN_BUFFER_1 + $b4
        beq L_f9d2
        lda SCREEN_BUFFER_1 + $2a3
        and #$01
        bne L_f9bc
        lda SCREEN_BUFFER_1 + $2a4
        bne L_f9d2
    L_f9bc:
        lda #$00
        sta SCREEN_BUFFER_1 + $a4
        sta SCREEN_BUFFER_1 + $2a4
        lda SCREEN_BUFFER_1 + $a3
        bpl L_f9f7
        bmi L_f988
    L_f9c9:
        ldx #$a6
        jsr L_f8e2
        lda SCREEN_BUFFER_1 + $9b
        bne L_f98b
    L_f9d2:
        jmp L_febc

    L_f9d5:
         .byte $a5,$92,$f0,$07,$30,$03
        .byte $c6,$b0,$2c,$e6,$b0,$a9,$00,$85,$92,$e4,$d7,$d0,$0f,$8a,$d0,$a0
        .byte $a5,$a9,$30,$bd,$c9,$10,$90,$b9,$85,$96,$b0,$b5

    L_f9f7:
        txa 
        eor SCREEN_BUFFER_1 + $9b
        sta SCREEN_BUFFER_1 + $9b
        lda SCREEN_BUFFER_1 + $b4
        beq L_f9d2
        dec SCREEN_BUFFER_1 + $a3
        bmi L_f9c9
        lsr SCREEN_BUFFER_1 + $d7
        ror SCREEN_BUFFER_1 + $bf
        ldx #$da
        jsr L_f8e2
        jmp L_febc
    L_fa10:
        lda SCREEN_BUFFER_1 + $96
        beq L_fa18
        lda SCREEN_BUFFER_1 + $b4
        beq L_fa1f
    L_fa18:
        lda SCREEN_BUFFER_1 + $a3
        bmi L_fa1f
        jmp L_f997
    L_fa1f:
        lsr SCREEN_BUFFER_1 + $b1
        lda #$93
        sec 
        sbc SCREEN_BUFFER_1 + $b1
        adc SCREEN_BUFFER_1 + $b0
        asl 
        tax 
        jsr L_f8e2
        inc SCREEN_BUFFER_1 + $9c
        lda SCREEN_BUFFER_1 + $b4
        bne L_fa44
        lda SCREEN_BUFFER_1 + $96
        beq L_fa5d
        sta SCREEN_BUFFER_1 + $a8
        lda #$00
        sta SCREEN_BUFFER_1 + $96
        lda #$81
        sta cCia1IntControl
        sta SCREEN_BUFFER_1 + $b4
    L_fa44:
        lda SCREEN_BUFFER_1 + $96
        sta SCREEN_BUFFER_1 + $b5
        beq L_fa53
        lda #$00
        sta SCREEN_BUFFER_1 + $b4
        lda #$01
        sta cCia1IntControl
    L_fa53:
        lda SCREEN_BUFFER_1 + $bf
        sta SCREEN_BUFFER_1 + $bd
        lda SCREEN_BUFFER_1 + $a8
        ora SCREEN_BUFFER_1 + $a9
        sta SCREEN_BUFFER_1 + $b6
    L_fa5d:
        jmp L_febc
    L_fa60:
        jsr L_fb97
        sta SCREEN_BUFFER_1 + $9c
        ldx #$da
        jsr L_f8e2
        lda SCREEN_BUFFER_1 + $be
        beq L_fa70
        sta SCREEN_BUFFER_1 + $a7
    L_fa70:
        lda #$0f
        bit SCREEN_BUFFER_1 + $aa
        bpl L_fa8d
        lda SCREEN_BUFFER_1 + $b5
        bne L_fa86
        ldx SCREEN_BUFFER_1 + $be
        dex 
        bne L_fa8a
        lda #$08
        jsr L_fe1c
        bne L_fa8a
    L_fa86:
        lda #$00
        sta SCREEN_BUFFER_1 + $aa
    L_fa8a:
        jmp L_febc
    L_fa8d:
        bvs L_fac0
        bne L_faa9
        lda SCREEN_BUFFER_1 + $b5
        bne L_fa8a
        lda SCREEN_BUFFER_1 + $b6
        bne L_fa8a
        lda SCREEN_BUFFER_1 + $a7
        lsr 
        lda SCREEN_BUFFER_1 + $bd
        bmi L_faa3
        bcc L_faba
        clc 
    L_faa3:
        bcs L_faba
        and #$0f
        sta SCREEN_BUFFER_1 + $aa
    L_faa9:
        dec SCREEN_BUFFER_1 + $aa
        bne L_fa8a
        lda #$40
        sta SCREEN_BUFFER_1 + $aa
        jsr L_fb8e
        lda #$00
        sta SCREEN_BUFFER_1 + $ab
        beq L_fa8a
    L_faba:
        lda #$80
        sta SCREEN_BUFFER_1 + $aa
        bne L_fa8a
    L_fac0:
        lda SCREEN_BUFFER_1 + $b5
        beq L_face
        lda #$04
        jsr L_fe1c
        lda #$00
        jmp L_fb4a
    L_face:
        jsr L_fcd1
        bcc L_fad6
        jmp L_fb48
    L_fad6:
        ldx SCREEN_BUFFER_1 + $a7
        dex 
        beq L_fb08
        lda SCREEN_BUFFER_1 + $93
        beq L_faeb
        ldy #$00
        lda SCREEN_BUFFER_1 + $bd
        cmp (SCREEN_BUFFER_1 + $ac),y
        beq L_faeb
        lda #$01
        sta SCREEN_BUFFER_1 + $b6
    L_faeb:
        lda SCREEN_BUFFER_1 + $b6
        beq L_fb3a
        ldx #$3d
        cpx SCREEN_BUFFER_1 + $9e
        bcc L_fb33
        ldx SCREEN_BUFFER_1 + $9e
        lda SCREEN_BUFFER_1 + $ad
    L_faf9:
        sta SCREEN_BUFFER_1 + $101,x
        lda SCREEN_BUFFER_1 + $ac
        sta SCREEN_BUFFER_1 + $100,x
        inx 
        inx 
        stx SCREEN_BUFFER_1 + $9e
        jmp L_fb3a
    L_fb08:
        ldx SCREEN_BUFFER_1 + $9f
        cpx SCREEN_BUFFER_1 + $9e
        beq L_fb43
        lda SCREEN_BUFFER_1 + $ac
        cmp SCREEN_BUFFER_1 + $100,x
        bne L_fb43
        lda SCREEN_BUFFER_1 + $ad
        cmp SCREEN_BUFFER_1 + $101,x
        bne L_fb43
        inc SCREEN_BUFFER_1 + $9f
        inc SCREEN_BUFFER_1 + $9f
        lda SCREEN_BUFFER_1 + $93
        beq L_fb2f
        lda SCREEN_BUFFER_1 + $bd
        ldy #$00
        cmp (SCREEN_BUFFER_1 + $ac),y
        beq L_fb43
        iny 
        sty SCREEN_BUFFER_1 + $b6
    L_fb2f:
        lda SCREEN_BUFFER_1 + $b6
        beq L_fb3a
    L_fb33:
        lda #$10
        jsr L_fe1c
        bne L_fb43
    L_fb3a:
        lda SCREEN_BUFFER_1 + $93
        bne L_fb43
        tay 
        lda SCREEN_BUFFER_1 + $bd
        sta (SCREEN_BUFFER_1 + $ac),y
    L_fb43:
        jsr L_fcdb
        bne L_fb8b
    L_fb48:
        lda #$80
    L_fb4a:
        sta SCREEN_BUFFER_1 + $aa
        sei 
        ldx #$01
        stx cCia1IntControl
        ldx cCia1IntControl
        ldx SCREEN_BUFFER_1 + $be
        dex 
        bmi L_fb5c
        stx SCREEN_BUFFER_1 + $be
    L_fb5c:
        dec SCREEN_BUFFER_1 + $a7
        beq L_fb68
        lda SCREEN_BUFFER_1 + $9e
        bne L_fb8b
        sta SCREEN_BUFFER_1 + $be
        beq L_fb8b
    L_fb68:
        jsr L_fc93
        jsr L_fb8e
        ldy #$00
        sty SCREEN_BUFFER_1 + $ab
    L_fb72:
        lda (SCREEN_BUFFER_1 + $ac),y
        eor SCREEN_BUFFER_1 + $ab
        sta SCREEN_BUFFER_1 + $ab
        jsr L_fcdb
        jsr L_fcd1
        bcc L_fb72
        lda SCREEN_BUFFER_1 + $ab
        eor SCREEN_BUFFER_1 + $bd
        beq L_fb8b
        lda #$20
        jsr L_fe1c
    L_fb8b:
        jmp L_febc
    L_fb8e:
        lda SCREEN_BUFFER_1 + $c2
        sta SCREEN_BUFFER_1 + $ad
        lda SCREEN_BUFFER_1 + $c1
        sta SCREEN_BUFFER_1 + $ac
        rts 


    L_fb97:
        lda #$08
        sta SCREEN_BUFFER_1 + $a3
        lda #$00
        sta SCREEN_BUFFER_1 + $a4
        sta SCREEN_BUFFER_1 + $a8
        sta SCREEN_BUFFER_1 + $9b
        sta SCREEN_BUFFER_1 + $a9
        rts 


    L_fba6:
        lda SCREEN_BUFFER_1 + $bd
        lsr 
        lda #$60
        bcc L_fbaf
    L_fbad:
        lda #$b0
    L_fbaf:
        ldx #$00
    L_fbb1:
        sta cCia1TimerBLo
        stx cCia1TimerBHi
        lda cCia1IntControl
        lda #$19
        sta cCia1TimerbControl
        lda SCREEN_BUFFER_1 + $01
        eor #$08
        sta SCREEN_BUFFER_1 + $01
        and #$08
        rts 


    L_fbc8:
        sec 
        ror SCREEN_BUFFER_1 + $b6
        bmi L_fc09
        lda SCREEN_BUFFER_1 + $a8
        bne L_fbe3
        lda #$10
        ldx #$01
        jsr L_fbb1
        bne L_fc09
        inc SCREEN_BUFFER_1 + $a8
        lda SCREEN_BUFFER_1 + $b6
        bpl L_fc09
        jmp L_fc57
    L_fbe3:
        lda SCREEN_BUFFER_1 + $a9
        bne L_fbf0
        jsr L_fbad
        bne L_fc09
        inc SCREEN_BUFFER_1 + $a9
        bne L_fc09
    L_fbf0:
        jsr L_fba6
        bne L_fc09
        lda SCREEN_BUFFER_1 + $a4
        eor #$01
        sta SCREEN_BUFFER_1 + $a4
        beq L_fc0c
    L_fbfd:
        lda SCREEN_BUFFER_1 + $bd
        eor #$01
        sta SCREEN_BUFFER_1 + $bd
        and #$01
        eor SCREEN_BUFFER_1 + $9b
        sta SCREEN_BUFFER_1 + $9b
    L_fc09:
        jmp L_febc
    L_fc0c:
        lsr SCREEN_BUFFER_1 + $bd
        dec SCREEN_BUFFER_1 + $a3
        lda SCREEN_BUFFER_1 + $a3
        beq L_fc4e
        bpl L_fc09
    L_fc16:
        jsr L_fb97
        cli 
        lda SCREEN_BUFFER_1 + $a5
        beq L_fc30
        ldx #$00
        stx SCREEN_BUFFER_1 + $d7
        dec SCREEN_BUFFER_1 + $a5
        ldx SCREEN_BUFFER_1 + $be
        cpx #$02
        bne L_fc2c
        ora #$80
    L_fc2c:
        sta SCREEN_BUFFER_1 + $bd
        bne L_fc09
    L_fc30:
        jsr L_fcd1
        bcc L_fc3f
        bne L_fbc8
        inc SCREEN_BUFFER_1 + $ad
        lda SCREEN_BUFFER_1 + $d7
        sta SCREEN_BUFFER_1 + $bd
        bcs L_fc09
    L_fc3f:
        ldy #$00
        lda (SCREEN_BUFFER_1 + $ac),y
        sta SCREEN_BUFFER_1 + $bd
        eor SCREEN_BUFFER_1 + $d7
        sta SCREEN_BUFFER_1 + $d7
        jsr L_fcdb
        bne L_fc09
    L_fc4e:
        lda SCREEN_BUFFER_1 + $9b
        eor #$01
        sta SCREEN_BUFFER_1 + $bd
    L_fc54:
        jmp L_febc
    L_fc57:
        dec SCREEN_BUFFER_1 + $be
        bne L_fc5e
        jsr L_fcca
    L_fc5e:
        lda #$50
        sta SCREEN_BUFFER_1 + $a7
        ldx #$08
        sei 
        jsr L_fcbd
        bne L_fc54
        lda #$78
        jsr L_fbaf
        bne L_fc54
        dec SCREEN_BUFFER_1 + $a7
        bne L_fc54
        jsr L_fb97
        dec SCREEN_BUFFER_1 + $ab
        bpl L_fc54
        ldx #$0a
        jsr L_fcbd
        cli 
        inc SCREEN_BUFFER_1 + $ab
        lda SCREEN_BUFFER_1 + $be
        beq L_fcb8
        jsr L_fb8e
        ldx #$09
        stx SCREEN_BUFFER_1 + $a5
        stx SCREEN_BUFFER_1 + $b6
        bne L_fc16
    L_fc93:
        php 
        sei 
        lda vScreenControl1
        ora #$10
        sta vScreenControl1
        jsr L_fcca
        lda #$7f
        sta cCia1IntControl
        jsr L_fddd
        lda SCREEN_BUFFER_1 + $2a0
        beq L_fcb6
        sta SCREEN_BUFFER_1 + $315
        lda SCREEN_BUFFER_1 + $29f
        sta SCREEN_BUFFER_1 + $314
    L_fcb6:
        plp 
        rts 


    L_fcb8:
        jsr L_fc93
        beq L_fc54
    L_fcbd:
        lda $fd93,x
        sta SCREEN_BUFFER_1 + $314
        lda $fd94,x
        sta SCREEN_BUFFER_1 + $315
        rts 


    L_fcca:
        lda SCREEN_BUFFER_1 + $01
        ora #$20
        sta SCREEN_BUFFER_1 + $01
        rts 


    L_fcd1:
        sec 
        lda SCREEN_BUFFER_1 + $ac
        sbc SCREEN_BUFFER_1 + $ae
        lda SCREEN_BUFFER_1 + $ad
        sbc SCREEN_BUFFER_1 + $af
        rts 


    L_fcdb:
        inc SCREEN_BUFFER_1 + $ac
        bne L_fce1
        inc SCREEN_BUFFER_1 + $ad
    L_fce1:
        rts 


        ldx #$ff
        sei 
        txs 
        cld 
        jsr L_fd02
        bne L_fcef
        jmp (L_7ffd + $3)
    L_fcef:
        stx vScreenControl2
        jsr $fda3
        jsr $fd50
        jsr L_fd15
        jsr L_ff5b
        cli 
        jmp (L_a000)
    L_fd02:
        ldx #$05
    L_fd04:
        lda L_fd0f,x
        cmp L_7ffd + $6,x
        bne L_fd0f
        dex 
        bne L_fd04
    L_fd0f:
        rts 



        .byte $c3,$c2,$cd,$38,$30

    L_fd15:
        ldx #$30
        ldy #$fd
        clc 
    L_fd1a:
        stx SCREEN_BUFFER_1 + $c3
        sty SCREEN_BUFFER_1 + $c4
        ldy #$1f
    L_fd20:
        lda SCREEN_BUFFER_1 + $314,y
        bcs L_fd27
        lda (SCREEN_BUFFER_1 + $c3),y
    L_fd27:
        sta (SCREEN_BUFFER_1 + $c3),y
        sta SCREEN_BUFFER_1 + $314,y
        dey 
        bpl L_fd20
        rts 



        .byte $31,$ea,$66,$fe,$47,$fe,$4a,$f3,$91,$f2,$0e,$f2,$50,$f2,$33,$f3
        .byte $57,$f1,$ca,$f1,$ed,$f6,$3e,$f1,$2f,$f3,$66,$fe,$a5,$f4,$ed,$f5
        .byte $a9,$00,$a8

    L_fd53:
        sta.a SCREEN_BUFFER_1 + $02,y
        sta SCREEN_BUFFER_1 + $200,y
        sta SCREEN_BUFFER_1 + $300,y
        iny 
        bne L_fd53
        ldx #$3c
        ldy #$03
        stx SCREEN_BUFFER_1 + $b2
        sty SCREEN_BUFFER_1 + $b3
        tay 
        lda #$03
        sta SCREEN_BUFFER_1 + $c2
    L_fd6c:
        inc SCREEN_BUFFER_1 + $c2
    L_fd6e:
        lda (SCREEN_BUFFER_1 + $c1),y
        tax 
        lda #$55
        sta (SCREEN_BUFFER_1 + $c1),y
        cmp (SCREEN_BUFFER_1 + $c1),y
        bne L_fd88
        rol 
        sta (SCREEN_BUFFER_1 + $c1),y
        cmp (SCREEN_BUFFER_1 + $c1),y
        bne L_fd88
        txa 
        sta (SCREEN_BUFFER_1 + $c1),y
        iny 
        bne L_fd6e
        beq L_fd6c
    L_fd88:
        tya 
        tax 
        ldy SCREEN_BUFFER_1 + $c2
        clc 
        jsr L_fe2d
        lda #$08
        sta SCREEN_BUFFER_1 + $282
        lda #$04
        sta SCREEN_BUFFER_1 + $288
        rts 



        .byte $6a,$fc,$cd,$fb,$31,$ea,$2c,$f9,$a9,$7f,$8d,$0d,$dc,$8d,$0d,$dd
        .byte $8d,$00,$dc,$a9,$08,$8d,$0e,$dc,$8d,$0e,$dd,$8d,$0f,$dc,$8d,$0f
        .byte $dd,$a2,$00,$8e,$03,$dc,$8e,$03,$dd,$8e,$18,$d4,$ca,$8e,$02,$dc
        .byte $a9,$07,$8d,$00,$dd,$a9,$3f,$8d,$02,$dd,$a9,$e7,$85,$01,$a9,$2f
        .byte $85,$00

    L_fddd:
        lda SCREEN_BUFFER_1 + $2a6
        beq L_fdec
        lda #$25
        sta cCia1TimerALo
        lda #$40
        jmp L_fdf3
    L_fdec:
        lda #$95
        sta cCia1TimerALo
        lda #$42
    L_fdf3:
        sta cCia1TimerAHi
        jmp L_ff6e
    L_fdf9:
        sta SCREEN_BUFFER_1 + $b7
        stx SCREEN_BUFFER_1 + $bb
        sty SCREEN_BUFFER_1 + $bc
        rts 


    L_fe00:
        sta SCREEN_BUFFER_1 + $b8
        stx SCREEN_BUFFER_1 + $ba
        sty SCREEN_BUFFER_1 + $b9
        rts 


    L_fe07:
        lda SCREEN_BUFFER_1 + $ba
        cmp #$02
        bne L_fe1a
        lda SCREEN_BUFFER_1 + $297
        pha 
        lda #$00
        sta SCREEN_BUFFER_1 + $297
        pla 
        rts 


    L_fe18:
        sta SCREEN_BUFFER_1 + $9d
    L_fe1a:
        lda SCREEN_BUFFER_1 + $90
    L_fe1c:
        ora SCREEN_BUFFER_1 + $90
        sta SCREEN_BUFFER_1 + $90
        rts 


    L_fe21:
        sta SCREEN_BUFFER_1 + $285
        rts 


    L_fe25:
        bcc L_fe2d
    L_fe27:
        ldx SCREEN_BUFFER_1 + $283
        ldy SCREEN_BUFFER_1 + $284
    L_fe2d:
        stx SCREEN_BUFFER_1 + $283
        sty SCREEN_BUFFER_1 + $284
        rts 


    L_fe34:
        bcc L_fe3c
        ldx SCREEN_BUFFER_1 + $281
        ldy SCREEN_BUFFER_1 + $282
    L_fe3c:
        stx SCREEN_BUFFER_1 + $281
        sty SCREEN_BUFFER_1 + $282
        rts 


    L_fe43:
        sei 
        jmp ($0318)
        pha 
        txa 
        pha 
        tya 
        pha 
        lda #$7f
        sta cCia2IntControl
        ldy cCia2IntControl
        bmi L_fe72
        jsr L_fd02
        bne L_fe5e
        jmp (L_7ffd + $5)
    L_fe5e:
        jsr L_f6bc
        jsr L_ffe1
        bne L_fe72
        jsr L_fd15
        jsr $fda3
        jsr L_e518
        jmp (L_a002)
    L_fe72:
        tya 
        and SCREEN_BUFFER_1 + $2a1
        tax 
        and #$01
        beq L_fea3
        lda cCia2PortA
        and #$fb
        ora SCREEN_BUFFER_1 + $b5
        sta cCia2PortA
        lda SCREEN_BUFFER_1 + $2a1
        sta cCia2IntControl
        txa 
        and #$12
        beq L_fe9d
        and #$02
        beq L_fe9a
        jsr L_fed6
        jmp L_fe9d
    L_fe9a:
        jsr L_ff07
    L_fe9d:
        jsr L_eebb
    L_fea0:
        jmp L_feb6
    L_fea3:
        txa 
    L_fea4:
        and #$02
        beq L_feae
        jsr L_fed6
        jmp L_feb6
    L_feae:
        txa 
        and #$10
        beq L_feb6
        jsr L_ff07
    L_feb6:
        lda SCREEN_BUFFER_1 + $2a1
        sta cCia2IntControl
    L_febc:
        pla 
        tay 
        pla 
        tax 
    L_fec0:
        pla 
    L_fec1:
        rti 

        .byte $c1,$27,$3e,$1a,$c5,$11,$74,$0e,$ed,$0c,$45,$06,$f0,$02,$46,$01
        .byte $b8,$00,$71,$00

    L_fed6:
        lda cCia2PortB
        and #$01
        sta SCREEN_BUFFER_1 + $a7
        lda cCia2TimerBLo
        sbc #$1c
        adc SCREEN_BUFFER_1 + $299
        sta cCia2TimerBLo
        lda cCia2TimerBHi
        adc SCREEN_BUFFER_1 + $29a
        sta cCia2TimerBHi
        lda #$11
        sta cCia2TimerbControl
        lda SCREEN_BUFFER_1 + $2a1
        sta cCia2IntControl
        lda #$ff
    L_fefe:
        sta cCia2TimerBLo
        sta cCia2TimerBHi
        jmp L_ef59
    L_ff07:
        lda SCREEN_BUFFER_1 + $295
        sta cCia2TimerBLo
        lda SCREEN_BUFFER_1 + $296
        sta cCia2TimerBHi
        lda #$11
        sta cCia2TimerbControl
        lda #$12
        eor SCREEN_BUFFER_1 + $2a1
        sta SCREEN_BUFFER_1 + $2a1
        lda #$ff
        sta cCia2TimerBLo
        sta cCia2TimerBHi
        ldx SCREEN_BUFFER_1 + $298
        stx SCREEN_BUFFER_1 + $a8
        rts 


    L_ff2e:
        tax 
        lda SCREEN_BUFFER_1 + $296
        rol 
        tay 
        txa 
        adc #$c8
        sta SCREEN_BUFFER_1 + $299
        tya 
        adc #$00
        sta SCREEN_BUFFER_1 + $29a
        rts 


        nop 
        nop 
    L_ff43:
        php 
        pla 
        and #$ef
        pha 
        pha 
        txa 
        pha 
        tya 
        pha 
        tsx 
        lda SCREEN_BUFFER_1 + $104,x
        and #$10
        beq L_ff58
        jmp ($0316)
    L_ff58:
        jmp ($0314)
    L_ff5b:
        jsr L_e518
    L_ff5e:
        lda vRaster
        bne L_ff5e
        lda vIRQFlags
        and #$01
        sta SCREEN_BUFFER_1 + $2a6
        jmp L_fddd
    L_ff6e:
        lda #$81
        sta cCia1IntControl
        lda cCia1TimerAControl
        and #$80
        ora #$11
        sta cCia1TimerAControl
        jmp L_ee8e

        .byte $03,$4c,$5b,$ff,$4c,$a3,$fd,$4c,$50,$fd,$4c,$15,$fd,$4c,$1a,$fd
        .byte $4c,$18,$fe

    L_ff93:
        jmp L_edb9
    L_ff96:
        jmp L_edc7
    L_ff99:
        jmp L_fe25
    L_ff9c:
        jmp L_fe34
        jmp L_ea87
        jmp L_fe21
    L_ffa5:
        jmp L_ee13
    L_ffa8:
        jmp L_eddd
    L_ffab:
        jmp L_edef
    L_ffae:
        jmp $edfe
    L_ffb1:
        jmp $ed0c
    L_ffb4:
        jmp $ed09
    L_ffb7:
        jmp L_fe07
    L_ffba:
        jmp L_fe00
    L_ffbd:
        jmp L_fdf9
    L_ffc0:
        jmp ($031a)
    L_ffc3:
        jmp ($031c)
    L_ffc6:
        jmp ($031e)
    L_ffc9:
        jmp ($0320)
    L_ffcc:
        jmp ($0322)
    L_ffcf:
        jmp ($0324)
    L_ffd2:
        jmp ($0326)
    L_ffd5:
        jmp L_f49e
    L_ffd8:
        jmp L_f5dd
        jmp L_f6e4
        jmp L_f6dd
    L_ffe1:
        jmp ($0328)
    L_ffe4:
        jmp ($032a)
        jmp ($032c)
    L_ffea:
        jmp L_f69b
        jmp L_e505
        jmp L_e50a
    L_fff3:
        jmp L_e500

        .byte $52,$52,$42
