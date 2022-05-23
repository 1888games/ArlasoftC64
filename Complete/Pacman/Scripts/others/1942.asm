//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $4400

//Start of disassembled code
* = $0314 "Base Address"


    L_0314:
        .byte $3c,$03
        .byte $66,$fe

    L_0318:
        .byte $47

    L_0319:
        inc L_f34a,x
        sta ($f2),y
        asl L_50e0 + $12

        .byte $f2,$33,$f3,$57,$f1,$b5,$e6,$ed,$f6,$3e,$f1,$2f,$f3,$66,$fe,$a5
        .byte $f4

    L_0332:
        sbc.a $00f5

        .byte $00,$00,$00,$00,$00,$00,$00,$ce,$19,$d0,$4e,$11,$d0,$a9,$00,$8d
        .byte $20,$d0,$8d,$21,$d0,$aa

    L_034b:
   
        sta vColorRam + $00,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
        sta vColorRam + $2e8,x
        inx 
        bne L_034b
    L_035a:
        ldx #$fb
        txs 
        stx $cc
        ldy #$13
    L_0361:
        lda $fd30,y
        sta L_0314,y
        dey 
        bpl L_0361
        ldx #$19
    L_036c:
        bit vScreenControl1
        bpl L_036c
    L_0371:
        bit vScreenControl1
        bmi L_0371
        dex 
        bne L_036c
        jsr L_fda3
        rol vScreenControl1
        cli 
    L_0380:
        jmp L_0b6f

    L_0383:
         .fill $7d, $0
        .byte $31,$3a,$30,$32,$3a,$39,$38,$20

    L_0408:
        .fill $3e1, $20
        .byte $20,$e2
        .fill $15, $20
        .byte $00,$0b,$08,$00,$00,$9e,$32,$30,$36

    L_0809:
        and ($00),y

        .byte $00,$00,$a9,$00,$a8,$85,$a5,$85,$ae,$a9,$09,$20,$47,$08,$20,$32
        .byte $08,$20,$48,$71,$20,$32,$08

    L_0822:
        lda #$00
        sta vScreenControl1
        jsr L_0832
        lda #$9b
        sta vScreenControl1
        jmp L_0a50
    L_0832:
        lda #$01
        tax 
    L_0835:
        tay 
        jsr L_ff80 + $3a
        lda #$00
        jsr L_ff80 + $3d
        lda #$00
        ldx #$ff
        ldy #$ff
        jmp L_ffd5
    L_0847:
        lda #$00
        sta $fb
        lda #$40
        sta $fc
        lda #$c2
        sta $b1
        lda #$36
    L_0855:
        sta $01
        jsr L_f838
        sei 
        lda #$05
        sta $01
        lda #$0b
        sta vScreenControl1
        jsr L_fe00
        lda #$37
        sta $01
        lda #$01
        sta $c0
        lda #$1b
        sta vScreenControl1
        jmp L_ff80 + $4

        .byte $d0,$0f,$2a,$91,$c1,$d1,$c1,$d0,$08,$8a,$91,$c1

    L_0883:
        iny 
        sei 
        lda #$35
        sta $01
        jsr L_ff41 + $d
        lda #$37
        sta $01
        cli 
        rts 



        .byte $3a,$5a,$0d,$20,$20,$20,$46,$41,$53,$54,$20,$53,$41,$56,$45,$20
        .byte $28,$48,$49,$47,$48,$29,$20,$45,$4e,$41,$42,$4c,$45,$44,$0d,$28
        .byte $43,$29,$31,$39,$38,$34,$20,$4e,$4f,$56,$41,$4c,$4f,$41,$44,$20
        .byte $4c,$54,$44,$2e,$20,$2d,$20,$4e,$4f,$2e,$4e,$31,$30,$31,$37,$0d
        .byte $8d,$02,$dd,$a9,$e7,$85,$01,$a9,$2f,$85,$00,$ad,$a6,$02,$f0,$0a
        .byte $a9,$25,$8d,$04,$dc,$a9,$a9,$3c,$8d,$32,$03,$a9,$03,$8d,$33,$03
        .byte $60,$8d,$05,$dc

    L_08f6:
        jmp L_ff6e
        sta $b7
        stx $bb
        sty $bc
        rts 


    L_0900:
        ldy #$06
        jsr L_fefe
        lda #$1f
        sta cCia1IntControl
        sta cCia2IntControl
        lda cCia1IntControl
        lda cCia2IntControl
        lda #$0c
        sta $fffe
        lda #$ff
        sta $ffff
        lda #$f0
        sta sVoc1FreqLo
        sta sVoc1SusRel
        lda #$0f
        sta sFiltMode
        lda #$00
        sta sVoc1Control
        sta sVoc1AttDec
        sta sVoc2Control
        sta sVoc3Control
        sta $a8
        sta $ab
        sta $b4
        sta $b5
        sta $a6
        lda #$21
        sta sVoc1Control
        lda #$96
        sta cCia1TimerALo
        lda #$00
        sta cCia1TimerAHi
        lda #$0d
        sta $a5
        lda #$11
        sta cCia1TimerAControl
        lda #$81
        sta cCia1IntControl
        cli 
        ldy #$00
    L_0962:
        lda #$00
        jsr L_feeb
        dey 
        bne L_0962
        lda #$80
        jsr L_feeb
        lda #$aa
        jsr L_feeb
        ldy #$00
        sty $aa
        lda $b7
        jsr L_feeb
    L_097d:
        cpy $b7
        beq L_0989
        lda ($bb),y
        jsr L_feeb
        iny 
        bne L_097d
    L_0989:
        lda $c1
        jsr L_feeb
        lda $c2
        sec 
        sbc #$01
        jsr L_feeb
        lda $ae
        jsr L_feeb
        lda $af
        jsr L_feeb
        lda $b0
        jsr L_feeb
        lda $b1
        clc 
        adc #$01
        jsr L_feeb
        lda $aa
        jsr L_feeb
        ldy #$00
        lda $b1
        beq L_09cc
    L_09b8:
        lda ($c1),y
        jsr L_feeb
        iny 
        bne L_09b8
        lda $aa
        jsr L_feeb
        dec $b1
        inc $c2
        jmp $feb4
    L_09cc:
        cpy $b0
        beq L_09d8
        lda ($c1),y
        jsr L_feeb
        iny 
        bne L_09cc
    L_09d8:
        lda $aa
        jsr L_feeb
        lda #$00
    L_09df:
        jsr L_feeb
        dey 
        bne L_09df
        sei 
        ldy #$06
        jmp L_fefe
    L_09eb:
        ldx $ab
        beq L_09eb
        sta sVoc1FreqHi
        sta $a8
        clc 
        adc $aa
        sta $aa
        ldx #$00
        stx $ab
        rts 


        lda #$00
        lda SCREEN_BUFFER_0 + $f9
        sta L_0f29 + $f,y
        lda SCREEN_BUFFER_0 + $f8
        sta L_0f39,y
        cpx #$06
        bne L_0a13
        jmp L_0883
    L_0a13:
        txa 
        pha 
        jsr $0c88
        pla 
        asl 
        asl 
        asl 
        tax 
        ldy #$00
    L_0a1f:
        lda SCREEN_BUFFER_0 + $106,y
        sta L_0ef3 + $3,x
        inx 
        iny 
        cpy #$08
        bne L_0a1f
        jsr $3dd3
        jsr L_0e0f
        ldy #$64
        jsr L_135e + $8
        lda #$ff
        sta SCREEN_BUFFER_0 + $e6
    L_0a3b:
        lda cCia1PortA
        cmp #$6f
    L_0a40:
        beq L_0a4a
        jsr $402a
        dec SCREEN_BUFFER_0 + $e6
        bne L_0a3b
    L_0a4a:
        jmp L_0883
        rti 
        bvc L_0a58
    L_0a50:
        jmp L_0b6f
    L_0a53:
        and #$00
        sta L_e9fa + $c
    L_0a58:
        sta L_e9fa + $d
        sta sVoc1Control
        sta sVoc2Control
        sta sVoc3Control
        ldx #$0a
        jsr L_0ab6
        rts 


    L_0a6a:
        ldx #$00
        lda $3a
        cmp L_0d9e + $3
        bne L_0a77
        ldy #$48
        bne L_0a79
    L_0a77:
        ldy #$50
    L_0a79:
        stx $73
        sty $74
        jsr L_1863
        jmp L_17ca
    L_0a83:
        lda $9a
        asl 
        asl 
        clc 
        adc #$81
        adc $9a
        sta $9a
        eor cCia1TimerALo
        rts 


    L_0a92:
        clc 
        adc $a3
        sta $99
        jsr L_0a83
        cmp $99
        bcs L_0aa1
        lda #$01
        rts 


    L_0aa1:
        and #$00
        rts 


    L_0aa4:
        lda vScreenControl1
        ora #$10
        sta vScreenControl1
        rts 


    L_0aad:
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        rts 


    L_0ab6:
        stx $19
    L_0ab8:
        stx $1a
    L_0aba:
        dec $1a
    L_0abc:
        bne L_0aba
        dec $19
        bne L_0ab8
        rts 


    L_0ac3:
        stx $20
        ldx #$00
    L_0ac7:
        lda $20
        sta SCREEN_BUFFER_1 + $78,x
        sta SCREEN_BUFFER_1 + $100,x
        sta SCREEN_BUFFER_1 + $200,x
        sta SCREEN_BUFFER_1 + $300,x
        tya 
        sta vColorRam + $78,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
        sta vColorRam + $300,x
        dex 
        bne L_0ac7
        rts 


    L_0ae6:
        lda #$01
        sta vIRQFlags
        pla 
        rti 
    L_0aed:
        lda #$01
        sta vIRQFlags
        dec L_112c
        bne L_0aff
        dec L_112c + $1
        bne L_0aff
        jsr L_813a
    L_0aff:
        pla 
    L_0b00:
        rti 
    L_0b01:
        pha 
        lda cCia1IntControl
        pla 
        rti 
        sei 
        lda #$36
        sta $01
        jmp (L_0318)
    L_0b0f:
        sei 
        ldx #$01
        ldy #$0b
        stx $fffe
        sty $ffff
        lda #$01
        sta cCia1TimerAControl
        lda #$f0
        sta vIRQMasks
        cli 
        rts 


    L_0b26:
        ldx #$77
    L_0b28:
        lda L_0dc2,x
        sta SCREEN_BUFFER_1 + $00,x
        lda L_0e3a,x
        sta vColorRam + $00,x
        dex 
        bpl L_0b28
        rts 


        ldx #$4f
    L_0b3a:
        lda L_0de3 + $7,x
        sta SCREEN_BUFFER_1 + $00,x
        lda L_0e3a + $28,x
        sta vColorRam + $28,x
        dex 
        bpl L_0b3a
        rts 


    L_0b4a:
        lda #$30
        bne L_0b50
    L_0b4e:
        lda #$38
    L_0b50:
        ldy #$48
        ldx #$08
        sta $1a
        sty $1c
        lda #$00
        sta $19
        sta $1b
        ldy #$00
    L_0b60:
        lda ($19),y
        sta ($1b),y
        iny 
        bne L_0b60
        inc $1a
        inc $1c
        dex 
        bne L_0b60
        rts 


    L_0b6f:
        sei 
        lda #$35
        sta $01
        ldx #$07
        ldy #$0b
        stx $fffa
        sty L_fffb
    L_0b7e:
        ldx #$01
        ldy #$0b
        stx $fffe
        sty $ffff
        cli 
        lda #$00
        sta $06
        sta $07
        ldx #$b8
        ldy #$0b
        stx L_0318
        sty L_0319
        lda #$96
        sta cCia2PortA
        lda #$44
        sta $0288
        lda #$00
        sta L_0cb4
        ldx #$20
        ldy #$08
        jsr L_0ac3
        jsr L_1f8c
        jsr L_1faf
        jsr L_0b26
    L_0bb8:
        lda #$35
        sta $01
    L_0bbc:
        ldx #$ff
        txs 
        jsr L_0aad
        jsr L_0a53
        jsr L_0c9f
        ldx #$1e
        jsr L_0ab6
        jsr $ee3a
        ldx #$14
        jsr L_0ab6
    L_0bd5:
        jsr L_0b0f
        ldx #$1f
    L_0bda:
        lda $10f8,x
        sta L_cffe + $1,x
        dex 
        bne L_0bda
        lda #$d0
        sta vScreenControl2
        jsr L_0b0f
    L_0beb:
        jsr L_0b4e
        lda #$01
        jsr L_8030
        beq L_0c42
        jsr L_0b0f
        lda #$ff
        sta vSprEnable
        ldx L_0cb4
    L_0c00:
        cpx #$04
        bne L_0c09
        ldx #$00
        stx L_0cb4
    L_0c09:
        inc L_0cb4
        lda L_0cb5,x
        sta $40
        lda L_0cb7 + $2,x
        pha 
        jsr L_14c2
        pla 
        beq L_0c22
        tax 
    L_0c1c:
        jsr L_1e33
        dex 
    L_0c20:
        bpl L_0c1c
    L_0c22:
        jsr L_1d9e
        jsr L_1e9c
        ldx #$20
        ldy #$08
        jsr L_0ac3
        ldx #$00
        stx $3d
        jsr L_0b4a
        jsr L_1f64
        and #$00
        ldy #$ff
        jsr L_8030
        bne L_0bd5
    L_0c42:
        jsr L_0aad
        jsr L_0a53
        jsr L_0b4a
        ldx #$0a
        jsr L_0ab6
        jsr L_0b0f
        ldx #$00
        stx $3e
        jsr L_1ffa
        jsr L_1587
        jsr $ee3a
        jsr L_1f64
        jsr L_0aa4
        ldx #$01
        stx $3d
        ldx #$01
        stx $3e
    L_0c6e:
        jsr L_1628
        lda $6e
        bne L_0c89
        lda L_0cd4
        beq L_0c7c
        bne L_0c6e
    L_0c7c:
        lda $3f
        beq L_0c6e
    L_0c80:
        jsr L_2e24
        lda #$00
        sta $3f
        beq L_0c6e
    L_0c89:
        ldx #$00
        stx $3d
        jsr L_0a53
        jsr L_f644
        lda #$02
        ldx $40
        ldy #$ff
        jsr L_8030
        jmp L_0bb8
    L_0c9f:
        lda #$02
        sta $15c4
        ldx #$1e
        ldy #$d0
        stx $1686
        sty $1687
        lda #$18
        sta $1588
        rts 



    L_0cb4:
         .byte $00

    L_0cb5:
        clc 
        clc 

    L_0cb7:
         .byte $14,$14,$00
        .byte $05,$01,$06,$9b

    L_0cbe:
        .byte $00

    L_0cbf:
        tax 
    L_0cc0:
        asl $06

    L_0cc2:
         .byte $00,$63
        .byte $61,$62

    L_0cc6:
        .byte $89,$87
        .byte $88

    L_0cc9:
        .byte $00,$63,$64
        .byte $65,$66,$67,$68,$69,$6a,$6b,$63

    L_0cd4:
        ora #$09

    L_0cd6:
         .byte $00

    L_0cd7:
        sed 
        sbc L_fbf7 + $3,y

        .byte $fc,$fd,$fe,$ff

    L_0cdf:
        .fill $84, $0

    L_0d63:
        clv 
        clv 
        clv 
        clv 
        clv 
        clv 
        lda L_b9b9,y
        lda L_b9b9,y
        tsx 
        tsx 
        tsx 
        tsx 
        lda L_b9b9,y
        lda L_baba,y
        tsx 
        lda L_bab9,y
        tsx 

    L_0d7e:
         .byte $bb,$bb,$bb,$02,$02,$07,$07,$02,$02,$07,$07,$02,$02,$07,$07,$02
        .byte $02,$07,$07,$02,$02,$07,$07,$02,$02,$07,$07,$02,$02,$07,$07,$02

    L_0d9e:
        .byte $02,$0f,$0f,$13
        .byte $15,$00

    L_0da4:
        .byte $00

    L_0da5:
        ora ($02,x)

        .byte $04,$08,$10,$20,$40,$80

    L_0dad:
        inc L_fbf7 + $6,x

        .byte $f7,$ef,$df,$bf,$7f

    L_0db5:
        asl $18
        rts 



    L_0db8:
         .byte $f9,$e7,$9f,$04,$10,$40

    L_0dbe:
        php 
        php 
        clc 

        .byte $0c

    L_0dc2:
        rti 

    L_0dc3:
         .byte $41,$41,$41,$41,$41,$41,$41,$41,$41,$45,$41,$41,$41,$41,$41,$41
        .byte $41,$45,$41,$41,$41,$41,$41,$41,$41,$45,$41,$41,$41,$41,$41,$41

    L_0de3:
        .byte $41,$41,$41,$41,$41,$41,$42,$43
        .byte $20,$20,$13,$03,$0f,$12,$05,$20,$20,$44,$20,$0c,$09,$16,$05,$13
        .byte $20,$44,$20

    L_0dfe:
        .byte $12,$0f,$0c,$0c,$13
        .byte $20,$44,$20

    L_0e06:
        .byte $08,$09,$07,$08,$2d,$13,$03,$0f,$12

    L_0e0f:
        ora $20
        lsr 
        lsr $47
        bmi L_0e3a + $c
        bmi L_0e3a + $e
        bmi L_0e3a + $10
        bmi L_0e3a + $2

        .byte $44,$20,$20,$1b,$1b,$1b,$20,$20,$44,$20,$20,$1c,$1c,$1c,$20,$20
        .byte $44,$20,$20,$20

    L_0e30:
        bmi L_0e3a + $28

        .byte $34,$30,$30,$30,$30,$20,$48,$49

    L_0e3a:
        .fill $29, $9
        .byte $00,$00,$07,$07,$07,$07,$07,$00,$00,$09,$00,$03,$03,$03,$03,$03
        .byte $00,$09,$00,$04,$04,$04,$04,$04,$00,$09,$00,$07,$07,$07,$07,$07
        .byte $07,$07,$07,$07,$07,$00,$09,$09,$09,$01,$01,$01,$01,$01,$01,$01
        .byte $00,$09,$00,$00,$05,$05,$05,$05,$05,$09,$00,$00,$02,$02,$02,$00
        .byte $00,$09,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$00,$09,$09

    L_0eb2:
        .fill $2f, $0

    L_0ee1:
        ldy L_bcb9 + $3,x
        lda L_bdbd,x
        ldx $bebe,y

        .byte $bf,$bf,$bf,$c0,$c0,$c0,$c1,$c1,$c1

    L_0ef3:
        .byte $02,$02,$02,$07,$07,$07,$02,$02,$02,$07,$07,$07,$02,$02,$02,$07

    L_0f03:
        .byte $07,$07,$c2,$c2,$c2,$c2,$c2,$c2
        .byte $c4,$c4,$c4,$c4,$c4,$c4,$c6,$c6,$c6,$c6,$c6,$c6,$c8,$c8,$c8,$c8
        .byte $c8,$c8,$ca,$ca,$ca,$ca,$ca,$ca,$cc,$cc,$cc,$cc,$cc,$cc

    L_0f29:
        .byte $02,$02,$02,$07,$07,$07,$02,$02,$02,$07,$07,$07,$02,$02,$02,$07

    L_0f39:
        .byte $07,$07,$02,$02,$02,$07,$07,$07,$02,$02,$02,$07,$07,$07,$02,$02
        .byte $02,$07,$07,$07

    L_0f4d:
        .fill $193, $0
        .byte $01,$02,$03,$04,$05,$06,$07

    L_10e7:
        php 
        ora #$0a
    L_10ea:
        adc $7d,x
        ror L_6d7f,x

        .byte $80,$81,$82

    L_10f2:
        .byte $04,$04,$54,$2b
        .byte $59
        .fill $13, $0
        .byte $9b,$37,$00,$00,$00,$08,$00,$14,$0f,$00,$00,$00,$00,$00,$00,$0e
        .byte $06,$01,$02,$03,$04,$00

    L_1120:
        ora ($02,x)

        .byte $03,$04,$05,$06,$07

    L_1127:
        eor $53
        jmp.a $0000

    L_112c:
         .byte $00,$00,$00,$00,$00,$00,$00,$00

    L_1134:
        ora ($0a,x)

    L_1136:
         .byte $64,$00,$00,$00,$00,$00,$00,$00

    L_113e:
        ora ($01,x)

        .byte $07,$03,$04,$02

    L_1144:
        plp 
        cli 
        dey 
        clv 
        inx 
        ora $7b40,y
        cpy #$7c
        rti 

    L_114f:
         .byte $7e,$00,$00,$00,$00,$00,$00,$00
        .byte $5e,$92,$c6

    L_115a:
        .byte $00,$00,$00
        .byte $ed,$f3,$f9

    L_1160:
        .byte $00,$00,$00,$03,$03,$07,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00

    L_1170:
        .byte $00,$00,$00,$00,$00,$50,$50,$00,$00,$00,$00,$00,$00,$00,$00,$54
        .byte $4f,$50,$20,$30,$30,$34,$30,$30,$30,$30,$20,$53,$4d,$47,$20,$30
        .byte $33,$32,$4e,$44,$20,$30,$30,$33,$35,$30,$30,$30,$20,$47,$4a,$46
        .byte $20,$30,$32,$33,$52,$44,$20,$30,$30,$33,$30,$30,$30,$30,$20,$41
        .byte $45,$42,$20,$30,$31,$34,$54,$48

    L_11b8:
        jsr L_3028 + $8

        .byte $32,$35,$30,$30,$30,$20,$2e,$2e,$2e,$20,$30,$31,$35,$54,$48,$20
        .byte $30,$30,$32,$30,$30,$30,$30,$20,$2e,$2e,$2e,$20,$30,$31,$36,$54
        .byte $48

    L_11dc:
        jsr L_3028 + $8

        .byte $30,$32,$30,$30,$30,$20,$2e,$2e,$2e,$20,$30,$31,$41,$20,$42,$20
        .byte $43,$20,$44,$20,$45,$20,$46,$20,$47,$20,$48,$20,$49,$20,$4a,$20
        .byte $4b,$20,$4c,$20,$4d,$20,$4e,$20,$4f

    L_1208:
        jsr L_2050

        .byte $51,$20,$52,$20,$53,$20,$54,$20,$55,$20,$56,$20,$57,$20,$58,$20
        .byte $59,$20,$5a,$20,$2e,$20,$2d,$20,$26,$20,$3f,$20,$20,$20,$2a,$20
        .byte $2b,$20,$2c,$20,$22,$20,$24,$20
        .fill $11, $2d

    L_1244:
        .byte $20,$54,$4f,$50,$20
        .byte $30,$30

    L_124b:
        .byte $30,$30,$30,$30,$30,$20,$20,$20,$20
        .byte $20,$30,$30

    L_1257:
        .byte $20,$20,$20,$20,$20,$20
        .byte $4d,$49,$44,$57,$41,$59
        .fill $18, $20

    L_127b:
        jsr L_4c20

        .byte $41,$53,$54,$20,$33,$32,$20,$53,$54,$41,$47,$45

    L_128a:
        .fill $19, $20
        .byte $47,$45,$54,$20,$52,$45,$41,$44,$59,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$54,$4f,$20,$50,$4c,$41,$59,$20,$20,$20,$20,$20,$20

    L_12c3:
        jsr L_541f + $1
    L_12c6:
        pha 
        eor $20
        lsr $49
        lsr $4c41
        jsr L_5241

        .byte $45,$41,$20,$20,$20,$20,$20,$20,$20,$20,$4c,$45,$59,$54,$45,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$52,$41,$42,$41
        .byte $55,$4c,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$41
        .byte $54,$54,$55,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$4d
        .byte $41,$52,$53,$48,$41,$4c,$4c,$20,$20

    L_131a:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $4d,$49,$44,$57,$41,$59,$20,$20,$20,$20,$20,$20,$53,$48,$4f,$4f
        .byte $54,$49,$4e,$47,$20,$44,$4f,$57,$4e,$20,$30

    L_133e:
        .byte $30,$30
        .byte $25
        .fill $18, $20
        .byte $42,$4f,$4e,$55,$53

    L_135e:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$30

    L_136a:
        .byte $30,$30,$30,$30
        .byte $20,$50,$54,$53,$20,$20,$20,$20,$20,$20,$20,$52,$58

    L_137b:
        .byte $31,$30,$30,$30,$3d,$30,$30,$30,$30
        .byte $20,$50,$54,$53
        .fill $28, $20
        .byte $4c,$49,$56,$45,$53,$20,$4c,$45,$46,$54,$20,$33,$20,$20,$20,$20
        .byte $20,$4c,$41,$53,$54,$20,$33,$32,$20,$53,$54,$41,$47,$45
        .fill $1b, $20
        .byte $52,$45,$41,$44,$59,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$50,$4c,$41,$59,$45,$52,$20,$31,$20

    L_1403:
        .byte $20,$20,$20
        .byte $20,$2a,$4d,$59,$4e,$53,$58,$51,$2a,$30,$2a,$51,$5c,$4b,$5a,$52
        .byte $53,$4d,$5d,$2a,$2a,$2a,$5d,$5e,$4f,$5a,$52,$4f,$58,$2a,$51,$5c
        .byte $4f,$4f,$58,$2a,$2a

    L_142b:
        .byte $00,$0b,$0c,$0f
        .byte $01,$0f,$0c,$0b,$00,$00,$00,$06,$0e,$03,$01,$03,$0e,$06,$00,$00
        .byte $00,$00,$00

    L_1442:
        pha 
        and #$00
        ldx #$06
    L_1447:
        sta L_0eb2,x
        dex 
        bpl L_1447
        pla 
        sta L_0eb2,y
        lda SCREEN_BUFFER_1 + $53
        sta $a5
        ldx #$06
        clc 
    L_1459:
        lda SCREEN_BUFFER_1 + $52,x
        adc L_0eb2,x
        cmp #$3a
        bcc L_1465
        sbc #$0a
    L_1465:
        sta SCREEN_BUFFER_1 + $52,x
        dex 
        bpl L_1459
        lda SCREEN_BUFFER_1 + $53
        cmp $a5
        beq L_147d
        lda $6f
        cmp #$05
        bcs L_147d
        inc $6f
        jsr L_149c
    L_147d:
        ldx #$00
    L_147f:
        lda SCREEN_BUFFER_1 + $52,x
        cmp SCREEN_BUFFER_1 + $6e,x
        beq L_148a
        bcs L_148d
        rts 


    L_148a:
        inx 
        bne L_147f
    L_148d:
        ldx #$06
    L_148f:
        lda SCREEN_BUFFER_1 + $52,x
        sta SCREEN_BUFFER_1 + $6e,x
        sta L_0e30,x
        dex 
    L_1499:
        bpl L_148f
        rts 


    L_149c:
        ldx #$04
        lda #$20
    L_14a0:
        sta SCREEN_BUFFER_1 + $5d,x
        sta SCREEN_BUFFER_1 + $65,x
        dex 
        bpl L_14a0
        ldx $6f
        bmi L_14b5
        lda #$1b
    L_14af:
        sta SCREEN_BUFFER_1 + $5d,x
        dex 
        bpl L_14af
    L_14b5:
        ldx $70
        bmi L_14c1
        lda #$1c
    L_14bb:
        sta SCREEN_BUFFER_1 + $65,x
        dex 
        bpl L_14bb
    L_14c1:
        rts 


    L_14c2:
        lda $40
        asl 
        tax 
        lda $b230,x
        sta $32
        lda L_b231,x
        sta $33
        lda L_ba5d + $3,x
        sta $44
        lda L_ba61,x
        sta $45
        rts 


    L_14db:
        lda #$a7
        sta $0cbd
        lda #$00
        sta L_0cbe
        lda #$b1
        sta L_0cbf
        rts 


    L_14eb:
        ldx $c2
        dex 
        inc L_2efd,x
        rts 


    L_14f2:
        and #$00
        sta SCREEN_BUFFER_0 + $310
        sta SCREEN_BUFFER_0 + $311
        clc 
        ldx #$05
    L_14fd:
        lda L_2efd,x
        adc SCREEN_BUFFER_0 + $310
        sta SCREEN_BUFFER_0 + $310
        dex 
        bpl L_14fd
        clc 
        ldx #$05
    L_150c:
        lda L_2efd + $6,x
        .break
        adc SCREEN_BUFFER_0 + $311
        sta SCREEN_BUFFER_0 + $311
    L_1515:
        dex 
        bpl L_150c
        rts 


    L_1519:
        ldx #$0b
        and #$00
    L_151d:
        sta L_0eb2 + $8,x
        sta L_0f4d + $109,x
        dex 
        bpl L_151d
        rts 


    L_1527:
        ldx #$0b
        and #$00
    L_152b:
        sta L_0f4d,x
        dex 
        bpl L_152b
        rts 


    L_1532:
        ldx #$02
        lda #$0c
    L_1536:
        sta L_0eb2 + $25,x
        dex 
        bpl L_1536
        lda #$10
        sta L_0eb2 + $28
        sta L_0eb2 + $29
        rts 


    L_1545:
        ldx #$07
        and #$00
    L_1549:
        sta L_0cdf + $28,x
        sta L_0cdf,x
        sta L_0cdf + $58,x
        sta L_0cdf + $60,x
        sta L_0cdf + $68,x
        dex 
        bpl L_1549
        ldx #$0b
        and #$00
    L_155f:
        sta L_0cdf + $70,x
        dex 
        bpl L_155f
        rts 


    L_1566:
        lda #$00
        sta $0da3
        sta L_0da4
        lda #$2d
        sta $ac
        lda #$2b
        sta $ae
        rts 


    L_1577:
        and #$00
        sta $c2
        ldx #$05
    L_157d:
        sta L_2efd,x
        sta L_2efd + $6,x
        dex 
        bpl L_157d
        rts 


    L_1587:
        lda #$18
        sta $40
        lda #$00
        sta vBorderCol
        sta $43
        sta $42
        sta L_0eb2 + $7
        sta $66
        sta $68
        sta $6a
        sta $6e
        sta $55
        sta L_0cd6
        sta L_0cd4
        sta $8f
        sta $97
        sta $a3
        sta $a2
        sta $ba
        sta $bc
        sta $c8
        sta $05
        sta $08
        lda #$01
        sta $aa
        jsr L_1566
        jsr L_1577
        lda #$02
        sta $6f
        sta $70
        jsr L_1519
        jsr L_1527
        jsr L_1545
        ldx #$02
        and #$00
    L_15d6:
        sta L_0eb2 + $20,x
        sta L_0eb2 + $2a,x
        dex 
        bpl L_15d6
        jsr L_1532
        ldx #$20
        ldy #$08
        jsr L_0ac3
        ldx #$00
        stx $3d
        lda #$ff
        sta vSprEnable
        sta vSprMCM
        ldx #$01
        stx vSprMCMCol0
        dex 
        stx vSprMCMCol1
        lda #$0f
        sta vSpr7Col
        jsr L_1e5c
        jsr L_1d9e
        jmp L_0b26
    L_160c:
        lda $c8
        bne L_1620
        lda $3d
        beq L_1620
        lda #$00
        sta $55
        lda $56
        cmp #$0a
        beq L_1621
        inc $56
    L_1620:
        rts 


    L_1621:
        lda #$03
        sta $56
        sta $55
        rts 


    L_1628:
        lda $55
        beq L_1668
        lda #$00
        sta $55
        ldx #$07
    L_1632:
        sta L_0cdf + $18,x
        sta L_0cdf + $40,x
        dex 
        bpl L_1632
        jsr L_1f64
        lda $8f
        beq L_1662
        ldx $91
        ldy $90
        jsr L_1fd0
        ldx #$02
    L_164b:
        lda L_10e7,x
        sta ($7a),y
        dey 
        beq L_1656
        dex 
        bpl L_164b
    L_1656:
        inc $91
        lda $91
        cmp #$19
        bne L_1662
        and #$00
        sta $8f
    L_1662:
        jsr L_17e6
        jmp L_19e8
    L_1668:
        lda $68
        beq L_1684
        lda #$00
        sta $68
        lda L_0cd4
        beq L_1678
        dec L_0cd4
    L_1678:
        jsr L_17e6
        jsr L_1871
        jsr L_1685
        jsr L_19d6
    L_1684:
        rts 


    L_1685:
        lda vSprSprColl
        sta $19
        lda $6a
        bne L_1691
        jmp L_1741
    L_1691:
        lda $6c
        beq L_1698
        jmp L_172c
    L_1698:
        dec $6b
        beq L_16ae
        lda #$1e
        sbc $6b
        tax 
        lda L_0d63,x
        sta L_47f9 + $6
        lda L_0d7e + $3,x
        sta vSpr7Col
        rts 


    L_16ae:
        dec $6f
        jsr L_149c
        lda $6f
        bpl L_16bc
        lda #$01
        sta $6e
        rts 


    L_16bc:
        lda $c2
        cmp #$03
        bcc L_16dc
        ldx $be
        ldy $bf
        stx $32
        sty $33
        ldx $c0
        ldy $c1
        stx $44
        sty $45
        jsr L_1e33
        lda #$02
        sta $c2
        jmp L_16e6
    L_16dc:
        jsr L_14c2
        jsr L_1e33
        and #$00
        sta $c2
    L_16e6:
        jsr L_1527
        jsr L_1d9e
        lda #$03
        sta $56
        jsr L_1f64
        jsr L_1532
        jsr L_1545
        and #$00
        sta $8f
        sta $97
        sta $bc
        jsr L_1566
        ldx #$00
        stx $3d
        lda #$00
        sta $66
        sta $42
        sta L_0cc2
        jsr L_14db
        jsr L_2204
        lda #$01
    L_1719:
        sta vSprMCMCol0
        inc $6c
        lda #$0f
        sta vSpr7Col
        lda #$05
        ldx $6f
        ldy #$02
        jmp L_8030
    L_172c:
        ldx $ffff
        cpx #$80
        bcc L_1734
        rts 


    L_1734:
        lda #$00
        sta $6a
        ldx #$01
        stx $3e
        ldx #$01
        stx $3d
        rts 


    L_1741:
        ldx #$0b
    L_1743:
        lda L_0f4d,x
        bne L_174c
        dex 
        bpl L_1743
        rts 


    L_174c:
        lda $66
        bne L_175d
        lda $42
        bne L_178f
        lda $19
        and #$80
        beq L_175d
        jsr L_1790
    L_175d:
        lda $0da3
        beq L_1776
        lda $b0
        cmp #$01
        bne L_1776
        lda $19
        and #$08
        beq L_1776
        lda #$03
        sta $b0
        lda #$01
        sta $b6
    L_1776:
        lda L_0da4
        beq L_178f
        lda $b2
        cmp #$01
        bne L_178f
        lda $19
        and #$10
        beq L_178f
        lda #$03
        sta $b2
        lda #$01
        sta $b7
    L_178f:
        rts 


    L_1790:
        lda #$02
        sta $70
        jsr L_149c
        lda #$01
        sta $6a
        ldx #$00
        stx $3e
        lda #$1e
        sta $6b
        lda #$00
        sta $6c
        pha 
        lda #$06
        sta L_e9fa + $c
        pla 
        rts 


    L_17af:
        ldx #$07
        stx $19
    L_17b3:
        ldx $19
        lda L_0cdf,x
        beq L_17c5
        lda L_0cdf + $20,x
        pha 
        jsr L_185b
        pla 
        jsr L_1fe1
    L_17c5:
        dec $19
        bpl L_17b3
        rts 


    L_17ca:
        clc 
        lda $73
        adc $7c
        sta $75
        lda $74
        adc $7d
        sta $76
        rts 


    L_17d8:
        clc 
        lda $73
        adc $7c
        sta $77
        lda $74
        adc $7d
        sta $78
        rts 


    L_17e6:
        lda #$07
        sta $72
    L_17ea:
        ldx $72
        lda L_0cdf,x
        bne L_17f4
        jmp L_1851
    L_17f4:
        lda L_0cdf + $18,x
        beq L_1804
        lda L_0cdf + $20,x
        pha 
        jsr L_185b
    L_1800:
        pla 
        jsr L_1fe1
    L_1804:
        ldx $72
        lda #$01
        sta L_0cdf + $18,x
        dec L_0cdf + $8,x
        lda L_0cdf + $8,x
        cmp #$03
        bne L_181d
        and #$00
        sta L_0cdf,x
        jmp L_1851
    L_181d:
        jsr L_185b
        jsr L_1fdb
        sta $7c
        ldx $72
        sta L_0cdf + $20,x
        jsr L_0a6a
        ldx $72
        lda L_0cd7,x
        sta $7e
        sta $7c
        jsr L_1863
        jsr L_17d8
        ldy #$07
    L_183e:
        lda ($75),y
        ora $9c
        sta ($77),y
        dey 
        bpl L_183e
        ldx $72
        jsr L_185b
        lda $7e
        jsr L_1fe1
    L_1851:
        dec $72
        lda $72
        bmi L_185a
        jmp L_17ea
    L_185a:
        rts 


    L_185b:
        lda L_0cdf + $8,x
        ldy L_0cdf + $10,x
        tax 
        rts 


    L_1863:
        lda #$00
        sta $7d
        ldx #$02
    L_1869:
        asl $7c
        rol $7d
        dex 
        bpl L_1869
        rts 


    L_1871:
        lda #$07
        sta $72
    L_1875:
        ldx $72
        lda L_0cdf + $28,x
        bne L_187f
        jmp L_18d5
    L_187f:
        lda L_0cdf + $40,x
        beq L_188f
        lda L_0cdf + $48,x
        pha 
        jsr L_18df
        pla 
        jsr L_1fe1
    L_188f:
        ldx $72
        lda #$01
        sta L_0cdf + $40,x
        jsr L_18e7
        bne L_18a3
        and #$00
        sta L_0cdf + $28,x
        jmp L_18d5
    L_18a3:
        jsr L_18df
        jsr L_1fdb
        sta $7c
        ldx $72
        sta L_0cdf + $48,x
        jsr L_0a6a
        lda $72
        sta $7e
        sta $7c
        jsr L_1863
        jsr L_17d8
        ldy #$07
    L_18c1:
        lda ($75),y
        ora L_0cdf + $7c,y
        sta ($77),y
        dey 
        bpl L_18c1
        ldx $72
        jsr L_18df
        lda $7e
        jsr L_1fe1
    L_18d5:
        dec $72
        lda $72
        bmi L_18de
        jmp L_1875
    L_18de:
        rts 


    L_18df:
        lda L_0cdf + $38,x
        ldy L_0cdf + $30,x
        tax 
        rts 


    L_18e7:
        lda L_0cdf + $50,x
        and #$02
        beq L_18f4
        jsr L_199f
        jmp L_1912
    L_18f4:
        lda L_0cdf + $50,x
        and #$10
        beq L_18fe
        jsr L_1965
    L_18fe:
        lda L_0cdf + $50,x
        and #$08
        beq L_1908
        jsr L_1977
    L_1908:
        lda L_0cdf + $50,x
        and #$04
        beq L_1912
        jsr L_198d
    L_1912:
        ldy #$07
        and #$00
    L_1916:
        sta L_0cdf + $7c,y
    L_1919:
        dey 
        bpl L_1916
        ldy #$f0
        lda L_0cdf + $58,x
        beq L_1925
        ldy #$0f
    L_1925:
        sty $9d
        lda L_0cdf + $60,x
        bne L_1939
        ldy #$03
        lda $9d
    L_1930:
        sta L_0cdf + $7c,y
        dey 
        bpl L_1930
        jmp L_1945
    L_1939:
        ldy #$07
        lda $9d
    L_193d:
        sta L_0cdf + $7c,y
        dey 
        cpy #$03
        bne L_193d
    L_1945:
        lda L_0cdf + $38,x
        cmp #$19
        bcs L_1956
        lda L_0cdf + $30,x
        beq L_1956
        cmp #$28
        beq L_1956
        rts 


    L_1956:
        and #$00
        sta L_0cdf + $28,x
        lda L_0cdf + $68,x
        tay 
        and #$00
        sta L_0cdf + $70,y
        rts 


    L_1965:
        lda L_0cdf + $58,x
        bne L_1973
        dec L_0cdf + $30,x
        lda #$01
        sta L_0cdf + $58,x
        rts 


    L_1973:
        dec L_0cdf + $58,x
        rts 


    L_1977:
        lda L_0cdf + $60,x
        beq L_197f
        inc L_0cdf + $38,x
    L_197f:
        ldy #$00
        lda $56
        and #$01
        bne L_1988
        iny 
    L_1988:
        tya 
        sta L_0cdf + $60,x
        rts 


    L_198d:
        lda L_0cdf + $58,x
        beq L_199b
        inc L_0cdf + $30,x
        and #$00
        sta L_0cdf + $58,x
        rts 


    L_199b:
        inc L_0cdf + $58,x
        rts 


    L_199f:
        sec 
        lda $0cbd
        sbc #$14
        sta $a0
        lda L_0cbe
        sbc #$00
        ldy #$02
    L_19ae:
        lsr 
        ror $a0
        dey 
        bpl L_19ae
        lda $a0
        cmp L_0cdf + $30,x
        beq L_19c8
        bcc L_19bf
        bcs L_19c5
    L_19bf:
        jsr L_1965
        jmp L_19c8
    L_19c5:
        jsr L_198d
    L_19c8:
        lda $08
        bne L_19cf
        inc $08
        rts 


    L_19cf:
        lda #$00
        sta $08
        jmp L_1977
    L_19d6:
        jsr L_19dc
        jmp L_1c68
    L_19dc:
        jsr L_19e8
        jsr L_1acc
        jsr L_1b56
        jmp L_1bde
    L_19e8:
        lda #$06
        sta $81
    L_19ec:
        ldx $81
        lda L_0eb2 + $8,x
        bne L_1a53
        lda L_0f4d,x
        bne L_19fb
        jmp L_1a53
    L_19fb:
        lda L_0f4d + $183,x
        cmp #$ff
        beq L_1a53
        txa 
        asl 
        asl 
        asl 
        asl 
        tax 
    L_1a08:
        lda L_0f4d + $c,x
        bne L_1a53
        ldy L_0f4d + $d,x
        lda L_0f4d + $e,x
        sta $7c
        lda L_0f4d + $f,x
        ldx $7c
        jsr L_1a95
        jsr L_1a2c
        bne L_1a3e
        inc $84
        jsr L_1a2c
        bne L_1a3e
        jmp L_1a53
    L_1a2c:
        ldx #$02
    L_1a2e:
        jsr L_1a5b
        cmp #$f8
        bcs L_1a3b
        dex 
        bpl L_1a2e
        and #$00
        rts 


    L_1a3b:
        lda #$01
        rts 


    L_1a3e:
        ldx $81
        and #$00
        sta L_0eb2 + $14,x
        lda #$01
        sta L_0eb2 + $8,x
        jsr L_17af
        jsr L_1a85
        jsr L_14eb
    L_1a53:
        dec $81
        bmi L_1a5a
        jmp L_19ec
    L_1a5a:
        rts 


    L_1a5b:
        stx $87
        sty $88
        clc 
        txa 
        adc $82
        tay 
        cpy #$01
        bcc L_1a7e
        cpy #$27
        bcs L_1a7e
        ldx $84
        cpx #$18
        bcs L_1a7e
        cpx #$03
        bcc L_1a7e
        jsr L_1fdb
        ldy $88
        ldx $87
        rts 


    L_1a7e:
        and #$00
        ldy $88
        ldx $87
        rts 


    L_1a85:
        and #$00
        ldx #$07
    L_1a89:
        sta L_0cdf,x
        dex 
        bpl L_1a89
        lda #$01
        sta L_0cd4
        rts 


    L_1a95:
        sty $84
        stx $82
        sta $83
        sec 
        lda $82
        sbc #$18
        sta $85
        lda $83
        sbc #$00
        sta $86
        ldx #$02
    L_1aaa:
        lsr $86
        ror $85
        dex 
        bpl L_1aaa
        lda $85
        sta $87
        sec 
        lda $84
        sbc #$32
        sta $85
        ldx #$02
    L_1abe:
        lsr $85
        dex 
        bpl L_1abe
        ldx $87
        ldy $85
        stx $82
        sty $84
        rts 


    L_1acc:
        lda #$02
        sta $81
    L_1ad0:
        ldx $81
        lda L_0eb2 + $f,x
        bne L_1b4e
        lda L_0f4d + $7,x
        bne L_1adf
        jmp L_1b4e
    L_1adf:
        txa 
        asl 
        asl 
        asl 
        asl 
        tax 
        lda L_0f4d + $7c,x
        bne L_1b4e
        ldy L_0f4d + $7d,x
        lda L_0f4d + $7e,x
        sta $7c
        lda L_0f4d + $7f,x
        ldx $7c
        jsr L_1a95
        inc $84
        inc $84
        inc $84
        ldx #$05
    L_1b02:
        jsr L_1a5b
        cmp #$f8
        bcs L_1b0f
        dex 
        bpl L_1b02
        jmp L_1b4e
    L_1b0f:
        ldy #$04
        lda #$01
        jsr L_1442
        jsr L_17af
        jsr L_1a85
        ldx $81
        lda $97
    L_1b20:
        beq L_1b25
        dec L_0eb2 + $25,x
    L_1b25:
        dec L_0eb2 + $25,x
        lda L_0eb2 + $25,x
        pha 
        asl 
        sta L_0eb2 + $2a,x
        pla 
        beq L_1b35
        bpl L_1b4e
    L_1b35:
        lda #$0c
        sta L_0eb2 + $25,x
        and #$00
        sta L_0eb2 + $20,x
        sta L_0eb2 + $1b,x
        lda #$01
        sta L_0eb2 + $f,x
        ldy #$03
        lda #$01
        jsr L_1442
    L_1b4e:
        dec $81
        bmi L_1b55
        jmp L_1ad0
    L_1b55:
        rts 


    L_1b56:
        lda L_0eb2 + $12
        bne L_1b9f
        lda L_0f4d + $a
        bne L_1b68
        jmp L_1b9f
        lda L_0f4d + $ac
        bne L_1b9f
    L_1b68:
        ldy L_0f4d + $ad
        ldx L_0f4d + $ae
        lda L_0f4d + $af
        jsr L_1a95
        clc 
        lda $84
        adc #$02
        sta $19
        sta $84
        adc #$04
        sta $1a
        ldx #$06
    L_1b83:
        cpx #$04
        bne L_1b8d
        lda $1a
        sta $84
        bne L_1b95
    L_1b8d:
        cpx #$02
        bne L_1b95
        lda $19
        sta $84
    L_1b95:
        jsr L_1a5b
        cmp #$f8
        bcs L_1ba0
        dex 
        bpl L_1b83
    L_1b9f:
        rts 


    L_1ba0:
        ldy #$04
        lda #$01
        jsr L_1442
        jsr L_17af
        jsr L_1a85
        lda $97
        beq L_1bb4
        dec L_0eb2 + $28
    L_1bb4:
        dec L_0eb2 + $28
        lda L_0eb2 + $28
        pha 
        asl 
        sta L_0eb2 + $2d
        pla 
        beq L_1bc4
        bpl L_1b9f
    L_1bc4:
        lda #$10
        sta L_0eb2 + $28
        and #$00
        sta L_0eb2 + $23
        sta L_0eb2 + $1e
        lda #$01
        sta L_0eb2 + $12
        ldy #$03
        lda #$02
        jsr L_1442
        rts 


    L_1bde:
        lda L_0eb2 + $13
        bne L_1c29
        lda L_0f4d + $b
        bne L_1beb
        jmp L_1c29
    L_1beb:
        lda L_0f4d + $bc
        bne L_1c29
        ldy L_0f4d + $bd
        ldx L_0f4d + $be
        lda L_0f4d + $bf
        jsr L_1a95
        clc 
        lda $84
        adc #$05
        sta $19
        sta $84
        adc #$05
        sta $1a
        inc $82
        ldx #$15
    L_1c0d:
        cpx #$0d
        bne L_1c17
        lda $1a
        sta $84
        bne L_1c1f
    L_1c17:
        cpx #$08
        bne L_1c1f
        lda $19
        sta $84
    L_1c1f:
        jsr L_1a5b
        cmp #$f8
        bcs L_1c2a
        dex 
        bpl L_1c0d
    L_1c29:
        rts 


    L_1c2a:
        ldy #$04
        lda #$02
        jsr L_1442
        jsr L_17af
        jsr L_1a85
        lda $97
        beq L_1c3e
        dec L_0eb2 + $29
    L_1c3e:
        dec L_0eb2 + $29
        lda L_0eb2 + $29
        pha 
        asl 
        sta L_0eb2 + $2e
        pla 
        beq L_1c4e
        bpl L_1c29
    L_1c4e:
        lda #$10
        sta L_0eb2 + $29
        and #$00
        sta L_0eb2 + $24
        sta L_0eb2 + $1f
        lda #$01
        sta L_0eb2 + $13
        ldy #$03
        lda #$05
        jsr L_1442
        rts 


    L_1c68:
        jsr L_1d36
        lda $6a
        beq L_1c70
        rts 


    L_1c70:
        ldy L_0cbf
        ldx $0cbd
        lda L_0cbe
        jsr L_1a95
        jsr L_1c89
        bne L_1c9c
        inc $84
        jsr L_1c89
        bne L_1c9c
        rts 


    L_1c89:
        ldx #$03
    L_1c8b:
        jsr L_1a5b
        cmp #$0b
        bcc L_1c98
        dex 
        bpl L_1c8b
        and #$00
        rts 


    L_1c98:
        tay 
        lda #$01
        rts 


    L_1c9c:
        cpy #$08
        bcs L_1ca3
        jmp L_1d2a
    L_1ca3:
        pha 
        lda #$0c
        sta L_e9fa + $c
        pla 
        ldy #$04
        lda #$01
        jsr L_1442
        and #$00
        sta $8f
        lda $40
        and #$03
        bne L_1cc0
        lda #$01
        sta $97
        rts 


    L_1cc0:
        cmp #$02
        bne L_1cff
        lda $97
        beq L_1cca
        sta $bc
    L_1cca:
        lda $0da3
        bne L_1d35
        lda L_0da4
        bne L_1d35
        lda #$01
        sta $0da3
        sta L_0da4
        lda #$05
        sta $b8
        sta $b9
        and #$00
        sta $97
        sta $b6
        sta $b7
        sta $b0
        sta $b2
        lda #$26
        sta $b4
        sta $b5
        lda #$3b
        sta $ae
        lda #$1a
        sta $ac
        jmp L_2c77
    L_1cff:
        cmp #$01
        beq L_1d23
        ldx #$0b
    L_1d05:
        txa 
        asl 
        asl 
        asl 
        asl 
        tay 
        lda L_0f4d + $c,y
        bne L_1d1f
        lda L_0f4d,x
        beq L_1d1f
        and #$00
        sta L_0eb2 + $14,x
        lda #$01
        sta L_0eb2 + $8,x
    L_1d1f:
        dex 
        bpl L_1d05
        rts 


    L_1d23:
        lda #$02
        sta $70
        jmp L_149c
    L_1d2a:
        lda $66
        bne L_1d35
        lda $42
        bne L_1d35
        jsr L_1790
    L_1d35:
        rts 


    L_1d36:
        lda $0da3
        bne L_1d41
        lda L_0da4
        bne L_1d41
        rts 


    L_1d41:
        ldy L_0cbf
        ldx $0cbd
        lda L_0cbe
        jsr L_1a95
        sec 
        lda $82
        sbc #$02
        sta $82
        lda $0da3
        beq L_1d6c
        lda $b0
        cmp #$01
        bne L_1d6c
        jsr L_1d8c
        beq L_1d6c
        lda #$03
        sta $b0
        lda #$01
        sta $b6
    L_1d6c:
        clc 
        lda $82
        adc #$05
        sta $82
        lda L_0da4
        beq L_1d8b
        lda $b2
        cmp #$01
        bne L_1d8b
        jsr L_1d8c
        beq L_1d8b
        lda #$03
        sta $b2
        lda #$01
        sta $b7
    L_1d8b:
        rts 


    L_1d8c:
        ldx #$03
    L_1d8e:
        jsr L_1a5b
        cmp #$0b
        bcc L_1d9b
        dex 
        bpl L_1d8e
        and #$00
        rts 


    L_1d9b:
        lda #$01
        rts 


    L_1d9e:
        ldy #$00
        lda ($32),y
        sta $3b
        iny 
        lda ($32),y
        sta $3c
        iny 
        lda ($32),y
        sta $34
        iny 
        lda ($32),y
        sta $35
        iny 
        lda ($32),y
        sta $50
        iny 
        lda ($32),y
        sta $51
        iny 
        lda ($32),y
        sta $6d
        iny 
        lda ($32),y
        tay 
        and #$01
        tax 
        lda L_0d9e + $3,x
        sta $3a
        tya 
        and #$20
        beq L_1dd7
        lda #$01
        sta $41
    L_1dd7:
        tya 
        and #$40
        beq L_1de0
        lda #$01
        sta $43
    L_1de0:
        rts 


    L_1de1:
        ldy #$00
        lda ($36),y
        sta $3b
        iny 
        lda ($36),y
        sta $3c
        iny 
        lda ($36),y
        sta $38
        iny 
        lda ($36),y
        sta $39
        iny 
        lda ($36),y
        sta $50
        iny 
        lda ($36),y
        sta $51
    L_1e00:
        iny 
        lda ($36),y
        sta $6d
        iny 
        lda ($36),y
        tay 
        and #$01
        tax 
        lda L_0d9e + $3,x
        sta $3a
        tya 
        and #$20
        beq L_1e32
        lda #$01
        sta $42
        ldx #$00
        stx $3e
        lda $b0
        cmp #$03
        beq L_1e28
        lda #$02
        sta $b0
    L_1e28:
        lda $b2
        cmp #$03
        beq L_1e32
        lda #$02
        sta $b2
    L_1e32:
        rts 


    L_1e33:
        sec 
        lda $32
        sbc #$08
        sta $32
        bcs L_1e3e
        dec $33
    L_1e3e:
        rts 


    L_1e3f:
        sec 
        lda $36
        sbc #$08
        sta $36
        bcs L_1e4a
        dec $37
    L_1e4a:
        rts 


    L_1e4b:
        stx $19
        sty $1a
        ldx $1d
        lda $19
        sta SCREEN_BUFFER_0 + $100,x
        lda $1a
        sta SCREEN_BUFFER_0 + $120,x
        rts 


    L_1e5c:
        jsr L_14c2
        jsr L_1527
        lda L_0eb2 + $7
        beq L_1e89
        ldx #$00
        stx $3d
        jsr L_0a53
        jsr $f974
        jsr L_14f2
        lda #$0a
        sta $56
        ldy #$ff
        lda #$04
        jsr L_8030
        jsr L_0a53
        jsr $ee3a
        ldx #$01
        stx $3d
    L_1e89:
        and #$00
        sta L_0eb2 + $7
        sta $42
        ldx $40
        ldy #$06
        lda #$03
        jsr L_8030
        jmp L_14db
    L_1e9c:
        lda $34
        sta $38
        lda $35
        sta $39
        lda $32
        sta $36
        lda $33
        sta $37
        lda #$00
        sta $41
        ldy #$00
        lda ($32),y
        sta $3b
        iny 
        lda ($32),y
        sta $3c
        lda #$18
        sta $1d
    L_1ebf:
        lda $38
        bpl L_1ee4
        dec $39
        bne L_1ed0
        jsr L_1e3f
        jsr L_1de1
        jmp L_1ebf
    L_1ed0:
        ldy #$02
        lda ($36),y
        sta $38
        ldy #$00
        lda ($36),y
        sta $3b
        iny 
        lda ($36),y
        sta $3c
        jmp L_1ebf
    L_1ee4:
        ldx $38
        lda SCREEN_BUFFER_0 + $200,x
        sta $19
        lda SCREEN_BUFFER_0 + $280,x
        sta $1a
        clc 
        lda $3b
        adc $19
        tax 
        lda $3c
        adc $1a
        tay 
        jsr L_1e4b
        dec $38
    L_1f00:
        dec $1d
        ldx $1d
        cpx #$03
        bpl L_1ebf
        dec $34
        bpl L_1f1f
        dec $35
        bne L_1f19
        jsr L_1e33
        jsr L_1d9e
        jmp L_1f1f
    L_1f19:
        ldy #$02
        lda ($32),y
        sta $34
    L_1f1f:
        lda $41
        beq L_1f63
        dec $40
        bne L_1f2d
        lda #$18
        sta $40
        inc $aa
    L_1f2d:
        jsr L_1e5c
        jsr L_1d9e
        jsr L_1532
        jsr L_1545
        jsr L_1577
        inc $a2
        lda $a2
        and #$03
        bne L_1f46
        inc $a3
    L_1f46:
        and #$00
        sta $0da3
        sta L_0da4
        jsr L_149c
        ldx #$01
        stx $3e
        jsr L_1566
        lda #$01
        sta vSprMCMCol0
        lda $bc
        beq L_1f63
        sta $97
    L_1f63:
        rts 


    L_1f64:
        jsr L_1e9c
        ldx #$03
    L_1f69:
        lda $0340,x
        sta $19
        lda L_035a,x
        sta $1a
        lda SCREEN_BUFFER_0 + $100,x
        sta $20
        lda SCREEN_BUFFER_0 + $120,x
        sta $21
        ldy #$26
    L_1f7f:
        lda ($20),y
        sta ($19),y
        dey 
        bne L_1f7f
        inx 
        cpx #$19
        bne L_1f69
        rts 


    L_1f8c:
        ldx #$00
        ldy #$44
        stx $19
        sty $1a
    L_1f94:
        lda $19
        sta $0340,x
        lda $1a
        sta L_035a,x
        lda $19
        clc 
        adc #$28
        sta $19
        bcc L_1fa9
        inc $1a
    L_1fa9:
        inx 
        cpx #$1a
        bne L_1f94
        rts 


    L_1faf:
        ldx #$00
        stx $19
        stx $1a
    L_1fb5:
        lda $19
        sta SCREEN_BUFFER_0 + $200,x
        lda $1a
        sta SCREEN_BUFFER_0 + $280,x
        clc 
        lda $19
        adc #$26
        sta $19
        bcc L_1fca
        inc $1a
    L_1fca:
        inx 
        cpx #$80
        bne L_1fb5
        rts 


    L_1fd0:
        lda $0340,x
        sta $7a
        lda L_035a,x
        sta $7b
        rts 


    L_1fdb:
        jsr L_1fd0
        lda ($7a),y
        rts 


    L_1fe1:
        pha 
        jsr L_1fd0
        pla 
        sta ($7a),y
        rts 


    L_1fe9:
        lda #$7f
        sta cCia1IntControl
        and vScreenControl1
        sta vScreenControl1
        lda #$01
        sta vIRQMasks
        rts 


    L_1ffa:
        sei 
        ldx #$dc
        ldy #$20
        stx $fffe
        sty $ffff
        jsr L_1fe9
        lda #$e6
        sta vRaster
        cli 
        rts 


        pha 
        nop 
        lda #$00
        sta vBackgCol1
        sta vBackgCol2
        sec 
        lda #$0e
    L_201c:
        sbc #$01
        bne L_201c
    L_2020:
        lda vScreenControl1
    L_2023:
        and #$e0
        ora $56
        and #$f7
        sta vScreenControl1
        jsr L_160c
        lda $3a
    L_2031:
        sta vMemControl
        lda $56
        cmp #$06
    L_2038:
        bne L_203e
        lda #$01
        bne L_2040
    L_203e:
        lda #$07
    L_2040:
        sta $2060
    L_2043:
        lda vScreenControl2
        and #$f7
    L_2048:
        sta vScreenControl2
    L_204b:
        lda #$5d
        sta $fffe
    L_2050:
        lda #$20
        sta $ffff
    L_2055:
        lda #$55
        sta vRaster
        jmp L_0ae6
        pha 
        sec 
        lda #$07
    L_2061:
        sbc #$01
        bne L_2061
        lda $50
        sta vBackgCol1
        lda $6d
        sta vBackgCol0
        lda $51
        sta vBackgCol2
        lda L_0f4d + $183
        sta L_47e9 + $f
        lda L_0f4d + $184
    L_207d:
        sta L_47f9
        lda L_0f4d + $185
        sta L_47f9 + $1
        lda L_0f4d + $186
        sta L_47f9 + $2
        lda L_0f4d + $187
        sta L_47f9 + $3
        lda L_0f4d + $188
        sta L_47f9 + $4
        lda L_0f4d + $189
        sta L_47f9 + $5
        lda $c8
        bne L_20a6
        lda #$01
        sta $68
    L_20a6:
        lda #$b8
        sta $fffe
        lda #$20
        sta $ffff
        lda #$5a
        sta vRaster
        jmp L_0ae6
        pha 
        lda $56
        cmp #$05
        bcc L_20ca
    L_20bf:
        txa 
        pha 
        tya 
        pha 
        jsr L_2c90
        pla 
        tay 
        pla 
        tax 
    L_20ca:
        lda #$dc
        sta $fffe
        lda #$20
        sta $ffff
        lda #$e6
        sta vRaster
        jmp L_0ae6
        pha 
        txa 
        pha 
        tya 
        pha 
        lda $3e
        bne L_20e8
        jmp L_217c
    L_20e8:
        lda #$00
        sta L_0cc2
        lda $c8
        bne L_214a
        lda cCia1PortA
        lsr 
        bcs L_20fa
        jsr L_2498
    L_20fa:
        lsr 
        bcs L_2100
        jsr L_2489
    L_2100:
        lsr 
        bcs L_2106
        jsr L_2465
    L_2106:
        lsr 
        bcs L_210c
        jsr L_2441
    L_210c:
        lsr 
        bcs L_211c
        lda $ba
        bne L_2116
        jsr L_24a7
    L_2116:
        lda #$01
        sta $ba
        bne L_2120
    L_211c:
        and #$00
        sta $ba
    L_2120:
        lda $66
        bne L_217c
        lda $70
        bmi L_214a
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        cmp #$ef
        bne L_214a
        lda #$01
        sta $66
        dec $70
        jsr L_149c
        lda #$08
        sta L_0cc0
        sta $0cc1
        lda #$00
        sta L_0cc9
    L_214a:
        lda $06
    L_214c:
        beq L_217c
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        cmp #$df
        beq L_2161
        lda #$00
        sta $05
        jmp L_217c
    L_2161:
        lda $05
        beq L_2168
        jmp L_217c
    L_2168:
        lda #$01
        sta $05
        ldy #$00
        ldx #$01
        lda $c8
    L_2172:
        beq L_2177
        ldy #$0f
        dex 
    L_2177:
        stx $c8
        sty sFiltMode
    L_217c:
        lda $c8
        bne L_2186
        jsr L_e96e
        jsr L_23fb
    L_2186:
        jsr L_21e3
        lda $c8
        beq L_2199
        ldx #$7c
    L_218f:
        ldy #$00
    L_2191:
        dey 
        bpl L_2191
        dex 
        bpl L_218f
        bmi L_219f
    L_2199:
        jsr L_2507
        jsr L_224e
    L_219f:
        lda #$1b
        sta vScreenControl1
        lda #$00
        sta vBackgCol0
        sta vBorderCol
        lda #$0c
    L_21ae:
        sta vBackgCol1
        lda #$0f
        sta vBackgCol2
        lda vScreenControl2
        ora #$08
        sta vScreenControl2
        lda #$11
        sta vMemControl
        ldx #$06
        lda #$ff
    L_21c7:
        sta L_47e9 + $f,x
        dex 
        bpl L_21c7
        pla 
    L_21ce:
        tay 
        pla 
        tax 
        lda #$0f
        sta $fffe
        lda #$20
        sta $ffff
        lda #$4a
        sta vRaster
        jmp L_0ae6
    L_21e3:
        lda $6a
        bne L_224d
        lda $66
        beq L_2229
        dec L_0cc0
        bne L_2232
        lda $0cc1
    L_21f3:
        sta L_0cc0
        inc L_0cc9
        lda L_0cc9
        cmp #$09
        bne L_2204
        lda #$00
        sta $66
    L_2204:
        lda L_0cc9
        cmp #$01
        bne L_2212
        pha 
        lda #$03
        sta L_e9fa + $c
        pla 
    L_2212:
        cmp #$03
        bne L_221d
        pha 
        lda #$02
        sta L_e9fa + $c
        pla 
    L_221d:
        ldx L_0cc9
    L_2220:
        lda L_0cc9 + $1,x
        sta L_47f9 + $6
        jmp L_2232
    L_2229:
        ldx L_0cc2
        lda L_0cc2 + $1,x
        sta L_47f9 + $6
    L_2232:
        lda vSpriteXMSB
        and #$7f
        ldx L_0cbe
        beq L_223e
        ora #$80
    L_223e:
        sta vSpriteXMSB
        lda $0cbd
        sta vSprite7X
        ldy L_0cbf
        sty vSprite7Y
    L_224d:
        rts 


    L_224e:
        lda $0da3
        beq L_2256
        jsr L_2259
    L_2256:
        jmp L_2327
    L_2259:
        lda $b0
        bne L_228c
        lda $b4
        cmp L_0cbf
        bcs L_2289
        inc $b4
        inc $b4
        inc $b4
        jsr L_22f6
        dec $b8
        bne L_2281
        lda #$05
        sta $b8
        inc $b6
        lda $b6
        cmp #$08
        bne L_2281
        and #$00
        sta $b6
    L_2281:
        ldx $b6
        lda L_10ea,x
        jmp L_22ed
    L_2289:
        inc $b0
        rts 


    L_228c:
        cmp #$01
        bne L_22a1
        lda L_0cbf
        sta $b4
        jsr L_22f6
        ldy L_0cc2
        lda L_0cc6,y
        jmp L_22ed
    L_22a1:
        cmp #$02
        bne L_22be
        lda $b4
        cmp #$f5
        beq L_22b8
        inc $b4
        ldy $b4
        sty vSprite3Y
        lda L_0cc6
        jmp L_22ed
    L_22b8:
        and #$00
        sta $0da3
        rts 


    L_22be:
        ldx $b6
        cpx #$01
        bne L_22cb
        pha 
        lda #$05
        sta L_e9fa + $c
        pla 
    L_22cb:
        cpx #$12
        bne L_22d9
        and #$00
        sta $0da3
        lda #$2b
        sta $ae
        rts 


    L_22d9:
        jsr L_22f6
        ldx $b6
        lda L_0ee1,x
        sta L_0f4d + $186
        lda L_0ef3,x
        sta vSpr3Col
        inc $b6
        rts 


    L_22ed:
        sta L_0f4d + $186
        lda #$0f
        sta vSpr3Col
        rts 


    L_22f6:
        lda L_0cbe
        beq L_2306
        lda vSpriteXMSB
        ora #$08
        sta vSpriteXMSB
        jmp L_230e
    L_2306:
        lda vSpriteXMSB
        and #$f7
        sta vSpriteXMSB
    L_230e:
        sec 
        lda $0cbd
        sbc #$1a
        sta vSprite3X
        bcs L_2321
        lda vSpriteXMSB
        and #$f7
        sta vSpriteXMSB
    L_2321:
        ldy $b4
    L_2323:
        sty vSprite3Y
        rts 


    L_2327:
        lda L_0da4
        bne L_232d
        rts 


    L_232d:
        lda $b2
        bne L_2360
        lda $b5
        cmp L_0cbf
        bcs L_235d
        inc $b5
        inc $b5
        inc $b5
        jsr L_23ca
        dec $b9
        bne L_2355
        lda #$05
        sta $b9
        inc $b7
        lda $b7
        cmp #$08
        bne L_2355
        and #$00
        sta $b7
    L_2355:
        ldx $b7
        lda L_10ea,x
        jmp L_23c1
    L_235d:
        inc $b2
        rts 


    L_2360:
        cmp #$01
        bne L_2375
        lda L_0cbf
        sta $b5
        jsr L_23ca
        ldy L_0cc2
        lda L_0cc6,y
        jmp L_23c1
    L_2375:
        cmp #$02
        bne L_2392
        lda $b5
        cmp #$f5
        beq L_238c
        inc $b5
        ldy $b5
        sty vSprite4Y
        lda L_0cc6
        jmp L_23c1
    L_238c:
        and #$00
        sta L_0da4
        rts 


    L_2392:
        ldx $b7
        cpx #$01
        bne L_239f
        pha 
        lda #$05
        sta L_e9fa + $c
        pla 
    L_239f:
        cpx #$12
        bne L_23ad
        and #$00
        sta L_0da4
        lda #$2d
        sta $ac
        rts 


    L_23ad:
        jsr L_23ca
        ldx $b7
        lda L_0ee1,x
        sta L_0f4d + $187
        lda L_0ef3,x
        sta vSpr4Col
        inc $b7
        rts 


    L_23c1:
        sta L_0f4d + $187
        lda #$0f
        sta vSpr4Col
        rts 


    L_23ca:
        lda L_0cbe
        beq L_23da
        lda vSpriteXMSB
        ora #$10
        sta vSpriteXMSB
        jmp L_23e2
    L_23da:
        lda vSpriteXMSB
        and #$ef
        sta vSpriteXMSB
    L_23e2:
        clc 
        lda $0cbd
        adc #$18
        sta vSprite4X
        bcc L_23f5
        lda vSpriteXMSB
        ora #$10
        sta vSpriteXMSB
    L_23f5:
        ldy $b5
        sty vSprite4Y
        rts 


    L_23fb:
        lda $42
        beq L_2440
        sta L_0eb2 + $7
        lda #$00
        sta L_0cc2
        lda L_0cbe
        bne L_2429
        lda $0cbd
        cmp #$a7
        beq L_2436
        bcs L_241f
        inc $0cbd
        lda #$01
        sta L_0cc2
        bne L_2436
    L_241f:
        dec $0cbd
        lda #$02
        sta L_0cc2
        bne L_2436
    L_2429:
        dec $0cbd
        bne L_2436
        lda #$00
        sta L_0cbe
        dec $0cbd
    L_2436:
        lda L_0cbf
        cmp #$8a
        bcc L_2440
        dec L_0cbf
    L_2440:
        rts 


    L_2441:
        pha 
        lda L_0cbe
        beq L_244e
        lda $0cbd
        cmp $ac
        bcs L_2463
    L_244e:
        lda #$01
        sta L_0cc2
        clc 
        lda $0cbd
        adc #$03
        sta $0cbd
        bcc L_2463
        lda #$01
        sta L_0cbe
    L_2463:
        pla 
        rts 


    L_2465:
        pha 
        lda L_0cbe
        bne L_2472
        lda $0cbd
        cmp $ae
        bcc L_2487
    L_2472:
        lda #$02
        sta L_0cc2
        sec 
        lda $0cbd
        sbc #$03
        sta $0cbd
        bcs L_2487
        lda #$00
        sta L_0cbe
    L_2487:
        pla 
        rts 


    L_2489:
        pha 
        lda L_0cbf
        cmp #$d9
        bpl L_2496
        adc #$03
        sta L_0cbf
    L_2496:
        pla 
        rts 


    L_2498:
        pha 
        lda L_0cbf
        cmp #$8a
        bmi L_24a5
        sbc #$03
        sta L_0cbf
    L_24a5:
        pla 
        rts 


    L_24a7:
        pha 
        lda L_0cd4
        bne L_24b5
        lda $66
        bne L_24b5
        lda #$01
        sta $3f
    L_24b5:
        pla 
        rts 


    L_24b7:
        lda L_0f4d + $d,x
        sta $95
        lda L_0f4d + $e,x
        sta $93
        lda L_0f4d + $f,x
        sta $94
        sec 
        lda $93
        sbc #$18
        sta $93
        lda $94
        sbc #$00
        sta $94
        ldy #$02
    L_24d5:
        lsr $94
        ror $93
        dey 
        bpl L_24d5
        sec 
        lda $95
        sbc #$32
        sta $95
        ldy #$02
    L_24e5:
        lsr $95
        dey 
        bpl L_24e5
        inc $93
        inc $95
        rts 


    L_24ef:
        lda $67
        asl 
        asl 
        asl 
        asl 
        tax 
        jsr L_24b7
        ldx $93
        inx 
        stx $90
        lda $95
        sta $91
        lda #$01
        sta $8f
        rts 


    L_2507:
        lda #$00
        sta $67
        sta vSprExpandY
        sta vSprExpandX
    L_2511:
        ldx $67
        lda L_0f4d,x
        bne L_256d
        lda L_0f4d + $b
        bne L_256a
        cpx #$03
        bcs L_2526
        lda L_0f4d + $a
    L_2524:
        bne L_256a
    L_2526:
        cpx #$03
        bcs L_2533
    L_252a:
        cpx #$00
        beq L_2533
        lda L_0f4d + $7
    L_2531:
        bne L_256a
    L_2533:
        cpx #$05
        bcs L_2540
        cpx #$03
        bcc L_2540
        lda L_0f4d + $8
        bne L_256a
    L_2540:
        cpx #$07
        bcs L_254d
        cpx #$05
        bcc L_254d
        lda L_0f4d + $9
        bne L_256a
    L_254d:
        cpx #$03
        bne L_2556
    L_2551:
        lda $0da3
        bne L_256a
    L_2556:
        cpx #$04
        bne L_255f
        lda L_0da4
        bne L_256a
    L_255f:
        lda #$ff
        sta L_0f4d + $183,x
        txa 
        asl 
        tax 
        sta vSprite0Y,x
    L_256a:
        jmp L_2624
    L_256d:
        lda L_0eb2 + $8,x
        beq L_25c4
        lda L_0eb2 + $14,x
        cmp #$12
        bne L_25a6
        and #$00
        sta L_0f4d,x
        sta L_0eb2 + $8,x
        sta L_0f4d + $109,x
        sta L_0cdf + $70,x
        ldy #$05
        lda #$05
        jsr L_1442
        pha 
        lda #$05
        sta L_e9fa + $c
        pla 
        dec $92
        bne L_25a3
        jsr L_24ef
        ldy #$04
        lda #$02
        jsr L_1442
    L_25a3:
        jmp L_2624
    L_25a6:
        cmp #$00
        bne L_25b1
        pha 
        lda #$07
        sta L_e9fa + $c
        pla 
    L_25b1:
        tay 
        lda L_0ee1,y
        sta L_0f4d + $183,x
        lda L_0ef3,y
    L_25bb:
        sta vSpr0Col,x
        inc L_0eb2 + $14,x
        jmp L_2624
    L_25c4:
        txa 
        asl 
        sta $48
        asl 
        asl 
        sta $8d
        asl 
        tax 
        lda L_0f4d + $c,x
        beq L_25e0
        dec L_0f4d + $c,x
        ldx $67
        lda #$ff
        sta L_0f4d + $183,x
        jmp L_2624
    L_25e0:
        ldy $48
        lda L_0f4d + $d,x
        sta vSprite0Y,y
        lda L_0f4d + $e,x
        sta vSprite0X,y
        ldy $67
        lda vSpriteXMSB
        and L_0dad,y
        sta vSpriteXMSB
        lda L_0f4d + $f,x
        beq L_2607
        lda vSpriteXMSB
        ora L_0da5,y
        sta vSpriteXMSB
    L_2607:
        lda L_0f4d + $18,x
        sta $4a
        lda L_0f4d + $19,x
        sta $4b
        ldy $8d
        lda L_0f4d + $11a,y
        tay 
        lda ($4a),y
        ldy $67
        sta L_0f4d + $183,y
        lda L_0f4d + $175,y
        sta vSpr0Col,y
    L_2624:
        inc $67
        lda $67
        cmp #$07
        beq L_262f
        jmp L_2511
    L_262f:
        lda L_0f4d + $a
        bne L_2637
        jmp L_2736
    L_2637:
        lda L_0eb2 + $12
        beq L_2693
        lda L_0eb2 + $1e
        cmp #$24
        bne L_265e
        and #$00
        sta L_0f4d + $a
        sta L_0eb2 + $12
        sta L_0f4d + $113
        sta L_0cdf + $7a
        pha 
        lda #$06
        sta L_e9fa + $c
        pla 
        jsr L_14eb
        jmp L_2736
    L_265e:
        cmp #$00
        bne L_2669
        pha 
        lda #$07
        sta L_e9fa + $c
        pla 
    L_2669:
        pha 
        tay 
        lda L_0f03 + $2,y
        sta L_0f4d + $183
        tay 
        iny 
        sty L_0f4d + $184
        pla 
        tay 
        lda L_0f29,y
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
        tya 
        lsr 
        tay 
        lda L_0ee1,y
        sta L_0f4d + $185
        inc L_0eb2 + $1e
        jmp L_2736
    L_2693:
        lda L_0f4d + $ac
        beq L_269e
        dec L_0f4d + $ac
        jmp L_2736
    L_269e:
        lda vSpriteXMSB
        and #$f8
        sta vSpriteXMSB
        lda L_0f4d + $ae
        sta vSprite0X
        tax 
        clc 
        adc #$0c
        tay 
        bcc L_26bb
        lda vSpriteXMSB
        ora #$04
        sta vSpriteXMSB
    L_26bb:
        sty vSprite2X
        txa 
        clc 
        adc #$18
        tax 
        bcc L_26cd
        lda vSpriteXMSB
        ora #$02
        sta vSpriteXMSB
    L_26cd:
        stx vSprite1X
        lda L_0f4d + $af
        beq L_26dd
        lda vSpriteXMSB
        ora #$07
        sta vSpriteXMSB
    L_26dd:
        ldy L_0f4d + $ad
        sty vSprite0Y
        sty vSprite1Y
        clc 
        tya 
        adc #$15
        sta vSprite2Y
        ldx #$9b
        lda $10f7
        bne L_26f6
        ldx #$8a
    L_26f6:
        stx L_0f4d + $183
        inx 
        stx L_0f4d + $184
        ldx #$9d
        stx L_0f4d + $185
        lda L_0eb2 + $28
        cmp #$10
        beq L_2725
        dec L_0eb2 + $2d
        bne L_2720
        lda L_0eb2 + $28
        sta L_0eb2 + $2d
        ldy #$00
        lda L_0eb2 + $23
        bne L_271c
        iny 
    L_271c:
        tya 
        sta L_0eb2 + $23
    L_2720:
        lda L_0eb2 + $23
        beq L_272b
    L_2725:
        lda L_0f4d + $17f
        jmp L_272d
    L_272b:
        lda #$02
    L_272d:
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
    L_2736:
        lda #$02
        sta $67
    L_273a:
        ldx $67
        lda L_0f4d + $7,x
        bne L_2744
        jmp L_2881
    L_2744:
        txa 
        asl 
        sta $89
        asl 
        sta $8a
        asl 
        sta $8b
        asl 
        sta $8c
        lda L_0eb2 + $f,x
        beq L_27b1
        lda L_0eb2 + $1b,x
        cmp #$24
        bne L_2778
        and #$00
        sta L_0f4d + $7,x
        sta L_0eb2 + $f,x
        sta L_0f4d + $110,x
        sta L_0cdf + $77,x
        pha 
        lda #$06
        sta L_e9fa + $c
        pla 
        jsr L_14eb
        jmp L_2881
    L_2778:
        cmp #$00
        bne L_2783
        pha 
        lda #$07
        sta L_e9fa + $c
        pla 
    L_2783:
        pha 
        tay 
        lda L_0f03 + $2,y
        ldx $89
        sta L_0f4d + $184,x
        tay 
        iny 
        tya 
        sta L_0f4d + $185,x
        pla 
        tay 
        lda L_0f29,y
        sta vSpr1Col,x
        sta vSpr2Col,x
        ldy $67
        lda vSprExpandY
        ora L_0db5,y
        sta vSprExpandY
        ldx $67
        inc L_0eb2 + $1b,x
        jmp L_2881
    L_27b1:
        ldx $8c
        lda L_0f4d + $7c,x
        beq L_27be
        dec L_0f4d + $7c,x
        jmp L_2881
    L_27be:
        ldx $67
        lda vSpriteXMSB
        and L_0db8,x
        tay 
        lda vSprExpandY
        ora L_0db5,x
        sta vSprExpandY
        ldx $8c
        lda L_0f4d + $7f,x
        beq L_27e0
        ldx $67
        tya 
        ora L_0db5,x
        tay 
        ldx $8c
    L_27e0:
        clc 
        lda L_0f4d + $7e,x
        ldx $8a
        sta vSprite1X,x
        adc #$18
        sta vSprite2X,x
        bcc L_27f7
        ldx $67
        tya 
        ora L_0db8 + $3,x
        tay 
    L_27f7:
        sty vSpriteXMSB
        ldx $8c
        lda L_0f4d + $7d,x
        ldx $8a
        sta vSprite1Y,x
        sta vSprite2Y,x
        ldx $8c
        lda L_0f4d + $88,x
        sta $4a
        lda L_0f4d + $89,x
        sta $4b
        ldx $89
        ldy $8b
        lda L_0f4d + $152,y
        tay 
        lda ($4a),y
        cmp #$85
        beq L_2825
        cmp #$0c
        bne L_2831
    L_2825:
        ldy #$85
        lda $10f7
        bne L_282e
        ldy #$0c
    L_282e:
        tya 
        bne L_2843
    L_2831:
        cmp #$83
        beq L_2839
        cmp #$0e
        bne L_2843
    L_2839:
        ldy #$83
        lda $10f7
        bne L_2842
        ldy #$0e
    L_2842:
        tya 
    L_2843:
        sta L_0f4d + $184,x
        tay 
        iny 
        tya 
        sta L_0f4d + $185,x
        ldx $67
        lda L_0eb2 + $25,x
        cmp #$0c
        beq L_2871
        dec L_0eb2 + $2a,x
        bne L_286c
        lda L_0eb2 + $25,x
        sta L_0eb2 + $2a,x
        ldy #$00
        lda L_0eb2 + $20,x
        bne L_2868
        iny 
    L_2868:
        tya 
        sta L_0eb2 + $20,x
    L_286c:
        lda L_0eb2 + $20,x
        beq L_2877
    L_2871:
        lda L_0f4d + $17c,x
        jmp L_2879
    L_2877:
        lda #$02
    L_2879:
        ldx $89
        sta vSpr1Col,x
        sta vSpr2Col,x
    L_2881:
        dec $67
        bmi L_2888
        jmp L_273a
    L_2888:
        lda L_0f4d + $b
        bne L_2890
        jmp L_29b7
    L_2890:
        lda L_0eb2 + $13
        beq L_2901
        lda L_0eb2 + $1f
        cmp #$24
        bne L_28b7
        and #$00
        sta L_0f4d + $b
        sta L_0eb2 + $13
        sta L_0f4d + $114
        sta L_0cdf + $7b
        pha 
        lda #$06
        sta L_e9fa + $c
        pla 
        jsr L_14eb
        jmp L_29b7
    L_28b7:
        cmp #$00
        bne L_28c2
        pha 
    L_28bc:
        lda #$07
        sta L_e9fa + $c
        pla 
    L_28c2:
        pha 
        tay 
        lda L_0f03 + $2,y
        sta L_0f4d + $184
        sta L_0f4d + $186
        tay 
        iny 
        sty L_0f4d + $185
        sty L_0f4d + $187
        pla 
        tay 
        lda L_0f29,y
        ldx #$06
    L_28dc:
        sta vSpr0Col,x
        dex 
        bpl L_28dc
        tya 
        lsr 
        tay 
        lda L_0ee1,y
        sta L_0f4d + $183
        sta L_0f4d + $188
        sta L_0f4d + $189
        lda #$20
        sta vSprExpandY
        lda #$4c
        sta vSprExpandX
        inc L_0eb2 + $1f
        jmp L_29b7
    L_2901:
        lda L_0f4d + $bc
    L_2904:
        beq L_290c
        dec L_0f4d + $bc
        jmp L_29b7
    L_290c:
        lda vSpriteXMSB
        and #$80
        sta vSpriteXMSB
        clc 
        lda L_0f4d + $be
        tay 
        sta vSprite1X
        adc #$30
        sta vSprite2X
        adc #$18
        sta vSprite0X
        sta vSprite5X
        adc #$18
        sta vSprite3X
        adc #$18
        sta vSprite4X
        clc 
        tya 
        adc #$3c
        sta vSprite6X
        clc 
        lda L_0f4d + $bd
        sta vSprite0Y
        adc #$15
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        adc #$2a
        sta vSprite6Y
        lda #$20
        sta vSprExpandY
        lda #$52
        sta vSprExpandX
        lda #$0d
        sta vSprMCMCol0
        ldy #$00
        ldx #$9e
    L_296a:
        txa 
        sta L_0f4d + $183,y
        inx 
        iny 
        cpy #$07
        bne L_296a
        ldx #$a0
        lda $10f7
        bne L_297d
        ldx #$0a
    L_297d:
        stx L_0f4d + $185
        inx 
        stx L_0f4d + $186
        lda L_0eb2 + $29
        cmp #$10
        beq L_29a7
        dec L_0eb2 + $2e
        bne L_29a2
        lda L_0eb2 + $29
        sta L_0eb2 + $2e
        ldy #$00
        lda L_0eb2 + $24
        bne L_299e
        iny 
    L_299e:
        tya 
        sta L_0eb2 + $24
    L_29a2:
        lda L_0eb2 + $24
        beq L_29ad
    L_29a7:
        lda L_0f4d + $180
        jmp L_29af
    L_29ad:
        lda #$02
    L_29af:
        ldx #$06
    L_29b1:
        sta vSpr0Col,x
        dex 
        bpl L_29b1
    L_29b7:
        dec L_10f2
        bne L_29cd
        lda L_10f2 + $1
        sta L_10f2
        ldx #$00
        lda $10f7
        bne L_29ca
        inx 
    L_29ca:
        stx $10f7
    L_29cd:
        and #$00
        sta $67
    L_29d1:
        lda $67
        tax 
        lda L_0eb2 + $8,x
        bne L_29de
        lda L_0f4d,x
        bne L_29e1
    L_29de:
        jmp L_2c45
    L_29e1:
        txa 
        asl 
        asl 
        asl 
        sta $8d
        asl 
        tax 
        lda L_0f4d + $c,x
        beq L_29f1
        jmp L_2c45
    L_29f1:
        lda L_0f4d + $11,x
        bne L_29ff
        inc L_0f4d + $10,x
        jsr L_2d8c
        jmp L_2c45
    L_29ff:
        dec L_0f4d + $11,x
        lda L_0f4d + $13,x
        and #$40
        bne L_2a29
        lda L_0f4d + $13,x
        bmi L_2a1c
        sta $48
        clc 
        lda L_0f4d + $d,x
        adc $48
        sta L_0f4d + $d,x
        jmp L_2a29
    L_2a1c:
        and #$3f
        sta $48
    L_2a20:
        sec 
        lda L_0f4d + $d,x
        sbc $48
        sta L_0f4d + $d,x
    L_2a29:
        ldy L_0f4d + $f,x
        lda L_0f4d + $12,x
        and #$40
        bne L_2a5e
        lda L_0f4d + $12,x
        bmi L_2a49
        sta $48
        clc 
        lda L_0f4d + $e,x
        adc $48
        sta L_0f4d + $e,x
        bcc L_2a5a
        ldy #$01
        bne L_2a5a
    L_2a49:
        and #$3f
        sta $48
        sec 
        lda L_0f4d + $e,x
        sbc $48
        sta L_0f4d + $e,x
        bcs L_2a5a
        ldy #$00
    L_2a5a:
        tya 
        sta L_0f4d + $f,x
    L_2a5e:
        lda L_0f4d + $1a,x
        bne L_2a8b
        ldy $8d
    L_2a65:
        lda L_0f4d + $119,y
        sta L_0f4d + $1a,x
        lda L_0f4d + $11a,y
        sta $4c
        inc $4c
        lda $4c
        sta L_0f4d + $11a,y
        tay 
        lda L_0f4d + $18,x
        sta $4a
        lda L_0f4d + $19,x
        sta $4b
        lda ($4a),y
        bne L_2a8b
        ldy $8d
        sta L_0f4d + $11a,y
    L_2a8b:
        dec L_0f4d + $1a,x
        lda L_0f4d + $14,x
        beq L_2a99
        dec L_0f4d + $14,x
        jmp L_2aa4
    L_2a99:
        ldy $8d
        lda L_0f4d + $115,y
        sta L_0f4d + $14,x
        inc L_0f4d + $12,x
    L_2aa4:
        lda L_0f4d + $15,x
        beq L_2aaf
        dec L_0f4d + $15,x
        jmp L_2aba
    L_2aaf:
        ldy $8d
        lda L_0f4d + $116,y
        sta L_0f4d + $15,x
        inc L_0f4d + $13,x
    L_2aba:
        lda L_0f4d + $12,x
        and #$bf
        sta L_0f4d + $12,x
        lda L_0f4d + $e,x
        sta $c4
        lda L_0f4d + $f,x
        sta $c5
        lda L_0f4d + $16,x
        and #$80
        beq L_2b26
        ldy $c4
        lda $c5
        jsr L_2c63
        bcs L_2afb
        clc 
        lda L_0f4d + $12,x
        and #$3f
        adc $c4
        tay 
        bcc L_2ae9
        inc $c5
    L_2ae9:
        lda $c5
        jsr L_2c63
        bcs L_2b1e
        lda L_0f4d + $12,x
        and #$7f
        sta L_0f4d + $12,x
        jmp L_2b26
    L_2afb:
        lda L_0f4d + $12,x
        and #$3f
    L_2b00:
        sta $c6
        sec 
        lda $c4
        sbc $c6
        tay 
        bcs L_2b0c
        dec $c5
    L_2b0c:
        lda $c5
        jsr L_2c63
        bcc L_2b1e
        lda L_0f4d + $12,x
        ora #$80
        sta L_0f4d + $12,x
        jmp L_2b26
    L_2b1e:
        lda L_0f4d + $12,x
        ora #$40
        sta L_0f4d + $12,x
    L_2b26:
        lda L_0f4d + $13,x
        and #$bf
        sta L_0f4d + $13,x
        lda L_0f4d + $d,x
        sta $c6
        lda L_0f4d + $16,x
        and #$40
        beq L_2b7d
        lda $c6
        cmp L_0cbf
        bcs L_2b59
        clc 
        lda L_0f4d + $13,x
        and #$3f
        adc $c6
        cmp L_0cbf
        bcs L_2b75
        lda L_0f4d + $13,x
        and #$7f
        sta L_0f4d + $13,x
        jmp L_2b7d
    L_2b59:
        lda L_0f4d + $13,x
        and #$3f
        sta $c7
        sec 
        lda $c6
        sbc $c7
        cmp L_0cbf
        bcc L_2b75
        lda L_0f4d + $13,x
        ora #$80
        sta L_0f4d + $13,x
        jmp L_2b7d
    L_2b75:
        lda L_0f4d + $13,x
        ora #$40
        sta L_0f4d + $13,x
    L_2b7d:
        ldy $67
        lda L_0f4d + $109,y
        bne L_2b87
        jmp L_2c45
    L_2b87:
        lda L_0f4d + $16,x
        and #$20
        bne L_2b91
        jmp L_2c45
    L_2b91:
        jsr L_2c51
        bne L_2b99
        jmp L_2c45
    L_2b99:
        lda L_0f4d + $17,x
        jsr L_0a92
        bne L_2ba4
        jmp L_2c45
    L_2ba4:
        jsr L_24b7
        ldy $67
        cpy #$07
        bcc L_2c06
        cpy #$0a
        bcs L_2bca
        lda L_0cdf + $70,y
        beq L_2bb9
        jmp L_2c45
    L_2bb9:
        clc 
        lda $95
        adc #$03
        sta $95
        clc 
        lda $93
        adc #$02
        sta $93
        jmp L_2c17
    L_2bca:
        cpy #$0b
        beq L_2bf0
        clc 
        lda $95
        adc #$03
        sta $95
        clc 
        lda $93
        adc #$03
        sta $93
        jsr L_0a83
        and #$03
        tay 
        lda L_0f4d + $16,x
        and #$e1
        ora L_0dbe,y
        sta L_0f4d + $16,x
        jmp L_2c17
    L_2bf0:
        clc 
        lda $95
        adc #$04
        sta $95
        jsr L_0a83
        and #$0f
        clc 
        adc $93
        adc #$02
        sta $93
        jmp L_2c17
    L_2c06:
        lda L_0cdf + $70,y
        bne L_2c45
        lda $95
        cmp #$05
        bcc L_2c45
        cmp #$17
        bcs L_2c45
        inc $93
    L_2c17:
        lda #$01
        sta L_0cdf + $70,y
        ldy $9b
        lda $93
    L_2c20:
        sta L_0cdf + $30,y
        lda $95
        sta L_0cdf + $38,y
        and #$00
        sta L_0cdf + $40,y
        sta L_0cdf + $58,y
        sta L_0cdf + $60,y
        lda #$01
        sta L_0cdf + $28,y
        lda $67
        sta L_0cdf + $68,y
        lda L_0f4d + $16,x
        and #$1e
        sta L_0cdf + $50,y
    L_2c45:
        inc $67
        lda $67
        cmp #$0c
        beq L_2c50
        jmp L_29d1
    L_2c50:
        rts 


    L_2c51:
        ldy #$07
    L_2c53:
        lda L_0cdf + $28,y
        beq L_2c5e
        dey 
        bpl L_2c53
        and #$00
        rts 


    L_2c5e:
        sty $9b
        lda #$01
        rts 


    L_2c63:
        sta $c7
        sty $c6
        sec 
        lda $c6
        sbc $0cbd
        sta $48
        lda $c7
        sbc L_0cbe
        ora $48
        rts 


    L_2c77:
        ldy #$00
        lda $0da3
        beq L_2c84
        sty L_0f4d + $3
    L_2c81:
        sty L_0f4d + $8
    L_2c84:
        lda L_0da4
        beq L_2c8f
        sty L_0f4d + $4
        sty L_0f4d + $8
    L_2c8f:
        rts 


    L_2c90:
        lda $43
        bne L_2c97
        jmp L_2d8b
    L_2c97:
        jsr L_1519
        jsr L_1527
        jsr L_1532
        ldy #$00
        sty L_0f4d + $cc
        sty $4e
        lda ($44),y
        sta $a6
        iny 
        lda ($44),y
        sta $a7
        dey 
        lda ($a6),y
        sta $48
        iny 
        lda ($a6),y
        sta $49
        iny 
        lda ($a6),y
        tax 
        dex 
        txa 
        clc 
        adc $aa
        sta $92
        ldx #$00
    L_2cc7:
        ldy #$00
        asl $49
        rol $48
        bcc L_2cd3
        iny 
        inc L_0f4d + $cc
    L_2cd3:
        tya 
        sta L_0f4d,x
        inx 
        cpx #$0c
        bne L_2cc7
        lda #$00
        sta $67
        lda #$01
        sta $48
    L_2ce4:
        lda $67
        tax 
        asl 
        sta $49
        lda L_0f4d,x
        beq L_2d4c
        txa 
        asl 
        asl 
        asl 
        asl 
        tax 
        inc $48
        inc $48
        ldy $48
        lda ($a6),y
        sta $4a
        iny 
        lda ($a6),y
        sta $4b
        stx $64
        ldx $49
        ldy #$00
        lda ($4a),y
        sta L_0f4d + $cd,x
        iny 
        lda ($4a),y
        sta L_0f4d + $ce,x
        iny 
        lda ($4a),y
        sta L_0f4d + $e5,x
        iny 
        lda ($4a),y
        sta L_0f4d + $e6,x
        iny 
        lda ($4a),y
        ldx $67
        sta L_0f4d + $175,x
        iny 
        lda ($4a),y
        sta L_0f4d + $fd,x
        iny 
        lda ($4a),y
        sta L_0f4d + $109,x
        ldx $64
        ldy #$07
    L_2d39:
        lda ($4a),y
        sta L_0f4d + $c,x
        inx 
        iny 
        cpy #$0b
        bne L_2d39
        and #$00
        sta L_0f4d + $c,x
        jsr L_2d8c
    L_2d4c:
        inc $67
        lda $67
        cmp #$0c
        bne L_2ce4
        clc 
        lda $44
        adc #$02
        sta $44
        bcc L_2d5f
        inc $45
    L_2d5f:
        ldx $c2
        lda L_0f4d + $cc
        sta L_2efd + $6,x
        and #$00
        sta L_2efd,x
        inc $c2
        lda $c2
        cmp #$02
        bne L_2d84
        ldx $32
        ldy $33
        stx $be
        sty $bf
        ldx $44
        ldy $45
        stx $c0
        sty $c1
    L_2d84:
        lda #$00
        sta $43
        jsr L_2c77
    L_2d8b:
        rts 


    L_2d8c:
        lda $67
        tax 
        asl 
        tay 
        asl 
        asl 
        sta $8d
        lda L_0f4d + $cd,y
        sta $5e
        lda L_0f4d + $ce,y
        sta $5f
        lda L_0f4d + $e5,y
        sta $60
        lda L_0f4d + $e6,y
        sta $61
        txa 
        asl 
        asl 
        asl 
        asl 
        clc 
        adc #$04
        tax 
        lda L_0f4d + $c,x
        sta L_0f4d + $18f
        asl 
        tay 
        inx 
        lda ($5e),y
        sta $5c
        lda ($60),y
        sta $5a
        iny 
        lda ($5e),y
        sta $5d
        lda ($60),y
        sta $5b
        clc 
        lda $5c
        bne L_2de4
        lda $5d
        bne L_2de4
        ldx $67
        and #$00
        sta L_0f4d,x
        sta L_0eb2 + $8,x
        sta L_0f4d + $109,x
        beq L_2e23
    L_2de4:
        ldy #$00
    L_2de6:
        lda ($5c),y
    L_2de8:
        sta L_0f4d + $c,x
        inx 
        iny 
        cpy #$07
        bne L_2de6
        stx $64
        ldy #$03
        lda ($5c),y
        ldx $8d
        sta L_0f4d + $115,x
        iny 
        lda ($5c),y
        sta L_0f4d + $116,x
        ldx $64
        ldy $67
        lda $5a
        sta L_0f4d + $c,x
        lda $5b
        sta L_0f4d + $d,x
        lda L_0f4d + $fd,y
        sta L_0f4d + $e,x
        ldx $8d
        lda L_0f4d + $fd,y
        sta L_0f4d + $119,x
        and #$00
        sta L_0f4d + $11a,x
    L_2e23:
        rts 


    L_2e24:
        lda $0cd5
        sta L_0cd4
        lda L_e9fa + $d
    L_2e2d:
        bne L_2e36
        pha 
        lda #$0b
        sta L_e9fa + $c
        pla 
    L_2e36:
        lda L_0cd6
        beq L_2e53
        jsr L_2e6b
        ldx #$03
    L_2e40:
        lda $1a
        sta L_0cdf + $c,x
        and #$00
        sta L_0cdf + $1c,x
        dex 
        bpl L_2e40
    L_2e4d:
        lda #$00
        sta L_0cd6
        rts 


    L_2e53:
        jsr L_2e6b
        ldx #$03
    L_2e58:
        lda $1a
        sta L_0cdf + $8,x
        and #$00
        sta L_0cdf + $18,x
        dex 
        bpl L_2e58
        lda #$01
        sta L_0cd6
        rts 


    L_2e6b:
        and #$00
        sta $80
        sec 
        lda $0cbd
        sbc #$24
        sta $19
        lda L_0cbe
        sbc #$00
        sta $1a
        ldx #$02
    L_2e80:
        lsr $1a
        ror $19
        ror $80
        dex 
        bpl L_2e80
        ldx #$06
    L_2e8b:
        lsr $80
        dex 
        bpl L_2e8b
        lda #$c0
        ldx $80
        beq L_2e9b
    L_2e96:
        lsr 
        lsr 
        dex 
        bpl L_2e96
    L_2e9b:
        sta $9c
        sec 
        lda L_0cbf
        sbc #$32
        sta $1a
        ldx #$02
    L_2ea7:
        lsr $1a
        dex 
        bpl L_2ea7
        lda L_0cd6
        asl 
        asl 
        tax 
        clc 
        lda $19
        sta L_0cdf + $10,x
        adc #$02
        sta L_0cdf + $11,x
        adc #$02
        sta L_0cdf + $12,x
        adc #$02
        sta L_0cdf + $13,x
        ldy $97
        beq L_2ed8
        lda L_0cdf + $11,x
        adc #$01
        sta L_0cdf + $13,x
        lda #$01
        sta L_0cdf + $3,x
    L_2ed8:
        lda #$01
        sta L_0cdf + $1,x
        sta L_0cdf + $2,x
        ldy $0da3
        beq L_2eee
        ldy $b0
        cpy #$01
        bne L_2eee
        sta L_0cdf,x
    L_2eee:
        ldy L_0da4
        beq L_2efc
        ldy $b2
        cpy #$01
        bne L_2efc
        sta L_0cdf + $3,x
    L_2efc:
        rts 



    L_2efd:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $bd,$c7,$40,$06,$fe,$33,$08,$84,$c0,$f0,$e2,$8e,$08,$34,$03,$12
        .byte $34,$08,$84,$c0,$f0,$d5,$8e,$1c,$34,$03,$26,$34,$07,$bd,$c7,$30
        .byte $3f,$30,$34,$08,$bc,$c0,$48,$1d,$d0,$3a,$34,$08,$bc,$c0,$48,$17
        .byte $d0,$44,$34,$03,$4e,$34,$07,$bd,$c7,$30,$20,$58,$34,$08,$bc,$c0
        .byte $48,$10,$d0,$62,$34,$03,$6c,$34,$07,$bd,$c7,$30,$7f,$76,$34,$08
        .byte $bc,$c0,$48,$15,$d0,$80,$34,$07,$bd,$c7,$30,$40,$8a,$34,$08

    L_2f68:
        ldy L_48c0,x

        .byte $1c,$d0,$94,$34,$07,$bd,$c7,$40,$02,$9e,$34,$08,$bc,$c0,$48,$25
        .byte $d0,$a8,$34,$07

    L_2f7f:
        lda $40c7,x
        asl 

        .byte $b2,$34,$08,$bc,$c0,$48,$26,$d0,$bc,$34,$03,$c6,$34,$08,$84,$c0
        .byte $f0,$c8,$8e,$d0,$34,$03,$da,$34,$07,$bd,$c7,$40,$01,$e4,$34,$0a
        .byte $bc,$c0,$f2,$02,$8a,$40,$03,$ee,$34,$0a,$bc,$c0,$f2,$02,$8a,$40
        .byte $04,$f8,$34,$07,$bd,$c7,$40,$07,$02

    L_2fbc:
        and $0a,x
        ldy L_f2b1 + $f,x

        .byte $02,$8a,$40,$05,$0c,$35,$03,$16,$35,$08,$84,$c0,$f0,$8d,$89,$20
        .byte $35,$08,$84,$c0,$f0,$80,$89

    L_2fd8:
        rol 
        and $07,x
        lda $40c7,x
        dec $34,x
        and $0a,x
        ldy L_f2b1 + $f,x
        clv 
        txa 
        rti 
        asl $3e
        and $07,x
        lda $c7,x
        rti 

        .byte $00,$48,$35,$08,$b4,$c0,$48,$2d,$d0,$52,$35,$08,$b4,$c0,$f0,$62
        .byte $42,$c0,$33

    L_3002:
        .byte $0c,$0c,$0c,$0c,$0c,$0c,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff,$00,$00
        .byte $00,$00,$03,$0c,$30,$c0

    L_3018:
        .byte $0c,$0c,$ff,$0c,$0c,$0c,$0c,$0c,$c3,$c3,$c3,$ff,$c3,$c3,$c3,$ff

    L_3028:
        .byte $00,$00,$00,$3c,$3c,$00,$00,$00,$0c,$0c,$0c,$0f,$0c,$3c
        .byte $cc,$0c,$fc

    L_3039:
        .byte $0c,$0c,$0c,$0c,$0c,$0c,$0f,$fa,$ef,$ef,$ef,$fb,$eb,$eb
        .byte $ea,$fb,$af,$af,$af,$af,$af

    L_304e:
        ldx L_abf7 + $3

        .byte $ab,$ab,$ab,$bb,$bb,$fe,$ee,$02,$02,$02,$02,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$02,$02,$02,$55,$55,$5a,$65,$65,$65,$66,$69,$55
        .byte $55,$aa,$95,$95,$b5,$9d,$97

    L_3078:
        lsr $56,x
        lsr $d6,x
        inc $7e,x

        .byte $5f,$57,$f5,$5d,$5d,$5d,$57,$57,$57,$57,$e5,$e5,$e5,$e5,$e5,$e5
        .byte $e5,$e5,$58,$5b,$58,$5b,$58,$5b,$58,$5b,$b7,$b7,$b7,$f7,$d7,$d7
        .byte $d7,$d7,$54,$57,$54,$57,$54,$57,$54,$57,$77,$77,$77,$77,$77,$77
        .byte $77,$f7,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00

    L_30c0:
        .fill $40, $ff
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$65,$65,$65,$65,$65,$65,$55,$55
        .byte $65,$6d,$65,$ad,$a5,$5d,$55,$5d,$00,$03,$0e,$0e,$3a,$3b,$eb,$ed
        .byte $eb,$ad,$b5,$d5,$d5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55

    L_3130:
        .byte $eb,$7a
        .byte $5e,$57,$57,$55,$55,$55,$00,$c0,$b0,$b0,$ac,$ec,$eb,$7b,$56,$56
        .byte $56,$56,$58,$5b,$58,$5b,$09,$09,$09,$02,$02,$02,$00,$00,$6c,$63
        .byte $6c,$b3,$8c,$b3,$cc,$33,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09
        .byte $09,$09,$09,$09,$09,$09,$69,$69,$a9,$a9,$ab,$e9,$f7,$65,$d7,$f7
        .byte $df,$f7,$df,$f7,$5d,$f5,$57,$57,$67,$77,$57,$57,$57,$57,$5d,$5f
        .byte $5d,$5f,$5d,$5f,$7d,$77,$39,$39,$39,$39,$39,$39,$39,$39,$6c,$63
        .byte $6c,$63,$6c,$63,$6c,$63,$d7,$d7,$d7,$d7,$d7,$d7,$d7,$ff,$5c,$53
        .byte $5c,$53,$5c,$53,$5c,$53,$65,$59,$59,$96,$95,$95,$95,$95,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$9d,$b7
        .byte $9d,$b7,$95,$95,$95,$95,$dd,$77,$dd,$77,$55,$55,$55,$55,$00,$00
        .byte $00,$00,$00,$00,$00,$00
        .fill $28, $ff
        .byte $56,$56,$56,$56

    L_3204:
        lsr $56,x
        lsr $56,x
        eor $55,x
        adc $65
        adc $65
        adc $65

        .byte $03,$03,$0e,$0e,$3a,$3b,$eb

    L_3217:
        sbc L_b5ad
        lda $d5,x
        dec $56,x
        lsr $57,x
        eor $55,x
        eor $55,x
        stx $96,y

        .byte $97,$d7,$55,$55,$55,$55,$aa,$aa,$ff,$ff,$55,$55,$55,$55,$96,$96
        .byte $d6,$d7,$7a,$5e,$5e,$57,$97,$95,$95,$d5,$c0,$c0,$b0,$b0,$ac,$ec
        .byte $eb,$7b,$aa,$aa,$aa,$66,$9a,$56,$56,$56,$cc,$33,$cc,$30,$cc,$30
        .byte $c0,$00,$09,$09,$09,$09,$09,$09,$0b,$0f,$25,$25,$25,$25,$25,$25
        .byte $25,$25,$6a,$65,$a5,$a5,$a5,$e6,$f6,$66,$aa,$55,$55,$65,$9d,$57
        .byte $57,$57,$d7,$d7,$77,$77,$77,$77,$77,$77,$7d,$77,$7d,$77,$dd,$f7
        .byte $dd,$77,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$8c,$b3,$8c,$b3,$8c,$b3
        .byte $8c,$b3,$d7,$d7,$5b,$5b,$9f,$97,$5b,$57,$4c,$73,$4c,$73,$4c,$73
        .byte $4c,$73,$95,$66,$65,$66,$a5,$9a,$95,$95
        .fill $28, $0
        .fill $28, $ff

    L_3300:
        sta $95,x
        sta $95,x
        sta $95,x
        sta $95,x

        .byte $ff,$ea,$ea,$ea,$d5,$d5,$d5,$d5,$ed,$aa,$aa,$aa,$55,$55,$55,$55
        .byte $55,$aa,$aa,$aa,$65,$65,$65,$65,$55,$aa,$aa,$aa,$55,$55,$55,$55
        .byte $55,$aa,$aa,$aa,$55,$55,$55,$55

    L_3330:
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x

        .byte $7b,$aa,$aa,$aa,$55,$55,$55,$55,$ff,$ab,$ab,$ab,$57,$57,$57,$57
        .byte $cc,$33,$cc,$33,$cc,$33,$cc,$33,$55,$55,$55,$55,$55,$55,$ff,$ff
        .byte $95,$95,$95,$95,$95,$95,$95,$95,$55,$55,$55,$55,$55,$55,$55,$55
        .byte $77,$77,$77,$77,$77,$77,$77,$7f,$5d,$75,$5d,$77,$55,$75,$55,$75
        .byte $7d,$77,$7d,$5f,$5d,$df,$7d,$5f,$95,$bf,$bf,$bf,$bf,$bf,$bf,$bf
        .byte $55,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$56,$fe,$fe,$fe,$fe,$fe,$fe,$fe
        .byte $fb,$fb,$fb,$eb,$ab,$ab,$ab,$ab,$6a,$9a,$6a,$9a,$66,$9a,$67,$fd
        .byte $ab,$ab,$ab,$af,$b7,$d7,$57,$57

    L_33b8:
        .fill $20, $0
        .fill $28, $ff
        .byte $03,$03,$03,$03,$03,$03,$03,$03

    L_3408:
        asl 
        and $95
        sta $9a,x
        lda $95
        sta $55,x

        .byte $57,$5e,$7a,$eb,$ed,$ed,$ed,$ff,$aa,$aa,$ff

    L_341c:
        adc $65
        adc $65
        eor $d5,x
        lda $ad,x

        .byte $eb,$7b,$7b,$7b,$55,$55,$65,$69,$7a,$5e,$56,$5a,$55,$55,$55,$69
        .byte $ad,$b5,$a5,$e9,$55,$55,$55,$69,$7a,$5e,$5a,$6b,$55,$55,$59,$69
        .byte $ad,$b5,$95,$a5,$01,$01,$01,$01,$01,$01,$01,$01,$c0,$c0,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$cc,$33,$0c,$33,$0c,$03,$00,$00,$55,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$ff,$eb,$f7,$dd,$f7,$55,$7f,$7f,$7f,$ff
        .byte $ff,$aa,$77,$55,$55,$75,$55,$75,$55,$7d,$57,$77,$57,$57,$57,$57
        .byte $57,$57,$57,$d7,$bf,$bf,$bf,$bf,$bf,$bf,$6f,$6f,$66,$66,$66,$66
        .byte $66,$65,$65,$6f,$fe,$f6,$f6,$f6,$f6,$f6,$db,$db,$57,$5f,$7f,$ff
        .byte $ff,$fe,$fa,$ea,$59,$59,$99,$96,$96,$95,$65,$65,$55,$55,$55,$55
        .byte $55,$55,$ff

    L_34b7:
        .byte $ff,$57,$57,$57,$57,$5f
        .byte $7d,$f7,$dd

    L_34c0:
        .fill $18, $0
        .byte $55,$55,$55,$55,$55,$99,$66,$aa,$aa,$aa,$aa,$66,$99,$95,$95,$95
        .byte $95,$95,$95,$95,$25,$25,$25,$25,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e
        .byte $65,$65,$65,$aa,$aa,$65,$65,$65,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed
        .byte $65,$65,$65,$65,$65,$65,$65,$65,$7b,$7b,$7b,$7b,$7b,$7b,$7b,$7b
        .byte $9b,$ed,$79,$5d,$55,$55,$55,$55,$7a,$5e,$57,$55,$55,$55,$55,$55
        .byte $ad,$b5,$d5,$55,$55,$55,$55,$55,$e6,$7b,$6d,$75,$55,$55,$55,$55
        .byte $c0,$00

    L_354a:
        cpy #$00
        cpy #$00
        cpy #$00

        .byte $7c,$73,$7c,$73,$7c,$73,$7c,$73,$00,$00,$00,$00,$c0,$30,$c0,$30
        .byte $55,$56,$5b,$5b,$6f,$6f,$6f,$6f,$aa,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $55,$b5,$ed,$ed,$fb,$fb,$fb,$fb,$55,$a9,$a9,$a9,$55,$75,$57,$7f
        .byte $d7,$d7,$d7,$d7,$d7,$df,$7d,$77,$6f,$6f,$6f,$e7,$59,$59,$5e,$5f
        .byte $ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$db,$db,$db,$db,$6f,$6f,$bf,$ff
        .byte $55,$55,$55,$bf,$99,$ea,$ea,$d9,$66,$65,$65,$65,$65,$66,$66,$66
        .byte $57,$9d,$75,$55,$55,$aa,$97,$67,$57,$57,$57,$57,$57,$ff,$55,$ff
        .fill $18, $0
        .byte $95,$95,$95,$95,$95,$95,$95,$95,$55,$55,$55,$6a,$6a,$65,$65,$65
        .byte $65,$65,$65,$6a,$6a,$65,$65,$65,$65,$65,$65,$65,$65,$65,$65,$65
        .byte $00,$00,$00,$00,$00,$03

    L_35fe:
        asl L_3938 + $2
        and L_3938 + $1,y
        and L_3938 + $1,y
        and L_5555,y
        eor $aa,x
        tax 
        eor $55,x
        eor $eb,x

        .byte $7a,$5e,$57,$57,$5e,$7a,$eb,$ff,$aa,$aa,$aa,$aa,$aa,$aa,$ff,$eb
        .byte $ad,$b5,$d5,$d5,$b5,$ad,$eb,$0b,$2d,$b5,$b5,$b6,$b7,$25,$0a,$6f
        .byte $5b,$56,$b6,$b6,$db,$6f,$bf,$f9,$e5,$95,$9e,$9e,$e7,$f9,$fe,$ef
        .byte $7b,$5e,$5e,$9e,$de,$5b,$af,$c0,$30,$c0,$30,$c0,$30,$c0,$30,$5c
        .byte $5f,$5c,$5f,$5c,$5f,$5c,$5f,$c0,$30,$cc,$30,$cc,$33,$cc,$33,$6f
        .byte $6f,$bf,$bf,$bf,$bf,$bf,$bf,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$fb
        .byte $fb,$fe,$fe,$fe,$fe,$fe,$fe,$55,$75,$55,$75,$55,$75,$55,$5d,$dd
        .byte $b7,$ed,$db,$d7,$d7,$d7,$d7,$67,$67,$65,$65,$65,$65,$59,$59,$ff
        .byte $ff,$ff,$ff,$7f,$55,$55,$55,$ff,$ff,$ff,$ff,$df,$5d,$5d,$5d,$ff
        .byte $ff,$ff,$ef,$fb,$fb,$fb,$fb,$69,$bb,$9b,$9b,$9b,$9b,$bb,$59,$55
        .byte $55,$6a,$95,$95,$d5,$7f,$55,$dd,$75,$d5,$55,$55

    L_36bd:
        eor $55,x
        eor $00,x

        .fill $1b, $0
        .byte $ff,$aa,$aa,$ff,$00,$00,$00,$00,$00,$c0,$b0,$ac,$aa,$aa,$aa,$66
        .byte $99,$55,$55,$55,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff

    L_3700:
        sbc $e5
        sbc $e5
        sbc $e5
        sbc $e5

        .byte $a3,$58,$56,$56,$a6,$5a,$56,$56,$ed,$ed,$ed,$eb,$7a,$5e,$57,$55
        .byte $65,$65,$65,$65,$ff,$aa,$aa,$ff,$7b,$7b,$7b,$eb,$ad,$b5,$d5,$55
        .byte $ff,$ff,$55,$aa,$aa,$55,$ff,$ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$55
        .byte $57,$57,$55,$5a,$5a,$55,$57,$57,$57,$57,$57,$57,$55,$5a,$5a,$55
        .byte $cc,$30,$cc,$30,$cc,$30,$cc,$30,$57,$57,$57,$57,$57,$57,$57,$57
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$bf,$bf,$bf,$bf,$bf,$95,$aa,$aa
        .byte $ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$fe,$fe,$fe,$fe,$fe,$56,$aa,$aa
        .byte $65,$69,$69,$69,$69,$69,$6b,$6f,$d7,$d7,$d7,$f7,$b7,$b7,$b7,$b7
        .byte $55,$55,$55,$55,$55,$55,$55,$ff,$ab,$ff,$55,$55,$55,$af,$55,$55
        .byte $75,$75,$75,$d5,$d5,$55,$55,$55,$fb,$fb,$fb,$fb,$fb,$fb,$fb,$fb

    L_37a8:
        sta $96,x
        txs 
        txs 
        txs 
        stx $fe,y
        inc L_9757,x

        .byte $a7,$a7,$a7,$97,$bf,$bf,$de,$76,$de,$76,$56,$56,$56,$56,$ff,$c3
        .byte $c3,$c3,$c3,$c3,$c3,$ff,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff,$00,$00
        .byte $00,$00,$00,$00,$00,$00
        .fill $28, $ff
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d5,$f5,$55,$d7,$55,$5f,$ff,$ff
        .byte $ff,$ff,$5f,$f5,$ff,$ff,$f5,$50,$f6,$f6,$f6,$da,$5a,$46,$06,$01
        .byte $6a,$1a,$05,$02,$28,$08,$82,$22,$a9,$95,$5a,$8a,$2a,$8a,$08,$22
        .byte $aa,$aa,$aa,$aa,$aa,$a9,$95,$44,$aa,$aa,$aa,$a5,$9d,$77

    L_383e:
        ora L_a977,x
        lda $55
        adc $d5,x
        eor $d5,x

        .byte $54,$44,$95,$11,$a5,$25,$05,$89,$21,$54,$52,$50,$48,$60,$22,$80
        .byte $88,$28,$20,$08,$0a,$08,$02,$02,$01,$00,$00,$03,$03,$03,$2d,$bc
        .byte $9f,$3f,$ea,$a8,$88,$19,$52,$af,$fb,$f0,$cc,$35,$56,$ab,$bb,$db
        .byte $57,$00,$00,$6a,$fb,$ef,$ef,$ef,$ee,$01,$86,$a6,$a5,$05,$01,$01
        .byte $00,$de,$ba,$6f,$6b,$57,$5a,$5b,$2f,$fb,$fb,$ff,$fa,$ab,$ff,$ff
        .byte $ff,$57,$57,$de,$ae,$f7,$fd,$ff,$fe,$ea,$ef,$bf,$fd,$d5,$5a,$a5
        .byte $50

    L_38a8:
        .byte $00,$02,$0b,$2f,$bf,$ff,$fa,$ef,$bf,$ff,$ff
        .byte $fe,$eb,$bd,$d4,$40,$ff,$ff,$ff,$b5,$50,$01,$01,$00,$f9,$d4,$50
        .byte $54,$55,$e6,$55,$54,$00,$00,$00,$00,$00,$40,$00,$00,$b5,$50,$00
        .byte $00,$00,$00,$00,$c0,$fd,$fd,$f4,$d0,$40,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$03,$0f,$3f,$00,$03,$0f,$3f,$ff,$f5,$50,$00,$fe,$fb,$fd
        .byte $d4,$40,$00,$00,$00,$1f,$1f,$1f,$5d,$f7,$d7,$77,$d7,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$7d,$75,$55,$57,$dd,$d7,$7f,$77,$00,$00,$00
        .byte $00,$00,$00,$00,$01,$00,$00,$00,$00,$05,$15,$71,$cd

    L_3920:
        .byte $00,$00,$00
        .byte $01,$07,$1f,$57,$5b,$07,$1f,$7f,$ff,$ff,$fc,$ff,$fc,$f1,$c4,$34
        .byte $c4,$10,$d0,$40,$40

    L_3938:
        .byte $a7,$97,$5f
        .byte $5d,$77,$f7,$df,$7f,$f5,$dd,$74,$f4,$d0,$d0,$40,$40,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$fd,$f4,$f4,$d0,$40,$00,$00,$00,$c0,$00,$00
        .byte $00,$00,$00,$00,$00,$ff,$dd,$dd,$dd,$f5,$d5,$55,$d7,$dd,$d5,$d5
        .byte $55,$57,$7c,$dc,$f0,$00,$00,$00,$00,$30,$30,$00,$00,$00,$03,$03
        .byte $03,$03,$0f,$0f,$0f,$c0,$c0,$c0,$f0,$f0,$f0,$b0,$fc,$00,$00,$00
        .byte $00,$00,$00,$00,$02,$0c,$0f,$0c,$33,$33

    L_3995:
        bit L_f47e

        .byte $00,$00,$00,$80,$80,$80,$80,$80,$2f,$0f,$0f,$2f,$2f,$0f,$2f,$2f
        .byte $bc,$fc,$ec,$fd,$ef,$ef,$fb,$fb,$07,$2f,$7d,$f4,$d0,$52,$4a,$29
        .byte $ef,$4e,$3f,$ce,$af,$9c,$7e,$4a,$00,$80,$80,$00,$80,$a0,$a0,$80
        .byte $2f,$2f,$aa,$fa,$fd,$fa,$ef,$bf,$fb,$f5,$ff,$aa,$56,$fd,$d5,$55
        .byte $65,$d5,$94,$b7,$a7,$53,$57,$53,$3e,$3f,$fb,$ca,$bf,$fb,$fe,$fe
        .byte $a0,$a0,$80,$a0,$a0,$a8,$a0,$e8,$fb,$a9,$b5,$d5,$54,$40,$00,$00
        .byte $55,$50,$40

    L_39fb:
        .byte $00,$00,$00,$00,$00,$4f,$1f,$57,$1f,$0b,$0f,$2f,$2f
        .byte $fe,$be,$fb,$fb,$fe,$fe,$ee,$ef,$a8,$a0,$a8,$e8,$a8,$aa,$ba,$aa
        .byte $00,$00,$00,$00,$08,$00,$00,$02,$00,$08,$00,$08,$20,$00,$03,$0c
        .byte $3f,$3e,$2f,$ef,$3f,$ff,$bb,$bb,$ff,$fe,$fa,$fe,$fc,$ee,$fa,$fe
        .byte $a8

    L_3a39:
        nop 
        tax 
        ldx $e8aa
        tax 
        tay 

        .byte $00,$08,$88,$00,$02,$00,$20,$00,$83,$00,$b0,$20,$33,$00,$0c,$8b
        .byte $3f,$ff,$fb,$ff,$2f,$2f,$3b,$0c,$ff,$ef,$fe,$fa,$fb,$bf,$fe,$ea
        .byte $aa,$aa,$ba,$aa,$aa,$ab,$b8,$2e,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$aa,$6a,$aa,$6a,$6a,$aa,$6a,$6a
        .byte $aa,$aa,$ab,$aa,$ab,$66,$55,$99,$aa,$aa,$fa,$ea,$fa,$ea,$5a,$9a
        .byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$6a,$6a

    L_3aaa:
        ror 
    L_3aab:
        ror 

        .byte $5a,$1a,$1a,$16,$95,$9a,$9a,$5a,$5a,$5a,$67,$56,$92,$d8,$92,$d8
        .byte $92,$d8,$f6,$b4,$aa,$aa,$aa,$aa,$2a,$8a,$22,$8a

    L_3ac8:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $16,$19,$19,$19,$1a,$06,$06,$55,$66,$95,$99,$96,$65,$66,$65,$59
        .byte $a4,$55,$a5,$56,$66,$66,$55,$49,$22,$88,$62,$58,$66,$58,$66,$59

    L_3af8:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $05,$06,$06,$06,$06,$06,$01,$45,$19,$99,$26,$86,$a6,$89,$a5,$55
        .byte $55,$4a,$55,$59,$26,$88,$a2,$6a,$66,$59,$66,$99,$66,$88,$22,$88
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01

    L_3b3a:
        ora ($00,x)
        ora ($00),y

        .byte $00,$00,$a2,$a8,$a2,$68,$55,$69,$1a,$1a,$6a,$6a,$1a,$9a,$56,$56
        .byte $15,$89,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00,$00,$00,$00,$00
        .byte $00,$01,$07,$1f,$77,$5f,$77,$1f,$17,$1f,$17,$07,$07,$07,$05,$01
        .byte $01,$01,$6a,$2a,$1a,$0a,$cf,$06,$02,$01,$9a,$26,$86,$2b,$bf,$ab
        .byte $a2,$a8,$aa,$aa,$aa,$aa,$55,$69,$6a,$1a,$00,$00,$00,$00,$c0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$00,$00,$00,$0f
        .byte $f3,$cf,$00,$00,$00,$00,$3f,$f5,$d6,$56,$a2,$68,$2b,$ff,$5f,$97
        .byte $97,$95,$9a,$af,$ff,$ff,$ff,$ff,$fe,$ff,$00

    L_3bb9:
        .byte $00,$00,$03,$03,$03,$54
        .byte $dd,$3f,$ff,$ff,$ff,$fc,$fc,$fc,$33,$cd,$fe,$35,$35,$f5,$d5,$d6
        .byte $d6,$5a,$aa,$aa,$6a,$aa,$aa,$9a,$56,$a9,$a5,$97,$57,$5f,$5f,$7e
        .byte $7e,$fb,$fb,$ee,$ee,$bb,$bb,$ff,$ef,$75,$5f,$d7,$5f,$df,$f7,$d7
        .byte $f7,$73,$4f,$5f,$db,$d4,$d5,$f5,$f7,$d9,$d5,$f5,$ff,$ff,$3f,$78
        .byte $55,$55,$57,$73,$cf,$cf,$3e,$a5,$55,$fb,$fb,$e3,$ef,$8f,$7f,$7f
        .byte $ff,$fc,$ff,$f3,$ff,$cf,$ff,$3f,$3e,$f1,$fd,$fd,$fc,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$7f,$7f,$7f,$1f,$df,$f5,$fd,$fd,$f7,$ff,$ff,$ff
        .byte $ff,$55,$55

    L_3c32:
        .byte $77,$f7,$57,$df,$df,$df,$fc,$ff,$f3,$f3

    L_3c3c:
        dec $ffff

        .byte $ff,$fa,$fe,$ef,$ab,$aa,$ba,$f5,$5f,$aa,$a6,$99,$a5,$55,$5a,$af
        .byte $bf,$94,$e9,$2a,$49,$45,$15,$95,$eb,$51,$17,$45,$5f,$1d,$77,$5d
        .byte $f7,$dd,$77,$df,$7f,$df,$7f,$fd,$7f,$fd,$fd,$d5,$f7,$5d,$d7,$5d
        .byte $77,$df,$7d,$df,$77,$df,$f7,$df,$77,$bf,$ff,$ef,$cd,$bd,$36,$f6
        .byte $f6,$ff,$d7,$55,$56,$56,$5a,$9a,$aa,$dd,$77,$df,$77,$5f,$5f,$57
        .byte $57,$f5,$dd,$f5,$d7,$75,$d7,$5d,$d7,$dd,$77,$dd,$77,$dd,$77,$df
        .byte $77,$df,$f7,$7d,$f7,$dd,$df,$ff,$77,$d6,$d5,$d5,$d5,$d5,$d6,$d6
        .byte $d6,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$97,$95,$a5,$a5,$a9,$aa,$a9
        .byte $55,$dd,$77,$5d,$77,$df,$77,$dd,$77,$7f,$ff,$dd,$ff,$77,$ff,$df
        .byte $ff,$7f,$ff,$dd,$df,$fd,$76,$da,$6a,$da,$d9,$d5,$d5,$f5,$b5,$bd
        .byte $af,$6a,$6a,$5a,$59,$59,$59,$59,$55,$55,$57,$55,$57,$5d,$57,$5d
        .byte $d5,$df,$7d,$df,$77,$fd,$55,$55,$45,$dd,$75,$d5,$65,$65,$96,$96
        .byte $9a

    L_3d00:
        lsr 
        lsr 

        .byte $42,$02,$82,$a0,$a8,$a8,$ef,$af,$bd,$f7,$fd,$d5,$77,$dd,$df,$7f
        .byte $dd,$7d,$5d,$f5,$76,$f6,$d5,$56,$5a,$6a,$aa,$aa,$aa,$aa,$a6,$a6
        .byte $aa,$aa,$aa,$aa,$aa,$aa,$9a,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$df,$77,$df,$7d,$df,$7d,$f5,$fd,$df,$df
        .byte $7f,$7f,$7f,$fd,$f7,$df,$dd,$d7,$df,$7f,$77,$7d,$74,$74,$fd,$74
        .byte $f4,$d0,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00
        .byte $00,$00,$00,$00,$00,$00,$dd,$7d,$d5,$77,$d7,$77,$f7,$fd,$7f,$77
        .byte $fd,$74,$f4,$d8,$6a,$aa,$d0,$40,$00,$00,$00,$00,$00,$00,$dd,$75
        .byte $d4,$50,$40,$00,$00,$00,$5d,$77,$5d,$57,$1d,$15,$15,$04,$dd,$75
        .byte $d4,$50,$50

    L_3d95:
        rti 

        .byte $00,$00,$f6,$f6,$da,$6a,$aa,$aa,$aa,$aa

    L_3da0:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80
        .byte $a0,$a0,$a8,$a8,$aa,$aa,$ff,$ff,$ff,$ff,$7f,$7f,$3f,$3f,$7f,$7f
        .byte $df,$df,$df,$f7,$f7,$f7,$ff,$fd,$ff,$dd,$f5,$fd,$f7,$d7,$f7,$57
        .byte $dd,$75,$55,$57,$5d,$77,$dd,$57,$5d,$77,$df,$77,$df,$ff,$df,$77
        .byte $df,$7f,$fd,$f7,$df,$7f,$80,$80,$80,$a0,$a0

    L_3de5:
        ldy #$a0
        ldy #$f5

        .byte $77,$d5,$77,$dd,$7d,$dd,$75,$d5,$75,$d7,$75,$d7,$5d,$57,$7f,$aa
        .byte $aa,$aa,$aa,$aa,$aa,$aa,$aa

    L_3e00:
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        lda $54
        tax 
        tax 
        tax 
        tax 
        lda $54
        ora ($44),y

        .byte $00,$00,$54,$54,$54,$54,$54,$54,$00,$00,$a8,$a8,$a8,$a8,$a8,$a8
        .byte $00,$00,$00,$00,$00,$00,$00,$02,$40,$40,$40,$40,$40

    L_3e2d:
        .byte $50,$50,$50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$02,$00,$00,$00,$02,$08,$08,$a2,$08,$20,$82,$08,$22,$08
        .byte $82,$00,$22,$00,$00,$00,$00,$00,$00,$00,$00,$50,$54,$f5,$7d,$fd
        .byte $f7,$fd,$f7,$00,$00,$40,$51,$56,$55,$56,$55,$08,$10,$6a,$a8,$66
        .byte $9a,$69,$94,$08,$82,$20,$82,$08,$a0,$00,$00,$88,$00,$20,$80,$00
        .byte $00,$00,$00,$00,$00,$fc,$fc,$fc,$fc,$fc,$fc,$5d,$57,$f5,$dd,$f5
        .byte $dd,$f5,$dd,$d5,$55,$d5,$d5,$75,$55,$75,$75,$40,$00,$40,$40,$40
        .byte $40,$80,$80,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$01,$05
        .byte $15,$7a,$d6,$07,$19,$69,$6a,$aa,$a9,$a5,$a7,$77,$d7,$77,$df,$dd
        .byte $f7,$d7,$f7,$d5,$55,$d6,$56,$d4,$d8,$58,$51,$80,$80,$00,$01,$07
        .byte $1f,$5f,$7f,$07,$1f,$7f,$ff,$fd,$f5,$d7,$77,$da,$59,$59,$65,$d7
        .byte $ff,$fd,$f7,$6f,$5d,$77,$df,$df,$7f,$fd,$f4,$dd,$f5,$d5,$f5,$5d
        .byte $77,$dd,$77,$67,$5d,$7d,$75,$d7,$77,$d7,$77,$7d,$75,$d7

    L_3efb:
        .byte $77,$f7,$df,$df,$df,$f7,$f7,$df
        .byte $dd,$d7,$df,$dd,$7f,$d7,$d7,$5f,$dd,$d4,$d0,$40,$40,$d0,$40,$40
        .byte $00,$00,$00,$00,$00,$c0,$40,$90,$90,$a4,$a4,$a9,$a9

    L_3f20:
        cmp L_5555,x

        .byte $57,$5d,$f4,$d0,$40,$74,$d0,$40,$40,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$40

    L_3f38:
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $66,$62,$02,$09,$1a,$11,$02,$06,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $40,$40

    L_3f52:
        .byte $90,$a4,$a4,$aa,$a9,$aa,$00
        .byte $01,$04,$10,$00

    L_3f5d:
        rti 

    L_3f5e:
         .byte $00,$90,$40,$10,$10,$10,$04,$04,$04
        .byte $01,$00,$00,$00,$00,$00,$00,$01,$01,$06,$01,$05,$1e,$7c,$79,$f1
        .byte $57,$aa,$aa,$aa,$aa,$a6,$aa,$aa,$aa,$aa,$9a,$6a,$aa,$aa,$aa,$aa
        .byte $aa,$a4,$a4,$a9,$aa,$a9,$a6,$a6,$9a,$01,$01,$01,$06,$47,$9b,$07
        .byte $11,$05,$47,$55,$6a,$99,$99,$e5,$e7,$55,$1d

    L_3fa2:
        .byte $7f,$7f,$5f,$d7,$f7,$5f,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $aa,$aa,$aa,$aa,$a9,$a9,$a6,$a6,$9a,$98,$56,$61,$a1,$86,$86,$18

    L_3fc0:
        ora $6360,y

        .byte $8f,$6d,$19,$17,$f5,$d7,$5d,$77,$7d,$ff,$ff,$ff,$ff,$df,$7f,$7f
        .byte $f7,$fd,$df,$f5,$7d,$a9,$aa,$a6,$aa,$99,$aa,$9a,$a6,$85,$94,$90
        .byte $91,$91,$a5,$95,$97,$18,$68,$5b,$f6,$f6,$fd,$dd,$d7,$df,$df,$df
        .byte $7f,$7f,$df,$f7,$f7,$77,$dd,$d7,$f5,$dd,$75,$dd,$e1,$3c,$66,$db
        .byte $b1,$b1,$db,$66,$3c,$38,$7c,$c6,$c6,$fe,$c6,$c6,$c6,$fc,$c6,$c6
        .byte $fc,$c6,$c6,$c6,$fc,$3c,$66,$c0,$c0,$c0,$c2,$66,$3c

    L_4020:
        sed 
        cpy L_c6c5 + $1
        dec $cc
        cld 
        sed 
        inc L_c0c3 + $3,x
        sed 
        cpy #$c0
        dec $fe
        inc L_c0c3 + $3,x
        sed 
        cpy #$c0
        cpy #$c0

        .byte $3c,$66,$c0,$ce,$c6,$c6,$66,$3c,$c6,$c6,$c6,$fe,$c6,$c6,$c6,$c6
        .byte $7e,$18,$18,$18,$18,$18

    L_404e:
        clc 
        ror $ccfe,x

        .byte $0c,$0c,$0c,$8c,$cc,$78,$c6,$cc,$d8,$f0,$d8,$cc,$c6,$c6,$c0,$c0
        .byte $c0,$c0,$c0,$c6,$c6,$fe,$ee,$fe,$d6,$d6,$c6,$c6,$c6,$c6,$c6,$e6
        .byte $f6,$fe,$de,$ce,$c6,$c6,$7c,$e6,$c6,$c6,$c6,$c6,$ce,$7c,$fc,$c6
        .byte $c6,$fc,$c0,$c0,$c0,$c0,$7c,$c6,$c6,$c6,$c6,$c6,$7c,$0e,$fc,$c6
        .byte $c6,$fc,$d8,$cc,$c6,$c6,$7c,$c6,$c0

    L_409b:
        .byte $7c
        .byte $06,$06,$c6,$7c,$7e,$18,$18,$18,$18,$18,$18,$18,$c6,$c6,$c6,$c6
        .byte $c6,$c6,$c6,$7c,$c6,$c6,$c6,$c6,$c6,$c6,$6c,$38,$c6,$c6,$c6,$c6
        .byte $d6,$fe,$ee,$c6,$c6,$ee,$7c,$38,$7c,$ee,$c6,$c6,$cc,$cc,$cc,$cc
        .byte $78,$30,$30,$30,$fe,$0c,$18,$30,$60,$c6,$c6,$fe,$00,$18,$ff,$7e
        .byte $18,$18,$18,$3c,$00,$7e,$67,$67,$7e,$7c,$6e,$67,$00,$00

    L_40ea:
        clc 
        clc 

        .byte $00,$00,$18,$18,$ff,$8c,$ba,$8a,$eb,$8b,$ff,$ff,$ff,$61,$af,$a9
        .byte $ad,$a1,$ff

    L_40ff:
        .byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $18,$18,$18,$18,$00,$00,$18,$f0,$d8,$d8,$f3,$db,$db,$0e,$04,$00

    L_4119:
        .byte $00,$00,$00,$00,$00,$00,$00,$f0,$c0
        .byte $e0,$ee,$cb,$fb,$0b,$0e,$00,$62,$66,$0c,$18,$30,$66,$46,$00,$3c
        .byte $66,$3c,$38,$67,$66,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18

    L_4142:
        .byte $30,$30,$30,$30,$30,$18,$00
        .byte $18

    L_414a:
        .byte $0c,$0c,$0c,$0c,$0c

    L_414f:
        clc 

        .byte $00,$38,$7c

    L_4153:
        bpl L_41d1
        dec $c6

        .byte $7c,$00,$78,$cc,$78,$30,$fc,$30,$30,$00,$6c,$fe,$fe,$fe,$7c,$38
        .byte $10,$00,$00,$00,$00,$7e,$00,$00,$00,$00,$00,$00,$3c,$3c,$3c,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6c,$c6,$c6,$c6,$c6,$c6
        .byte $6c,$00,$38,$78,$18,$18,$18,$18,$7e,$00,$7c,$c6,$06

    L_4194:
        .byte $0c,$30,$e6
        .byte $fe,$00,$7c,$c6,$06,$1c,$06,$c6,$7c,$00,$0c,$1c,$2c,$4c,$fe,$0c
        .byte $1e,$00,$fe,$06,$c0,$fc,$06,$c6,$7c,$00,$7e,$e6,$c0,$fc,$c6,$c6
        .byte $7c,$00,$fe,$c0,$0c,$0c,$18,$18,$18,$00,$7c,$c6,$c6,$7c,$c6,$c6
        .byte $7c,$00,$7c,$c6,$c6,$7e,$06,$c6,$7c,$00

    L_41d1:
        eor $55,x

        .byte $ff,$ff,$aa,$aa,$aa,$00,$00,$00,$05,$15,$3f,$2a,$0a,$55,$55,$ff
        .byte $ff,$aa,$aa,$aa,$00,$00,$00,$00,$7e,$00,$7e,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$3c,$66,$66,$0c,$18,$00,$18,$15,$6a,$6f
        .byte $6c,$6c,$6c,$6c,$6c,$55,$aa,$ff,$00,$00,$00,$00,$00,$54,$a9,$f9
        .byte $39,$39,$39,$39,$39,$6c,$6c,$6c,$6c,$6c,$6c,$6c,$6c,$00,$2c,$6b
        .byte $6b,$6b,$5b,$14,$00,$55,$aa,$ff,$3c,$2c,$2c,$2c,$2c,$6c,$6c,$2f
        .byte $1f,$1b,$07,$06,$01,$00,$00,$00,$00,$c0,$f0,$f0,$50,$00,$00,$00
        .byte $00,$03,$0f,$0f,$05,$39,$39,$f8,$f4,$e4,$d0

    L_424e:
        bcc L_4290
        and L_3938 + $1,y
        and L_3938 + $1,y
        and.a $0039,y

    L_4259:
         .fill $27, $0
        .byte $0d,$45,$c0,$ff,$ff,$ff,$6b,$a6,$bb,$6f,$a6,$fa,$6b,$56,$b5,$6f

    L_4290:
        lsr $f5,x

        .byte $6b,$a6,$b9,$6f,$a6,$fa,$6b,$a6,$ba,$6f,$a6,$fa,$9b,$a9,$ba,$9e
        .byte $a9,$ea,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$ea,$aa,$aa,$3f,$ea
        .byte $aa,$00,$3f,$aa,$00,$00,$eb,$00,$00,$3f,$00,$00,$03,$24,$17,$00
        .byte $35,$fd,$ff,$df,$e6,$ba,$6b,$a5,$ba,$5b,$56,$b5,$6b,$55,$b5,$5b
        .byte $66,$ba,$6b,$a5,$ba,$5b,$a6,$ba,$6b,$a5,$ba,$5b,$a6,$ea,$6e,$a9
        .byte $ea,$9e,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$ab,$aa,$ab
        .byte $fc,$aa,$fc,$00,$eb,$00,$00,$fc,$00,$00,$c0,$00,$00,$24,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$03,$00,$00,$0d,$3f,$ff,$f9
        .byte $ea,$aa,$a6,$95,$55,$65,$0a,$aa,$a5,$00,$03,$a6,$00,$00,$09,$00
        .byte $00,$0d,$00,$00

    L_4326:
        .byte $02,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00,$00
        .byte $0a,$00,$00,$29,$00,$00,$a9,$00,$00,$01,$00,$00,$00,$21,$00,$00
        .byte $00,$00,$00,$00,$d5,$00,$00,$c0,$00,$00,$f0,$00,$00,$bf,$ff,$fc
        .byte $be,$aa,$ab,$b9,$55,$56,$ba,$aa,$a0,$ba,$c0,$00,$bc,$00,$00,$f0
        .byte $00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$e0,$00
        .byte $00,$e8,$00,$00,$fa,$00,$00,$c0,$00,$00,$00,$00,$00,$21,$00,$00
        .byte $00,$00,$00,$00,$00,$0d,$43,$00,$3b,$0e,$ff,$e6,$fa,$55,$55,$56
        .byte $0a,$aa,$56,$00,$ff,$d6,$00,$00,$35,$00,$00,$0d,$00,$00,$01,$00
        .byte $00,$01,$00,$00,$01,$00,$00,$01,$00,$02,$81,$00,$07,$a9,$00,$07
        .byte $e9,$00,$04,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$54,$00
        .byte $00,$00,$00,$00,$c1,$70,$00,$b0,$ec,$00,$bf,$ab,$ff,$b5,$55,$56
        .byte $b5,$6a,$a0,$b7,$ff,$00,$bc,$00,$00,$b0,$00,$00,$80,$00,$00,$80
        .byte $00,$00,$80,$00,$00,$80,$00,$00,$82,$80,$00,$ba,$90,$00

    L_43f0:
        tay 

        .byte $10,$00,$80,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$50
        .byte $00,$bd,$c2,$04,$8d,$03,$d0,$bd,$1d,$04,$8d,$02,$d0,$bd,$5d,$04
        .byte $8d,$f9,$e3,$bd,$4d,$04,$8d,$28,$d0,$bd,$0d,$04,$2d,$88,$44

    L_4420:
        ora vSpriteXMSB
        sta vSpriteXMSB
        lda SCREEN_BUFFER_0 + $3d,x
        and SCREEN_BUFFER_1 + $88
        ora vSprPriority
        sta vSprPriority
        ldx.a $005a
        lda SCREEN_BUFFER_0 + $c2,x
        sta vSprite0Y
        lda SCREEN_BUFFER_0 + $1d,x
        sta vSprite0X
        lda SCREEN_BUFFER_0 + $5d,x
        sta $e3f8
        lda SCREEN_BUFFER_0 + $4d,x
        sta vSpr0Col
        lda SCREEN_BUFFER_0 + $0d,x
        and SCREEN_BUFFER_1 + $87
        ora vSpriteXMSB
        sta vSpriteXMSB
        lda SCREEN_BUFFER_0 + $3d,x
        and SCREEN_BUFFER_1 + $87
        ora vSprPriority
        sta vSprPriority
        lda #$d5
        sta vRaster
        lda vScreenControl1
        and #$7f
        sta vScreenControl1
        lda #$37
        sta SCREEN_BUFFER_0 + $06
        lda #$41
        sta SCREEN_BUFFER_0 + $07
        lda #$01
        sta vIRQFlags
        pla 
        tay 
        pla 
        tax 
        pla 
        rti 

        .byte $01,$02,$04,$08,$10,$20,$40,$80,$fe,$fd,$fb,$f7,$ef,$df,$bf,$7f
        .byte $8d,$28,$d0,$bd,$0d,$04,$2d,$88,$44,$0d,$10,$d0,$8d,$10,$d0,$bd
        .byte $3d,$04,$2d,$88,$44,$0d,$1b,$d0,$8d,$1b,$d0,$ae,$5a,$00,$bd,$c2
        .byte $04,$8d,$01,$d0,$bd,$1d,$04,$8d,$00,$d0,$bd,$5d,$04,$8d,$f8,$e3
        .byte $bd,$4d,$04,$8d,$27,$d0,$bd,$0d,$04,$0f,$0e,$0d,$0c,$0b,$0a,$09
        .byte $08,$07,$06,$05,$04,$03,$02,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff
        .byte $00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff
        .byte $00,$00,$ff,$00,$ff,$00,$ff,$00,$fd,$00,$ff,$00,$ff,$00,$ff,$00
        .byte $ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00
        .byte $ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00
        .byte $ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff

    L_4532:
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff

    L_4542:
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff

    L_4552:
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$02,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$80,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$82,$ff,$00

    L_4602:
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00

    L_4612:
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$fd,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00

    L_4692:
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$08,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff,$00
        .byte $ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$02,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$80,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff,$00,$ff,$00,$ff,$00,$ff,$00,$00,$ff
        .byte $00,$ff,$00,$ff,$00,$ff,$ff

    L_47e9:
        .byte $00,$ff,$00,$ff,$00,$ff,$00,$00,$ff,$00,$ff,$00,$ff,$00,$ff,$ff

    L_47f9:
        .byte $00,$ff,$00,$ff,$00,$ff,$82
        .byte $c0,$33

    L_4802:
        .byte $0c,$0c,$0c,$0c,$0c,$0c,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff,$00,$00
        .byte $00,$00,$03,$0c,$30,$c0,$0c,$0c,$ff,$0c,$0c,$0c,$0c,$0c,$c3,$c3

    L_4822:
        .byte $c3,$ff,$c3,$c3,$c3,$ff,$00,$00,$00,$3c,$3c,$00,$00,$00,$0c,$0c
        .byte $0c,$0f,$0c,$3c,$cc,$0c,$fc,$0c,$0c,$0c,$0c,$0c,$0c,$0f,$fa,$ef
        .byte $ef,$ef,$fb,$eb,$eb,$ea,$fb,$af,$af,$af,$af,$af,$ae,$fa,$ab,$ab
        .byte $ab,$ab,$bb,$bb,$fe,$ee,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$02,$02,$55,$55,$5a,$65,$65,$65,$66,$69,$55,$55
        .byte $aa,$95,$95,$b5,$9d,$97,$56,$56,$56,$d6,$f6,$7e,$5f,$57,$f5,$5d
        .byte $5d,$5d,$57,$57,$57,$57,$e5,$e5,$e5,$e5,$e5,$e5,$e5,$e5,$58,$5b
        .byte $58,$5b,$58,$5b,$58,$5b,$b7,$b7,$b7,$f7,$d7,$d7,$d7,$d7,$54,$57
        .byte $54,$57,$54,$57,$54,$57,$77,$77,$77,$77,$77,$77,$77,$f7,$00,$00
        .byte $00,$00,$00,$00,$00

    L_48b7:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00

    L_48c0:
        .fill $40, $ff
        .byte $00,$00,$00,$00,$00,$00,$00,$00

    L_4908:
        adc $65
        adc $65
    L_490c:
        adc $65
        eor $55,x
        adc $6d
        adc $ad
        lda $5d
        eor $5d,x

        .byte $00,$03,$0e,$0e,$3a,$3b,$eb,$ed,$eb,$ad,$b5,$d5,$d5,$55,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$55,$55,$eb,$7a,$5e,$57,$57,$55,$55,$55
        .byte $00,$c0,$b0,$b0,$ac,$ec,$eb,$7b,$56,$56,$56,$56,$58,$5b,$58,$5b

    L_4948:
        ora #$09
        ora #$02

    L_494c:
         .byte $02,$02,$00,$00
        .byte $6c,$63,$6c,$b3,$8c,$b3,$cc,$33,$09,$09,$09,$09,$09,$09,$09,$09
        .byte $09,$09,$09,$09,$09,$09,$09,$09,$69,$69,$a9,$a9,$ab,$e9,$f7,$65
        .byte $d7,$f7,$df,$f7,$df,$f7,$5d,$f5,$57,$57,$67,$77,$57,$57,$57,$57
        .byte $5d,$5f,$5d,$5f,$5d,$5f,$7d,$77,$39,$39,$39,$39,$39,$39,$39,$39
        .byte $6c,$63,$6c,$63,$6c,$63,$6c,$63,$d7,$d7,$d7,$d7,$d7,$d7,$d7,$ff
        .byte $5c,$53,$5c,$53,$5c,$53,$5c,$53,$65,$59,$59,$96,$95,$95,$95,$95
        .byte $00

    L_49b1:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $9d,$b7,$9d,$b7,$95,$95,$95,$95,$dd,$77,$dd,$77,$55,$55,$55,$55
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .fill $28, $ff
        .byte $56,$56,$56,$56

    L_4a04:
        lsr $56,x
        lsr $56,x
    L_4a08:
        eor $55,x
        adc $65
        adc $65
        adc $65

        .byte $03,$03,$0e,$0e,$3a,$3b,$eb

    L_4a17:
        sbc L_b5ad
        lda $d5,x
        dec $56,x
        lsr $57,x
    L_4a20:
        eor $55,x
        eor $55,x
        stx $96,y

        .byte $97,$d7,$55,$55,$55,$55,$aa,$aa,$ff,$ff,$55,$55,$55,$55,$96,$96
        .byte $d6,$d7,$7a,$5e,$5e,$57,$97,$95,$95,$d5,$c0,$c0,$b0,$b0,$ac,$ec
        .byte $eb,$7b,$aa,$aa,$aa,$66,$9a,$56,$56,$56,$cc,$33,$cc,$30,$cc,$30
        .byte $c0,$00,$09,$09,$09,$09,$09,$09,$0b,$0f,$25,$25,$25,$25,$25,$25
        .byte $25,$25,$6a,$65,$a5,$a5,$a5,$e6,$f6,$66,$aa,$55,$55,$65,$9d,$57
        .byte $57,$57,$d7,$d7,$77,$77,$77,$77,$77,$77,$7d,$77,$7d,$77,$dd,$f7
        .byte $dd,$77,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$8c,$b3,$8c,$b3,$8c,$b3
        .byte $8c,$b3,$d7,$d7,$5b,$5b,$9f,$97,$5b,$57,$4c,$73,$4c,$73,$4c,$73
        .byte $4c,$73,$95,$66,$65,$66,$a5,$9a,$95,$95
        .fill $28, $0
        .fill $28, $ff
        .byte $95,$95,$95,$95,$95,$95,$95,$95,$ff,$ea,$ea,$ea,$d5,$d5,$d5,$d5
        .byte $ed,$aa,$aa,$aa,$55,$55,$55,$55,$55,$aa,$aa,$aa,$65,$65,$65,$65

    L_4b20:
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x
        eor $aa,x
        tax 
        tax 
        eor $55,x
        eor $55,x

        .byte $7b,$aa,$aa,$aa,$55,$55,$55,$55

    L_4b48:
        .byte $ff,$ab,$ab,$ab,$57,$57,$57,$57
        .byte $cc,$33,$cc,$33,$cc,$33,$cc,$33,$55,$55,$55,$55,$55,$55,$ff,$ff
        .byte $95,$95,$95,$95,$95,$95,$95,$95,$55,$55,$55,$55,$55,$55,$55,$55
        .byte $77,$77,$77,$77,$77,$77,$77,$7f,$5d,$75,$5d,$77,$55,$75,$55,$75
        .byte $7d,$77,$7d,$5f,$5d,$df,$7d,$5f,$95,$bf,$bf,$bf,$bf,$bf,$bf,$bf
        .byte $55,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$56,$fe,$fe,$fe,$fe,$fe,$fe,$fe
        .byte $fb,$fb,$fb,$eb,$ab,$ab,$ab,$ab,$6a,$9a,$6a,$9a,$66,$9a,$67,$fd
        .byte $ab,$ab,$ab,$af,$b7,$d7,$57,$57
        .fill $20, $0
        .fill $28, $ff

    L_4c00:
        .byte $03,$03,$03,$03,$03,$03,$03,$03
        .byte $0a,$25,$95,$95,$9a,$a5,$95,$95,$55,$57,$5e,$7a,$eb,$ed,$ed,$ed
        .byte $ff,$aa,$aa,$ff,$65,$65,$65,$65

    L_4c20:
        eor $d5,x
        lda $ad,x

        .byte $eb,$7b,$7b,$7b,$55,$55,$65,$69,$7a,$5e,$56,$5a,$55,$55,$55,$69
        .byte $ad,$b5,$a5,$e9,$55,$55,$55,$69,$7a,$5e,$5a,$6b,$55,$55,$59,$69
        .byte $ad,$b5,$95,$a5,$01,$01,$01,$01,$01,$01,$01

    L_4c4f:
        ora ($c0,x)
    L_4c51:
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$cc

        .byte $33,$0c,$33,$0c,$03,$00,$00,$55,$55,$55,$55,$55,$55,$55,$55,$55
        .byte $55,$ff,$eb,$f7,$dd,$f7,$55

    L_4c70:
        .byte $7f,$7f,$7f,$ff,$ff
        .byte $aa,$77,$55,$55,$75,$55,$75,$55,$7d,$57,$77

    L_4c80:
        .byte $57,$57,$57,$57,$57,$57,$57,$d7,$bf,$bf,$bf,$bf,$bf,$bf,$6f,$6f
        .byte $66,$66,$66,$66,$66,$65,$65,$6f,$fe,$f6,$f6,$f6,$f6,$f6,$db,$db
        .byte $57,$5f,$7f,$ff,$ff,$fe,$fa,$ea,$59,$59,$99,$96,$96,$95,$65,$65
        .byte $55,$55,$55,$55,$55,$55,$ff

    L_4cb7:
        .byte $ff,$57,$57,$57,$57,$5f
        .byte $7d,$f7,$dd
        .fill $18, $0
        .byte $55,$55,$55,$55,$55,$99

    L_4cde:
        ror $aa
        tax 
        tax 
        tax 
        ror $99
        sta $95,x
    L_4ce7:
        sta $95,x
        sta $95,x
        sta $25,x
        and $25
        and $ff

    L_4cf1:
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$65,$65,$65,$aa,$aa,$65,$65,$65
        .byte $ed,$ed,$ed,$ed,$ed,$ed,$ed,$ed,$65,$65,$65,$65,$65,$65,$65,$65

    L_4d20:
        .byte $7b,$7b,$7b,$7b,$7b,$7b,$7b,$7b,$9b
        .byte $ed,$79,$5d,$55,$55,$55,$55,$7a,$5e,$57,$55,$55,$55,$55,$55,$ad
        .byte $b5,$d5,$55,$55,$55,$55,$55,$e6,$7b,$6d,$75,$55,$55,$55,$55,$c0
        .byte $00,$c0,$00

    L_4d4c:
        cpy #$00
    L_4d4e:
        cpy #$00

    L_4d50:
         .byte $7c,$73,$7c,$73,$7c,$73,$7c,$73,$00,$00,$00,$00
        .byte $c0,$30,$c0,$30,$55,$56,$5b,$5b,$6f,$6f,$6f,$6f,$aa,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$55,$b5,$ed,$ed,$fb,$fb,$fb,$fb,$55,$a9,$a9,$a9
        .byte $55,$75,$57,$7f,$d7,$d7,$d7,$d7,$d7,$df,$7d,$77,$6f,$6f,$6f,$e7
        .byte $59,$59,$5e,$5f,$ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$db,$db,$db,$db
        .byte $6f,$6f,$bf,$ff,$55,$55,$55,$bf,$99,$ea,$ea,$d9,$66,$65,$65,$65
        .byte $65,$66,$66,$66,$57,$9d,$75,$55,$55,$aa,$97,$67,$57,$57,$57,$57
        .byte $57,$ff,$55,$ff
        .fill $18, $0
        .byte $95,$95,$95,$95,$95,$95,$95,$95,$55,$55,$55,$6a,$6a,$65,$65,$65
        .byte $65,$65,$65,$6a,$6a,$65,$65,$65,$65,$65,$65,$65,$65,$65,$65,$65
        .byte $00,$00,$00,$00,$00,$03,$0e,$3a,$39,$39,$39,$39,$39,$39,$39,$39
        .byte $55,$55,$55,$aa,$aa,$55,$55,$55,$eb,$7a,$5e,$57,$57,$5e,$7a,$eb
        .byte $ff,$aa,$aa,$aa,$aa,$aa,$aa,$ff,$eb,$ad,$b5,$d5,$d5,$b5,$ad,$eb
        .byte $0b,$2d,$b5,$b5,$b6,$b7,$25,$0a

    L_4e30:
        .byte $6f,$5b
        .byte $56,$b6,$b6,$db,$6f,$bf,$f9,$e5,$95,$9e,$9e,$e7,$f9,$fe,$ef,$7b
        .byte $5e,$5e,$9e,$de,$5b,$af,$c0,$30,$c0,$30,$c0,$30

    L_4e4e:
        cpy #$30

        .byte $5c,$5f,$5c,$5f,$5c,$5f,$5c,$5f,$c0,$30,$cc,$30,$cc,$33,$cc,$33
        .byte $6f,$6f,$bf,$bf,$bf,$bf,$bf,$bf,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $fb,$fb,$fe,$fe,$fe,$fe,$fe,$fe,$55,$75,$55,$75,$55,$75,$55,$5d
        .byte $dd,$b7,$ed,$db,$d7,$d7,$d7,$d7,$67,$67,$65,$65,$65,$65,$59,$59
        .byte $ff

    L_4e91:
        .byte $ff,$ff,$ff,$7f
        .byte $55,$55,$55,$ff,$ff,$ff,$ff,$df,$5d,$5d,$5d,$ff,$ff,$ff,$ef,$fb
        .byte $fb,$fb,$fb,$69,$bb,$9b,$9b,$9b,$9b,$bb,$59,$55,$55,$6a,$95,$95
        .byte $d5,$7f,$55,$dd,$75,$d5,$55,$55,$55,$55,$55
        .fill $1c, $0
        .byte $ff,$aa,$aa,$ff,$00,$00,$00,$00,$00,$c0,$b0,$ac,$aa,$aa,$aa,$66
        .byte $99,$55,$55,$55,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$e5,$e5,$e5,$e5

    L_4f04:
        sbc $e5
    L_4f06:
        sbc $e5

        .byte $a3,$58,$56,$56,$a6,$5a,$56,$56,$ed,$ed,$ed,$eb,$7a,$5e,$57,$55
        .byte $65,$65,$65,$65,$ff,$aa,$aa,$ff,$7b,$7b,$7b,$eb,$ad,$b5,$d5,$55
        .byte $ff,$ff,$55,$aa,$aa,$55,$ff,$ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$55
        .byte $57,$57,$55,$5a,$5a,$55,$57,$57,$57,$57,$57,$57

    L_4f44:
        eor $5a,x

        .byte $5a,$55,$cc

    L_4f49:
        .byte $30,$cc,$30,$cc,$30,$cc
        .byte $30,$57

    L_4f51:
        .byte $57,$57,$57,$57,$57,$57,$57,$00,$00,$00,$00,$00,$00,$00,$00,$bf
        .byte $bf,$bf,$bf,$bf,$95,$aa,$aa,$ff,$ff,$ff,$ff,$ff,$55,$aa,$aa,$fe
        .byte $fe,$fe,$fe,$fe,$56,$aa,$aa,$65,$69,$69,$69,$69,$69,$6b,$6f,$d7
        .byte $d7,$d7,$f7,$b7,$b7,$b7,$b7,$55,$55,$55,$55,$55,$55,$55,$ff,$ab
        .byte $ff,$55,$55,$55,$af,$55,$55,$75,$75,$75,$d5,$d5,$55,$55,$55,$fb
        .byte $fb,$fb,$fb,$fb,$fb,$fb,$fb

    L_4fa8:
        sta $96,x
        txs 
        txs 
        txs 
        stx $fe,y
        inc L_9757,x

        .byte $a7,$a7,$a7,$97,$bf,$bf,$de,$76,$de,$76,$56,$56,$56,$56,$ff,$c3
        .byte $c3,$c3,$c3,$c3,$c3,$ff,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff,$00,$00
        .byte $00,$00,$00,$00,$00,$00
        .fill $28, $ff
        .byte $c0,$33,$0c,$0c,$0c,$0c,$0c,$0c,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff
        .byte $00,$00,$00,$00,$03,$0c,$30,$c0,$0c,$0c,$ff,$0c,$0c,$0c,$0c,$0c
        .byte $c3,$c3,$c3,$ff,$c3,$c3,$c3,$ff,$00,$00,$00,$3c,$3c,$00,$00,$00
        .byte $0c,$0c,$0c,$0f,$0c,$3c,$cc,$0c,$fc,$0c,$0c,$0c,$0c,$0c,$0c,$0f
        .byte $fa,$ef,$ef,$ef,$fb,$eb,$eb,$ea

    L_5048:
        .byte $fb,$af,$af,$af,$af,$af
        .byte $ae,$fa,$ab,$ab,$ab,$ab,$bb,$bb,$fe,$ee,$80,$80,$a0,$90,$5c,$5c
        .byte $70,$c0,$55,$a5,$a9,$aa,$aa,$aa,$aa,$aa,$55,$55,$55,$55,$95,$a9
        .byte $aa,$aa,$55,$55,$55,$55,$55,$55,$95,$aa,$55,$55,$55,$55,$55,$55
        .byte $56,$aa,$55,$55,$55,$55,$56,$6a,$aa,$aa,$55,$56,$6a,$aa,$aa,$aa
        .byte $aa,$aa,$55,$55,$55,$55

    L_5094:
        eor $56,x

        .byte $5a,$6a,$55,$56,$5a,$6a,$aa,$aa,$aa,$aa,$ff,$55,$55,$55,$55,$55
        .byte $55,$55,$c0,$00,$c0,$00,$00,$c0,$00,$c0,$57,$5d,$57,$55,$5d,$57
        .byte $55,$57,$55,$55,$55,$55,$55,$55,$55,$aa

    L_50c0:
        .fill $18, $ff
        .byte $fb,$fb,$fe,$fe,$fe,$fe,$fe,$fe

    L_50e0:
        .fill $20, $ff

    L_5100:
        .byte $00,$00,$00,$00,$00,$00,$00,$00

    L_5108:
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
        eor $56,x
    L_5118:
        eor $55,x
        eor $56,x
        eor L_9a66,y
        ror 
    L_5120:
        tax 
        tax 
        tax 
        rol 
        rol 
        asl 

        .byte $02,$00,$aa,$aa,$aa,$aa,$a8,$80,$00,$00

    L_5130:
        tax 
        tax 
        ldy #$00

        .byte $00,$00,$00,$00,$aa,$aa,$aa,$aa,$2a,$2a,$2a,$08,$aa,$aa,$aa,$aa
        .byte $aa,$aa,$a8,$80,$a8,$a8,$a0,$a0,$80,$00,$00,$00,$02,$02,$0a,$0a
        .byte $2a,$2a,$aa,$aa,$80,$80,$80,$a0,$90,$94,$94,$54,$55,$55,$55,$55
        .byte $55,$56,$5a,$aa,$55,$55,$56,$6a,$aa,$aa,$aa,$aa,$55,$6a,$aa,$aa

    L_5174:
        tax 
        tax 
        tax 
        tax 
        eor $a9,x
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        eor $55,x
        sta $a9,x
        tax 
        tax 
        tax 
        tax 
        eor $55,x
        eor $55,x
        eor $95,x
        lda #$aa
        sta $a5,x
        lda #$aa
        tax 
        tax 
        tax 
        tax 
        eor $55,x
        eor $55,x
        sta $a5,x
        lda #$aa
        eor $55,x
        eor $57,x

        .byte $57,$dc,$70,$cc,$55,$57,$74,$cc,$00,$c0,$00,$00,$77,$4c,$c0,$00
        .byte $00,$00,$00,$00,$dd,$31,$03

    L_51bb:
        .byte $00,$00,$00,$00,$00
        .byte $55,$d5,$1d,$33,$00,$03,$00,$00,$55,$55,$55,$d5,$d5,$37,$0d,$33
        .byte $dd,$76,$db,$7b,$ef,$6f,$ef,$6f,$bf,$bf,$bf,$bf,$bf,$bf,$ef,$6f
        .fill $20, $ff
        .byte $55,$55,$55,$55,$55,$55,$99,$66,$55,$55,$55,$55,$55,$56,$59,$66
        .byte $59,$56,$5a,$66,$9a,$6a,$aa,$aa,$56,$59,$66,$9a,$6a,$aa,$aa,$aa

    L_5220:
        eor $55,x
        eor $55,x
        eor $56,x
        eor $5556,y
        lsr $59,x
        ror $9a
        ror 
        tax 
        tax 
        eor $65,x
        sta L_a963 + $3,y
        tax 
        lda #$aa
        eor $55,x
        eor $55,x
        sta $66,x
        sta.a $00aa,y

    L_5241:
         .byte $00,$00,$80
        .byte $a0,$a0,$a8,$a8,$a8,$a8,$a0,$a0,$a0,$80,$80,$00,$aa,$aa,$2a,$29
        .byte $05,$05,$01,$00,$54,$55,$55,$57,$57,$5c,$5c,$f0,$75,$55,$75,$dd
        .byte $57,$5d,$55,$5d,$d5,$55,$d5,$55,$d5,$55,$d5,$55,$aa,$6a,$6a,$5a
        .byte $5a,$56,$56,$55,$aa,$a9,$a9,$a5,$a5,$95,$95,$55,$aa,$9a,$66,$99
        .byte $66,$59,$56,$55,$aa,$a6,$99,$66,$99,$65,$95,$55,$00,$00,$00,$00
        .byte $02,$0a,$2a,$aa,$00,$00,$00,$00,$00,$00,$00,$00,$cc,$70,$dc,$57
        .byte $57,$55,$55,$55,$00,$00,$c0,$00,$cc,$74,$57,$55,$00,$00,$00,$00
        .byte $00,$c0,$4c,$77,$00,$00,$00,$00,$00,$03,$31,$dd,$00,$00,$03,$00
        .byte $33,$1d,$d5,$55,$33,$0d,$37,$d5,$d5,$55,$55,$55

    L_52d0:
        tax 

        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$fe,$f6,$f6,$f6,$f6,$f6,$db,$db
        .fill $20, $ff
        .byte $59,$56,$5a,$66,$5a,$6a,$9a,$aa

    L_5308:
        .byte $5a,$5a
        .byte $6a,$6a,$6a,$5a,$5a,$6a,$d5,$d5,$f5,$75,$dd,$77,$5d,$57,$57,$57
        .byte $5d,$5f,$7d,$f7,$dd,$75,$57,$57,$5d,$5f,$7d,$77,$dd,$f5,$55,$55
        .byte $57,$5f,$7d,$77,$dd,$f5,$55,$55,$d5,$77,$dd,$77,$5d,$55,$55,$7d
        .byte $df,$77,$dd,$55,$55,$55,$d5,$d5,$55,$55,$55,$55,$55,$55,$57,$57
        .byte $5d,$5d,$5d,$75,$75,$75,$00,$00,$00,$02,$0a

    L_5355:
        asl 
        rol 
        rol 

        .byte $00,$00,$a0,$a8,$a8,$a9,$95,$97,$aa,$aa,$aa,$9a,$aa,$aa,$aa,$aa
        .byte $55,$55,$55,$65,$55,$55,$55,$55,$55,$55,$56,$5a,$55,$55,$55,$55
        .byte $d5,$55,$75,$d5,$5d,$55,$57,$5d,$75,$d5,$55,$7d,$57,$5d,$55,$57
        .byte $0d,$03,$0d,$05,$35,$0d,$d5,$75,$75,$d5,$0d,$35,$05,$0d,$03,$0d
        .byte $aa,$55,$75,$dd,$57,$5d,$55,$5d,$00,$a0,$a8,$aa,$aa,$aa,$aa,$aa
        .byte $00,$00,$00,$00,$80,$a8,$aa,$aa,$00,$00,$00,$00,$00,$00,$80,$aa

    L_53b8:
        .byte $00,$00,$00,$00,$00,$00,$02
        .byte $aa,$00,$00,$00,$00,$02,$2a,$aa,$aa,$00,$0a,$2a,$aa,$aa,$aa,$aa
        .byte $aa,$dd,$b7,$ed,$ef,$fb,$fb,$fb,$fb,$ef,$6f,$ef,$67,$d9,$79,$de
        .byte $77,$aa,$aa,$a8,$a8,$a0,$a0,$a0,$a0,$00,$00,$80,$80,$a0,$a0,$a8
        .byte $a8,$02,$02,$0a,$0a,$2a,$2a,$09,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff

    L_5400:
        cmp L_d565 + $10,x
        adc $d5,x
        eor $55,x
        eor $00,x

        .byte $00,$00,$00,$00,$00,$02,$a9,$00,$00,$00,$00,$08,$a6,$55,$55,$00
        .byte $00,$00,$00,$00,$80,$60

    L_541f:
        .byte $5a,$02,$02
        .byte $09,$09,$25,$25,$95,$95,$00,$00,$00,$00,$00,$00,$28,$96,$00,$00
        .byte $00,$00,$02,$02,$09,$a5,$08,$08,$26,$95,$55,$55

    L_543e:
        eor $55,x

        .byte $00,$00,$00,$82,$69,$55,$55,$55

    L_5448:
        .byte $00,$00,$80,$80

    L_544c:
        rts 


        rts 



    L_544e:
         .byte $58,$58,$2a,$0a,$05,$03,$00,$00,$00,$00,$57,$5c,$70,$c0,$00,$00
        .byte $00,$00,$f5,$75,$5d,$57,$55,$55,$55,$55,$75,$55,$75,$dd,$d7,$7d
        .byte $57,$55,$75,$55,$75,$dd,$57,$5d,$d5,$7f,$75,$55,$75,$dd,$57,$5d
        .byte $57,$fd,$75,$55,$75,$dd,$57,$7d,$d5,$55,$77,$5d,$75,$d5,$55,$55
        .byte $55,$55,$f5,$75,$5d,$57,$55,$55,$55,$55,$75,$55,$75,$dd,$d7,$7d
        .byte $5d,$57,$55,$aa,$75,$dd,$57,$5d,$55,$5d,$55,$55,$aa,$dd,$57,$5d
        .byte $55,$5d,$55,$55,$55,$aa,$57,$5d,$55,$5d,$55,$55,$55,$55,$aa,$5d
        .byte $55,$5d,$55,$55,$55,$55,$55,$aa,$55,$5d,$55,$55,$55,$55,$55,$55
        .byte $aa,$5d,$ef,$6f,$bf,$bf,$bf,$bf,$bf,$bf,$ff,$ff,$ff,$ff,$ff,$55
        .byte $aa,$aa,$aa,$aa,$a8,$80,$00,$00,$00,$00,$aa,$aa,$2a,$02,$00,$00
        .byte $00,$00,$aa,$aa,$a8,$a8,$a0,$20,$00,$00,$aa,$2a,$0a,$0a,$02,$02
        .byte $02,$00,$55,$55,$55,$55

    L_5504:
        .byte $57
        .byte $5d,$7f,$57

    L_5508:
        .byte $57,$57
        .byte $5d,$5d,$75,$75,$d5,$d5,$55,$55,$55,$55,$75,$fd,$75,$55,$75,$55
        .byte $75,$55,$5d,$55,$5d,$55,$dd,$77,$5d,$55,$55,$55,$55,$55,$57,$55
        .byte $75,$55,$d5,$55,$75,$55,$5d,$55,$5d,$55,$5d,$75,$d5,$55,$57,$55
        .byte $75,$55,$75,$55,$5d,$55,$75,$55,$5d

    L_5543:
        eor $57,x
        eor $57,x
        adc $55,x

        .byte $57,$55,$dd

    L_554c:
        eor $5d,x
        eor $55,x
        eor $75,x
        cmp $dd77,x
    L_5555:
        adc $55,x
    L_5557:
        eor $55,x
        eor $d5,x
        eor $5d,x
        eor $55,x
        eor $75,x
        eor $75,x
        cmp L_5d57,x
    L_5566:
        adc $d5,x
        adc $57,x
        adc L_55d5,x
        eor $55,x
        eor $7f,x
        cmp $55,x
        eor $55,x
    L_5575:
        eor $55,x
        eor $fd,x

        .byte $57,$55,$55,$55,$55,$55,$55,$75,$d5,$7d,$57,$55,$55,$55,$55,$75
        .byte $55,$75,$dd,$d7,$75,$5d,$57,$d5,$75,$7d,$df,$57,$5d,$55,$5d,$55
        .byte $55,$55,$55,$d5,$75,$5d,$5f,$56,$56,$56,$59,$5b,$59,$65,$9d,$b5
        .byte $75,$59,$5d,$5b,$56,$57,$56,$b5,$95,$b5,$9d,$97,$9d,$95,$9d,$65
        .byte $65,$65,$6d,$67,$6d,$65,$6d,$59,$59,$59,$59,$5b,$59,$59,$59,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$70,$c0,$70,$50,$5c

    L_55d5:
        bvs L_562c + $2
        eor vColorRam + $3d9,x
        cmp L_6ddb,y

        .byte $67,$9d,$77,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$a8
        .byte $a8,$a0,$80

    L_55f0:
        .byte $00,$80,$80,$80,$80,$80,$80,$00
        .byte $a0,$a0

    L_55fa:
        .byte $80,$80,$80,$80,$80,$80
        .byte $55,$55,$69,$aa,$eb,$7f,$5d,$55,$59,$69,$a9,$a9,$ad,$7d,$55,$55
        .byte $aa,$a6,$95,$95,$a6,$aa,$aa,$aa,$aa

    L_5619:
        tax 
        stx $55,y
        cmp $b6,x
        ldx $9a,y
        tax 
        tax 
        ldx $96
        stx $56,y

        .byte $fa,$aa,$80,$80,$60,$60

    L_562c:
        .byte $58,$58,$56,$56,$00,$00,$00,$00,$02
        .byte $09,$25,$95,$02,$09,$25,$95,$55,$55,$55,$55,$95,$25,$25,$09,$09
        .byte $25,$25,$95,$95,$95,$95,$25,$25,$95,$95,$95,$d5,$d5,$35,$35,$35

    L_5655:
        ora.a $0003
        eor $55,x
        eor $55,x
        eor $55,x
        cmp $3f,x
        sta $65,x
        adc L_57da + $4,y
        eor $5d55,x
        eor $55,x
        eor $55,x
        sta $69,x
        lsr $5d,x
        eor $55,x
        eor $55,x
        eor $55,x
        sta $6a,x
        eor $55,x
        eor $55,x
        eor $55,x
        lsr $a9,x
        eor $55,x
        eor $55,x
        lsr $69,x
        sta $5d,x
        lsr $59,x
        adc $9d

        .byte $57,$5d,$55,$5d,$d5,$55,$d5,$55,$55,$d5,$55,$d5,$dc,$57,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$77,$cc,$c3,$00,$00
        .byte $00,$00,$00,$00,$50,$50,$50,$50,$50,$50,$50,$50,$54,$54,$54,$54
        .byte $54,$54,$54,$54,$75,$ff,$55,$55,$55,$55,$55,$55,$75,$55,$ff,$55
        .byte $55,$55,$55,$55,$5d,$57,$70,$5c,$50,$70,$c0,$70,$dd,$f7,$fd,$7f
        .byte $dd,$77,$df,$77,$75,$55,$75,$dd,$57,$ff,$55,$55,$75,$55,$75,$dd
        .byte $57,$5d,$ff,$55,$75,$55,$75,$dd,$57,$5d,$55,$ff,$df,$77,$dd,$ff
        .byte $ff,$77

    L_56fe:
        sbc L_d5eb + $c,x

    L_5701:
         .byte $37,$0c,$00,$00,$00,$00,$00

    L_5708:
        sbc $0d,x

        .byte $03,$00,$00,$00,$00,$00,$55,$55,$55,$d5,$d5,$d5,$35,$35,$35,$0d
        .byte $0d,$0d,$03,$03,$03,$03,$55,$55,$55,$55,$55,$5d,$73,$c0,$55,$55
        .byte $57,$5c,$70,$c0,$00,$00

    L_5730:
        eor $d5,x
        and.a $0003,x

        .byte $00,$00,$00,$dd,$77,$dd,$77,$dd,$77,$dd,$77,$55,$55,$55,$75,$dd
        .byte $77,$dd,$77,$dd,$77,$dd,$77,$5d,$55,$55,$55,$55,$57,$5d,$77,$5d

    L_5755:
        .byte $77
        .byte $5d,$57,$55,$55,$d5,$75,$dd

    L_575d:
        adc $d5,x
        eor $55,x
        eor $55,x
        eor $56,x
        eor $9d65,y
        eor $56,x
        adc #$9d

        .byte $57,$5d,$55,$5d,$6a,$97,$75,$dd

    L_5774:
        .byte $57

    L_5775:
        eor $5d55,x
        lda #$56
        adc $dd,x

        .byte $57,$5d,$55,$5d,$55,$95,$69,$de,$57,$5d,$55,$5d,$55,$55,$55,$55
        .byte $95,$65,$59,$5e,$77,$55,$77,$dd,$57,$5d,$57,$5d,$7d,$55,$7d,$d5
        .byte $5d,$55,$5d,$55,$75,$55,$75,$d5,$75,$55,$75,$55,$95,$65,$95,$65
        .byte $95,$65,$95,$65,$75,$55,$75,$ff,$55,$55,$55,$55,$75,$55,$75,$dd
        .byte $ff,$55,$55,$55,$ff,$c3,$c3,$c3,$c3,$c3,$c3,$ff,$30,$30,$30,$ff
        .byte $30,$30,$30,$30,$0c,$0c,$0c,$0c,$0f,$0c,$3c,$cc,$c3,$c3

    L_57da:
        .byte $c3,$ff,$c3,$c3,$c3

    L_57df:
        .fill $21, $ff
        .byte $04,$04,$05,$06,$01,$0b,$03,$01,$01,$01,$02,$03

    L_580c:
        ora ($01,x)

        .byte $02,$03,$01,$01,$0b,$0b,$0d,$0d,$0e,$0e,$0d,$0d,$0e,$0e,$0b,$0b
        .byte $0b,$0b,$03,$03,$03,$03,$19,$19,$19,$19,$19,$19,$19,$19,$01,$01
        .byte $0b,$0b,$19,$19,$19,$19,$01,$0b,$19,$19,$01,$01,$0b,$0b,$01,$01
        .byte $0b,$0b,$04,$00,$00,$33,$40,$00,$ed,$c1,$00,$69,$90,$d0,$99,$9c
        .byte $40

    L_584f:
        .byte $e9,$9f,$70,$39,$9e
        .byte $6c,$0d,$de

    L_5857:
        .byte $6b,$03
        .byte $1e,$66,$03,$0e,$69,$01,$0f,$fb,$06,$00,$cc,$07,$00,$80,$02,$00
        .byte $40,$01,$01,$c0,$0d,$c1,$80,$09,$f0,$40,$02,$ec,$40,$00,$27,$40
        .byte $00,$09,$c0,$00,$02,$c0,$08,$00,$00,$10,$00

    L_5884:
        ora ($cc,x)

        .byte $00,$4f,$7b,$07,$1e,$65,$01,$de,$6a,$3d,$9e,$6b,$e9,$9e,$6c,$a9
        .byte $9f,$70,$99,$9c,$c0,$69,$d0,$c0,$3f,$10,$40,$03,$01,$80,$01,$01
        .byte $c0,$02,$00,$80,$07,$00,$40,$06,$03,$70,$01,$0d,$70,$01,$fa,$c0
        .byte $0d,$d8,$00,$0a,$e0,$00,$00,$00,$00,$08,$00,$00,$00,$04,$41,$10
        .byte $03,$0c,$c0,$3d,$df,$7c,$e9,$9e,$6b,$59,$9e,$65,$a9,$9e,$6a,$e9
        .byte $9e,$6b,$3d,$df,$7c,$03,$1c,$c0,$03,$00,$c0,$01,$00,$40,$06,$01
        .byte $80,$07,$01,$c0,$02,$00,$80,$01,$00,$40,$01,$ff,$40,$0d,$d5,$70
        .byte $09,$ea,$f0,$00,$00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$07,$4d,$d0,$3d,$db,$7c,$29,$9e,$68,$59,$9e,$65,$e9
        .byte $9e,$6b,$3f,$9e,$fc,$03,$df,$c0,$03,$00

    L_5920:
        cpy #$01

        .byte $00,$80,$02,$00,$c0,$03,$ff,$c0,$00,$55,$00,$00,$28,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$eb,$00,$3e,$9a,$bc,$a9,$9a,$6a
        .byte $e9,$9e,$6b

    L_5955:
        and L_7cdf,x

    L_5958:
         .byte $03,$1c
        .byte $c0,$03,$00,$c0,$00,$aa,$00,$00,$ff
        .fill $1c, $0
        .byte $08,$00,$00,$00,$01,$00,$40,$09,$aa,$60,$01,$00,$40,$03,$ff,$f0
        .byte $3e,$aa,$bc,$a9,$aa,$6a,$d9,$aa,$67,$3d,$eb,$7c,$00,$1c
        .fill $22, $0
        .byte $08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$69,$80,$00,$41,$00
        .byte $00,$41,$00,$01,$00,$40,$01,$eb,$40,$3d,$aa,$7c,$e9,$aa,$6b,$a9
        .byte $aa,$6a,$29,$aa,$68,$3d,$ff,$7c,$07,$41,$d0

    L_59ea:
        .fill $15, $0
        .byte $08

    L_5a00:
        .byte $00,$00,$00,$00,$00,$00
        .byte $0a,$aa,$a0,$0e,$aa,$b0,$03,$ff,$c0,$01,$00,$40,$02,$00,$80,$06
        .byte $01,$80,$06,$01,$80,$01,$00,$40,$01,$00

    L_5a20:
        rti 
        ora ($3c,x)
        rti 

        .byte $3d,$eb,$7c,$e9,$aa,$6b,$a9,$aa,$6a,$a9,$aa,$6a,$e9,$aa,$6b,$3d
        .byte $ff,$7c,$03,$00,$c0,$04,$41,$10,$00,$00,$00,$08

    L_5a40:
        .fill $18, $0
        .byte $0e,$aa,$b0,$07,$ff,$d0,$04,$00,$10,$04,$00

    L_5a63:
        bpl L_5a66

        .byte $3c

    L_5a66:
        rti 

    L_5a67:
         .byte $3d,$eb,$7c,$e9,$aa,$6b
        .byte $a9,$aa,$6a,$ea,$69,$ab,$3e,$7d,$bc,$03,$00,$c0,$00,$00,$00,$00
        .byte $00,$00,$08
        .fill $15, $0
        .byte $0a,$aa,$a0,$0f,$ff,$f0,$01,$00

    L_5a9d:
        rti 

        .byte $01,$ff,$70,$3d,$aa,$7c,$a9,$aa,$6a,$ea,$aa,$ab,$3f,$eb,$fc,$00
        .byte $3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$08

    L_5ac0:
        .fill $16, $0
        .byte $ff,$00,$3f,$aa,$fc,$a9,$aa,$6a,$e9,$aa,$6b,$3d,$eb,$7c,$03,$3c
        .byte $c0,$0c,$00,$30,$0c,$00,$30,$0a,$aa,$a0,$0f,$ff,$f0,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$08
        .fill $13, $0
        .byte $08,$00,$00,$4c,$40,$0a,$6a,$68,$0e,$aa,$ac,$03,$ff,$f0,$00

    L_5b22:
        cpy #$c0

        .byte $02,$ea,$e0,$03,$ff,$f0,$00

    L_5b2b:
        cpy #$c0

        .fill $17, $0
        .byte $08,$00,$00,$2b,$00,$00,$6b,$c0,$00,$eb,$80,$00,$3a,$00,$00,$04
        .byte $00,$00,$08,$00,$00,$04,$00,$00,$08

    L_5b5d:
        .byte $00,$00,$f7,$f0,$03,$ab
        .byte $ac,$0a,$a7,$a8,$05,$ab,$94,$0e,$ab,$ac,$03,$eb,$f0,$00,$3b,$00
        .byte $00,$08,$00,$00,$5d,$40,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00
        .byte $00,$08,$00,$00,$08,$00,$00,$3b,$00,$00,$6b,$80,$00,$3a,$00,$00
        .byte $04,$00,$00,$3b,$00,$00,$e7,$c0,$03,$ab,$b0,$0e,$a7,$ac,$0a,$ab
        .byte $a8,$0f,$e7,$fc,$00,$3b,$00,$00,$5d,$40,$00,$08,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00
        .byte $00,$00,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00,$6b,$80,$00
        .byte $ba,$80,$00,$08,$00,$00,$2a,$00,$0a,$5e,$e8,$0f,$ed,$7c,$00,$2b
        .fill $1c, $0
        .byte $21,$00

    L_5c01:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $5d,$40,$03,$aa,$b0,$0e,$aa,$ac,$0a,$aa,$a8,$03,$ea,$f0,$00,$3b
        .byte $00,$00,$08,$00,$00,$08,$00,$00,$2b,$00,$00,$ab,$80,$00,$3b
        .fill $13, $0
        .byte $21,$00,$5d,$40,$00,$08,$00,$00,$3b,$00,$03,$ea,$f0,$0e,$aa,$ac
        .byte $0a,$aa,$a8,$0a,$aa,$a8,$03,$aa,$ac,$00,$fb,$f0,$00

    L_5c5c:
        php 

        .byte $00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00,$2b,$00
        .byte $00,$ab,$80,$00,$2b,$00,$00,$08

    L_5c75:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$5d,$40,$00,$3b,$00
        .byte $0f,$eb,$fc,$0a,$aa,$a8,$0e,$aa,$ac,$03,$aa,$b0,$00

    L_5c9c:
        nop 
        cpy #$00

        .byte $3b,$00,$00,$08,$00,$00,$3b,$00,$00,$ab,$80,$00,$2a,$00,$00,$08
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00
        .byte $00,$fb,$c0,$00,$aa,$80,$00,$0c,$00,$00,$2a,$00,$0a,$aa,$a8,$0f
        .byte $ea,$fc,$00,$3b
        .fill $1c, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$3b,$00,$00,$ab,$80,$00,$2b,$00,$00,$08,$00,$00,$08,$00,$00
        .byte $3b,$00,$03,$ea,$f0,$0a,$aa,$a8,$0e,$aa,$ac,$03,$aa,$b0,$00

    L_5d2e:
        eor.a $0040,x

        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$00,$00,$00,$5d,$40,$00,$08,$00,$00,$3b,$00,$03,$eb
        .byte $f0,$0e,$ab,$ac,$05,$ab

    L_5d57:
        sty $0a,x

        .byte $a7,$a8,$03,$ab

    L_5d5d:
        ldy $f700
        beq L_5d62
    L_5d62:
        php 

        .byte $00,$00,$04,$00,$00,$08,$00,$00,$04,$00,$00,$3a,$00,$00,$eb,$80
        .byte $00,$6b

    L_5d75:
        cpy #$00

    L_5d77:
         .byte $2b,$00,$00
        .byte $08

    L_5d7b:
        .byte $00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$08,$00,$00,$5d,$40,$00,$3b,$00,$0f,$e7,$fc,$0a,$ab,$a8,$0e
        .byte $a7,$ac,$03,$ab,$b0,$00,$e7,$c0,$00,$3b,$00,$00,$04,$00,$00,$3a
        .byte $00,$00,$6b,$80,$00,$3b,$00,$00,$08,$00,$00,$08,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$08,$00,$00,$08,$00
        .byte $00,$6b,$80,$00,$ba

    L_5dd4:
        .byte $80,$00
        .byte $08

    L_5dd7:
        .byte $00,$00
        .byte $2a,$00,$0a,$5e,$e8,$0f,$ed,$7c,$00,$2b
        .fill $1c, $0
        .byte $21
        .fill $13, $0
        .byte $3b,$00,$00,$ab,$80,$00,$2b,$00,$00,$08,$00,$00,$08,$00,$00,$3b
        .byte $00,$03,$ea,$f0,$0a,$aa,$a8,$0e,$aa,$ac,$03,$aa,$b0,$00

    L_5e31:
        eor.a $0040,x

        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$08,$00,$00,$2b,$00,$00,$ab,$80,$00,$2b
        .byte $00,$00,$08,$00,$00

    L_5e59:
        php 

        .byte $00,$00,$08,$00,$00,$08,$00,$00,$08,$00,$00,$fb,$f0,$03,$aa,$ac
        .byte $0a,$aa,$a8,$0a,$aa,$a8,$0e,$aa,$ac,$03,$ea,$f0,$00,$3b,$00,$00
        .byte $08,$00,$00,$5d,$40,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$08,$00,$00,$2a,$00,$00,$ab,$80,$00,$3b
        .byte $00,$00,$08,$00,$00,$3b,$00,$00,$ea,$c0,$03,$aa,$b0,$0e,$aa,$ac
        .byte $0a,$aa,$a8,$0f,$eb,$fc,$00,$3b,$00,$00,$5d,$40,$00,$08,$00,$00
        .byte $00,$00,$00,$00,$00,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$00,$08,$00,$00,$08,$00,$00,$fb,$c0,$00,$aa,$80,$00,$0c
        .byte $00,$00,$2a,$00,$0a,$aa,$a8,$0f,$ea,$fc,$00,$3b
        .fill $19, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$5d,$40,$03,$aa,$b0,$0e,$aa,$ac,$0a,$aa,$a8,$03,$ea,$f0,$00
        .byte $3b,$00,$00,$08,$00,$00,$08,$00,$00,$2b,$00,$00,$ab,$80,$00,$3b
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$01,$00,$00,$30,$40,$00,$ac,$30,$02,$6b,$84
        .byte $02,$9a,$c1,$03,$ab,$b0,$00,$eb,$ac,$00,$3e,$ab,$00,$1e,$9b,$00
        .byte $23,$a4,$00,$40,$f0,$00,$80,$00,$1f,$c0,$00,$2b,$80,$00,$0f,$80
        .byte $00,$0e,$80,$00,$0c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$03,$80,$00,$0e,$40,$00,$0e,$40
        .byte $00,$0e,$40,$00,$0e,$80,$0c,$0e,$81,$2c,$0e,$a1,$9c,$0e,$a1,$a9
        .byte $99,$ac,$38,$0f,$f1,$0c,$0f,$f1,$0c,$0e,$81,$00,$0e,$80,$00,$0e
        .byte $40,$00,$0e,$40,$00,$0e,$40,$00,$03,$80,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$0e,$80,$00,$0f,$80,$00
        .byte $2b,$80,$00,$1f,$c0,$00,$00,$80,$00,$00,$40,$f0,$00,$23,$a4,$00
        .byte $1e,$9b,$00,$3e,$ab,$00,$eb,$ac,$03,$ab,$b0,$02,$9a,$c1,$02,$6b
        .byte $84,$00,$ac,$30,$00,$30,$40,$00,$01,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$30,$00,$02,$b0,$00,$02,$f0
        .byte $00,$02,$e8,$00,$03,$f4,$00,$02,$00,$0f,$01,$00,$1a,$c8,$00,$e6
        .byte $b4,$00,$ea,$bc,$00,$3a,$eb,$00,$0e,$ea,$c0,$43,$a6,$80,$12,$e9
        .byte $80,$0c,$3a,$00,$01,$0c,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$02,$c0,$00,$01,$b0,$00

    L_604c:
        ora ($b0,x)

        .byte $00,$01,$b0,$00,$02,$b0,$00,$42,$b0,$30,$4a,$b0,$38,$4a,$b0,$36
        .byte $3a,$66,$6a,$4f,$f0,$2c,$4f,$f0,$30,$42,$b0,$30,$02,$b0,$00

    L_606d:
        ora ($b0,x)

        .byte $00,$01,$b0,$00,$01,$b0,$00,$02,$c0,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$40,$00,$01,$0c,$00,$0c,$3a,$00
        .byte $12

    L_6090:
        sbc #$80

        .byte $43

    L_6093:
        ldx $80
        asl L_c0ea

        .byte $3a,$eb,$00,$ea,$bc,$00,$e6,$b4,$00,$1a,$c8,$00,$0f,$01,$00,$00
        .byte $02,$00,$00,$03,$f4,$00,$02,$e8,$00,$02,$f0,$00,$02,$b0,$00,$00
        .byte $30,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00,$00,$15,$00,$5c
        .byte $03,$00,$3b,$0e,$ff,$e6,$fa,$55,$55,$56,$0a,$aa,$56,$00,$ff,$d6
        .byte $00,$00,$35,$00,$00,$0d,$00,$00,$01,$00,$00,$01,$00,$00,$01,$00
        .byte $00,$01,$00,$02,$81,$00,$07,$a9,$00,$07,$e9,$00,$04,$02,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$21,$00

    L_6101:
        .byte $00,$00,$00,$00,$00
        .byte $c0,$35,$00,$b0,$ec,$00,$bf,$ab,$ff,$b5,$55,$56,$b5,$6a,$a0,$b7
        .byte $ff,$00,$bc,$00,$00,$b0,$00,$00,$80,$00,$00,$80,$00,$00,$80,$00
        .byte $00,$80,$00,$00,$82,$80,$00,$ba,$90,$00

    L_6130:
        tay 

        .byte $10,$00,$80,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$00,$54,$00,$00,$03,$00,$00,$03,$00,$00,$0d,$3f,$ff
        .byte $f9,$ea,$aa,$a6,$95,$55,$65,$0a,$aa,$a5,$00,$03,$a6,$00,$00,$09
        .byte $00,$00,$0d,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00
        .byte $00,$0a,$00,$00,$29,$00,$00,$a9,$00,$00,$01,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$00,$00,$c0,$00,$00,$c0,$00,$00,$f0,$00,$00,$bf,$ff
        .byte $fc,$be,$aa,$ab,$b9,$55,$56,$ba,$aa,$a0,$ba,$c0,$00,$bc,$00,$00
        .byte $f0,$00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$e0
        .byte $00,$00,$e8,$00,$00,$fa,$00,$00,$c0,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$70,$00,$00,$24,$00,$3f,$ec,$00,$2a,$9c,$00,$15,$5f
        .byte $00,$35,$5d,$c0,$0e,$9d,$40,$03,$ee,$40,$00,$1f,$c0,$00,$10,$00
        .byte $00,$10,$00,$00,$10,$00,$00,$d0,$00,$03,$5c,$00,$01,$6f,$00,$00
        .byte $6e,$00,$00,$28,$00,$00,$20,$00,$00,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$0d,$00,$00,$1b,$00,$00,$0b,$fc,$00,$37,$a8,$00,$e7
        .byte $54,$03,$57,$5c,$01,$57,$b0,$01,$ab

    L_621a:
        cpy #$03

    L_621c:
         .byte $f4,$00,$00,$04,$00,$00,$04,$00,$00,$04,$00,$00
        .byte $06,$00,$00,$37,$80,$00,$db,$c0,$00,$5b,$00,$00,$18,$00,$00,$08
        .byte $00,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00,$5d,$40,$00,$08

    L_6248:
        .byte $00,$00,$3b,$00,$03,$e7,$f0,$0e,$a7
        .byte $ac,$05,$57,$54,$09,$57,$58,$03,$ab,$ac,$00,$f7,$f0,$00,$04,$00
        .byte $00,$04,$00,$00,$04,$00,$00,$04,$00,$00,$36,$00,$00,$db,$80,$00
        .byte $5b,$c0,$00,$1b,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00,$00
        .byte $52,$00,$03,$02,$00,$0e,$c2,$00,$0e,$c2,$3f,$fe,$fe,$ea,$a9,$aa
        .byte $99,$55,$5a,$66,$65,$66,$99,$99,$9a,$ea,$a9,$ae,$3a,$aa,$aa,$0f
        .byte $ee,$ee,$00,$fb,$ba,$00,$0f,$ee,$00,$00,$3a,$00,$00,$0e,$21,$c0
        .byte $00,$00,$c0,$00,$00,$b0,$00,$00,$f0,$00,$00,$b0,$00,$00,$f0,$00
        .byte $00,$b5,$c0,$00,$f3,$b0,$00,$b3,$b0,$00,$ff,$bf,$fc,$be,$6a,$ab
        .byte $b9,$55,$66,$b9,$59,$99,$b6,$66,$66,$ba,$6a,$ab,$ba,$aa,$ac,$bb
        .byte $bb,$f0,$be,$ef,$00,$bf,$f0,$00

    L_62f9:
        ldy.a $0000,x

        .byte $b0,$00,$00,$21,$00,$00,$00,$00,$00,$00,$00,$17,$40,$00,$02,$00
        .byte $00,$0e,$c0,$00,$3a,$f0,$00

    L_6313:
        nop 
        cpx L_aa00
        cpx $00
        lda #$e8

        .byte $00,$ea,$ec,$00,$3d,$f0,$00,$02,$00,$00,$01,$00,$00,$02,$00,$00
        .byte $01,$00,$00,$0e,$80,$00,$3a,$e0,$00,$1a,$f0,$00

    L_6337:
        asl 
        cpy #$00

        .byte $02,$00,$00,$00,$00,$21,$00

    L_6341:
        .byte $00,$00,$00,$00,$00,$00,$07,$50,$00,$02,$00,$00,$02
        .byte $c0,$00,$02,$c0,$00,$02,$c0,$00,$02,$e0,$00,$01,$e0,$00,$02,$e0
        .byte $00,$01,$c0

    L_6361:
        .byte $00,$02,$00,$00
        .byte $01,$00,$00,$02,$00,$00,$01,$00,$00,$02,$c0,$00,$02,$c0,$00,$02
        .byte $f0,$00,$02,$c0,$00,$02,$00,$00,$00,$00,$21,$00,$00,$00,$00,$00
        .byte $00,$00,$75,$00,$00,$20,$00,$00,$ec,$00,$03,$af,$00,$0e,$ae,$c0
        .byte $06,$ae,$80,$0a,$9e,$80,$0e,$ae,$c0,$03,$df,$00,$00,$20,$00,$00
        .byte $10,$00,$00

    L_63a8:
        jsr.a $0000

        .byte $10,$00,$00,$e8,$00,$03,$ae,$00,$01,$af,$00,$00,$ac,$00,$00,$20
        .byte $00,$00,$00,$00,$21,$00,$00,$00,$00,$00,$00,$01,$74,$00,$00,$20
        .byte $00,$00,$e0,$00,$00,$e0,$00,$00,$e0,$00,$02,$e0,$00,$02,$d0,$00
        .byte $02,$e0,$00,$00,$d0,$00,$00,$20,$00,$00,$10,$00,$00,$20,$00,$00
        .byte $10,$00,$00,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$00,$20
        .byte $00,$00,$00,$00,$21,$00

    L_6401:
        .byte $00,$00,$00,$02,$00,$00
        .byte $0a,$c0,$00,$1a,$f0,$00,$3a,$e0,$00,$0e,$80,$00,$01,$00,$00,$02
        .byte $00,$00,$01,$00,$00,$02,$00,$00,$3d,$f0,$00,$ea,$ec,$00,$a9,$e8
        .byte $00,$aa,$e4,$00,$ea,$ec,$00,$3a,$f0,$00

    L_6431:
        asl.a $00c0

        .byte $02,$00,$00,$17,$40,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00
        .byte $02,$00,$00,$02,$c0,$00,$02,$f0,$00,$02,$c0,$00,$02,$c0,$00,$01
        .byte $00,$00,$02,$00,$00,$01,$00,$00,$02,$00,$00,$01,$c0,$00,$02,$e0
        .byte $00,$01,$e0,$00,$02,$e0,$00,$02,$c0,$00,$02,$c0,$00,$02,$c0,$00
        .byte $02,$00,$00,$07,$50,$00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00
        .byte $20,$00,$00,$ac,$00,$01,$af,$00,$03,$ae,$00,$00,$e8,$00,$00,$10
        .byte $00,$00,$20,$00,$00,$10,$00,$00,$20,$00,$03,$df,$00,$0e,$ae,$c0
        .byte $0a,$9e,$80,$06,$ae,$80,$0e,$ae,$c0,$03,$af,$00,$00,$ec,$00,$00
        .byte $20,$00,$00,$75,$00

    L_64b9:
        .byte $00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$00,$00,$20,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00
        .byte $00,$e0,$00,$00,$10,$00,$00,$20,$00,$00,$10,$00,$00,$20,$00,$00
        .byte $d0,$00,$02,$e0,$00,$02,$d0,$00,$02,$e0,$00,$00,$e0,$00,$00,$e0
        .byte $00,$00,$e0,$00,$00,$20,$00,$01,$74,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$00,$3f,$00,$00,$eb,$00,$0f,$ec,$00,$3a

    L_650b:
        .byte $f0,$00,$3b,$fc,$00,$3c,$3c,$00,$00,$3b,$00,$00,$37,$00,$00
        .byte $0e,$00,$00,$0e,$00,$00,$3d,$00,$03,$ed,$00,$3f,$ad,$00,$e7,$ab
        .byte $03,$a7,$ab,$03,$a9,$ef,$03,$a9,$f3,$03,$af,$40,$00,$f0,$50,$00
        .byte $05
        .fill $15, $0
        .byte $0f,$00,$00,$fa,$c0,$0f,$ea,$b0,$f9

    L_6559:
        nop 

        .byte $b0,$e9,$ea,$b0,$ea,$7a,$f0,$ea,$7f,$00,$ba

    L_6565:
        .byte $f0,$00,$bf
        .byte $15,$00,$f0,$50,$00,$bc,$00,$00,$ac,$00,$00,$ac,$00,$00,$f0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$c0,$00,$03,$b0
        .byte $00,$03,$b0,$00

    L_658c:
        asl.a $00b0
        asl.a $00b0

        .byte $0f,$fc,$00,$0f,$ff,$f0,$3a,$cf,$ff,$3a,$c0,$fe

    L_659e:
        .byte $3b,$00,$0f,$0f,$00,$03,$00,$00
        .byte $0e,$00,$00,$0e,$00,$00,$3a,$00,$00,$3f,$00,$00,$35,$00,$00,$ea
        .byte $00,$00,$ea,$00,$00

    L_65bb:
        nop 

        .byte $00,$00,$3f,$00,$00,$3f,$f0,$00

    L_65c4:
        nop 
        bcs L_65c7
    L_65c7:
        nop 
        bcs L_65cd

        .byte $5a,$c0,$03

    L_65cd:
        sbc $d0,x
        asl L_0f4d + $162
        asl $40ab

        .byte $ff,$ac,$40,$bf,$fc,$00,$aa,$fc,$00,$5a,$af,$c0,$e5,$7a,$f0,$bf
        .byte $ba,$b0,$aa,$fe,$b0,$ab,$0f,$c0,$fc,$00,$00,$5d,$00,$00,$b1,$00
        .byte $00,$b4,$00,$00,$c4,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$00,$00
        .byte $ea,$00,$00,$ea,$00,$00,$ea,$00,$00,$35,$00,$00,$3f,$00,$00,$3a
        .byte $00,$00,$0e,$00,$00,$0e,$0f,$00,$03,$3b,$00,$0f,$3a,$c0,$fe,$3a
        .byte $cf,$ff,$0f,$ff,$f0,$0f,$fc,$00,$0e,$b0,$00,$0e,$b0,$00,$03,$b0
        .byte $00,$03,$b0,$00,$03

    L_663a:
        cpy #$00

        .byte $00,$00,$00,$00,$00,$00,$00,$c4,$00,$00,$b4,$00,$00,$b1,$00,$00
        .byte $5d,$00,$00,$fc,$00,$00,$ab,$0f,$c0,$aa,$fe,$b0,$bf,$ba,$b0,$e5
        .byte $7a,$f0,$5a,$af,$c0,$aa,$fc,$00,$bf,$fc,$00,$ff,$ac,$40,$0e,$ab
        .byte $40,$0e,$af,$10,$03,$f5,$d0,$03,$5a,$c0,$00,$ea,$b0,$00

    L_667a:
        nop 

        .byte $b0,$00,$3f,$f0
        .fill $40, $0
        .byte $10,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$02,$00,$00,$02
        .byte $00,$00,$02,$00,$17,$02,$00,$0e,$c2,$00,$0e,$c2,$3f,$fe,$fe,$ea
        .byte $a9,$aa,$99,$55,$5a,$66,$65,$66,$99,$99,$9a,$ea,$a9,$ae,$3a,$aa
        .byte $aa,$0f,$ee,$ee,$00,$fb,$ba,$00,$0f,$ee,$00,$00,$3a,$00,$00,$0e
        .byte $21,$c0,$00,$00,$c0,$00,$00,$b0,$00,$00,$f0,$00,$00,$b0,$00,$00
        .byte $f0,$14,$00,$b0,$c0,$00,$f3,$b0,$00,$b3,$b0,$00,$ff,$bf,$fc,$be
        .byte $6a,$ab,$b9,$55,$66,$b9,$59,$99,$b6,$66,$66,$ba,$6a,$ab,$ba,$aa
        .byte $ac,$bb,$bb,$f0,$be,$ef,$00,$bf,$f0,$00

    L_6739:
        ldy.a $0000,x

        .byte $b0,$00,$00,$21,$00,$ef,$00,$00,$18,$00,$00,$2c,$00,$00,$18,$00
        .byte $00,$2c,$00,$00,$18,$00,$00,$2c,$00,$00,$18,$00,$00,$2c,$00,$00
        .byte $18,$00,$00,$1c,$00,$0f,$df,$f0,$3a,$9e,$ac,$2a,$9f,$a8,$3a,$9f
        .byte $ac,$0f,$df

    L_676f:
        .byte $f0,$00,$3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$3c,$00,$00,$eb,$00,$03,$aa,$c0,$03,$aa,$c0,$03,$96,$c0
        .byte $0e,$96,$b0,$0e,$55,$b0,$0d,$55,$70,$0d,$55,$70,$0d,$69,$70,$0d
        .byte $a6,$70,$0f,$96,$b0,$0e,$a5,$b0,$0f,$96,$b0

    L_67aa:
        asl L_b0a3 + $2

        .byte $0f,$96,$b0,$0e,$a5,$b0,$0f,$96,$b0,$0e,$a5,$b0,$0f,$96,$b0,$0e
        .byte $a5,$b0,$21,$00,$0f,$ff,$0f,$f9,$aa,$3a,$aa,$aa,$d5,$55,$55,$55
        .byte $55,$55,$99,$99,$99,$a6,$65,$66,$2a,$aa,$aa,$0a,$a9,$aa,$02,$aa
        .byte $aa,$00,$a9,$aa,$00,$0a,$aa,$00,$02,$aa,$00,$00,$3a,$00,$00,$0e
        .byte $00,$00,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$21,$5c,$00,$d4,$ff,$ff,$ff,$6b,$a6,$bb,$6f,$a6,$fa,$6b
        .byte $56,$b5,$6f,$56,$f5,$6b,$a6,$b9,$6f,$a6,$fa,$6b,$a6,$ba,$6f,$a6
        .byte $fa,$9b,$a9,$ba,$9e,$a9,$ea,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
        .byte $ea,$aa,$aa,$3f

    L_6831:
        nop 
        tax 

        .byte $00,$3f,$aa,$00,$00,$eb,$00,$00,$3f,$00,$00,$03,$24,$03,$51,$70
        .byte $fd,$ff,$df,$e6,$ba,$6b,$a5,$ba,$5b,$56,$b5,$6b,$55,$b5,$5b,$66
        .byte $ba,$6b,$a5,$ba,$5b,$a6,$ba,$6b,$a5,$ba,$5b,$a6,$ea,$6e,$a9,$ea
        .byte $9e,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$ab,$aa,$ab,$fc
        .byte $aa,$fc,$00,$eb,$00,$00,$fc,$00,$00,$c0,$00,$00,$24,$ff,$f0,$00

    L_6883:
        tax 

        .byte $6f,$f0,$aa,$aa,$ac,$55,$55,$57,$55,$55,$55,$66,$66,$66,$99,$59
        .byte $9a,$aa,$aa,$a8,$aa,$6a,$a0,$aa,$aa,$80,$aa,$6a,$00,$aa,$a0,$00
        .byte $aa,$80,$00,$ac,$00,$00,$b0,$00,$00,$c0
        .fill $11, $0
        .byte $21,$3a,$96,$ac,$fe,$a5,$bf,$fa

    L_68c7:
        stx $af,y
        ldx L_bea1 + $4
        tsx 
        stx $ae,y
        ldx L_bea1 + $4
        tsx 
        stx $ae,y
        ldx L_bea1 + $4
        tsx 
        stx $af,y
        inc L_bfa5

        .byte $fb

    L_68df:
        stx $af,y
        rol L_bc9f + $6,x

        .byte $0f,$96,$bc,$0e,$a5,$b0,$0f,$96,$b0,$0e,$a5,$b0,$0f,$96,$b0,$0e
        .byte $a5,$b0,$03,$96,$c0,$03,$a5,$c0,$03,$d6,$c0,$21,$00,$24,$00,$00

    L_6904:
        sec 

        .byte $00,$00,$24,$00,$00,$38,$00,$00,$24,$00,$00,$38,$00,$00,$24,$00
        .byte $00,$38,$00,$00,$24,$00,$00,$38,$00,$00,$24,$00,$00,$38,$00,$00
        .byte $24,$00,$03,$eb,$c0,$0e,$aa,$b0,$05,$55,$50,$05,$55,$50,$0a,$a6
        .byte $a0,$0e,$a7,$b0,$03,$f7,$c0,$00,$0c,$00,$21,$00,$00,$00,$00,$05
        .byte $00,$00,$f0,$50,$03,$af,$40,$03,$a9,$f3,$03,$a9,$ef,$03,$a7,$ab
        .byte $00,$e7,$ab,$00,$3f,$ad,$00,$03,$ed,$00,$00,$3d,$00,$00,$0e,$00
        .byte $00,$0e,$00,$00,$37,$00,$00,$3b,$00,$3c,$3c,$00,$3b,$fc,$00,$3a
        .byte $f0,$00,$0f,$ec,$00,$00,$eb,$00,$00,$3f,$00,$00,$00,$00,$00,$00
        .byte $00,$f0,$00,$00,$ac,$00,$00,$ac,$00,$00,$bc,$00,$00,$f0,$50,$00
        .byte $bf,$15,$00,$ba

    L_6999:
        beq L_699b
    L_699b:
        nop 

        .byte $7f,$00

    L_699e:
        nop 

        .byte $7a,$f0,$e9,$ea,$b0,$f9,$ea,$b0,$0f,$ea,$b0,$00,$fa,$c0,$00,$0f

    L_69af:
        .fill $50, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$c1,$00,$06,$b0
        .byte $00,$06,$af,$00,$01,$ae,$00,$00,$fa,$00,$04,$66,$00,$13,$d9,$00
        .byte $4e

    L_6a20:
        ldx $00,y
        rol.a $00ad,x

        .byte $e7,$ab,$03,$a9,$ec,$03,$aa,$70,$03,$aa,$c0,$03,$ab,$00,$00,$fc
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21,$00,$ff,$00,$13,$ab
        .byte $00,$4e,$ab,$00,$3e,$ab,$00,$e7,$ab,$00,$a9,$ec,$00,$ea,$70,$00

    L_6a55:
        tsx 
        cpy #$00

        .byte $af,$00,$00,$ab,$00,$00,$6b,$00,$00,$9b,$00,$00,$6e,$c0,$00

    L_6a67:
        .byte $f3,$b0,$00,$00
        .byte $ec,$3c,$00,$3b,$eb,$00,$0f,$eb,$00,$0d,$fc,$00,$3a,$70,$00,$3a
        .byte $c0,$00,$0f,$00,$21,$00,$0f,$c0,$00,$3a,$b0,$00,$3a,$b0,$00

    L_6a8a:
        nop 
    L_6a8b:
        ldy L_e9fa + $a
        ldy $ff04

        .byte $fc,$00,$d5,$5c,$04,$ea,$ac,$04,$ff,$fc,$3f,$ea,$ac,$ea,$ba,$ab
        .byte $6a,$b5,$57,$15,$ea,$ac,$00,$ff,$fc,$04,$ea,$ac,$04,$ff

    L_6aaf:
        .byte $fc,$00
        .byte $d5,$5c,$04,$ea,$ac,$04,$3a,$b0,$00,$3a,$b0,$00,$0f,$c0,$21
        .fill $16, $0
        .byte $03,$c0,$00,$0e,$b0,$00,$0e,$b0,$ff,$ff,$f0,$ff,$fd,$70,$00,$0e
        .byte $b0,$00,$0e,$b0,$00,$03,$c0
        .fill $12, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$fc,$00,$03,$ab,$00
        .byte $03,$aa,$c0,$03,$aa,$f0,$03,$ab,$6c,$00,$ed,$ab,$00,$36,$ad,$00
        .byte $4e,$b6,$00,$13,$d9,$00,$04,$66,$00,$00,$fa,$00,$03,$ae,$00,$0e
        .byte $af,$00,$0e,$b0,$00,$03,$c1,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $21,$00,$0f,$00,$00,$3a,$c0,$00,$3a,$b0,$00

    L_6b4a:
        asl.a $00fc

        .byte $0f,$af,$00,$3b,$eb,$00,$ec,$3c,$f3,$b0,$00

    L_6b58:
        ror $c0

    L_6b5a:
         .byte $00,$9b,$00,$00,$6b,$00,$00,$ab,$00,$00,$af,$00,$00
        .byte $ba,$c0,$00

    L_6b6a:
        nop 

    L_6b6b:
         .byte $f0,$00,$ab
        .byte $6c,$00,$ed,$ab,$00,$36,$ab,$00,$4e,$ab,$00,$13,$ab,$00,$00,$ff
        .byte $00,$21,$00,$00,$ff,$00,$03,$ab,$00,$03,$ab,$00,$00,$ff,$00,$00
        .byte $03,$00,$00,$03,$00,$00,$03,$00,$00,$03,$00,$00,$03,$00,$00,$0d
        .byte $00,$00,$39,$0f,$ff,$f9,$3a,$9e,$b9,$ea,$9e,$b9,$ea,$9e,$b9,$3a
        .byte $9e,$bb,$0f,$ff,$fe,$00,$10,$06,$01,$45,$06,$00,$00,$01,$00,$00
        .byte $00,$21,$ff,$00,$00,$ea,$c0,$00,$ea,$c0,$00,$ff,$00,$00,$c0,$00
        .byte $00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$b0,$00,$00
        .byte $ac,$00,$00,$af,$ff,$f0,$ae,$9e,$ac,$ae,$9e,$ab,$ae,$9e,$ab,$ee
        .byte $9e,$ac,$bf,$ff,$f0,$b0,$10,$00

    L_6bf6:
        lda ($45),y

        .byte $00,$c0,$00,$00,$00,$00,$00,$21,$00,$f0,$00,$03,$ac,$00,$0e,$ac
        .byte $00,$37,$b0,$00

    L_6c0c:
        sbc.a $00f0,y

        .byte $eb,$ec,$00,$3c,$3b,$00,$00,$0e,$c0,$00,$03,$bf,$00,$00,$ea

    L_6c1e:
        .byte $00,$00,$da,$00,$00
        .byte $e6,$00,$00,$f9,$00,$03,$ae,$00,$0f,$ab,$00,$39,$ea,$00,$ea,$7b
        .byte $00,$ea,$9c,$00,$ea,$b1,$00,$ea,$c4,$00,$ff,$00,$21,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$3f,$00,$00,$ea,$c0,$03,$aa,$c0,$0f
        .byte $aa,$c0,$39,$ea,$c0,$ea,$7b,$00,$7a,$9c,$00,$9e,$b1,$00,$a7,$c4
        .byte $00,$a9,$10,$00,$6f,$00,$00

    L_6c6a:
        tsx 
    L_6c6b:
        cpy #$00

        .byte $da,$b0,$00

    L_6c70:
        asl $b0

        .byte $00,$41,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$21
        .fill $15, $0
        .byte $03,$c0,$00,$0e,$b0,$00,$0e,$b0,$00,$0f,$ff,$ff,$0f,$ff,$ff,$0e
        .byte $b0,$00,$0e,$b0,$00,$03,$c0,$00

    L_6cad:
        .fill $12, $0
        .byte $21,$03,$f0,$00

    L_6cc3:
        asl.a $00ac
        asl.a $00ac

        .byte $3a,$ab,$00,$3a,$ab,$10,$3f,$ff,$10,$35,$57,$00,$3a,$ab,$10,$3f
        .byte $ff,$10,$3a,$ab,$fc,$ea,$ae,$ab,$d5,$5e,$ab,$3a,$ab,$fc,$3f,$ff
        .byte $00,$3a,$ab,$10,$3f,$ff,$10,$35,$57,$00,$3a,$ab,$10,$0e,$ac,$10
        .byte $0e,$ac,$00,$03,$f0,$00

    L_6cff:
        and ($00,x)

        .byte $ff,$00,$00,$ea

    L_6d05:
        cpy $00
        nop 
    L_6d08:
        lda ($00),y
        nop 
        ldy L_e9fa + $6,x

        .byte $db,$00,$3b,$6a,$00,$0d,$ab,$00,$03,$ae,$00,$00,$fa,$00,$00,$ea
        .byte $00,$00

    L_6d20:
        sbc #$00

        .byte $00,$e6,$00,$03

    L_6d26:
        lda L_0dfe + $2,y

        .byte $cf,$0c,$3b,$00,$3b,$ec,$00,$3a,$f0,$00,$3b,$b0,$00

    L_6d36:
        asl.a $00ac

        .byte $03,$ac,$00,$00,$f0,$00

    L_6d3f:
        and ($00,x)

        .byte $00,$00,$00,$00,$00,$00,$00,$00,$43,$c0,$00

    L_6d4c:
        asl.a $00b0

        .byte $7a,$b0,$00

    L_6d52:
        tsx 
        cpy #$00

        .byte $af,$00,$00,$99,$10,$00,$67,$c4,$00,$9e,$b1,$00,$7a,$bc,$00,$ea

    L_6d65:
        .byte $db,$00,$3b
        .byte $6a,$c0,$0d

    L_6d6b:
        tax 
        cpy #$03
        tax 
        cpy #$00
        nop 
        cpy #$00

        .byte $3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_6d7f:
        and ($00,x)

        .byte $00,$00,$00,$00,$03,$01,$45,$0e,$00,$10

    L_6d8b:
        asl L_df0f
        inc L_9e3a,x

        .byte $bb,$ea,$9e,$b9,$ea,$9e,$b9,$3a,$9e,$b9,$0f,$ff,$f9,$00,$00,$39
        .byte $00,$00,$0d,$00,$00,$03,$00,$00,$03,$00,$00,$03,$00,$00,$03,$00
        .byte $00,$03,$00,$00,$ff,$00,$03,$ab,$00,$03,$ab,$00,$00,$ff,$21,$00
        .byte $00,$00,$c0,$00,$00,$b1,$45,$00,$b0,$10,$00,$bf,$ff,$f0,$ee,$9e
        .byte $ac,$ae,$9e,$ab,$ae,$9e,$ab,$ae,$9e,$ac

    L_6ddb:
        .byte $af,$ff
        .byte $f0,$ac,$00,$00,$b0,$00,$00,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00
        .byte $c0,$00,$00,$c0,$00,$00,$ff,$00,$00,$ea,$c0,$00,$ea,$c0,$00,$ff
        .byte $00,$00,$21,$00,$00,$00,$84,$41,$12,$23,$0c,$ca,$39,$df,$68,$d6
        .byte $69,$a7,$56,$aa,$96,$56,$96,$99,$da,$55,$a7,$ba,$55,$ac,$29,$55
        .byte $6a,$09,$55,$60,$2a,$55,$a0,$86,$55,$aa,$0a,$96,$80,$21,$aa,$80
        .byte $82,$28,$60,$09,$eb,$48,$2d,$99,$70,$05,$96,$70,$00,$82,$00,$00
        .byte $00,$00,$08,$00,$00,$00,$84,$69,$12,$23,$aa,$8a,$3a,$aa,$a8,$da

    L_6e4d:
        stx $a7,y
        ror 
        eor $aa,x
        ror 
        eor $a9,x
        sbc #$55

        .byte $6b,$a9,$55,$68,$25,$55,$5a,$25,$55,$58,$29,$55,$68,$a9,$55,$6a
        .byte $29,$55,$68,$2a,$55,$a0,$8a,$96,$a0,$0a,$aa,$a8,$2e,$aa,$b0,$05
        .byte $aa

    L_6e78:
        .byte $70,$00,$82,$00,$00,$00,$00
        .byte $08,$80,$00,$00,$88,$57,$22,$23,$5d,$4a,$35,$75,$78,$d5,$75,$5f
        .byte $5f,$55,$5e,$75,$d5,$5d,$f5,$d5,$5f,$b5,$57,$5c,$3d,$55,$f6,$d5
        .byte $57,$54,$d7,$5d,$54,$dd,$75,$5e,$dd,$75,$5c,$bd,$75,$70,$8d,$5d
        .byte $d0,$07,$5f,$58,$23,$5d,$4a,$a0,$f5,$02,$a0,$a2,$80,$80

    L_6ebd:
        ldx #$80
        php 
        asl 

        .byte $00,$80,$20,$56,$08,$9a,$59,$82,$99,$65,$a2,$99,$66,$82,$26,$99
        .byte $60,$26,$59,$50,$26,$56,$68,$2a,$56,$98,$26,$59,$a0,$25,$a6,$02
        .byte $26,$59,$82,$26,$59,$82,$0a,$59,$80,$82,$59,$80,$22,$59,$88,$02
        .byte $5a,$08,$82,$58,$08,$80,$a8,$20,$22,$08,$80,$00,$00,$00,$08

    L_6f00:
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$00,$28,$00,$00,$28,$00,$00,$a0,$00,$2a,$80,$00,$aa,$80
        .byte $00,$aa,$00,$00,$a6,$00,$00,$96,$00,$02,$aa,$00,$0a,$a8,$00,$0a
        .byte $00,$00,$28,$00,$00,$28,$00,$00,$20,$00,$00

    L_6f33:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$20,$82,$00
        .byte $08,$28,$00,$02,$aa,$00,$22,$aa,$80,$0a,$aa,$80,$2a,$a6,$80,$0a
        .byte $96,$a0,$02,$aa,$80,$02,$aa,$80,$02,$aa,$00,$00,$a8,$80,$02,$20
        .byte $20,$08

    L_6f71:
        .byte $08,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$00,$00,$00,$00,$00,$02,$28,$80,$00,$aa,$00,$02,$aa,$88
        .byte $0a,$aa,$a0,$8a,$aa,$a2,$2a,$96,$a8,$0a,$55,$a0,$aa,$55,$a0,$0a
        .byte $55,$aa,$0a,$55,$a0,$2a,$96,$a8,$8a,$aa,$a2,$02

    L_6fab:
        tax 

        .byte $80,$02,$aa,$80,$08,$aa,$20,$00,$2a

    L_6fb5:
        .byte $00,$00,$02,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$08,$00,$00,$aa,$00,$02,$a6,$80,$0a,$96,$a0,$0a,$55,$a0
        .byte $0a,$55,$a8,$2a,$55,$a8,$29,$55,$68,$29,$55,$68,$29,$55,$68,$29
        .byte $55,$68,$29,$55,$68,$29,$55,$68,$0a,$55,$a8,$0a,$55,$a0,$02,$96
        .byte $a0,$02,$aa,$80,$00,$aa,$00,$00

    L_6ff7:
        plp 

        .byte $00,$00,$00,$00,$00,$00,$00,$08,$00,$80,$00,$02,$22,$00,$00,$a8
        .byte $80,$08,$16,$20,$02,$96,$80,$20,$55,$08,$0a,$55,$a0,$01,$55,$40
        .byte $29,$55,$60,$01,$55,$48,$09,$55,$40,$21,$55,$60,$02,$55,$80,$08
        .byte $55,$20,$20,$96,$00,$02,$aa,$88,$08,$28,$00,$00,$82,$20,$00,$82
        .byte $00,$00,$00,$80,$00,$00,$00,$08,$00,$00,$00,$00,$20,$00,$00,$a8
        .byte $00,$00,$02,$00,$02,$82,$80,$00,$14,$00,$0a,$14,$a0,$00,$55,$00
        .byte $08,$55,$20,$00,$55,$00,$08,$14,$00,$00,$96,$20,$02,$00,$80,$08
        .byte $20,$20,$00,$82,$00,$02,$20,$80,$00,$08

    L_7072:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $08,$00,$00,$15,$00,$00,$55,$00,$01,$55,$00,$01,$55,$00,$05,$55
        .byte $00,$05,$55,$00,$05,$55,$00,$05,$55,$00,$05,$55,$00,$05,$55,$00
        .byte $01,$55,$00,$01,$55,$00,$00

    L_70a6:
        eor $00,x

        .byte $00,$15,$00,$00,$01
        .fill $12, $0
        .byte $21,$54,$00,$00,$55,$00,$00,$55,$40,$00,$55,$40,$00,$55,$50,$00
        .byte $55,$50,$00,$55,$50,$00,$55,$50,$00,$55,$50,$00,$55,$50,$00,$55
        .byte $40,$00,$55,$40,$00,$55,$00,$00,$54,$00,$00,$40
        .fill $14, $0
        .byte $21
        .fill $11, $0
        .byte $01,$00,$00,$15,$00,$00,$55,$00,$01,$55,$00,$01,$55,$00,$05,$55
        .byte $00,$05,$55,$00,$05,$55,$00,$05,$55,$00,$05,$55,$00,$05,$55,$00
        .byte $01,$55,$00,$01,$55,$00,$00,$55,$00,$00,$15,$00,$00,$01,$21,$00
        .byte $aa,$80,$02,$95,$a0,$0a,$55,$68,$0a,$55,$68,$29,$55,$5a,$6a,$55
        .byte $6a,$55,$95,$68,$55,$95,$a8,$55,$66,$a0,$55,$6a,$80,$55,$50,$00
        .byte $55,$50,$00,$55,$50,$00,$55,$50,$00,$55,$50,$00,$55,$50,$00,$55
        .byte $40,$00,$55,$40,$00,$55,$00,$00,$54,$00,$00,$40,$00,$00,$21,$00
        .byte $2a,$a0,$00,$aa,$a8,$02,$a5,$6a,$02,$95,$5a,$0a,$55,$56,$0a,$55
        .byte $56,$02,$95,$59,$02,$a5,$69,$00,$aa,$a5,$00,$2a,$a5,$00,$00,$05
        .byte $00,$00,$05,$00,$00,$05,$00,$0a,$85,$00,$29,$51,$00,$25,$55,$00
        .byte $a5,$55,$00,$95,$55,$00,$a5,$54,$00,$29,$50,$00,$0a,$80,$21,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$40,$00,$15,$54,$00,$55,$55
        .byte $00,$55,$55,$40,$55,$55,$40,$55,$55,$50,$55,$55,$50,$55,$55,$50
        .byte $55,$55,$50,$55,$55,$50,$55,$55,$50,$55,$55,$40,$55,$55,$40,$55
        .byte $55,$00,$15,$54,$00,$01,$40,$00,$00,$00,$00,$00,$00,$00,$21,$00
        .byte $00,$80,$00,$02,$a0,$00,$0a,$a8,$00,$0a,$a8,$00,$2a,$aa,$00,$2a
        .byte $aa,$00,$0a,$aa,$00,$02,$a2,$00,$00,$0a,$00,$00,$0a,$00,$00

    L_7220:
        asl 

        .byte $00,$00,$0a,$00,$00,$0a,$00,$02,$8a,$00,$0a,$a2,$00,$0a,$a2,$00
        .byte $29,$a8,$00,$29,$68,$00

    L_7237:
        rol 
        pla 

        .byte $00,$0a,$a0,$00,$02,$80,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $02,$80,$00,$2a,$a8,$00,$aa,$aa,$00,$a9,$6a,$80,$a5,$5a,$80,$95
        .byte $5a,$a0,$95,$56,$a0,$55,$56,$a0,$55,$56,$a0,$55,$56,$a0,$95,$5a
        .byte $a0,$95,$5a,$80,$a5,$6a,$80,$aa,$aa,$00,$2a,$a8,$00,$02,$80,$00
        .byte $00,$00,$00,$00,$00,$00,$21,$00,$00,$00,$00,$00,$00,$00,$00,$80
        .byte $00,$02,$a0,$00,$0a,$a8,$00,$02,$a0,$00,$00,$80
        .fill $16, $0
        .byte $02,$80,$00,$0a,$a0,$00,$2a,$a8,$00,$2a,$a8,$00,$0a,$a0,$00

    L_72ba:
        .byte $02,$80,$00,$00,$00
        .byte $21
        .fill $12, $0
        .byte $02,$80,$00,$2a,$a8,$00,$a9,$6a,$00,$a5,$5a,$00,$a5,$5a,$00,$a5
        .byte $5a,$00,$a9,$6a,$00,$2a,$a8,$00,$02,$80
        .fill $13, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$02,$a0
        .byte $00,$00,$80
        .fill $1c, $0
        .byte $02,$80,$00,$0a,$a0,$00,$0a,$a0,$00,$02,$80,$00,$00,$00,$00,$00
        .byte $00,$21,$00

    L_7341:
        .fill $17, $0
        .byte $02,$80,$00,$0a,$a0,$00,$2a,$a8,$00,$2a,$a8,$00,$0a,$a0,$00,$02
        .byte $80

    L_7369:
        .fill $16, $0
        .byte $21,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$3a,$00,$00,$3a
        .byte $00,$00,$3e,$00,$05,$0f,$00,$54,$fe,$00,$0f,$ae,$00,$fd,$ab,$0f
        .byte $ad,$ab,$0e,$ab,$6b,$0e,$ab,$6f,$0e,$ab,$f0,$03,$af,$00,$00,$f0
        .fill $15, $0
        .byte $50,$00

    L_73c6:
        ora $0f

        .byte $00,$01,$fa,$c0,$cf,$6a,$c0,$fb,$6a,$c0,$ea,$da,$c0,$ea,$db,$00
        .byte $7a,$fc,$00,$7b,$c0,$00,$7c,$00,$00,$b0,$00,$00,$b0,$00,$00,$dc
        .byte $00,$00,$ec,$00,$00,$3c,$3c,$00,$3f,$ec,$00,$0f,$ac,$00,$3b,$f0
        .byte $00,$eb,$00,$00,$fc,$00,$00,$00,$00,$00,$00,$00,$00,$13,$00,$00
        .byte $1e,$00,$00,$4e,$00,$00,$75,$00,$00,$3f,$03,$f0,$ea,$0e,$bf,$aa
        .byte $0e,$ae,$fe,$0f,$ad,$5b,$03,$fa,$a5,$00,$3f,$aa,$00,$3f,$fe,$01
        .byte $3a,$ff,$01,$ea,$b0,$04,$fa,$b0,$07,$5f

    L_7432:
        cpy #$03
        lda $c0
        asl.a $00ab
        asl.a $00ab

        .byte $0f,$fc,$00,$00,$fc,$00,$00,$ab,$00,$00,$ab,$00,$00,$ab,$00,$00
        .byte $5c,$00,$00,$fc,$00,$00,$ac,$00,$00,$b0,$00,$00,$b0,$00,$00,$c0
        .byte $00,$f0,$f0,$00,$ec,$bf,$03,$ac,$ff,$f3,$ac,$0f,$ff,$f0,$00,$3f
        .byte $f0,$00

    L_746e:
        asl.a $00b0
        asl.a $00b0
    L_7474:
        asl.a $00c0
        asl.a $00c0

        .byte $03,$c0,$00,$00,$00,$00,$0f,$fc,$00,$0e,$ab,$00,$0e,$ab,$00,$03
        .byte $a5,$c0,$07,$5f,$c0,$04,$fa,$b0,$01,$ea

    L_7494:
        .byte $b0,$01,$3a,$ff,$00,$3f
        .byte $fe,$00,$3f,$aa,$03,$fa,$a5,$0f,$ad,$5b,$0e,$ae,$fe,$0e,$bf,$aa
        .byte $03,$f0,$ea,$00,$00,$3f,$00,$00,$75,$00,$00,$4e,$00,$00,$1e,$00
        .byte $00

    L_74bb:
        .byte $13,$00,$00,$00,$00,$00,$00,$00,$00,$03
        .byte $c0,$00,$0e,$c0,$00,$0e,$c0,$00,$0e,$b0,$00,$0e,$b0,$00,$3f,$f0
        .byte $0f,$ff,$f0,$ff,$f3,$ac,$bf,$03,$ac,$f0,$00,$ec,$c0,$00,$f0,$b0
        .byte $00,$00,$b0,$00,$00,$ac,$00,$00,$fc,$00,$00,$5c,$00,$00,$ab,$00
        .byte $00,$ab,$00,$00,$ab,$00,$00,$fc

    L_74fd:
        .fill $13, $0
        .byte $f0,$00,$03,$af,$00,$0e,$ab,$f0,$0e,$ab,$6f,$0e,$ab,$6b,$0f,$ad
        .byte $ab,$00,$fd,$ab,$00,$0f,$ae,$00,$54,$fe,$00,$05,$0f,$00,$00,$3e
        .byte $00,$00,$3a,$00,$00,$3a,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$00
        .byte $fc,$00,$00,$eb,$00,$00,$3b,$f0,$00,$0f,$ac,$00,$3f,$ec,$00,$3c
        .byte $3c,$00,$ec,$00,$00

    L_7555:
        .byte $dc,$00,$00,$b0,$00,$00,$b0,$00,$00,$7c,$00,$00,$7b
        .byte $c0,$00,$7a,$fc,$00,$ea,$db,$00,$ea,$da,$c0,$fb,$6a,$c0,$cf,$6a
        .byte $c0,$01,$fa,$c0,$05

    L_7577:
        .byte $0f,$00,$00,$50,$00,$00,$00,$00,$00
        .byte $55,$00,$55,$7f,$00,$fd,$7a,$aa,$ad,$7a,$aa,$ad,$7a,$aa,$ad,$0a
        .byte $aa,$a0,$0a,$aa,$a0,$0a,$aa,$a0,$0a,$aa,$a0,$0a,$aa,$a0,$0a,$aa
        .byte $a0,$0a,$aa,$a0,$0a,$aa,$a0,$0a,$aa,$a0,$0a,$aa,$a0,$7a,$aa,$ad
        .byte $7a,$aa,$ad,$7a,$aa,$ad,$7a,$aa,$ad,$7f,$00,$fd,$55,$00,$55,$99
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00

    L_75d0:
        .byte $00,$02,$00,$00,$02,$00,$00,$02,$00,$00,$02,$00
        .byte $2a,$82,$00,$99,$62,$02,$aa,$62,$02,$af,$f2,$0a,$ba,$b2,$0a,$ff
        .byte $c2,$2a,$f0,$02,$2e,$c0,$02,$2d,$c0,$03,$2d,$aa,$83,$39,$5a,$a3
        .byte $3a,$aa,$73,$00,$00,$00,$00,$80,$80,$80,$a2,$a2,$a0,$a2,$62,$a0
        .byte $62,$72,$60,$63,$f2,$60,$60,$c2,$60,$60,$02,$60,$60,$82,$60,$a2
        .byte $a2,$6a,$62,$a2,$5a,$62,$62,$55,$a2,$62,$65,$a2,$62,$6f,$a2,$a2
        .byte $7f,$62,$62,$70,$a2,$a2,$b0,$a2,$a2,$b0,$a3,$a3,$a0,$a3,$a3,$a0
        .byte $b3,$b3,$b0
        .fill $1d, $0
        .byte $aa,$00,$82,$65,$80,$8a,$a9,$80,$ca,$bf,$c0,$ea,$ea,$c0,$2b,$ff
        .byte $00,$ab,$c0,$00

    L_7670:
        .byte $bb,$00,$00,$b7,$00,$00

    L_7676:
        ldx $aa,y

        .byte $00,$e5,$6a,$80,$ea

    L_767d:
        lda #$c0

        .byte $00,$3d,$7d,$73,$3f,$eb,$f3,$3f,$da,$c3,$3e,$c0,$03,$39,$c0,$03
        .byte $39,$80,$03,$39,$a0,$03,$8d,$6a,$83,$6e,$5a,$a3,$73,$95,$63,$f3
        .byte $ff,$73,$f0,$ea,$f3,$c0,$3f,$c0,$00,$00,$00,$00,$00,$00,$aa,$aa
        .byte $aa,$aa,$aa,$aa,$55,$6a,$55,$55

    L_76b7:
        eor $55,x

        .byte $ff,$ff,$ff,$ff,$ff,$ff,$00,$b3,$b3,$b0,$f3,$f3,$f0,$f3,$f3,$f0
        .byte $b3,$b3,$b0,$a3,$a3,$a0,$b3,$b3,$b0,$a3,$a3,$a0,$a3,$a3,$ae,$a3
        .byte $a3,$e9,$a3,$a3,$e5,$b3,$b0,$ff,$f3,$f0,$ff,$c0,$c0,$3f,$00,$00
        .byte $00,$00,$00,$00,$aa,$aa,$aa,$aa,$aa,$aa,$55,$aa,$95,$55,$55,$55
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$00,$f5,$f5,$c0,$ff,$af,$c0,$ff,$6b,$00
        .byte $fb,$00,$00,$e7,$00,$00,$e6,$00,$00,$e6,$80,$00,$35,$aa,$02,$f9
        .byte $6a,$89,$ce,$55,$89,$cf,$fd,$cd,$c3,$ab,$cf,$00,$ff,$03,$00,$00
        .byte $00,$00,$00,$00,$aa,$aa,$aa,$aa,$aa,$aa,$55,$a9,$55,$55,$55,$55
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$00,$00,$02,$aa,$00,$08,$00,$00,$08,$00
        .byte $00,$20,$00,$00

    L_774d:
        .byte $2f,$ff,$00,$bf,$ff,$00,$bf,$ff,$02,$ff,$ff,$02,$ff,$ff
        .byte $05,$bf,$ff

    L_775e:
        ora $bf

        .byte $bf,$15,$6e,$6f,$15,$6e,$6f,$55,$59,$6f,$55,$59,$6f,$15,$55,$6f
        .byte $15,$55,$6f,$05,$55,$6f,$05,$55,$6f,$01,$15,$6f,$01,$15,$6f

    L_777f:
        and ($00,x)
        ora $6f,x

        .byte $00,$15,$6f,$00,$15,$6f,$00,$15,$6f,$00,$15,$6f,$00,$15,$6f,$00
        .byte $15,$6f,$00,$15,$6f,$00,$15,$6f,$00,$15,$6f,$00,$aa,$af,$00,$bf
        .byte $ff,$00,$bf,$ff,$55,$bf,$ff,$55,$bf,$ff,$55,$bf,$ff,$55,$bf,$ff
        .byte $55,$aa,$aa,$55,$55,$55,$55,$55,$55,$55,$55,$55,$21,$aa

    L_77c1:
        .byte $00,$00,$02,$00,$00,$02,$00,$00,$02,$00,$00,$c2,$00,$00,$c2,$00

    L_77d1:
        .byte $00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00
        .byte $c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2
        .byte $00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00

    L_77ff:
        and ($c2,x)

        .byte $00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00
        .byte $00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$00,$00,$c2,$aa,$00
        .byte $c0,$02,$00,$c0,$02,$00,$ff,$02,$00,$ff,$02,$00,$ff,$02,$00,$ff
        .byte $02,$00,$aa,$aa,$00,$55,$00,$00,$55,$00,$00,$55,$00,$00,$21,$00
        .byte $02,$aa,$00,$08,$00,$00,$08,$00,$00,$20,$00,$00,$2f,$ff,$00,$bf
        .byte $ff,$00,$bf,$ff,$02,$ff,$ea,$02,$ff,$ef,$06,$ff,$ef

    L_785e:
        asl $ff

        .byte $ef

    L_7861:
        asl $ff,x

        .byte $ef

    L_7864:
        asl $ff,x

        .byte $2f

    L_7867:
        lsr $ff,x
        rol 
    L_786a:
        lsr $ff,x

        .byte $03

    L_786d:
        lsr $ff,x

        .byte $03

    L_7870:
        lsr $ff,x

        .byte $03

    L_7873:
        eor $bf,x

        .byte $ff

    L_7876:
        eor $bf,x

        .byte $ff

    L_7879:
        eor $6f,x

        .byte $ff

    L_787c:
        eor $6f,x

        .byte $ff

    L_787f:
        and ($55,x)

        .byte $5b,$ff

    L_7883:
        eor $5b,x

        .byte $ff

    L_7886:
        ora $56,x
        tax 
    L_7889:
        ora $55,x
        eor $05,x
        eor $55,x
    L_788f:
        ora $55
        eor $02,x
        tax 
        lda $02

        .byte $ff,$e5,$02,$00,$25,$02,$00,$2a

    L_789e:
        lsr $ff,x

        .byte $0f

    L_78a1:
        lsr $ff,x

        .byte $0f,$56,$ff,$0f,$56,$ff,$ff,$56,$ff,$ff,$56,$ff,$ff,$56,$ff,$ff
        .byte $56,$aa,$aa,$55,$55,$55,$55,$55,$55,$55,$55,$55,$21,$aa,$80,$00
        .byte $00,$20,$00,$00,$20,$00,$00,$08

    L_78cb:
        .byte $00,$fc
        .byte $08,$00,$ff,$02,$00,$ff,$02,$00,$af,$c0,$80,$ef,$c0,$80,$ef,$f0
        .byte $80,$ef,$f0,$80,$ef,$f0,$80,$ef,$f0,$80,$af,$f0,$80,$ff,$f0,$80
        .byte $ff,$f0,$80,$ff,$f0,$80,$ff,$f0,$80,$ff,$f0,$80,$ff,$f0,$80,$ff
        .byte $f0,$80,$21,$ff,$f0,$80,$ff,$f0,$80,$af,$f0,$80,$2f,$f0,$80,$2f
        .byte $f0,$80,$2f,$f0,$80,$2f,$f0,$80,$2f,$f0,$80,$2f,$f0,$80,$af,$f0
        .byte $80,$ff,$f0,$80,$ff,$f2,$00,$ff,$f2,$00,$ff,$f8,$00,$ff,$f8,$00
        .byte $ff,$e0,$00,$ff,$e0,$00,$aa,$80,$00,$55,$40,$00,$55,$00,$00,$54
        .byte $00,$00,$21,$00,$00,$2a,$00,$00,$20,$00,$00,$20,$00,$00,$80,$00
        .byte $05,$bf,$00,$05,$bf,$00,$16,$fe,$00,$16,$fe,$00,$16,$fe,$00,$5b
        .byte $fa,$00,$5b,$fa,$00,$5b,$fa,$01,$6f,$ee,$01,$6f,$ee,$01,$6f,$ee
        .byte $05,$bf,$be,$05,$bf,$be,$05,$bf,$be,$16,$fe,$fe,$16,$fe,$fe,$16
        .byte $fe,$aa,$24,$56,$fc,$ff,$56,$fc,$ff,$56,$f0,$ff,$56,$f0,$ff,$56
        .byte $c0,$ff,$56,$c0,$ff,$56,$aa,$aa,$55,$55,$56,$55,$55,$56,$00,$00
        .byte $aa,$00,$00,$bf,$00,$00,$bf,$00,$15,$bf,$00,$15,$bf,$00,$15,$bf
        .byte $00,$15,$bf,$00,$15,$aa,$00,$15,$55,$00,$15,$55,$00,$15,$55,$00
        .byte $15,$55,$21,$aa,$a8,$00,$00,$08

    L_79c5:
        .byte $00,$00

    L_79c7:
        php 

        .byte $00,$00,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00
        .byte $ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff
        .byte $08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08,$00,$ff,$08
        .byte $00,$ff,$08,$00,$ff,$0a,$a0,$21,$ff,$00,$20,$ff,$00,$20,$ff,$00
        .byte $20,$ff,$00,$20,$ff,$00,$20,$ff,$fc,$20,$ff,$fa,$a0,$ff,$f8,$00
        .byte $ff,$f8,$00,$ff,$fa,$a0,$ff,$fc,$20,$ff,$00,$20,$ff,$00,$20,$ff
        .byte $fc,$20,$ff,$fc,$20,$ff,$fc,$20,$aa,$aa,$a0,$55,$54,$00,$55,$54
        .byte $00,$55,$54,$00,$55,$54,$00,$21,$02,$aa,$aa,$02,$00,$00,$02,$00
        .byte $00,$02,$00,$00,$56,$ff,$ff

    L_7a4f:
        lsr $ff,x

        .byte $ff,$56,$ff,$ff,$56,$ff,$ea,$56,$ff,$e5,$56,$ff,$e5,$56,$ff,$e5
        .byte $56,$aa,$a0,$55,$55,$00,$55,$55,$00,$55,$55,$00,$00,$00,$00,$00
        .byte $00,$02,$00,$00,$2b,$00,$02,$bf,$00,$2b,$ff,$02,$bf,$ff,$24,$02
        .byte $ff,$ff,$02,$ff,$ff,$56,$ff,$ff,$56,$ff,$fe,$56,$ff,$e8,$56,$ff
        .byte $e0,$56,$ff,$e0,$56,$ff,$e0,$56,$ff,$ea,$56,$ff,$0f,$56,$fc,$0f
        .byte $56,$fc,$0f,$56,$ff,$ff,$56,$ff,$ff,$56,$ff,$ff,$56,$ff,$ff,$56
        .byte $aa,$aa,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$21,$aa
        .byte $a8,$00,$00,$02,$00,$00,$02,$00,$00,$00,$80,$ff,$f0,$80,$ff,$f0
        .byte $20,$ff,$fc,$20,$af,$fc,$20,$6f,$ff,$20,$6f,$ff,$20,$6f,$ff,$20
        .byte $2f,$ff,$20,$2f,$ff,$20,$2f,$ff,$20,$2f,$ff,$20,$2f,$ff,$20,$bf
        .byte $ff

    L_7af2:
        jsr $ffff
        jsr $ffff
        jsr $ffff
        jsr $feff

        .byte $80,$21,$ff,$e8,$00,$fe,$80,$00,$e8,$00,$00,$80,$00,$00,$0a,$aa
        .byte $a0,$08,$00,$20,$08,$00,$20,$0b,$ff,$20,$ab,$ff,$20,$ff,$ff,$20
        .byte $ff,$ff,$20,$ff,$ff,$20,$ff,$ff,$20,$ff,$ff,$20,$ff,$ff,$20,$ff
        .byte $ff,$20,$aa,$aa,$a0,$55,$55,$00,$55,$55,$00,$55,$55,$00,$55,$55
        .byte $00,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$ff
        .byte $00,$00,$5f,$00,$00,$ff,$00,$00,$bf,$00,$00,$ee,$f0,$00,$bb,$f8
        .byte $00,$ef,$ff,$90,$3f,$ee,$a5,$ff,$ff,$29,$ff,$9e,$02,$5a,$5c,$00
        .byte $2a,$d4,$00,$ef,$fc,$00,$eb,$e2,$08,$bb,$f4,$22,$36,$f6,$08,$56
        .byte $14
        .fill $11, $0
        .byte $3c,$00,$00,$ff,$00,$00,$5f,$00,$00,$ff,$00,$00,$be,$c0,$00,$ef
        .byte $f0,$00,$bb,$fc,$00,$ef,$fc,$00,$3f,$ee,$01,$7f,$ff,$0a,$7a,$ae
        .byte $aa,$fe,$7c

    L_7bb3:
        bvc L_7bb3

        .byte $52,$05,$5a,$54,$22,$3a,$f6,$08,$56,$14
        .fill $11, $0
        .byte $3c,$01,$00,$ff,$09,$00,$5f,$29,$00,$ff,$61,$00,$be,$d4,$00,$ef
        .byte $f4,$00,$bb,$dc,$00,$ef,$7c,$00,$3e,$ee,$00

    L_7beb:
        rol.a $00bf,x

        .byte $ef,$ae,$00,$ea,$7c,$00,$fb,$52,$00,$3e,$f4,$22,$3a,$f6,$08,$56
        .byte $14

    L_7bff:
        .byte $00,$80,$00,$00,$80,$00,$00,$90,$00,$00
        .byte $84,$00,$00,$01,$00,$00,$04,$3c,$00,$14,$ff,$00,$20,$5f,$00,$28
        .byte $ff,$00,$08,$be,$c0,$05,$ef,$f0,$07,$bb,$fc,$03,$ef,$fc,$00,$ff

    L_7c29:
        inc L_3efb + $5

        .byte $ff,$00,$2a,$9e,$00,$fa,$5c,$00,$fb,$d2,$08,$ee,$f4,$22,$3e,$f6
        .byte $08,$57,$14,$00,$00,$00,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5,$00
        .byte $00,$ff,$00,$00,$fe,$00,$0f,$bb,$00,$2f,$ee,$14,$ff,$fb,$42,$bb
        .byte $fd,$ca,$ff,$fd,$68,$b6,$f7,$50,$35,$a8,$40,$17,$a8,$00,$3f,$ac
        .byte $00,$7e,$ee,$00,$7f,$bf,$00,$7a,$ef,$d8,$62,$2f,$50,$48,$8b,$48
        .byte $22,$21,$20,$00,$00,$00,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5,$00
        .byte $00,$ff,$00,$00,$fe,$00,$0f,$bb,$00,$3f,$ee,$00,$3f,$fb,$14,$bb
        .byte $fe,$48,$fd,$f9,$e8,$2d,$6d,$60,$05,$69,$40,$03,$ef,$00,$1f,$eb
        .byte $c0,$1f,$bb,$c0,$1f,$23,$c0,$12,$8b,$c0,$82,$23,$d4,$88,$88,$50
        .byte $22,$22,$80,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5,$00,$00,$ff,$00
        .byte $00,$fe,$00,$03,$bb,$00,$0f,$ee,$00,$3f,$fb,$14,$3f,$fe,$68,$2f
        .byte $be,$60,$3f

    L_7cdf:
        .byte $da,$90,$0b,$5b,$50,$03
        .byte $6a,$40

    L_7ce7:
        .byte $03,$fb,$00,$03,$eb,$00,$1f
        .byte $ba,$00,$1f,$ee,$00,$1e,$8f,$80,$92,$2f,$28,$88,$87,$60,$22,$25
        .byte $80

    L_7cff:
        .byte $00,$00,$3c,$00,$00,$ff,$00,$00
        .byte $f5,$00,$00,$ff,$00,$00,$fe,$00,$03,$bb,$00,$0f,$ee,$00,$0f,$fb
        .byte $10,$3f,$fe,$a4,$3f,$b7,$94,$2f,$d6,$84,$0e,$d7,$14,$02,$a8,$10
        .byte $03,$e8,$10,$0f

    L_7d2b:
        sed 

        .byte $00,$07,$ec,$00,$27,$ee,$00,$05,$f8,$88,$a2,$f2,$20,$88,$f4,$80
        .byte $22,$55,$80,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5,$00,$00,$ff,$00
        .byte $00,$fe,$00,$03,$bb,$00,$0f,$ee,$00,$3f,$fb,$04

    L_7d58:
        rol $18ff

        .byte $3f,$7a,$18,$2d,$69,$50,$09,$a9,$40,$02,$a8,$00,$03,$fa,$00,$03
        .byte $e2,$80,$07,$ec,$00,$07,$ba,$20,$07,$f8

    L_7d75:
        .byte $88,$27,$f2
        .byte $28,$09,$48,$80,$22,$52,$00,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5
        .byte $00,$00,$ff,$00,$00,$fe,$00,$0f,$bb,$00,$2f,$ee,$00,$3f,$fb,$06
        .byte $fb,$fe,$18,$bf,$ff,$68,$fa,$f9,$d0,$b5,$ab,$50,$16,$aa,$40,$03
        .byte $fb,$00,$03,$ea,$80,$00,$ef,$80,$0f,$ef,$00,$2f,$bc,$80,$9e,$22
        .byte $a8,$1c,$88,$80,$25,$22,$00,$00,$40,$00,$00,$60,$3c,$00,$28,$ff
        .byte $00,$69,$f5,$00,$19,$ff,$00,$07,$fe,$00,$07,$bb,$00,$2d,$6e,$00
        .byte $fe,$98,$00,$bd,$bc,$00,$f5,$fc,$00,$e6,$b4,$00,$3f,$a8,$00,$3f
        .byte $a8,$00,$3f,$ac,$00,$7e,$ee,$00,$7f,$bf,$00,$7a,$ef,$d8,$62,$2f
        .byte $50,$48,$8b,$48,$22,$21,$20

    L_7dff:
        .byte $00,$00,$00
        .byte $20,$00,$f0,$28,$03,$fc,$0a,$03,$d4,$12,$03,$fc,$40,$0f,$f8,$10
        .byte $0e,$ec,$20,$3f,$b8,$a0,$3f,$ef,$60,$bb,$ff,$40

    L_7e1e:
        .byte $fe,$fd,$80,$b9,$d0,$00,$e5,$f0,$00
        .byte $fe,$a0,$00,$3e,$b0,$00,$3b,$bc,$00,$fe,$dc,$00,$6b,$be,$20,$68
        .byte $bc,$80,$52,$15,$20,$88,$94,$80,$00,$00,$3c,$00,$00,$ff,$00,$00
        .byte $f5,$00,$00,$ff,$00,$03,$fe,$00,$0f,$bb,$00,$2f,$ee,$00,$ff

    L_7e56:
        sed 
        bit $bd

        .byte $fc,$a4,$f5,$af,$90,$e6,$a7,$d0,$3f,$a9,$40,$3f,$ec,$00,$07,$af
        .byte $00,$0f,$bf,$00,$3e,$cf,$00,$3f,$07,$00,$14,$05,$40,$05,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$ff,$00,$00,$f5,$00
        .byte $00,$ff,$00,$03,$fe,$09,$03,$bb

    L_7e91:
        and #$2f
        inc L_ff64

        .byte $fb,$50,$bd,$fc,$10,$f5,$f9,$40,$e6,$a6,$04,$3f,$ab,$d4,$3f,$ef
        .byte $d4,$07,$af,$d0,$7f,$b0,$00

    L_7ead:
        ror.a $00c0,x

        .byte $50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $40,$3c,$00,$60,$ff,$00,$69,$f5,$00,$19,$ff,$00,$07,$fe,$00,$07
        .byte $bb,$00,$2d,$6e,$00,$fe,$98,$00,$bd,$bc,$00,$f5,$f8,$80,$e6,$aa
        .byte $04,$3f,$ab,$d4,$3f,$ef,$d4,$07,$af,$d0,$7f,$b0,$00

    L_7eed:
        ror.a $00c0,x

        .byte $50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_7f00:
        .byte $00,$3c,$00,$00,$ff,$00,$00
        .byte $f5,$00,$00,$ff,$00,$03,$fe,$00,$03,$bb,$00,$0f,$ee,$00,$3f,$fb
        .byte $00,$2f,$7f,$40,$3d,$79,$a0,$2d,$6a,$98,$3f,$ab,$d8,$0f,$fb,$d4
        .byte $07,$fb,$d0,$7f,$e0,$04,$7e,$80,$06,$50,$00

    L_7f32:
        asl $00

        .byte $00,$02,$00,$00,$02
        .fill $11, $0
        .byte $3c,$00,$00,$ff,$00,$00,$f5,$00,$00,$ff,$00,$00,$fe,$00,$0f,$bb
        .byte $00,$2f,$ee,$00,$ff,$fb,$00,$bb,$fc,$06,$ff,$ff,$5a,$b6,$ff,$68

    L_7f6a:
        and $a5,x

        .byte $80,$17,$a8,$00,$3f,$fb,$00,$8b,$eb,$00,$1f

    L_7f77:
        inc L_9f1c + $4

        .byte $9c,$88,$14,$95,$20
        .fill $11, $0
        .byte $3c,$00,$00,$ff,$00,$00,$f5,$00,$00,$ff,$00,$03,$be,$00,$0f,$fb
        .byte $00,$3f,$ee,$00,$3f,$fb,$00,$bb,$fc,$00,$ff,$fd,$40,$ba,$ad,$a0
        .byte $3d,$bf,$aa,$85,$bf,$05,$15,$a5,$50,$9f,$ac,$88,$14,$95,$20,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40
        .byte $3c,$00,$60,$ff,$00,$68,$f5,$00,$49,$ff,$00,$17,$be,$00,$1f

    L_7fdf:
        .byte $fb,$00,$37
        .byte $ee,$00,$3d,$fb,$00,$bb,$bc,$00,$fe,$bc,$00,$ba,$fb,$00,$3d,$ab
        .byte $00,$85,$ef,$00,$1f,$bc,$00,$9f,$ac,$88,$14,$95,$20

    L_7fff:
        .byte $00,$1f,$80,$1f,$80,$c3,$c2
        .byte $cd,$38,$30,$2d,$3e,$20,$53,$2e,$4d,$2e,$47,$2e,$20,$4a,$55,$4e
        .byte $45,$2f,$4a,$55,$4c,$59,$20,$38,$36,$a9

    L_8020:
        .byte $37
        .byte $85,$01,$20,$a3,$fd,$20,$15,$fd,$20,$5b,$ff,$4c,$50,$0a,$00

    L_8030:
        stx $20
        sty L_112c + $1
        asl 
        tax 
        lda L_8d48,x
        sta $19
        lda L_8d48 + $1,x
        sta $1a
        ldx #$05
    L_8043:
        lda vSpr0Col,x
        sta L_112c + $2,x
        dex 
        bpl L_8043
        ldx $fffe
        ldy $ffff
        stx $112a
        sty $112b
        and #$00
        sta L_112c
        sta L_1136 + $6

        .byte $6c,$19,$00,$a2,$0b,$86,$6d,$e8,$86,$50,$a9,$0f,$85,$51,$29,$00
        .byte $8d,$6a,$11,$8d,$20,$d0,$20,$ad,$82,$a9,$3f,$8d,$15,$d0,$20,$72
        .byte $81,$a2,$7f,$a0,$11,$a9,$06,$20,$f9,$81,$20,$1d,$81,$a9,$3f,$8d
        .byte $1d,$d0,$8d,$17,$d0,$a9,$20,$8d,$10,$d0,$20,$28,$81,$a2,$01,$8e
        .byte $3e,$11,$ca,$8e,$3d,$11,$a2,$58,$a0,$1b,$86,$22,$84,$23

    L_80ae:
        jsr L_80f9
        lda $07
        beq L_80de
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        cmp #$fd
        bne L_80de
        dec L_1170 + $5
        bne L_80de
        lda L_1170 + $6
        sta L_1170 + $5
        dec $0caf
        bne L_80d6
        lda #$18
        sta $0caf
    L_80d6:
        lda $0caf
        sta $6d
        jsr L_0c9f
    L_80de:
        ldx #$0a
        jsr L_0ab6
        lda cCia1PortA
        and #$10
        beq L_80f8
        dec $22
        bne L_80ae
    L_80ee:
        dec $23
        lda $23
        cmp #$ff
        bne L_80ae
        lda #$01
    L_80f8:
        rts 


    L_80f9:
        dec L_113e
        beq L_80ff
        rts 


    L_80ff:
        lda #$80
        sta L_113e
        ldy L_1136 + $7
        lda $113f,y
        ldx #$05
    L_810c:
        sta vSpr0Col,x
        dex 
        bpl L_810c
        iny 
        cpy #$05
        bne L_8119
        ldy #$00
    L_8119:
        sty L_1136 + $7
        rts 


    L_811d:
        ldx #$0f
        and #$00
    L_8121:
        sta vSprite0X,x
        dex 
        bpl L_8121
        rts 


    L_8128:
        ldx #$00
        ldy #$00
    L_812c:
        lda L_1144,y
        sta vSprite0X,x
        inx 
        inx 
        iny 
        cpy #$06
        bne L_812c
        rts 


    L_813a:
        sei 
        lda $112a
        sta $fffe
        lda $112b
        sta $ffff
        lda #$ff
        sta vSprMCM
        lda L_112c + $2
        sta vSpr0Col
        lda L_112c + $3
        sta vSpr1Col
        lda L_112c + $4
        sta vSpr2Col
        lda L_112c + $5
        sta vSpr3Col
        lda L_112c + $6
        sta vSpr4Col
        lda L_112c + $7
        sta vSpr5Col
        cli 
        rts 


    L_8172:
        ldx #$00
        and #$00
    L_8176:
        sta $7b40,x
        sta L_7bff + $1,x
        sta L_7cff + $1,x
        sta L_7dff + $1,x
        sta L_7f00,x
        inx 
        bne L_8176
        rts 


    L_8189:
        sta L_1136 + $4
        and #$00
        sta L_1136 + $1
        sta L_1136 + $2
        sta L_1136 + $3
        ldx #$02
    L_8199:
        lda L_1136 + $4
        sec 
    L_819d:
        sbc L_1134,x
        bcc L_81aa
        sta L_1136 + $4
        inc L_1136 + $1,x
        bcs L_819d
    L_81aa:
        dex 
        bpl L_8199
        clc 
        ldx #$02
    L_81b0:
        lda L_1136 + $1,x
        adc #$30
        sta L_1136 + $1,x
        dex 
        bpl L_81b0
        rts 


    L_81bc:
        sty $10
        ldy #$64
        jsr L_81e2
        jsr L_81c9
        lda $22
        rts 


    L_81c9:
        clc 
        ldx #$08
        lda $23
    L_81ce:
        rol $22
        rol 
        bcs L_81d7
        cmp $10
        bcc L_81da
    L_81d7:
        sbc $10
        sec 
    L_81da:
        dex 
        bne L_81ce
        rol $22
        sta $23
        rts 


    L_81e2:
        stx $22
        sty $23
        clc 
        and #$00
        ldx #$08
    L_81eb:
        ror 
        ror $22
        bcc L_81f3
        clc 
        adc $23
    L_81f3:
        dex 
        bpl L_81eb
        sta $23
        rts 


    L_81f9:
        stx $19
        sty $1a
        sta $1d
        ldy #$00
    L_8201:
        tya 
        asl 
        tax 
        lda $114a,x
        sta L_114f + $1
        lda $114b,x
        sta L_114f + $2
        jsr L_8230
        tya 
        asl 
        tax 
        clc 
        lda $114a,x
        adc #$27
        sta L_114f + $1
        lda $114b,x
        adc #$00
        sta L_114f + $2
        jsr L_8230
        iny 
        cpy #$03
        bne L_8201
        rts 


    L_8230:
        tya 
        pha 
        lda $1d
        sta L_114f + $3
    L_8237:
        lda #$03
        sta L_114f + $4
    L_823c:
        jsr L_8282
        jsr L_825d
        dec L_114f + $4
        bne L_823c
        clc 
        lda L_114f + $1
        adc #$3d
        sta L_114f + $1
        bcc L_8255
        inc L_114f + $2
    L_8255:
        dec L_114f + $3
        bne L_8237
        pla 
        tay 
        rts 


    L_825d:
        ldx L_114f + $1
        ldy L_114f + $2
        stx $22
        sty $23
        ldx #$00
        ldy #$00
    L_826b:
        lda L_1170 + $7,x
        sta ($22),y
        iny 
        iny 
        iny 
        inx 
        cpx #$08
        bne L_826b
        inc L_114f + $1
        bne L_8280
        inc L_114f + $2
    L_8280:
        rts 


    L_8281:
        clc 
    L_8282:
        ldy #$00
        lda ($19),y
        and #$3f
        sta $22
        sty $23
        ldx #$02
    L_828e:
        asl $22
        rol $23
        dex 
        bpl L_828e
        clc 
        lda $23
        adc #$40
        sta $23
        inc $19
        bne L_82a2
        inc $1a
    L_82a2:
        ldy #$07
    L_82a4:
        lda ($22),y
        sta L_1170 + $7,y
        dey 
        bpl L_82a4
        rts 


    L_82ad:
        sei 
        sta L_1160 + $7
        ldx #$df
        ldy #$83
        stx $fffe
        sty $ffff
        jsr L_1fe9
        lda #$00
        sta L_1160 + $8
        lda #$02
        sta L_1160 + $9
        lda #$25
        sta vRaster
        cli 
        rts 


        pha 
        nop 
        lda #$00
        sta vBackgCol1
        sta vBackgCol2
        sec 
        lda #$0a
    L_82dc:
        sbc #$01
        bne L_82dc
        lda vScreenControl1
        and #$e0
        ora $56
        and #$f7
        sta vScreenControl1
        jsr L_160c
        lda $3a
        sta vMemControl
        lda $3d
        beq L_8302
        lda $56
        cmp #$06
        bne L_8302
        lda #$01
    L_8300:
        bne L_8304
    L_8302:
        lda #$07
    L_8304:
        sta $8324
        lda vScreenControl2
        and #$f7
        sta vScreenControl2
        lda #$21
        sta $fffe
        lda #$83
        sta $ffff
        lda #$55
        sta vRaster
        jmp L_0aed
        pha 
        sec 
        lda #$07
    L_8325:
        sbc #$01
        bne L_8325
        lda $50
        sta vBackgCol1
        lda $6d
        sta vBackgCol0
        lda $51
        sta vBackgCol2
        lda L_0f4d + $183
        sta L_47e9 + $f
        lda L_0f4d + $184
        sta L_47f9
        lda L_0f4d + $185
        sta L_47f9 + $1
        lda L_0f4d + $186
        sta L_47f9 + $2
        lda L_0f4d + $187
        sta L_47f9 + $3
        lda L_0f4d + $188
        sta L_47f9 + $4
        lda L_0f4d + $189
        sta L_47f9 + $5
        txa 
        pha 
        tya 
        pha 
        ldy #$03
        jsr L_8432
        pla 
        tay 
        pla 
        tax 
        lda #$81
        sta $fffe
        lda #$83
        sta $ffff
        lda #$87
        sta vRaster
        jmp L_0aed
        pha 
        txa 
        pha 
        tya 
        pha 
        ldy #$04
        jsr L_8432
        pla 
        tay 
        pla 
        tax 
        lda #$a1
        sta $fffe
        lda #$83
        sta $ffff
        lda #$bb
        sta vRaster
        jmp L_0aed
        pha 
        txa 
        pha 
        tya 
        pha 
        ldy #$05
        jsr L_8432
        pla 
        tay 
        pla 
        tax 
        lda #$c1
        sta $fffe
        lda #$83
        sta $ffff
        lda #$cc
        sta vRaster
        jmp L_0aed
        pha 
        txa 
        pha 
        tya 
        pha 
        jsr L_86eb
        pla 
        tay 
        pla 
        tax 
        lda #$df
        sta $fffe
        lda #$83
        sta $ffff
        lda #$25
        sta vRaster
        jmp L_0aed
        pha 
        txa 
        pha 
        tya 
        pha 
        lda #$1b
        sta vScreenControl1
        lda #$00
        sta vBackgCol0
        sta vBorderCol
        lda #$0c
        sta vBackgCol1
        lda #$0f
        sta vBackgCol2
        lda #$11
        sta vMemControl
        lda vScreenControl2
        ora #$08
        sta vScreenControl2
        ldx #$06
        lda #$ff
    L_840c:
        sta L_47e9 + $f,x
        dex 
        bpl L_840c
        lda vSprMCM
        and #$c0
        ora #$80
        sta vSprMCM
        pla 
        tay 
        pla 
        tax 
    L_8420:
        lda #$cf
        sta $fffe
        lda #$82
        sta $ffff
        lda #$4a
        sta vRaster
        jmp L_0aed
    L_8432:
        ldx #$00
        sty $0a
    L_8436:
        clc 
        lda L_114f + $5,y
        adc #$03
        sta vSprite0Y,x
        lda L_1160 + $7
        beq L_844a
        lda L_1160,y
        sta L_1160 + $6
    L_844a:
        inx 
        inx 
        cpx #$0c
        bne L_8436
        ldx #$00
        ldy $0a
        lda L_115a,y
        tay 
    L_8458:
        sta L_47e9 + $f,x
        pha 
        lda L_1160 + $7
        beq L_8467
        lda L_1160 + $6
        sta vSpr0Col,x
    L_8467:
        pla 
        iny 
        tya 
        inx 
        cpx #$06
        bne L_8458
        rts 


    L_8470:
        and #$00
        sta $11
        clc 
        lda L_1160 + $b
        asl 
        asl 
        asl 
        asl 
        asl 
        adc #$23
        sta $10
        lda L_1160 + $b
        cmp #$07
        bcc L_848a
        inc $11
    L_848a:
        clc 
        lda L_1160 + $c
        asl 
        adc L_1160 + $c
        asl 
        asl 
        adc L_1160 + $c
        asl 
        adc #$5e
        tay 
        ldx $10
        rts 


    L_849e:
        lda #$08
        sta L_1160 + $b
        lda #$03
        sta L_1160 + $c
        rts 


    L_84a9:
        jsr L_8470
        stx vSprite6X
        lda $11
        beq L_84bb
        lda vSpriteXMSB
        ora #$40
        sta vSpriteXMSB
    L_84bb:
        sty vSprite6Y
        rts 


    L_84bf:
        jsr L_859c
        jsr L_859c
        jsr L_8470
        cpx vSprite6X
        bne L_84f8
        cpy vSprite6Y
        bne L_84f8
        lda L_e9fa + $d
        bne L_84f8
        lda cCia1PortA
        lsr 
        bcs L_84e0
        jsr L_84f9
    L_84e0:
        lsr 
        bcs L_84e6
        jsr L_8502
    L_84e6:
        lsr 
        bcs L_84ec
        jsr L_850d
    L_84ec:
        lsr 
        bcs L_84f2
        jsr L_8516
    L_84f2:
        lsr 
        bcs L_84f8
        jsr L_8521
    L_84f8:
        rts 


    L_84f9:
        ldx L_1160 + $c
        beq L_8501
        dec L_1160 + $c
    L_8501:
        rts 


    L_8502:
        ldx L_1160 + $c
        cpx #$03
        beq L_850c
        inc L_1160 + $c
    L_850c:
        rts 


    L_850d:
        ldx L_1160 + $b
        beq L_8515
        dec L_1160 + $b
    L_8515:
        rts 


    L_8516:
        ldx L_1160 + $b
        cpx #$08
        beq L_8520
        inc L_1160 + $b
    L_8520:
        rts 


    L_8521:
        clc 
        lda L_1160 + $c
        asl 
        asl 
        asl 
        adc L_1160 + $c
        asl 
        sta L_1170
        clc 
        lda L_1160 + $b
        asl 
        adc L_1170
        pha 
        ldx #$eb
        ldy #$11
        stx $10
        sty $11
        pla 
        tay 
        lda ($10),y
        cmp #$24
        bne L_854c
        dec L_1136 + $6
        rts 


    L_854c:
        cmp #$22
        bne L_856c
        lda #$20
        ldx L_1160 + $e
        jsr L_8585
        ldy L_1160 + $e
        beq L_855e
        dey 
    L_855e:
        sty L_1160 + $e
        inc L_1160 + $f
        pha 
        lda #$07
        sta L_e9fa + $c
        pla 
        rts 


    L_856c:
        pha 
        lda #$0c
        sta L_e9fa + $c
        pla 
        ldx L_1160 + $e
        cpx #$03
        beq L_857b
        inx 
    L_857b:
        stx L_1160 + $e
        jsr L_8585
        inc L_1160 + $f
        rts 


    L_8585:
        sta L_124b + $5,x
        pha 
        lda L_1170 + $3
        sta $10
        lda L_1170 + $4
        sta $11
        clc 
        txa 
        adc #$0b
        tay 
        pla 
        sta ($10),y
        rts 


    L_859c:
        and #$00
        sta L_1170 + $2
        lda vSprite6X
        sta L_1170 + $1
        lda vSpriteXMSB
        and #$40
        beq L_85b1
        inc L_1170 + $2
    L_85b1:
        jsr L_8470
        sec 
        lda $10
        sbc L_1170 + $1
        sta L_1160 + $d
        lda $11
        sbc L_1170 + $2
        ora L_1160 + $d
        beq L_85eb
        bcc L_85d9
        inc vSprite6X
        bne L_85eb
        lda vSpriteXMSB
        ora #$40
        sta vSpriteXMSB
        jmp L_85eb
    L_85d9:
        dec vSprite6X
        lda vSprite6X
        cmp #$ff
        bne L_85eb
        lda vSpriteXMSB
        and #$bf
        sta vSpriteXMSB
    L_85eb:
        cpy vSprite6Y
        beq L_85fb
        bcc L_85f8
        inc vSprite6Y
        jmp L_85fb
    L_85f8:
        dec vSprite6Y
    L_85fb:
        rts 


        jsr L_8806
        and #$00
    L_8601:
        sta vSprExpandY
        sta vSprExpandX
        sta vBorderCol
        sta vBackgCol0
        lda vScreenControl2
        ora #$08
        sta vScreenControl2
        ldx #$20
        ldy #$00
        jsr L_0ac3
        jsr L_8172
        ldx #$24
    L_8621:
        sec 
        lda $1407,x
        sbc #$0a
        sta SCREEN_BUFFER_0 + $350,x
        dex 
        bpl L_8621
        ldx #$50
        ldy #$07
        stx $19
        sty $1a
        lda #$06
        sta $1d
        lda $114a
        sta L_114f + $1
        lda $114b
        sta L_114f + $2
        jsr L_8230
        clc 
        lda $114a
        adc #$27
        sta L_114f + $1
        lda $114b
        adc #$00
        sta L_114f + $2
        jsr L_8230
        ldx #$00
        ldy #$ca
        stx $19
        sty $1a
        ldx #$09
    L_8666:
        jsr L_86d9
        ldy #$27
    L_866b:
        lda ($19),y
        sta ($7a),y
        lda #$0e
        sta ($20),y
        dey 
        bpl L_866b
        clc 
        lda $19
        adc #$28
        sta $19
        bcc L_8681
        inc $1a
    L_8681:
        inx 
        cpx #$19
        bne L_8666
        jsr L_0aa4
        ldx #$b4
        ldy #$00
        stx $22
        sty $23
        ldx #$14
    L_8693:
        lda L_142b,x
        sta SCREEN_BUFFER_0 + $350,x
        dex 
        bpl L_8693
    L_869c:
        lda cCia1PortA
        and #$10
        beq L_86d8
        ldx SCREEN_BUFFER_0 + $357
        ldy #$05
    L_86a8:
        lda SCREEN_BUFFER_0 + $351,y
        sta SCREEN_BUFFER_0 + $352,y
        dey 
        bpl L_86a8
        stx SCREEN_BUFFER_0 + $351
        ldx SCREEN_BUFFER_0 + $361
        ldy #$05
    L_86b9:
        lda SCREEN_BUFFER_0 + $35b,y
        sta SCREEN_BUFFER_0 + $35c,y
        dey 
        bpl L_86b9
        stx SCREEN_BUFFER_0 + $35b
        ldx #$42
        jsr L_0ab6
        dec $22
        bne L_869c
        dec $23
        lda $23
        cmp #$ff
        bne L_869c
        lda #$01
    L_86d8:
        rts 


    L_86d9:
        lda $0340,x
        sta $7a
        sta $20
        lda L_035a,x
        sta $7b
        clc 
        adc #$94
        sta $21
        rts 


    L_86eb:
        jsr L_e96e
        lda L_1160 + $a
        bne L_86f6
        jmp L_87fd
    L_86f6:
        ldx L_1160 + $8
        bne L_8721
        ldx vSprite7Y
        cpx #$57
        bcc L_870f
        dex 
        dex 
        stx vSprite7Y
        ldy #$63
        sty L_47f9 + $6
        jmp L_87fd
    L_870f:
        lda #$07
        sta L_1160 + $9
        inc L_1160 + $8
        pha 
        lda #$03
        sta L_e9fa + $c
        pla 
        jmp L_87fd
    L_8721:
        cpx #$01
        bne L_873d
        dec L_1160 + $9
        bne L_8735
    L_872a:
        lda #$07
        sta L_1160 + $9
        inc L_1160 + $8
        jmp L_87fd
    L_8735:
        ldy #$64
        sty L_47f9 + $6
        jmp L_87fd
    L_873d:
        cpx #$02
        bne L_8751
        dec L_1160 + $9
        bne L_8749
        jmp L_872a
    L_8749:
        ldy #$65
        sty L_47f9 + $6
        jmp L_87fd
    L_8751:
        cpx #$03
        bne L_8765
        dec L_1160 + $9
        bne L_875d
        jmp L_872a
    L_875d:
        ldy #$66
        sty L_47f9 + $6
        jmp L_87fd
    L_8765:
        cpx #$04
        bne L_8780
        dec L_1160 + $9
        bne L_8771
        jmp L_872a
    L_8771:
        ldy #$67
        sty L_47f9 + $6
        pha 
        lda #$04
        sta L_e9fa + $c
        pla 
        jmp L_87fd
    L_8780:
        cpx #$05
        bne L_87aa
        ldx vSprite7Y
        cpx #$dc
        bcs L_8798
        inx 
        inx 
        stx vSprite7Y
        ldy #$68
        sty L_47f9 + $6
        jmp L_87fd
    L_8798:
        lda #$07
        sta L_1160 + $9
        inc L_1160 + $8
        pha 
        lda #$02
        sta L_e9fa + $c
        pla 
        jmp L_87fd
    L_87aa:
        cpx #$06
        bne L_87be
        dec L_1160 + $9
        bne L_87b6
        jmp L_872a
    L_87b6:
        ldy #$69
        sty L_47f9 + $6
        jmp L_87fd
    L_87be:
        cpx #$07
        bne L_87d2
        dec L_1160 + $9
        bne L_87ca
        jmp L_872a
    L_87ca:
        ldy #$6a
        sty L_47f9 + $6
        jmp L_87fd
    L_87d2:
        cpx #$08
        bne L_87ed
        dec L_1160 + $9
        bne L_87e5
        pha 
        lda #$01
        sta L_e9fa + $c
        pla 
        jmp L_872a
    L_87e5:
        ldy #$6b
        sty L_47f9 + $6
        jmp L_87fd
    L_87ed:
        ldx vSprite7Y
        cpx #$b2
        bcc L_87fd
        dex 
        stx vSprite7Y
        ldy #$63
        sty L_47f9 + $6
    L_87fd:
        lda L_1136 + $6
        beq L_8805
        jsr L_84bf
    L_8805:
        rts 


    L_8806:
        sei 
        ldx #$1b
        ldy #$88
        stx $fffe
        sty $ffff
        jsr L_1fe9
        lda #$2f
        sta vRaster
        cli 
        rts 


        pha 
        lda #$19
        sta vScreenControl1
        lda #$00
        sta vSprExpandX
        lda #$ff
        sta vSprEnable
        sta vSprMCM
        lda #$0c
        sta vBackgCol1
        lda #$0f
        sta vBackgCol2
        lda #$5b
        sta vSprite0X
        lda #$73
        sta vSprite1X
        lda #$8b
        sta vSprite2X
        lda #$a3
        sta vSprite3X
        lda #$bb
        sta vSprite4X
        lda #$d3
        sta vSprite5X
        lda #$eb
        sta vSprite6X
        lda #$03
        sta vSprite7X
        lda #$52
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        sta vSprite6Y
        sta vSprite7Y
        lda #$80
        sta vSpriteXMSB
        lda #$dd
        sta L_47e9 + $f
        lda #$df
        sta L_47f9
        lda #$e1
        sta L_47f9 + $1
        lda #$e3
        sta L_47f9 + $2
        lda #$e5
        sta L_47f9 + $3
        lda #$e7
        sta L_47f9 + $4
        lda #$e9
        sta L_47f9 + $5
        lda #$eb
        sta L_47f9 + $6
        lda #$05
        sta vSprMCMCol0
        lda #$0d
        sta vSprMCMCol1
        lda #$01
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
        sta vSpr3Col
        sta vSpr4Col
        sta vSpr5Col
        sta vSpr6Col
        sta vSpr7Col
        lda #$dd
        sta $fffe
        lda #$88
        sta $ffff
        lda #$65
        sta vRaster
        jmp L_0ae6
        pha 
        sec 
        lda #$08
    L_88e1:
        sbc #$01
        bne L_88e1
        lda #$67
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        sta vSprite6Y
        sta vSprite7Y
        inc L_47e9 + $f
        inc L_47f9
        inc L_47f9 + $1
        inc L_47f9 + $2
        inc L_47f9 + $3
        inc L_47f9 + $4
        inc L_47f9 + $5
        inc L_47f9 + $6
        lda #$00
        sta vBackgCol1
        lda #$0f
        sta vBackgCol2
        lda #$33
        sta $fffe
        lda #$89
        sta $ffff
        lda #$80
        sta vRaster
        jmp L_0ae6
        pha 
        txa 
        pha 
        tya 
        pha 
        lda #$12
        sta vMemControl
        lda #$0e
        sta vBackgCol0
        jsr L_e96e
        pla 
        tay 
        pla 
        tax 
        lda #$5b
        sta $fffe
        lda #$89
        sta $ffff
        lda #$f8
    L_8955:
        sta vRaster
        jmp L_0ae6
        pha 
        lda #$00
        sta vBackgCol0
        lda #$17
        sta vScreenControl1
        lda #$10
        sta vMemControl
        lda #$00
        sta vSprMCM
        lda #$fc
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        lda #$3f
        sta vSprEnable
        lda #$00
        sta vSpriteXMSB
        lda #$69
        sta vSprite0X
        lda #$81
        sta vSprite1X
        lda #$99
        sta vSprite2X
        lda #$b1
        sta vSprite3X
        lda #$c9
        sta vSprite4X
        lda #$e1
        sta vSprite5X
        lda #$ed
        sta L_47e9 + $f
        lda #$ee
        sta L_47f9
        lda #$ef
        sta L_47f9 + $1
        lda #$f0
        sta L_47f9 + $2
        lda #$f1
        sta L_47f9 + $3
        lda #$f2
        sta L_47f9 + $4
        txa 
        pha 
        tya 
        pha 
        ldy #$00
    L_89d0:
        lda SCREEN_BUFFER_0 + $350,y
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
        sta vSpr3Col
        sta vSpr4Col
        sta vSpr5Col
        ldx #$05
    L_89e7:
        dex 
        bpl L_89e7
        iny 
        cpy #$1d
        bne L_89d0
        pla 
        tay 
        pla 
        tax 
        lda #$1b
        sta $fffe
        lda #$88
        sta $ffff
        lda #$2f
        sta vRaster
        jmp L_0ae6
    L_8a05:
        lda $10
        cmp #$d9
        bne L_8a12
        lda $11
        cmp #$11
        bne L_8a12
        rts 


    L_8a12:
        sec 
        lda #$d9
        sta $19
        sbc #$12
        sta $22
        lda #$11
        sta $1a
        sbc #$00
        sta $23
    L_8a23:
        ldy #$11
    L_8a25:
        lda ($22),y
        sta ($19),y
        dey 
        cpy #$04
        bne L_8a25
        lda $19
        cmp $10
        bne L_8a3b
        lda $1a
        cmp $11
        bne L_8a3b
        rts 


    L_8a3b:
        sec 
        lda $19
        sbc #$12
        sta $19
        lda $1a
        sbc #$00
        sta $1a
        sec 
        lda $22
        sbc #$12
        sta $22
        lda $23
        sbc #$00
        sta $23
        jmp L_8a23
        rts 


        ldx #$7f
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        ldx #$91
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        ldx #$a3
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        ldx #$b5
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        ldx #$c7
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        ldx #$d9
        ldy #$11
        jsr L_8a90
        bcs L_8aa4
        rts 


    L_8a90:
        stx $10
        sty $11
        ldy #$04
    L_8a96:
        lda SCREEN_BUFFER_1 + $4e,y
        cmp ($10),y
        beq L_8aa0
        bcs L_8aa3
        rts 


    L_8aa0:
        iny 
        bne L_8a96
    L_8aa3:
        rts 


    L_8aa4:
        jsr L_8a05
        ldy #$03
    L_8aa9:
        lda ($10),y
        sta L_1244 + $1,y
        dey 
        bpl L_8aa9
        ldy #$11
        lda #$20
    L_8ab5:
        sta ($10),y
        sta L_1244 + $1,y
    L_8aba:
        dey 
        cpy #$0a
        bne L_8ab5
        ldx #$06
        ldy #$0a
    L_8ac3:
        lda SCREEN_BUFFER_1 + $52,x
        sta L_1244 + $1,y
        sta ($10),y
        dey 
        dex 
        bpl L_8ac3
        sec 
        lda #$19
        sbc $20
        jsr L_8189
        lda L_1136 + $2
        sta $1255
        ldy #$10
        sta ($10),y
        lda L_1136 + $1
        sta $1256
        iny 
        sta ($10),y
        ldx $10
        ldy $11
        stx L_1170 + $3
        sty L_1170 + $4
        and #$00
        sta L_1160 + $a
        lda #$01
        jsr L_82ad
        jsr L_8172
        ldx #$eb
        ldy #$11
        lda #$06
        jsr L_81f9
        jsr L_811d
        lda #$3f
        sta vSprExpandX
        sta vSprExpandY
        lda #$20
        sta vSpriteXMSB
        lda #$7f
        sta vSprEnable
        lda #$40
        sta vSprMCM
        lda #$02
        sta vSprMCMCol0
        lda #$0a
        sta vSprMCMCol1
        jsr L_8128
        lda #$01
        sta L_1160 + $3
        sta L_1160 + $4
        lda #$07
        sta L_1160 + $5
        jsr L_849e
        jsr L_84a9
        lda #$d6
        sta L_0f4d + $189
        ldx #$00
        stx vSpr6Col
        stx L_1160 + $e
        sta L_1160 + $f
        inx 
        stx L_1136 + $6
        lda #$0b
        sta $6d
        ldx #$0c
        stx $50
        ldx #$0f
        stx $51
    L_8b64:
        lda #$ff
        sta L_112c + $1
        lda L_1160 + $f
        beq L_8b7c
        ldx #$eb
        ldy #$11
        lda #$06
        jsr L_81f9
        and #$00
        sta L_1160 + $f
    L_8b7c:
        lda L_1136 + $6
        bne L_8b64
        ldx #$50
        jsr L_0ab6
        ldx #$02
    L_8b88:
        lda L_124b + $6,x
        cmp L_1127,x
        bne L_8b98
        dex 
        bpl L_8b88
        lda #$01
        sta $06
        rts 


    L_8b98:
        ldx #$02
    L_8b9a:
        lda L_124b + $6,x
        cmp L_10f2 + $2,x
        bne L_8ba9
        dex 
        bpl L_8b9a
        lda #$01
        sta $07
    L_8ba9:
        rts 


        lda #$07
        sta $56
        lda #$01
        sta L_1160 + $a
        jsr L_82ad
        jsr L_811d
        lda #$82
        sta vSprite7Y
        lda #$a7
        sta vSprite7X
        pha 
        lda #$01
        sta L_e9fa + $c
        pla 
        and #$00
        sta vBorderCol
        sta vSprExpandY
        lda #$06
        sta $6d
        jsr L_8172
        lda #$3f
        sta vSprExpandX
        lda #$20
        sta vSpriteXMSB
        jsr L_8128
        lda #$02
        sta L_1160 + $3
        lda #$07
        sta L_1160 + $4
        lda #$01
        sta L_1160 + $5
        lda $40
        jsr L_8189
        lda L_1136 + $1
        sta $1283
        lda L_1136 + $2
        sta $1282
        jsr L_8c12
        ldx #$57
        ldy #$12
        lda #$06
        jmp L_81f9
    L_8c12:
        ldx $40
        dex 
        txa 
        lsr 
        lsr 
        sta $20
        clc 
        asl 
        asl 
        asl 
        adc $20
        asl 
    L_8c21:
        tay 
        ldx #$00
    L_8c24:
        lda L_12c3,y
        sta L_1257,x
        iny 
        inx 
        cpx #$12
        bne L_8c24
        rts 


        lda #$01
        jsr L_82ad
        and #$00
        sta vBorderCol
        sta vSprExpandY
        sta L_1160 + $a
        lda #$06
        sta $6d
        and #$00
        sta vSprite6X
        sta vSprite6Y
        ldy #$6c
        sty L_47f9 + $6
        lda #$3f
        sta vSprExpandX
        lda #$20
        sta vSpriteXMSB
        jsr L_8128
        ldx #$01
        stx L_1160 + $3
        stx L_1160 + $4
        ldx #$07
        stx L_1160 + $5
        clc 
        lda $70
        adc #$31
        sta L_137b + $5
        ldy $70
        iny 
        tya 
        ldy #$03
        jsr L_1442
        ldx SCREEN_BUFFER_0 + $310
        ldy SCREEN_BUFFER_0 + $311
        jsr L_81bc
        jsr L_8189
        lda L_1136 + $3
        sta $133d
        sta $1369
        lda L_1136 + $2
        sta L_133e
        sta L_136a
        lda L_1136 + $1
        sta L_133e + $1
        sta L_136a + $1
        ldy #$02
        ldx #$02
    L_8ca8:
        sec 
        lda L_1136 + $1,x
        sbc #$30
        stx $10
        sty $11
        jsr L_1442
        ldy $11
        ldx $10
        iny 
        dex 
        bpl L_8ca8
        ldx #$2f
        ldy #$13
        lda #$06
        jsr L_81f9
        ldx #$ec
        ldy #$2c
        stx $22
        sty $23
    L_8cce:
        lda cCia1PortA
        and #$10
        beq L_8ce6
        ldx #$0a
        jsr L_0ab6
        dec $22
        bne L_8cce
        dec $23
        lda $23
        cmp #$ff
        bne L_8cce
    L_8ce6:
        jmp L_813a
        and #$00
        sta L_1160 + $a
        lda #$01
        jsr L_82ad
        and #$00
        sta vBorderCol
        sta vSprExpandY
        jsr L_8172
        lda #$3f
        sta vSprExpandX
        lda #$20
        sta vSpriteXMSB
        ldx #$0d
        and #$00
    L_8d0c:
        sta vSprite0X,x
        dex 
        bpl L_8d0c
        jsr L_8128
        ldx #$01
        stx L_1160 + $3
        stx L_1160 + $4
        inx 
        stx L_1160 + $5
        clc 
        lda $20
        adc #$31
        sta $13bb
        lda $40
        jsr L_8189
        lda L_1136 + $1
        sta $13c7
        lda L_1136 + $2
        sta $13c6
        lda #$63
        sta L_47f9 + $6
        ldx #$9b
        ldy #$13
        lda #$06
        jmp L_81f9

    L_8d48:
         .byte $63,$80,$fc
        .byte $85,$59,$8a,$aa,$8b,$31,$8c,$e9,$8c,$00,$00,$00,$00,$21,$a3,$d7
        .byte $6c,$62,$00,$c0,$00,$00,$00,$00,$00,$00,$d6,$a2,$d7,$6c,$60,$00
        .byte $c0,$00,$00,$00,$00,$00,$00,$d5,$a2,$d7,$6c,$5e,$00,$c0,$00,$00
        .byte $00,$00,$00,$00,$d4,$a2,$d7,$6c,$5c,$00,$c0,$00,$00,$00,$00,$00
        .byte $00,$d3,$a2,$d7,$6c,$5a,$00,$c0,$00,$00,$00,$00,$00,$00,$d2,$a2
        .byte $d7,$6c,$56,$00,$c0,$00,$00,$00,$00,$69,$b1,$c6,$9f,$64,$b7,$55
        .byte $00,$c0,$00,$00,$00,$00,$00,$00,$49,$8b,$d8,$55,$51,$00,$c0,$00
        .byte $00,$00,$00,$00,$00,$c0,$12,$ae,$94,$50,$00,$c0,$00,$00,$00,$00
        .byte $00,$00,$80,$0c,$ae,$94,$4e,$00,$c0,$00,$00,$00,$00,$00,$00,$d0
        .byte $93,$bf,$68,$4c,$00,$c0,$00,$00,$00,$00,$00,$00,$20,$a3,$d7,$6c
        .byte $4a,$00,$c0,$00,$00,$00,$00,$00,$00,$f8,$a2,$d7,$6c,$48,$00,$c0
        .byte $00,$00,$00,$00,$00,$00,$d0,$a2,$d7,$6c,$46,$00,$c0,$00,$00,$00
        .byte $00,$00,$00,$e0,$5b,$13,$a7,$44,$00,$c0,$00,$00,$00,$00,$00,$00
        .byte $f0,$46,$97,$e3,$43,$00,$c0,$00,$00,$00,$00,$00,$00,$cf,$49,$79
        .byte $98,$42,$00,$c0,$00,$00,$00,$00,$00,$00,$c0,$5d,$7f,$74,$41,$00
        .byte $c0,$00,$00,$00,$00,$00,$00,$58,$98,$b9,$9b,$40,$00,$c0,$00,$00
        .byte $00,$00,$00,$00,$c0,$5d,$00,$e5,$3f,$00,$c0,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$93,$7f,$3e,$00,$c0,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $0b,$81,$3d,$00,$c0,$00,$00,$00,$00,$c0,$8f,$c6,$9f,$64,$b7,$3b
        .byte $00,$c0,$00,$00,$00,$00,$00,$00,$c7,$b3,$fb,$b9,$80,$06,$c0,$00

    L_8e8b:
        .byte $00,$00,$00,$00,$00,$cb,$5f,$50,$93,$00
        .byte $06,$c0,$00,$00,$00,$00,$00,$00,$ca,$5f,$50,$93,$5a,$03,$c0,$00
        .byte $00,$00,$00,$00,$00,$b8,$51,$4f,$ba,$40,$03,$c0,$00,$00,$00,$00
        .byte $00,$00,$90,$51,$4f,$ba,$20,$05,$c0,$00,$00,$00,$00,$00,$00,$f8
        .byte $bb,$2f,$92,$00,$05,$c0,$00,$00,$00,$00,$00,$00,$d0,$bb,$2f,$92
        .byte $00,$44,$c0,$00,$00,$00,$00,$00,$00,$00,$00,$48,$b7,$18,$d0,$c0
        .byte $00,$00,$00,$00,$40,$51,$89,$b2,$1b,$54,$3a,$00,$c0,$00,$00,$00
        .byte $00,$00,$00,$00,$af,$1b,$54,$39,$00,$c0,$00,$00,$00,$00,$80,$bb
        .byte $e3,$a4,$ef,$bf,$38,$00,$c0,$00,$00,$00,$00,$00,$00,$42,$a7,$bf
        .byte $bd,$36,$00,$c0,$00,$00,$00,$00,$c0,$8f,$3f,$c0,$79,$bd,$35,$00
        .byte $c0,$00,$00,$00,$00,$00,$00,$96,$5f,$72,$b1,$34,$00,$c0,$00,$00
        .byte $00,$00,$00,$00,$50,$be,$f2,$59,$32,$00,$c0,$00,$00,$00,$00,$00
        .byte $00,$ef,$bd,$06,$4f,$1d,$00,$c0,$00,$00,$00,$00,$00,$00,$80,$a2
        .byte $81,$8d,$19,$00,$c0,$00,$00,$00,$00,$00,$00,$80,$a2,$ef,$bd,$26
        .byte $00,$c0,$00,$00,$00,$00,$00,$00,$48,$a3,$ef,$bd,$24,$00,$c0,$00
        .byte $00,$00,$00,$00,$00,$20,$a3,$ef,$bd,$22,$00,$c0,$00,$00,$00,$00
        .byte $00,$00,$f8,$a2,$ef,$bd,$20,$00,$c0,$00,$00,$00,$00,$00,$00,$d0
        .byte $a2,$ef,$bd,$0b,$00,$c0,$00,$00,$00,$00,$00,$00,$d0,$93,$bf,$b3
        .byte $0a,$00,$c0,$00,$00,$00,$00,$00,$00,$ef,$9a,$d5,$b0,$f8,$47,$c0
        .byte $00,$00,$00,$00,$00,$00,$2f,$92,$e8,$59,$14,$03,$c0,$00,$00,$00
        .byte $00,$00,$00,$65,$ca,$3b,$7b,$21,$d0,$c0,$00,$00,$00,$00,$80,$89
        .byte $61,$85,$c5,$4c,$20,$d0,$c0,$00,$00,$00,$00,$3e,$55,$f4,$59,$04
        .byte $4f,$6f,$0b,$c0,$00,$00,$00,$00,$00,$00,$b0,$b3,$fb,$b9,$50,$0a
        .byte $c0,$00,$00,$00,$00,$a8,$98,$93,$7a,$69,$f2

    L_9000:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$bf,$db,$dc
        .fill $22, $20
        .byte $23,$24,$25,$26,$27
        .fill $20, $20
        .byte $42,$43,$44,$45,$46,$47,$48
        .fill $1e, $20
        .byte $61,$62,$63,$64,$65,$66,$63,$68,$69
        .fill $1c, $20
        .byte $80,$25,$82,$83,$84,$25,$82,$83,$84,$25,$8a
        .fill $1b, $20
        .byte $a0,$25,$a2,$a3,$a4,$25,$a2,$a3,$a4,$25,$aa,$ab
        .fill $1a, $20
        .byte $a0,$25,$c2,$c3,$c4,$25,$c2,$c3,$c4,$25,$aa,$cb
        .fill $1a, $20
        .byte $c0,$25,$a2,$a3,$a4,$25,$a2,$a3,$a4,$25,$ca,$6a,$ab
        .fill $19, $20
        .byte $c0,$25,$e2,$e3,$e4,$25,$e2,$e3,$e4,$25,$ca,$6a,$cb
        .fill $19, $20
        .byte $c0,$25,$25,$a3,$25,$25,$25,$a3,$25,$25,$ca,$6a,$6a,$ab
        .fill $18, $20
        .byte $e0,$85,$86,$a3,$25,$25,$25,$a3,$87,$88,$ea,$6a,$6a,$cb
        .fill $18, $20
        .byte $e0,$a5,$a6,$a3,$25,$25,$25,$a3,$a7,$a8,$ea,$6a,$6a,$6a
        .fill $17, $20
        .byte $81,$60,$c1,$c1,$a1,$c1,$c1,$c1,$a1,$c1,$c1,$40,$e1,$6a,$6a,$a9
        .fill $16, $20
        .byte $81,$60,$85,$86,$a3,$25,$25,$25,$a3,$0d,$0e,$0f,$e1,$6a,$6a,$a9
        .fill $15, $20
        .byte $0c,$be,$25,$a5,$a6,$41,$25,$25,$25,$a3,$2d,$2e,$2f,$10,$6a,$6a
        .byte $c9
        .fill $15, $20
        .byte $2c,$be,$85,$86,$25,$a3,$25,$25,$25,$a3,$4d,$4e,$4f,$30,$6a,$6a
        .byte $c9
        .fill $15, $20
        .byte $2c,$be,$a5,$a6,$25,$41,$25,$25,$25,$bd,$b5,$b6,$15,$50,$6a,$6a
        .byte $c9
        .fill $15, $20
        .byte $2c,$be,$25,$85,$86,$a3,$25,$25,$25,$a3,$92,$b7,$15,$70,$6a,$6a
        .byte $e9
        .fill $15, $20
        .byte $4c,$be,$25,$a5,$a6,$41,$25,$25,$25,$a3,$d6,$8d,$8e,$90,$6a,$6a
        .byte $6a
        .fill $15, $20
        .byte $4c,$be,$85,$86,$25,$a3,$25,$25,$25,$a3,$ac,$ad,$ae,$15,$6a,$6a
        .byte $6a,$a9
        .fill $14, $20
        .byte $4c,$be,$a5,$a6,$25,$41,$25,$25,$25,$a3,$cc,$cd,$ce,$d0,$6a,$6a
        .byte $6a,$c9
        .fill $14, $20
        .byte $4c,$be,$25,$85,$86,$a3,$25,$25,$25,$a3,$ec,$ed,$ee,$f0,$6a,$6a
        .byte $6a,$e9
        .fill $14, $20
        .byte $6c,$be,$25,$a5,$a6,$21,$25,$25,$25,$a3,$71,$72,$73,$13,$6a,$6a
        .byte $6a,$6a
        .fill $14, $20
        .byte $6c,$bd,$c1,$c1,$c1,$bc,$c1,$c1,$c1,$22,$91,$cd,$93,$33,$6a,$6a
        .byte $6a,$6a,$a9,$20

    L_9389:
        .fill $12, $20
        .byte $6c,$bb,$25,$85,$86,$be,$25,$25,$25,$6f,$b1,$b2,$b3,$53,$6a,$6a
        .byte $6a,$6a,$c9
        .fill $12, $20
        .byte $0b,$25,$bb,$25,$a5,$a6,$be,$25,$25,$25,$af,$d1,$d2,$d3,$d4,$6a
        .byte $6a,$6a,$6a,$e9
        .fill $12, $20
        .byte $0b,$25,$bb,$85,$86,$25,$be,$25,$25,$25,$8f,$95,$f2,$f3,$f4,$54
        .byte $6a,$6a,$6a,$e9,$20

    L_93fb:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$0b,$25,$bb,$a5,$a6,$25,$be,$25,$25,$25,$af,$35,$b4,$94
        .byte $74,$34,$6a,$6a,$6a,$e9
        .fill $12, $20
        .byte $0b,$25,$bb,$25,$85,$86,$be,$25,$25,$25,$cf,$55,$d5,$75,$76,$14
        .byte $6a,$6a,$6a,$e9
        .fill $12, $20
        .byte $2b

    L_9459:
        .byte $25,$bb,$25,$a5,$a6,$be,$25,$25,$25,$ef,$f5,$f6,$96,$97,$25,$6a
        .byte $6a,$6a,$c9
        .fill $12, $20
        .byte $2b,$25,$bb,$85,$86,$25,$be,$25,$25,$25,$be,$f7,$38,$39,$d7,$25
        .byte $54,$6a,$6a,$c9
        .fill $12, $20
        .byte $2b,$25,$bb,$a5,$a6,$25,$be,$25,$25,$25,$be,$25,$25,$25,$25,$25
        .byte $34,$6a,$6a,$a9
        .fill $12, $20
        .byte $2b,$25,$bb,$25,$85,$86,$be,$25,$25,$25,$be,$25,$87,$88,$25,$25
        .byte $14,$6a,$6a,$a9,$20

    L_94df:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$4b,$6b,$bb,$25,$a5,$a6,$be,$25,$25,$25,$be,$25,$a7,$a8
        .byte $25,$25,$25,$6a,$6a,$a9
        .fill $12, $20
        .byte $c5,$c6,$11,$25,$85,$86,$be,$25,$25,$25,$be,$87,$88,$25,$12,$c7
        .byte $c8,$6a,$6a
        .fill $13, $20
        .byte $c5,$c6,$11,$25,$a5,$a6,$be,$25,$25,$25,$be,$a7,$a8,$25,$12,$c7
        .byte $c8,$6a,$e9
        .fill $13, $20
        .byte $c5,$c6,$11,$c1,$c1,$c1,$a1,$c1,$c1,$c1,$a1,$c1,$c1,$c1,$12,$c7
        .byte $c8,$6a,$c9
        .fill $15, $20
        .byte $11,$25,$85,$86,$be,$25,$25,$25,$be,$87,$88,$25,$e8,$e6,$6a,$6a
        .byte $ab

    L_959b:
        .fill $15, $20
        .byte $11,$25,$a5,$a6,$be,$25,$25,$25,$be,$a7,$a8,$25,$e7,$e5,$e5,$6a
        .byte $ab
        .fill $15, $20
        .byte $31,$85,$86,$25,$be,$25,$25,$25,$be,$25,$87,$88,$32,$6a,$6a

    L_95e5:
        ror 

        .byte $ab
        .fill $15, $20
        .byte $31,$a5,$a6,$25,$be,$25,$25,$25,$be,$25,$a7,$a8,$32,$6a,$6a,$6a
        .fill $16, $20
        .byte $31,$25,$85,$86,$be,$25,$25,$25,$be,$87,$88,$25,$32,$6a,$6a,$6a
        .fill $16, $20
        .byte $51,$25,$a5,$a6,$be,$25,$25,$25,$be,$a7,$a8,$25,$52,$6a,$6a,$e9
        .byte $20

    L_9659:
        .fill $15, $20
        .byte $20,$9c,$dd

    L_9671:
        .byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$49,$6a,$6a,$6a,$e9

    L_967e:
        .fill $16, $20
        .byte $20,$9d,$25

    L_9697:
        .byte $25,$25,$25,$25,$25,$25,$25,$25,$28,$6a,$6a,$6a,$c9
        .fill $17, $20
        .byte $29,$9b,$9b,$9b,$9b,$9b,$9b,$9b,$9b,$9b,$2a,$6a,$6a,$6a,$a9
        .fill $18, $20
        .byte $6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a
        .fill $19, $20
        .byte $8b,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$6a,$4a,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$bb
        .fill $26, $20
        .byte $ff,$20,$20,$20,$20,$20,$20,$85,$85,$85,$86,$88,$87,$87,$88,$89

    L_9757:
        .fill $1b, $20
        .byte $20,$84,$a2,$a5,$aa,$a4,$a9,$21,$a8,$a2,$21,$7d
        .fill $16, $20
        .byte $85,$81,$82,$83,$84,$21,$a9,$21,$ab,$ab,$21,$a7,$aa,$21,$21,$61
        .byte $7d,$20,$20,$20,$20,$20,$20,$20,$20,$6a,$6b,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$a3,$ab,$ab,$a4,$a6,$aa,$21,$aa,$21,$a2
        .byte $a5,$aa,$21,$a5,$21,$61,$bc,$48,$20,$20,$20,$20,$20,$20,$20,$8a
        .byte $8b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a3,$aa,$a2,$aa
        .byte $a7,$21,$a8,$21,$ab,$ab,$21,$65,$66,$67,$60,$bc,$bc,$49,$20,$7e
        .byte $0b
        .fill $11, $20
        .byte $a3,$aa,$a9,$a2,$a8,$65,$66,$21,$a6,$a0,$69,$21,$21,$60,$c4,$bc
        .byte $bc,$48
        .fill $14, $20
        .byte $a3,$a2,$aa,$21,$a1,$65,$66,$67,$66,$67,$68,$21,$60,$bc,$bc,$bc
        .byte $28,$29,$20,$20,$20,$20,$2a,$2b,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$a3,$a0,$a2,$a1,$64,$80,$21,$21,$21,$21
        .byte $21,$44,$bc,$bc,$bc,$7c,$20,$20,$20,$20,$20,$20,$4a,$4b,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$63,$62,$63
        .byte $80,$c1,$21,$21,$21,$21,$22,$60,$bc,$bc,$bc,$bf
        .fill $16, $20
        .byte $21,$21,$21,$21,$c0,$21,$c0,$21,$21,$21,$60,$bc,$bc,$bc,$7c
        .fill $17, $20
        .byte $21,$21,$21,$21,$21,$21,$21,$21,$44,$43,$bc,$bc,$bc,$bc,$bf
        .fill $17, $20
        .byte $21,$21,$21,$21,$44,$45,$46,$47,$43,$c3,$bc,$bc,$bc,$7c

    L_98f8:
        .fill $18, $20
        .byte $21,$21,$22,$23,$43,$bc,$bc,$bc,$c2,$bc,$bc,$bc,$bc,$bf
        .fill $18, $20
        .byte $40,$41,$42,$c2,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc

    L_9943:
        .fill $18, $20
        .byte $20,$bc,$c2,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$be
        .fill $18, $20

    L_9982:
        .byte $9c
        .byte $9d,$9e,$9f,$bc,$bc,$bc,$bc,$bc,$bc,$bd,$24,$bd

    L_998f:
        .fill $1b, $20
        .byte $20,$20,$24,$25,$26,$27,$25,$26
        .fill $1c, $20
        .byte $9c
        .fill $19, $20
        .byte $81,$82,$83,$86,$87,$88,$82,$83,$85,$20

    L_99f2:
        .fill $18, $20
        .byte $20,$20,$c6,$c7,$ab,$aa,$21,$a4,$a9,$ab,$21,$ab,$a4,$c5,$82,$83
        .byte $84
        .fill $17, $20
        .byte $c8,$ab,$a3,$21,$ab,$a0,$21,$21,$ab,$a2,$a3,$a9,$aa,$a5,$e8
        .fill $17, $20
        .byte $c9

    L_9a59:
        .byte $a2,$a3,$21,$ab,$ab
        .byte $21,$aa,$21,$21,$a3,$ab,$21,$ea

    L_9a66:
        .byte $e7
        .fill $17, $20
        .byte $ca,$ab,$a3,$ab,$ab,$a2,$a9,$21,$aa,$a7,$21,$a2,$a7,$ea,$e7
        .fill $18, $20
        .byte $ca,$cb,$ab,$21,$21

    L_9aaa:
        and ($aa,x)

        .byte $ab,$21,$a8,$e8,$e8,$e8,$e7

    L_9ab3:
        .fill $18, $20
        .byte $20,$20,$e0,$e1,$e2,$aa,$21,$aa,$ab,$e8,$e7,$e7,$e7,$e7
        .fill $1c, $20
        .byte $e3,$21,$ab,$ab,$e8,$e7,$e7,$e7,$e7,$e7

    L_9aff:
        .fill $1b, $20
        .byte $20,$20,$e0,$e2,$ea,$e7,$e7,$eb,$e9,$e9,$e9,$20

    L_9b26:
        .fill $1b, $20
        .byte $20,$20,$e3,$21,$e9,$e9,$ab,$ab,$ab,$a2
        .fill $1f, $20
        .byte $ca,$cb,$21,$e4,$e4,$e5,$e6
        .fill $21, $20
        .byte $e0
        .fill $22, $20
        .byte $7e,$0b

    L_9bb7:
        .fill $72, $20
        .byte $20,$20,$2a,$2b
        .fill $24, $20
        .byte $4a,$4b
        .fill $1f, $20
        .byte $7e,$0b

    L_9c74:
        .fill $45, $20
        .byte $20,$20,$6a,$6b
        .fill $24, $20
        .byte $8a,$8b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$ff
        .fill $2d, $4c
        .byte $ac,$ad,$ae,$14,$14,$14,$14,$14,$af,$b0,$b1,$4c,$4c,$4c

    L_9d29:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $8c4c
        sta L_dedd
        dec $9190,x
        and ($21,x)
        and ($21,x)
        and ($c0,x)
        and ($21,x)
        and ($21,x)
        and ($8c,x)
        sta L_4c80 + $e
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $2121
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($af,x)
        bcs L_9d29
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_214c
        and ($21,x)
        and ($21,x)
        cpy #$21
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
    L_9d97:
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($70,x)
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $2121
        and ($6d,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($70,x)
        jmp $4c4c
    L_9dc9:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        cpy #$21
        and ($21,x)
        and ($6e,x)
        and ($6d,x)
        and ($21,x)
        ror $2121
        and ($21,x)
        and ($6d,x)
        and ($8c,x)
        sta L_4c80 + $e
        jmp $4c4c
        jmp $4c4c
        jmp L_214c
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($6e,x)
        bit L_2e2d
        ldy L_2fbc,x
        bmi L_9e3e
        adc $6d21
        and ($21,x)
        and ($21,x)
        and ($af,x)
        bcs L_9dc9
        jmp $4c4c
        jmp $4c4c

        .byte $21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$6d,$12,$13,$bc,$bc,$bc
        .byte $bc,$bc,$bc,$bc,$bc,$32,$33,$21,$6d,$6e,$21,$21

    L_9e3a:
        and ($21,x)
        and ($21,x)
    L_9e3e:
        sty L_8e8b + $2
        jmp $4c4c

        .byte $21,$21,$6d,$21,$21,$21,$6d,$21,$6d,$12,$13,$c2,$6c,$bc,$bc

    L_9e53:
        .byte $bc,$bc,$bc,$bc,$bc,$bc,$bc,$c2,$32,$0d,$0e,$21,$6e,$21,$6e,$21
        .byte $6e,$21,$21,$6e,$af,$b0,$b1,$0c,$0d,$0e,$21,$6d,$21,$0f,$10,$11
        .byte $c2,$c2,$6c,$bc,$bc

    L_9e78:
        .byte $bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$6c,$bc,$c2,$bc,$c2,$c3,$c2,$c2
        .byte $c2,$c2,$bc,$bc,$c2,$bc,$c2,$bc,$bc,$c3,$c2,$bc,$c2,$bc,$c2,$6c
        .byte $bc,$6c,$6c,$bc,$6c,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc
        .byte $bc,$c2,$6c,$bc,$28

    L_9ead:
        .byte $29,$9f,$25,$24,$25,$24,$bc,$c4,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc
        .byte $bc,$bc,$bc,$6c,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc
        .byte $bc,$bc,$bc,$bc,$7c,$20,$20,$20,$20,$20,$20,$20,$9f,$bc,$bc,$9c
        .byte $24

    L_9ede:
        .fill $17, $bc
        .byte $25,$26,$20,$20,$20,$20,$20,$20,$20,$20,$20,$27,$28,$20,$20,$27
        .byte $28,$9e,$9f
        .fill $12, $bc
        .byte $49,$20

    L_9f1c:
        .fill $12, $20
        .byte $bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$7c,$9f,$25,$9e
        .byte $24,$bd
        .fill $14, $20
        .byte $24,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$9e
        .fill $1b, $20
        .byte $24,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$28,$29

    L_9f85:
        .fill $1b, $20
        .byte $20,$20,$24,$25,$24,$25,$24,$25,$9c

    L_9fa9:
        .fill $15, $20
        .byte $20,$20,$9c
        .fill $26, $4c
        .byte $ff,$b1,$4c,$4c,$4c,$4c,$4c,$4c,$ac

    L_9ff0:
        .byte $ad,$ae,$af,$b0,$b1
        .fill $19, $4c
        .byte $21,$8c,$8d,$8e,$8f,$90,$91,$21,$21,$21,$21,$21,$21,$92,$93,$4c
        .byte $4c,$4c

    L_a020:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_6d4c
        and ($21,x)
        and ($21,x)
        and ($21,x)
        ror $2121
        adc $2121
        and ($21,x)
        sty L_8e8b + $2
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_214c

        .byte $21,$21,$d4,$d4,$d4,$21,$21,$21,$21,$6e,$21,$21,$21,$21,$6e,$21
        .byte $21,$14,$d8,$d9,$f6,$f7,$dc,$dd,$de,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$34,$35,$36,$d5,$d5,$d5,$37,$38,$39,$21,$21
        .byte $21,$21,$6d,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$b5
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$37,$72,$21,$21,$21,$21,$21,$21,$21,$6d,$21,$21
        .byte $21,$21,$21,$6e,$21,$21,$b5,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$39,$21,$21,$21
        .byte $21,$21,$21,$21,$d4,$21,$21,$21,$21,$21,$21,$21,$21,$b5,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$72,$d4,$d4,$34,$35,$36,$37,$d5,$37,$38,$39,$21,$21
        .byte $21,$21,$21,$21,$b6,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .fill $17, $20
        .byte $72,$21,$21,$21,$21,$21,$b7,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .fill $18, $20
        .byte $72,$21,$21,$21,$21,$b7,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .fill $19, $20
        .byte $d2,$21,$21,$21,$b8,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .fill $19, $20
        .byte $d2,$21,$21,$6d,$b9,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .fill $18, $20
        .byte $71,$21,$21,$21,$21,$b8,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$57,$58,$59,$54,$55,$55,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$71,$21,$21,$21,$21,$6d,$b7,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$20,$20,$20,$20,$20,$20,$20,$71,$21,$21,$21,$21
        .byte $21,$21,$ba,$20,$20,$20,$20,$20,$20,$20,$71,$21,$21,$6e,$21,$21
        .byte $21,$b8,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$54,$55,$56,$20,$57,$58
        .byte $59,$21,$21,$21,$21,$6d,$21,$21,$21,$54,$55,$56,$20,$57,$58,$59
        .byte $21,$21,$21,$21,$21,$21,$21,$b7,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$6e,$21,$21,$6d,$21,$21
        .byte $21,$21,$21,$21,$21,$21,$21,$21,$6d,$21,$21,$21,$21,$b6,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$cc,$cd,$ce,$21,$21,$21,$21,$21,$21,$21
        .byte $21,$21,$21,$21,$21,$21,$21,$21,$21

    L_a281:
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($21,x)
        and ($b4,x)
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c

    L_a297:
         .byte $cc,$cd,$ce,$21,$21,$21,$21,$21,$21,$21,$6e,$21,$21,$21,$21,$6e
        .byte $21,$21,$21,$cf,$cf,$cf,$cf,$d0,$d1,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$73,$73

    L_a2c2:
        .byte $94,$94,$95,$95,$96,$96,$97,$97,$97
        .byte $96,$96,$95,$94,$73,$4c,$4c,$4c,$4c,$4c,$4c

    L_a2d6:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c9c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        dec L_dede,x
        dec $4c4c,x
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_dede

        .byte $de,$de,$de,$de,$de,$8f,$90,$91,$21,$21,$6e,$21
        .fill $15, $4c
        .byte $ac,$ad,$ae,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21
        .byte $21,$4c,$4c,$4c,$4c,$4c,$4c,$4c

    L_a35a:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $8f4c

        .byte $90,$91,$21,$21,$21,$21,$21,$d4,$d4,$d4,$d4,$d4,$d4,$6d,$21,$21
        .byte $21,$21,$21,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$ac,$ad,$ae,$21,$21,$21,$21,$21,$34,$35,$36,$d5,$d5,$d5
        .byte $d5,$d5,$d5,$37,$38,$39,$21,$21,$6d,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$ac,$ad,$ae,$21,$21,$21,$6d,$21,$21,$21,$da
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$72,$21,$21,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$ac,$ad,$ae,$21,$21,$21,$21,$21
        .byte $21,$21,$21,$21,$16,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$72,$21,$4c,$4c,$4c,$4c,$4c,$4c,$8f,$90,$91,$21,$21
        .byte $21,$d4,$d4,$21,$21,$21,$21,$21,$21,$21,$21

    L_a401:
        tsx 

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$72,$ac
        .byte $ad,$ae,$14,$14,$14,$21,$21,$21,$34,$35,$36,$d5,$d5,$37,$38,$39
        .byte $21,$21,$21,$21,$21,$21,$54,$55,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$21,$21,$21,$21,$6e,$6d,$21,$21,$da,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$72,$21,$21,$21,$21,$21,$6d,$21,$d3,$ba
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21
        .byte $21,$21,$da,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$d2,$21,$21
        .byte $21,$21,$21,$21,$21,$21,$15,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$21,$21,$6d,$21,$21,$21,$da,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$d2,$21,$21,$21,$21,$21,$21,$6e,$21,$15,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21,$16,$15,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$d2,$21

    L_a4bd:
        .byte $21,$6d,$21,$21,$21,$21,$21,$15,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$21,$21,$21,$21,$21,$16,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$d2,$21,$21,$21,$21,$21,$21,$21,$21,$15,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21,$16,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$72,$21,$21,$21,$21,$21
        .byte $21,$21,$21,$15,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$21,$21
        .byte $21,$6e,$21,$16,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$72,$21,$21,$21,$21,$21,$21,$21,$ba,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$71,$21,$21,$21,$21,$21,$16,$15,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$d2,$21,$21,$21,$21,$21,$21,$21
        .byte $54,$55,$56,$20,$20,$20,$57,$58,$59,$21,$21,$21,$6d,$21,$21,$21
        .byte $ba,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$d2,$21
        .byte $21,$21,$21,$21,$6e,$21,$21,$21,$21,$d3,$d3,$d3,$21,$21,$21,$21
        .byte $21,$21,$21,$21,$21,$21,$21,$54,$55,$56,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$71,$21,$21,$21,$21,$6d,$21,$21,$21,$21,$21,$21,$21
        .byte $21,$21,$6d,$21,$21,$21,$95,$96,$97,$98,$99,$17,$21,$21,$21,$21
        .byte $d3,$d3,$d3,$d3,$d3,$d3,$d3,$d3,$d3,$21,$21,$21,$21,$21,$21,$21
        .byte $21,$6d,$21,$21,$21,$21

    L_a5d3:
        and ($21,x)
        and ($21,x)
        and ($21,x)
        jmp $4c4c
        jmp $4c4c

        .byte $ef,$f0,$f1
        .fill $1d, $21
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$f5,$21,$21,$21,$21,$21,$21
        .byte $21,$21,$6e,$21,$21,$21,$6d,$21,$21,$21,$21,$21,$21,$21,$21,$21
        .byte $21,$21,$21,$21,$6e,$21,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$cc
        .byte $cd,$ce
        .fill $1a, $21
        .byte $4c,$4c,$4c,$4c

    L_a64f:
        jmp $4c4c
        jmp $4c4c
        jmp L_7341 + $b

        .byte $73,$73,$73,$ef,$f0,$f1,$21,$21,$21,$21,$21,$6e,$21,$21,$21,$21
        .byte $21,$6d,$21,$21,$21,$21,$21,$21,$b4
        .fill $13, $4c
        .byte $cc,$cd,$ce,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$6e,$21,$21
        .byte $21,$b4,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c

    L_a6a5:
        jmp $4c4c
        jmp $4c4c
        jmp L_7341 + $b

        .byte $73,$73,$73,$ef,$f0,$f1,$21,$21,$21,$21,$21,$21,$b4
        .fill $1f, $4c
        .byte $cc,$cd,$ce,$cf,$d0,$d1,$4c,$4c,$4c,$ff
        .fill $22, $4c
        .byte $de,$de,$de,$de
        .fill $18, $4c
        .byte $de,$de,$de,$de,$de,$de,$de,$8f,$90,$91,$21,$21,$6e,$21
        .fill $15, $4c
        .byte $ac,$ad,$ae,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21
        .byte $21
        .fill $12, $4c
        .byte $8f,$90,$91,$21,$6d,$21,$21,$21,$d4,$d4,$d4,$d4,$d4,$d4,$21,$21
        .byte $21,$6e,$21,$6d,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$ac,$ad,$ae,$21,$21,$21,$21,$21,$34,$35,$36,$d5,$d5
        .byte $d5,$d5,$d5,$d5,$37,$38,$39,$21,$21,$21,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$f2,$21,$21,$21,$21,$21,$21,$21
        .byte $da,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$72,$21,$21
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$f3,$21
        .byte $21,$21,$21,$6d,$21,$16,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$72,$21,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$f3,$21

    L_a7fe:
        .byte $21,$21,$21,$21,$21,$21,$ba,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$72,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$f4,$21,$21,$21,$21,$21,$21,$21,$21,$54,$55,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4d,$21,$21,$21,$21,$21
        .byte $21,$21,$21,$21,$21,$d3,$ba,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4d,$6e,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$15,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$f4,$21,$21,$21,$21,$21,$21,$21,$21,$6d
        .byte $21,$21,$21,$15

    L_a8a2:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$f3
        .byte $21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$15,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$f2,$21,$21,$21,$21,$21,$21,$21,$21,$21,$6e
        .byte $21,$21,$15,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$6f,$21,$21,$21
        .byte $6d,$21,$21,$21,$21,$21,$21,$21,$15,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$cc,$cd,$ce,$21,$21,$21,$21,$21,$21,$21,$21,$ba,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$71
        .fill $13, $4c
        .byte $73,$73,$73,$73,$ef,$f0,$f1,$21,$21,$54,$55,$56

    L_a963:
        .byte $20,$20,$20,$57
        .byte $58,$59,$21,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c

    L_a977:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_cdca + $2

        .byte $ce,$17,$17,$d3,$d3,$d3,$17,$21,$6e,$6d
        .fill $11, $4c

    L_a9a1:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp L_7341 + $b

        .byte $73,$73,$4c,$ef,$f0,$f1,$9c
        .fill $18, $20
        .byte $6a,$6b
        .fill $24, $20
        .byte $8a,$8b,$20,$20,$20,$20,$20,$20,$20,$77,$78

    L_aa00:
        adc L_bcb9 + $3,y
        rts 


        rts 



        .byte $0b,$7e,$0b,$20

    L_aa09:
        .fill $15, $20
        .byte $20,$6a,$6b,$6a,$6b,$79,$bc,$bc,$bc,$c4,$51,$4c,$50,$50,$50,$bc
        .byte $bc,$bc,$bc,$74,$76,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$6a,$79,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$51
        .byte $4c,$e7,$4c,$4c,$60,$c2,$bc,$bc,$bc,$bc,$bc,$74,$75,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$6a,$79,$bc,$bc,$bc,$bc,$6c,$6c
        .byte $bc,$bc,$bc,$bc,$51,$4c,$4c,$e7,$4c

    L_aa77:
        .byte $50,$50
        .byte $bc,$bc,$bc,$bc,$6c,$bc,$bc,$bc,$48,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$52,$bc,$bc,$6c,$bc,$bc,$bc,$bc,$bc,$c2,$bc,$bc,$51,$4c
        .byte $4c,$4c,$e7,$4c,$4c,$50,$50,$bc,$bc,$bc,$6c,$bc,$bc,$bc,$bc,$7d
        .byte $20

    L_aaaa:
        .byte $20,$20,$20,$20,$20,$20,$52
        .byte $bc,$bc,$bc,$bc,$bc,$bc

    L_aab7:
        ldy L_bcb9 + $3,x
        ldy L_4c4f,x
        jmp $4c4c
        cmp ($4c),y
        jmp $4c4c
        jmp L_bc4d + $3
        ldy L_6cad + $f,x
        jmp (L_bcb9 + $3)
        ldy L_7670 + $5,x
        jsr $7720
        sei 
        adc L_bcb9 + $3,y
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy L_4c4f,x
        jmp $edec
        beq L_aab7
        jmp $4c4c
        jmp $4c4c
    L_aaec:
        jmp L_bc4d + $3
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy L_bc6c,x
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy $4c4c,x
        jmp $4c4c
    L_ab0a:
        jmp $4c4c
        jmp $4c4c
        jmp $4c4c
        jmp $5050
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x
        ldy L_6cad + $f,x
        jmp (L_bcb9 + $3)

        .byte $bc,$bc,$bc,$bc,$bc,$bc,$c2,$bc,$4f,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $e7,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$50,$50,$bc,$bc,$bc,$bc
        .byte $bc,$6c,$bc,$bc,$6c,$6c,$bc,$bc,$bc,$bc,$51,$51,$51,$4f,$4c,$4c
        .byte $63,$62,$63,$62,$63,$e7,$e7,$4c,$4c,$4c,$e8,$e8,$e8,$4c,$4c,$4c
        .byte $4c,$4c,$50,$50,$bc,$bc,$bc,$c3

    L_ab6a:
        ldy L_bcb9 + $3,x
        ldy L_bcb9 + $3,x

        .byte $c2,$4f,$4c,$4c,$4c,$4c,$63,$63,$62,$63,$62,$63,$62,$63,$e7,$4c
        .byte $e7,$e7,$e7,$e7,$e7,$62,$63,$4c,$4c,$4c,$4c,$4c,$50,$50,$bc,$bc
        .byte $bc,$51,$51,$51,$51,$51,$4f,$4c,$4c,$4c,$4c,$4c,$62

    L_ab9d:
        .byte $62,$63,$62,$63,$62,$63,$62,$63,$e7,$e7,$e7,$e7,$63,$62,$63,$62
        .byte $63,$4c,$4c,$4c,$4c,$4c,$4c,$51,$51,$51,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4c,$4c,$4c,$4c,$4c,$62,$63

    L_abc4:
        .byte $62,$63,$62,$63,$62,$63,$62,$e7,$e7,$62,$63,$62,$63,$62,$63,$62
        .byte $63
        .fill $11, $4c
        .byte $63

    L_abe7:
        .byte $62,$63,$62,$63,$62,$63,$62,$63,$62,$e7,$e7,$e7,$63,$62,$63,$62

    L_abf7:
        .byte $63,$62,$63,$62,$63
        .byte $4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $62,$63,$62,$63,$62,$63,$62,$63,$62,$e7,$e7,$e7,$63,$62,$63,$62
        .byte $63,$62,$63,$62,$63,$62,$63
        .fill $14, $4c
        .byte $62,$63,$62,$63,$e7,$e7,$63,$62,$63,$62,$63,$62,$63,$62,$63,$62
        .byte $63
        .fill $16, $4c
        .byte $62,$63,$62,$63,$e7,$62,$63,$62,$63,$62,$63,$62,$63,$62,$63
        .fill $18, $4c
        .byte $62,$63,$62,$63,$63,$62,$63,$62,$63
        .fill $1e, $4c
        .byte $62,$63,$62,$ff
        .fill $13, $20
        .byte $85,$85,$85,$86,$88,$87,$87,$88,$89
        .fill $1c, $20
        .byte $84,$a2,$a5,$aa,$a4,$a9,$21,$a8,$a2,$21,$7d
        .fill $16, $20
        .byte $85,$81,$82,$83,$84,$21,$a9,$21,$ab,$ab,$21,$a7,$aa,$21,$21,$61
        .byte $7d
        .fill $14, $20
        .byte $84,$21,$ab,$ab,$a4,$a6,$aa,$21,$aa,$21,$aa,$a5,$aa,$21,$a5,$21
        .byte $61,$bc,$48
        .fill $12, $20
        .byte $84,$21,$ab,$aa,$a2,$aa,$a7,$21,$a8,$21,$ab,$ab,$21,$65,$66,$67
        .byte $60,$c3,$bc,$49,$20

    L_ad68:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $86,$87,$88,$89,$87,$63,$62,$63,$62,$63,$a2,$a8,$65,$66,$aa,$a6
        .byte $a0,$69,$21,$21,$60,$c4,$c2,$bc,$48,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$e3,$ea,$e7,$63,$62,$63,$62,$63,$62,$63,$21
        .byte $21,$a1,$65,$66,$67,$66,$67,$68

    L_adac:
        and ($60,x)
        ldy L_bcb9 + $3,x
        plp 
        and #$20

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$e3,$e7,$e7,$e7,$63
        .byte $62,$63,$21,$aa,$a0,$a2,$a1,$64,$80,$21,$21,$21,$21,$21,$44,$bc
        .byte $bc,$6c,$7c,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$e3,$80,$80,$21,$65

    L_adeb:
        ror $67

        .byte $62,$63,$62,$63,$80,$c1,$21,$21,$21,$21,$22,$60,$6c,$bc,$bc,$bf
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$e3
        .byte $21,$21,$64,$80,$21,$21,$21,$21,$21,$21,$c0,$21,$c0,$21,$21,$21
        .byte $60,$bc,$bc,$bc,$7c
        .fill $11, $20
        .byte $46,$63,$80,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$44,$43
        .byte $bc,$6c,$bc,$bc,$bf
        .fill $11, $20
        .byte $9f,$46,$21,$21,$21,$21,$21,$21,$21,$21,$44,$45,$46,$47,$43,$c3
        .byte $bc,$bc,$bc,$7c,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$2a,$2b,$20,$20,$20,$20,$9f,$46,$21,$21,$21,$21,$21,$22,$23
        .byte $43,$bc,$bc,$bc,$c2,$bc,$c2,$bc,$bc,$bf,$20,$20,$20,$2a,$2b,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$4a,$4b,$20,$20,$20,$20,$20,$9f

    L_aea8:
        .byte $46,$46,$46,$40,$41,$42,$c2
        .byte $bc,$6c,$bc,$6c,$bc,$bc,$bc,$bc,$bc,$20,$20,$20

    L_aebb:
        jsr L_4b48 + $2

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $bc,$c3,$bc,$bc,$c2,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc,$bc
        .byte $be,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$7e,$0b,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$24,$25,$26,$9c,$9d,$9e,$9f,$6c,$bc,$6c
        .byte $bc,$6c,$bc,$bd,$24,$bd
        .fill $11, $20
        .byte $7e,$0b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$24,$25,$26,$27
        .byte $25,$26,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2a,$2b

    L_af34:
        .fill $24, $20
        .byte $4a,$4b

    L_af5a:
        .fill $1b, $20
        .byte $20,$20,$2a,$2b
        .fill $24, $20
        .byte $4a,$4b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$9c
        .fill $16, $20
        .byte $81,$82,$83,$81,$82,$83,$86,$87,$88,$82,$83,$85
        .fill $18, $20
        .byte $c6,$c7,$ab,$aa,$21,$ab,$aa,$21,$a4,$a9,$ab,$21,$ab,$a4,$c5,$82
        .byte $83,$84,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $6a,$6b,$20,$20,$20,$20,$c8,$ab,$a3,$21,$ab,$a3,$21,$ab,$a0,$21
        .byte $21,$ab,$a2,$a3,$a9,$aa,$a5,$e8

    L_b01b:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$8a,$8b,$20,$20,$20,$20,$c9,$a2,$a3,$21,$ab,$a3,$21,$ab
        .byte $ab,$21,$aa,$21,$21,$a3,$e8,$e7,$e7,$e7,$20,$20,$7e,$0b,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$ca,$ab
        .byte $a3,$ab,$ab,$a3,$ab,$ab,$ab,$ab,$a9,$aa,$e8,$e7,$db,$e7,$e7,$df
        .fill $15, $20
        .byte $ca,$a3,$ab,$ab,$a3,$ab,$ab,$a2,$a9,$aa,$e8,$e7,$db,$3a,$5a,$5a
        .byte $7a,$20,$20,$20,$20,$20,$2a

    L_b093:
        .byte $2b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

    L_b0a3:
        .byte $e3,$a3,$ab,$ab

    L_b0a7:
        ldx #$ab

        .byte $ab

    L_b0aa:
        lda #$e8

        .byte $e7,$e7,$e7,$9a,$1c,$1c,$1b,$20,$20,$20,$20,$20,$4a

    L_b0b9:
        .byte $4b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $e3,$a3,$a3,$ab,$ab,$ab,$ab,$ea,$e7,$e7,$e7,$df,$9a,$1c,$1c,$1b
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$6a,$6b,$20
        .byte $20,$20,$20,$20,$20,$20,$e3,$ab,$a3,$a3,$a3,$ab,$ab,$a2,$e7,$e7
        .byte $df,$e7,$7b,$1c,$1c,$1b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$8a,$8b,$20,$20,$20,$20,$20,$20,$20,$20,$ca,$ab,$a3
        .byte $a3,$ab,$ab,$ab,$a3,$e7,$e7,$e7,$df,$7b,$9b,$bb
        .fill $18, $20
        .byte $ca,$cb,$a3,$ab,$21,$21,$ea,$ab,$e7,$df,$e7,$df,$e7,$db,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$6a,$6b,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$e0,$e1,$e2,$aa,$a3,$a3,$ab,$e7
        .byte $e9,$e7,$e7,$e7,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$8a,$8b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $e3,$21,$a3,$a3,$ab,$21,$ea,$e7,$e7,$e7
        .fill $1d, $20
        .byte $e0,$e2,$a3,$ab,$a9,$21,$e8,$e7,$e9
        .fill $14, $20
        .byte $6a,$6b,$20,$20,$20,$20,$20,$20,$20,$20,$e3,$a3,$ab,$21,$ea,$e7
        .byte $eb,$a9
        .fill $14, $20
        .byte $8a,$8b,$20,$20,$20,$20,$20,$20,$20,$20,$20,$ca,$cb,$a9,$e4,$e4
        .byte $e5,$e6
        .fill $21, $20
        .byte $e0,$20,$20,$20,$20,$ff,$9a

    L_b231:
        .byte $b6,$ba,$b2
        .byte $ba,$b2,$12,$b3,$12,$b3,$6a,$b3,$6a,$b3,$c2,$b3,$c2,$b3,$1a,$b4
        .byte $1a,$b4,$72,$b4,$72,$b4,$ca,$b4,$ca,$b4,$22,$b5,$22,$b5,$82,$b5
        .byte $82,$b5,$e2,$b5,$e2,$b5,$42,$b6,$42,$b6,$9a,$b6,$9a,$b6,$ff,$8f
        .byte $2b,$01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80,$20,$97
        .byte $00,$46,$09,$08,$06,$41,$a8,$af,$10,$01,$09,$08,$06,$01,$20,$97
        .byte $00,$1e,$09,$08,$06,$41,$47,$97,$10,$01,$09,$08,$06,$01,$20,$97
        .byte $00,$1e,$09,$08,$06,$41,$af,$ac,$13,$01,$09,$08,$06,$01,$20,$97
        .byte $00,$1e,$09,$08,$06,$41,$ce,$99,$14,$01,$09,$08,$06,$01,$20,$97
        .byte $00,$1e,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96
        .byte $03,$01,$0c,$0f,$06,$80,$20,$97,$00,$44,$05,$0d,$06,$41,$b6,$a9
        .byte $13,$01,$05,$0d,$06,$01,$c0,$9f,$00,$1e,$05,$0d,$06,$41,$ed,$9c
        .byte $12,$01,$05,$0d,$06,$01,$20,$97,$00,$1e,$05,$0d,$06,$41,$a8,$af
        .byte $10,$01,$05,$0d,$06,$01,$20,$97,$00,$19,$05,$0d,$06,$41,$af,$ac
        .byte $13,$01,$05,$0d,$06,$01,$20,$97,$00,$28,$0c,$0f,$06,$40,$ff,$8f
        .byte $2b,$01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80,$20,$97
        .byte $00,$3c,$08,$09,$06,$41,$b6,$a9,$13,$01,$08,$09,$06,$01,$c0,$9f
        .byte $00,$1e,$08,$09,$06,$41,$ed,$9c,$12,$01,$08,$09,$06,$01,$20,$97
        .byte $00,$1e,$08,$09,$06,$41,$a8,$af,$10,$01,$08

    L_b34f:
        ora #$06
        ora ($20,x)

        .byte $97,$00,$1e,$08,$09,$06,$41,$af,$ac,$13,$01,$08,$09,$06,$01,$20
        .byte $97,$00,$1e,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87
        .byte $96,$03,$01,$0c,$0f,$06,$80,$20,$97,$00,$34,$05,$0d,$06,$41,$47
        .byte $97,$10,$01,$05,$0d,$06,$01,$20,$97,$00,$1e,$05,$0d,$06,$41,$af
        .byte $ac,$13,$01,$05,$0d,$06,$01

    L_b39a:
        jsr.a $0097

        .byte $14,$05,$0d,$06,$41,$ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$a8,$af,$10,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $23,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96,$03
        .byte $01,$0c,$0f,$06,$80,$20,$97,$00,$4b,$09,$08,$06,$41,$a8,$af,$10
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$1e,$09,$08,$06,$41,$af,$ac,$13
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$1e,$09,$08,$06,$41,$ce,$99,$14
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$28,$09,$08,$06,$41,$a8,$af,$10
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$23,$0c,$0f,$06,$40,$ff,$8f,$2b
        .byte $01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80,$20,$97,$00
        .byte $3a,$05,$0d,$06,$41,$a8,$af,$10,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$af,$ac,$13,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$a8,$af,$10,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96,$03
        .byte $01,$0c,$0f,$06,$80,$20,$97,$00,$3a,$09,$08,$06,$41,$af,$ac,$13
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$1e,$09,$08,$06,$41,$47,$97,$10
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$1e,$09,$08,$06,$41,$ce,$99,$14
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$1e,$09,$08,$06,$41,$af,$ac,$13
        .byte $01,$09,$08,$06,$01,$20,$97,$00,$20,$0c,$0f,$06,$40,$ff,$8f,$2b
        .byte $01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80,$20,$97,$00
        .byte $3a,$05,$0d,$06,$41,$af,$ac,$13,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$47,$97,$10,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $28,$05,$0d,$06,$41,$af,$ac,$13,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96,$03
        .byte $01,$0c,$0f,$06,$80,$20,$97,$00,$4e,$05,$0d,$06,$41,$b6,$a9,$13
        .byte $01,$05,$0d,$06,$01,$c0,$9f,$00,$1c,$05,$0d,$0e,$41,$e3,$a6,$12

    L_b54d:
        ora ($05,x)
        ora $010e
        cpy #$9f

        .byte $00,$1e,$05,$0d,$0e,$41,$e0,$a2,$1a,$01,$05,$0d,$0e,$01,$c0,$9f
        .byte $00,$14,$05,$0d,$0e,$41,$c0

    L_b56b:
        .byte $9f,$00,$0c
        .byte $05,$0d,$06,$41,$ed,$9c,$12,$01,$05,$0d,$06,$01,$20,$97,$00,$17
        .byte $0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96,$03,$01
        .byte $0c,$0f,$06,$80,$20,$97,$00,$44,$05,$0d,$06,$41,$b6,$a9,$13,$01
        .byte $05,$0d,$06,$01,$c0,$9f,$00,$1c,$05,$0d,$0e,$41,$e0,$a2,$1a

    L_b5ad:
        ora ($05,x)
        ora $010e
        cpy #$9f

    L_b5b4:
         .byte $00,$14
        .byte $05,$0d,$0e,$41,$e7

    L_b5bb:
        .byte $9f,$13
        .byte $01,$05,$0d,$0e,$01,$c0,$9f,$00,$0c,$05,$0d,$0e,$41,$c0,$9f,$00
        .byte $0c,$05,$0d

    L_b5d0:
        asl $41
        sbc L_128a + $12
        ora ($05,x)
        ora $0106
        jsr.a $0097

        .byte $17,$0c,$0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$ff,$8f,$2b
        .byte $01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80,$20,$97,$00
        .byte $3e,$05,$0d,$06,$41,$47,$97,$10,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1e,$05,$0d,$06,$41,$ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00
        .byte $1f,$05,$0d

    L_b620:
        asl $41

        .byte $47,$97,$10,$01,$05,$0d,$06,$01,$20,$97,$00,$16,$05,$0d,$06,$41
        .byte $ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00,$29,$0c,$0f,$06,$40
        .byte $ff,$8f,$2b,$01,$0c,$0f,$06,$20,$87,$96,$03,$01,$0c,$0f,$06,$80
        .byte $20,$97,$00,$3e,$05,$0d,$06,$41,$ce,$99,$14,$01,$05,$0d,$06,$01
        .byte $20,$97,$00,$17,$05,$0d

    L_b668:
        asl $41

        .byte $47,$97,$10,$01,$05,$0d,$06,$01,$20,$97,$00,$1f,$05,$0d,$06,$41
        .byte $ce,$99,$14,$01,$05,$0d,$06,$01,$20,$97,$00,$16,$05,$0d,$06,$41
        .byte $47,$97,$10,$01,$05,$0d,$06,$01,$20,$97,$00

    L_b695:
        and #$0c

        .byte $0f,$06,$40,$ff,$8f,$2b,$01,$0c,$0f,$06,$20,$00,$30,$30,$30,$30
        .byte $fc,$01,$02

    L_b6aa:
        .byte $03,$04,$30,$30,$30,$30,$30,$30,$30,$fc,$30,$30,$30,$30,$33
        .byte $30,$30,$bd,$be,$bf,$30,$30,$30,$1a,$1b,$1c,$30,$30,$ff,$30,$30
        .byte $30,$ff,$30,$30,$30,$30,$30,$06,$07,$08,$09,$32

    L_b6d5:
        bmi L_b707
    L_b6d7:
        bmi L_b709
        bmi L_b70b
        bmi L_b70d
        bmi L_b70f
        bmi L_b711
        bmi L_b713
        bmi L_b715
        bmi L_b717
        bmi L_b719
        bmi L_b71b
    L_b6eb:
        bmi L_b71b + $2
        bmi L_b71b + $4
        bmi L_b721
        bmi L_b723
        bmi L_b724 + $1
        bmi L_b724 + $3

        .byte $30,$0b,$0c,$0d,$0e,$30

    L_b6fd:
        bmi L_b724 + $b
    L_b6ff:
        bmi L_b724 + $d
        bmi L_b724 + $f
        bmi L_b735
        bmi L_b737
    L_b707:
        bmi L_b739
    L_b709:
        bmi L_b73b
    L_b70b:
        bmi L_b73d
    L_b70d:
        bmi L_b73f
    L_b70f:
        bmi L_b741

    L_b711:
         .byte $30,$13

    L_b713:
        bmi L_b745

    L_b715:
         .byte $30,$30

    L_b717:
        bmi L_b74a + $2
    L_b719:
        rol $30,x

    L_b71b:
         .byte $30,$30,$30,$30,$30,$f0

    L_b721:
        ora ($f0),y

    L_b723:
         .byte $f0

    L_b724:
        .fill $11, $30

    L_b735:
        bmi L_b767
    L_b737:
        bmi L_b769
    L_b739:
        bmi L_b76b
    L_b73b:
        bmi L_b76d
    L_b73d:
        bmi L_b76f

    L_b73f:
         .byte $30,$30

    L_b741:
        bmi L_b773
        bmi L_b775
    L_b745:
        bmi L_b775 + $2

        .byte $32,$15,$16

    L_b74a:
        .byte $f0,$f0,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
        .byte $30,$30,$30,$30,$30,$30,$30,$30,$13,$fc,$fc,$ff,$ff

    L_b767:
        bmi L_b790 + $9
    L_b769:
        bmi L_b79b
    L_b76b:
        bmi L_b79d
    L_b76d:
        bmi L_b79f

    L_b76f:
         .byte $30,$1a,$17,$1c

    L_b773:
        beq L_b79f + $6

    L_b775:
         .byte $30,$30,$30,$30,$30,$30
        .byte $36,$30,$30,$30,$30,$30,$30,$32,$ff,$ff,$fc,$ff,$33,$fc,$35,$33
        .byte $ff

    L_b78c:
        rol $32,x
    L_b78e:
        and $ff,x

    L_b790:
         .byte $fc,$30,$ff,$ff,$32,$ff,$ff,$30,$fc,$30,$30

    L_b79b:
        bmi L_b7cd
    L_b79d:
        bmi L_b7cf

    L_b79f:
         .byte $30,$30,$30,$30,$30,$30,$30,$30,$fc,$fc,$ff,$ff,$ff,$fc,$fc,$ff
        .byte $fc,$fc,$fc,$ff,$fc,$fc,$ff,$fc,$ff,$ff,$ff,$fc,$ff,$ff,$ff,$fc
        .byte $ff,$39,$38,$34,$2f,$38,$2f,$34,$38,$34,$2f,$38,$34,$2f

    L_b7cd:
        sec 

        .byte $3a

    L_b7cf:
        and L_3c32 + $9,y
        and L_3a39,y

        .byte $3c,$39,$39,$3c,$39,$3a,$3c,$3a,$3b,$39,$3c,$39,$3a,$3c,$3b,$3c
        .byte $39,$3c,$3c,$4e,$23,$68,$68,$27,$68,$68,$27,$68,$68,$27,$68,$68
        .byte $23,$55,$4e,$3e,$4e,$30,$30,$44,$30,$4e,$30,$43,$54,$30,$54,$30
        .byte $3e,$30,$42,$4c,$30,$30,$3d,$30,$b1,$b2,$30,$4b,$23,$29,$29,$27
        .byte $29,$29,$27,$2a,$29,$27,$2a,$2a,$23,$55,$4d,$3d,$4e,$42,$4e,$43
        .byte $30,$4c,$30,$44,$55,$4e,$55,$30,$3f,$4e,$3e,$54,$4c,$30,$3e,$4e
        .byte $30,$4e,$4e,$4c,$26,$69,$69,$28,$69,$69,$28,$69,$69,$28,$69,$69
        .byte $25,$54,$4c,$3f,$4c,$44,$4c,$4e,$54,$4e,$4e,$4c,$55,$4d,$4e,$54
        .byte $3d,$4c,$43,$55,$4e,$4e,$40

    L_b85c:
        jmp $4c54
        jmp $234e

        .byte $29,$29,$27,$29,$29,$27,$2a,$29,$27,$2a,$2a,$23,$55,$4b,$40,$4d
        .byte $43,$4c,$4d,$55,$4b,$4e,$4b,$54,$4e,$4c,$55,$3e,$4d,$42,$55,$4c
        .byte $4c,$4e,$4e,$55,$4e,$4d,$50,$23,$68,$68,$27,$68,$68,$27,$68,$68
        .byte $27,$68,$68,$23,$55,$53,$52,$52,$53,$52,$52,$50,$52,$53,$53,$50
        .byte $50,$53,$53,$50,$50,$51,$53,$50,$50,$53,$51,$53,$50,$50,$6a,$23
        .byte $68,$68,$27,$68,$68,$27,$68,$68,$27,$68,$68,$23,$6a,$6b,$6c,$6d
        .byte $6b,$50,$6b,$6d,$6a,$6c,$6d,$6b,$6d,$6d,$6a,$6d,$6d,$6a,$6c,$6c
        .byte $6b,$6c,$6d,$6a,$6b,$6a,$4c,$23,$68,$68,$27,$68,$68,$27,$68,$68
        .byte $27,$68,$68,$23,$4c,$4d,$4e,$4c,$4e,$4d,$4c,$4e,$4b,$4c,$3e,$4c
        .byte $3f

    L_b8f3:
        rti 

        .byte $3f,$3e,$3f,$3f,$40,$3e,$41,$3f,$3e,$43,$44,$42,$b2,$2d,$2c,$2b
        .byte $2d,$2b,$2c,$2d,$2c,$2c,$2d,$2c,$2b,$2d,$b1,$b2,$b3,$b3,$b2,$b3
        .byte $b3,$b2,$b1,$b3,$b3,$b2,$b3,$b3,$b2,$b3,$b1,$b3,$b3,$b1,$b3,$b2
        .byte $b3,$b3,$b2,$b3,$30,$30,$30,$30,$30,$30,$30,$30

    L_b930:
        bmi L_b954 + $e
        bmi L_b954 + $10
        and $30,x
        bmi L_b96a + $4
        bmi L_b96a
        bmi L_b96a + $2

        .byte $ff,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$fc,$35,$30,$30,$30
        .byte $32,$ff,$30,$36,$32,$35,$30,$ff

    L_b954:
        .fill $13, $30
        .byte $ff,$30,$35

    L_b96a:
        .fill $14, $30
        .byte $35,$30,$fc,$30,$30,$30,$36,$30,$30,$30,$30,$30,$36,$30,$30,$30
        .byte $30,$30,$30,$30,$30,$30,$30,$36,$36

    L_b997:
        .byte $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
        .byte $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30

    L_b9b1:
        bmi L_b9e3
    L_b9b3:
        bmi L_b9b1
        bmi L_b9e7

        .byte $32,$fc

    L_b9b9:
        bmi L_b9e7 + $4
    L_b9bb:
        bmi L_b9e7 + $6
    L_b9bd:
        bmi L_b9e7 + $8
    L_b9bf:
        bmi L_b9f1
    L_b9c1:
        bmi L_b9f3

        .byte $fc,$30,$30,$35,$30,$30,$30,$35,$30,$30,$30,$30,$30,$30,$30,$30
        .byte $32,$fc

    L_b9d5:
        bmi L_ba07

    L_b9d7:
         .byte $30,$ff

    L_b9d9:
        bmi L_ba09 + $2
    L_b9db:
        bmi L_ba0d
    L_b9dd:
        bmi L_ba0f
    L_b9df:
        bmi L_ba0f + $2
    L_b9e1:
        bmi L_ba0f + $4

    L_b9e3:
         .byte $30,$35
        .byte $30,$30

    L_b9e7:
        .byte $30,$30,$30,$36,$30,$30,$30,$30,$30,$fc

    L_b9f1:
        bmi L_ba1f + $4
    L_b9f3:
        bmi L_b9f1

        .byte $30,$ff,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$35,$36
        .byte $30,$30

    L_ba07:
        bmi L_ba39

    L_ba09:
         .byte $30,$30,$30,$30

    L_ba0d:
        bmi L_ba39 + $6

    L_ba0f:
         .byte $30,$30,$30,$30,$30,$30,$30,$30,$30,$32,$fc,$ff,$fc,$ff,$13,$ff

    L_ba1f:
        .byte $fc,$ff,$fc,$32,$30,$30
        .byte $30,$30,$30,$ff

    L_ba29:
        bmi L_ba5b
    L_ba2b:
        bmi L_ba5d

    L_ba2d:
         .byte $30,$30

    L_ba2f:
        bmi L_ba61

    L_ba31:
         .byte $30,$ff

    L_ba33:
        bmi L_ba65

        .byte $30,$30

    L_ba37:
        bmi L_ba69

    L_ba39:
         .byte $30,$30,$13,$fc,$ff,$fc,$30,$fc,$ff,$ff,$fc,$fc,$ff,$ff,$fc,$ff
        .byte $fc,$ff,$ff,$fc,$ff,$30,$30,$30,$30,$30,$30,$30,$30,$fc

    L_ba57:
        bmi L_ba89

        .byte $30,$30

    L_ba5b:
        and $30,x

    L_ba5d:
         .byte $30,$30,$fc,$17

    L_ba61:
        iny 
        ora $c9

        .byte $fb

    L_ba65:
        iny 
        sbc ($c8),y

        .byte $e7

    L_ba69:
        iny 
        cmp $d3c8,x
        iny 
        cmp #$c8

        .byte $bf,$c8,$b5,$c8,$ab,$c8,$a1,$c8,$97,$c8,$8d,$c8,$83,$c8,$79,$c8
        .byte $6f,$c8,$63,$c8,$57,$c8,$4b,$c8,$3f

    L_ba89:
        iny 
        and $c8,x

        .byte $2b,$c8,$21,$c8,$17,$c8,$6d,$00,$6e,$6f,$70,$00

    L_ba98:
        adc ($00),y
        ror L_7f00,x

        .byte $00,$6d,$00,$80,$00,$81,$00,$82,$00,$75,$00,$7d,$00,$75,$82,$00
        .byte $75,$7d,$00,$6d,$00,$6d,$90,$91,$00,$6d,$92,$93

    L_bab9:
        .byte $00

    L_baba:
        adc $6e00

        .byte $6f,$70,$00

    L_bac0:
        adc ($00),y

        .byte $72,$73,$74,$6e,$00,$85,$00,$7e,$00,$81,$00,$83,$00,$6d,$90,$91
        .byte $92,$93,$00,$75,$00,$6d,$00,$7e,$00,$7d,$00,$81,$00,$82,$00,$7e
        .byte $00,$7f,$00,$80,$00,$81,$00

    L_bae9:
        .byte $82,$00
        .byte $75,$00,$ae,$94,$b0,$96,$b2,$98,$b4,$a5,$b6,$ce,$a8,$d0,$aa,$d2
        .byte $ac,$d4,$00,$ae,$00,$94,$00,$b0,$00

    L_bb04:
        stx $00,y

        .byte $b2,$00,$98,$00,$b4,$00,$a5,$00,$b6,$00,$ce,$00,$a8,$00,$d0,$00

    L_bb16:
        tax 

        .byte $00,$d2,$00,$ac,$00,$d4,$00,$75,$00

    L_bb20:
        ror $77,x
        sei 

        .byte $00,$79,$00,$57,$00,$02,$ff,$ff,$28,$02,$10,$00,$00,$ff,$ff,$00
        .byte $00,$57,$00,$82,$ff,$ff,$00,$00,$28,$04,$00,$ff,$ff,$00,$00,$08
        .byte $03,$03,$ff,$ff,$00,$00,$14,$00,$03,$ff,$ff,$00,$00,$08,$83,$03
        .byte $ff,$ff,$00,$00,$14,$83,$00,$ff,$ff,$00,$00,$08,$83,$83,$ff,$ff
        .byte $00,$00,$14,$00,$83,$ff,$ff,$00,$00,$08,$03,$83,$ff,$ff,$00,$00
        .byte $4b,$80,$82,$18,$ff,$00,$00,$4b,$00,$82,$18,$ff,$00,$00,$36,$00
        .byte $03,$ff,$ff,$28,$05,$50,$00,$02,$ff,$ff,$00,$00,$46,$00,$82,$ff
        .byte $ff,$20,$08,$46,$00,$03,$08,$ff,$28,$07,$46,$80,$03,$08,$ff,$28
        .byte $07,$5a,$00,$01,$ff,$21,$22,$0c,$5a,$00,$81,$ff,$21,$22,$0c,$3c
        .byte $04,$00,$ff,$ff,$00,$00,$2d,$84,$00,$ff,$ff,$00,$00,$3c,$00,$03
        .byte $ff,$ff,$28,$04,$10,$00,$00,$ff,$ff,$28,$01,$37,$00,$83,$ff,$ff
        .byte $28,$00,$e6,$00,$81,$ff,$ff,$24,$08,$e6,$00,$81,$ff,$ff,$28

    L_bbe2:
        .byte $02,$64,$02,$00,$ff,$ff,$00,$00,$64,$82,$00,$ff,$ff,$00,$00,$14
        .byte $04,$00,$ff,$ff,$00,$00,$25,$00,$04,$ff,$ff,$28,$03,$50,$02,$03
        .byte $ff,$ff,$a8,$04,$69,$02,$82,$ff,$ff,$80,$00,$69,$02,$02,$ff,$ff
        .byte $a8,$00,$1e,$82,$05

    L_bc17:
        .byte $ff,$ff,$00,$00,$02
        .byte $85,$05,$ff,$ff,$00,$00,$08,$85,$05

    L_bc25:
        .byte $ff,$ff,$00,$00,$02
        .byte $85,$85,$ff,$ff,$00,$00,$1e,$00,$85,$ff,$ff,$00,$00,$96,$02,$02
        .byte $ff,$ff,$40,$00,$96,$82,$02,$ff,$ff,$40,$00,$57,$00,$02,$ff,$ff
        .byte $22,$06,$10

    L_bc4d:
        .byte $00,$00,$ff,$ff,$00,$00,$57,$00,$82,$ff,$ff,$00,$00,$14,$03,$00

    L_bc5d:
        .byte $ff,$ff,$00,$00,$14,$03,$83,$ff,$ff,$00,$00,$3c
        .byte $01,$81,$0a

    L_bc6c:
        .byte $ff,$00,$00,$14,$83,$00,$ff,$ff,$00,$00,$14,$83,$83,$ff,$ff,$00

    L_bc7c:
        .byte $00,$3c
        .byte $81,$81,$0a,$ff,$00,$00,$46,$03,$00,$ff,$ff,$28

    L_bc8a:
        .byte $00,$03,$03,$03,$ff,$ff,$00,$00,$03,$83,$03,$ff,$ff,$00,$00
        .byte $1e,$83,$00,$ff,$ff,$28

    L_bc9f:
        .byte $00,$03,$83,$83,$ff,$ff,$00,$00,$3c,$00,$83,$ff,$ff,$00,$00,$4b
        .byte $00,$81,$ff,$ff,$00,$00,$0a,$02,$81,$02

    L_bcb9:
        .byte $ff,$00,$00,$14,$02,$00,$ff,$ff
        .byte $20,$05,$0a

    L_bcc4:
        .byte $01,$80,$ff,$02,$00,$00,$37,$82,$80,$ff,$17
        .byte $20,$05,$37,$82,$00,$ff,$17,$20,$05,$14,$02,$80,$ff,$0f,$20,$05
        .byte $5a,$00,$81,$ff,$ff,$20,$04,$32,$02,$00,$ff,$ff,$20,$05,$64,$02
        .byte $02,$ff,$ff,$80,$00,$64,$02,$01,$ff,$ff,$40

    L_bcfa:
        .byte $00,$64,$82
        .byte $01,$ff,$ff,$00,$00,$64,$82,$01,$ff,$ff,$40

    L_bd08:
        .byte $00,$64,$02
        .byte $01,$ff,$ff,$00,$00,$2c,$00,$02,$ff,$ff,$28,$0a,$04,$01,$02

    L_bd1a:
        .byte $ff,$ff,$00,$00,$04,$02,$02,$ff,$ff,$00,$00,$04,$02
        .byte $01,$ff,$ff,$00,$00,$2e,$02,$00

    L_bd2f:
        .byte $ff,$ff,$00,$00,$04,$02
        .byte $81,$ff

    L_bd37:
        .byte $ff,$00,$00,$04,$02,$82,$ff,$ff,$00,$00,$04
        .byte $01,$82

    L_bd44:
        .byte $ff,$ff,$00,$00,$0f,$00,$82,$ff,$ff,$00,$00,$04
        .byte $81,$82

    L_bd52:
        .byte $ff,$ff,$00,$00,$04,$82,$82,$ff,$ff,$00,$00,$04,$82
        .byte $81,$ff,$ff,$00,$00,$2d,$82,$00

    L_bd67:
        .byte $ff,$ff,$00,$00,$04,$82
        .byte $01,$ff

    L_bd6f:
        .byte $ff,$00,$00,$04,$82,$02,$ff,$ff,$00,$00,$04
        .byte $81,$02

    L_bd7c:
        .byte $ff,$ff,$00,$00,$32,$00,$03,$ff,$ff,$00,$00,$57,$00,$82,$ff,$ff

    L_bd8c:
        .byte $00,$00,$10,$00,$00,$ff,$ff,$00,$00,$57,$00,$02,$ff,$ff,$22

    L_bd9b:
        asl $26

        .byte $bb,$2d,$bb,$34,$bb,$00,$00,$10,$bd,$17,$bd,$1e,$bd,$25,$bd,$2c
        .byte $bd,$33,$bd,$3a,$bd,$41,$bd,$48,$bd,$4f,$bd,$56,$bd,$5d,$bd,$64

    L_bdbd:
        lda L_bd67 + $4,x

        .byte $72,$bd,$79,$bd,$80,$bd,$00,$00,$3b,$bb,$42,$bb,$49,$bb,$50,$bb
        .byte $57,$bb,$5e,$bb,$65,$bb,$6c,$bb,$3b,$bb,$42,$bb,$49,$bb,$50,$bb
        .byte $57,$bb,$5e,$bb,$65,$bb,$6c,$bb,$3b

    L_bde9:
        .byte $bb,$00,$00,$73,$bb
        .byte $81,$bb,$00,$00,$7a,$bb,$81,$bb,$00,$00,$88,$bb,$42,$bb,$3b,$bb
        .byte $6c,$bb,$65,$bb,$5e,$bb,$57,$bb,$50,$bb,$49,$bb,$49,$bb,$00,$00
        .byte $88,$bb,$50,$bb,$57,$bb,$5e,$bb,$65,$bb,$6c,$bb,$3b,$bb,$42,$bb
        .byte $49,$bb,$49,$bb,$00,$00,$ae,$bc,$b5,$bc,$bc,$bc,$c3,$bc,$ca,$bc
        .byte $d1,$bc,$d8,$bc,$df,$bc,$00,$00,$96,$bb,$00,$00,$9d,$bb,$00,$00
        .byte $a4,$bb,$ab,$bb,$a4,$bb,$ab,$bb,$a4,$bb

    L_be48:
        .byte $ab,$bb,$00,$00,$b2,$bb,$42,$bb
        .byte $49,$bb,$50,$bb,$b9,$bb,$50,$bb,$49,$bb,$00,$00,$10,$bd,$79,$bd
        .byte $72,$bd,$6b,$bd,$64,$bd,$5d,$bd,$56,$bd,$4f,$bd,$48,$bd,$41,$bd
        .byte $3a,$bd,$33,$bd,$2c,$bd,$25,$bd,$1e,$bd,$17,$bd,$80,$bd,$00,$00
        .byte $c0,$bb,$c7,$bb,$ce,$bb,$c7,$bb,$c0,$bb,$00,$00,$d5,$bb,$00,$00
        .byte $dc,$bb,$00,$00,$e3,$bb,$ea,$bb,$00,$00,$ea,$bb,$e3,$bb,$00,$00
        .byte $f8

    L_bea1:
        .byte $bb,$50,$bb,$57,$bb
        .byte $5e,$bb,$65,$bb,$6c,$bb,$f1,$bb,$42,$bb,$f8,$bb,$00,$00,$ff,$bb
        .byte $00,$00,$06,$bc,$00,$00,$0d,$bc,$00,$00,$ae,$bc,$b5,$bc,$e6,$bc
        .byte $c3,$bc,$ca,$bc,$d1,$bc,$d8,$bc,$df,$bc,$00,$00,$14,$bc,$1b,$bc
        .byte $22,$bc,$29,$bc,$30,$bc,$00,$00,$37,$bc,$00,$00,$3e,$bc,$00,$00
        .byte $45,$bc,$4c,$bc,$53,$bc,$00,$00,$5a,$bc,$61,$bc,$68,$bc,$00,$00
        .byte $6f,$bc,$76,$bc,$7d,$bc,$00,$00,$84,$bc,$8b,$bc,$92,$bc,$99,$bc
        .byte $a0,$bc,$a7,$bc,$00,$00,$ed,$bc,$00,$00,$f4,$bc,$fb,$bc,$00,$00
        .byte $02,$bd,$09,$bd,$00,$00,$87,$bd,$8e,$bd

    L_bf20:
        sta $bd,x

    L_bf22:
         .byte $00,$00,$92
        .byte $ba,$94,$ba,$98,$ba

    L_bf2a:
        inc.a $00ba,x

        .byte $bb,$02,$bb,$04,$bb,$06,$bb,$08,$bb,$0a,$bb,$0c,$bb,$0e,$bb,$10

    L_bf3d:
        .byte $bb,$12,$bb,$14,$bb
        .byte $16,$bb,$18,$bb,$1a,$bb,$1c,$bb,$fe,$ba,$9a,$ba,$9c,$ba,$9e,$ba
        .byte $a0,$ba,$a2,$ba,$a4,$ba,$a6,$ba,$a8,$ba,$9a,$ba,$9c,$ba,$9e,$ba
        .byte $a0,$ba,$a2,$ba,$a4,$ba,$a6,$ba,$a8,$ba,$9a,$ba,$aa,$ba,$b0,$ba

    L_bf72:
        lda L_b0b9 + $1
        tsx 

    L_bf76:
         .byte $9e
        .byte $ba,$9c,$ba,$9a,$ba,$a8

    L_bf7d:
        tsx 
        ldx $ba
    L_bf80:
        ldy $ba
        ldx #$ba
        ldy #$ba

        .byte $9e,$ba,$9e,$ba,$9e,$ba,$a0,$ba,$a2,$ba,$a4,$ba,$a6,$ba,$a8,$ba
        .byte $9a,$ba,$9c,$ba,$9e,$ba,$9e,$ba,$92,$ba,$b2,$ba

    L_bfa2:
        ldx $ba,y
        txs 
    L_bfa5:
        tsx 

        .byte $9c,$ba,$9e,$ba,$a0,$ba,$a2,$ba,$a0,$ba

    L_bfb0:
        .byte $9e
        .byte $ba

    L_bfb2:
        inc $1cba,x

        .byte $bb,$1a,$bb,$18,$bb,$16,$bb

    L_bfbc:
        .byte $14,$bb,$12,$bb
        .byte $10,$bb,$0e,$bb,$0c,$bb,$0a,$bb,$08,$bb,$06,$bb,$04,$bb,$02,$bb
        .byte $00,$bb,$fe,$ba,$ba,$ba,$bc,$ba,$c0,$ba,$c2,$ba,$ba,$ba,$c7,$ba

    L_bfe0:
        cmp #$ba

        .byte $cb,$ba

    L_bfe4:
        .byte $cb
        .byte $ba,$c9,$ba,$cd,$ba,$9e,$ba,$a0,$ba,$a2,$ba,$a4,$ba,$a6,$ba,$a8
        .byte $ba,$9a,$ba,$9c,$ba,$9e,$ba,$cf,$ba

    L_bffe:
        cmp $ba,x

    L_c000:
         .byte $d7
        .byte $ba

    L_c002:
        .byte $9e
        .byte $ba,$a0,$ba,$a2,$ba,$a4,$ba,$a6,$ba,$9a,$ba

    L_c00e:
        ldx #$ba
    L_c010:
        cmp vColorRam + $3ba,y
        tsx 
        cmp L_ddb1 + $9,y
        tsx 

        .byte $df,$ba,$dd,$ba,$e1,$ba,$e3,$ba

    L_c020:
        sbc $ba

        .byte $e7,$ba,$e9,$ba,$eb,$ba,$ed,$ba,$1e,$bb,$20,$bb,$24,$bb,$9c,$bd
        .byte $24,$bf,$0f,$04,$01,$28,$32,$64,$00,$9c,$bd,$24,$bf,$0f,$04

    L_c041:
        ora ($3c,x)

    L_c043:
         .byte $32,$82,$00,$9c
        .byte $bd,$24,$bf,$0f,$04,$01,$5a,$32,$b4,$00,$9c,$bd,$24,$bf,$0f,$04
        .byte $01,$78,$32,$e6,$00,$9c,$bd,$24,$bf,$0f,$04,$01,$be,$32,$96,$00
        .byte $9c,$bd,$24,$bf,$0f,$04,$01,$e6,$32,$6e,$00,$9c,$bd,$24,$bf,$0f
        .byte $04,$01,$ff,$32,$f0,$00,$9c,$bd,$24,$bf,$0f,$04,$01,$0a,$32,$6e
        .byte $00,$9c,$bd,$24,$bf,$0f,$04,$01,$0a,$32,$1e,$01,$9c,$bd,$24,$bf
        .byte $0f,$04,$01,$3c,$32,$a0,$00,$9c,$bd,$24,$bf,$0f,$04,$01,$82,$32
        .byte $32,$00,$9c,$bd,$24,$bf

    L_c0ad:
        .byte $0f,$04
        .byte $01,$96,$32,$1e,$01,$a4,$bd,$2a,$bf,$05,$04

    L_c0ba:
        ora ($00,x)

        .byte $32,$28,$00,$c8,$bd,$4c,$bf

    L_c0c3:
        .byte $02,$04,$00,$00,$64,$00,$00
        .byte $c8,$bd,$4c,$bf

    L_c0ce:
        .byte $02,$04,$00,$13,$64,$00,$00
        .byte $c8,$bd,$4c,$bf,$02,$04,$00,$26,$64,$00,$00,$c8,$bd,$4c,$bf

    L_c0e4:
        .byte $02,$04,$00
        .byte $39,$64,$00

    L_c0ea:
        .byte $00
        .byte $c8,$bd,$4c,$bf,$02,$04,$00,$4c,$64,$00,$00,$ec,$bd,$6e,$bf,$05
        .byte $3c,$01,$5a,$e6,$82,$00,$f2,$bd,$72,$bf,$05,$3c,$01,$5a,$e6,$be
        .byte $00,$f8,$bd,$76,$bf,$02,$04,$00,$14,$32,$78,$00,$f8,$bd,$76,$bf
        .byte $02,$04,$00,$14,$32,$c8,$00,$0e,$be,$8a,$bf,$05,$04,$00,$64,$32
        .byte $78

    L_c12c:
        .byte $00
        .byte $0e,$be,$8a,$bf,$05,$04,$00,$64,$32,$c8,$00,$24,$be,$9e,$bf,$05
        .byte $04,$01,$00,$e6,$b8,$00,$36,$be,$a0,$bf,$0f,$18,$01,$00,$32,$50
        .byte $00,$3a,$be,$a2,$bf,$0f,$18,$01,$00,$32,$fa,$00,$36,$be,$a0,$bf
        .byte $0f,$18,$01,$5a,$32,$50,$00,$3a,$be,$a2,$bf,$0f,$18,$01,$5a,$32
        .byte $fa,$00,$36,$be,$a0,$bf,$0f,$18,$01,$b4,$32,$50,$00,$3a,$be,$a2
        .byte $bf,$0f,$18,$01,$b4,$32,$fa,$00,$36,$be,$a0,$bf,$0f,$18,$01,$f0
        .byte $32,$50,$00

    L_c190:
        rol $a0be,x

        .byte $bf,$05,$14,$01,$00,$fa,$5f,$00,$4c,$be,$a4,$bf,$02,$04,$00,$00
        .byte $60,$00,$00,$4c,$be,$a4,$bf,$02,$04,$00,$1e,$5d,$00,$00,$4c,$be
        .byte $a4,$bf,$02,$04,$00,$3c,$5d,$00,$00,$4c,$be,$a4,$bf,$02,$04,$00
        .byte $5a,$5d,$00,$00,$4c,$be,$a4,$bf,$02,$04,$00,$78,$5d,$00,$00,$5c
        .byte $be,$b2,$bf,$0f,$05,$01,$00,$32,$0a,$01,$80,$be,$d4,$bf,$0f,$04
        .byte $01,$00,$1e,$3c,$01,$80,$be,$d4,$bf,$0f,$04,$01,$1e,$1e,$6e,$00
        .byte $80,$be,$d4,$bf,$0f,$04,$01,$3c,$1e,$a0,$00,$80,$be,$d4,$bf,$0f
        .byte $04,$01,$5a,$1e,$fa,$00,$80,$be,$d4,$bf,$0f,$04,$01,$78,$1e,$46
        .byte $00,$80,$be,$d4,$bf,$0f,$04,$01,$96,$1e,$96,$00,$80,$be,$d4,$bf
        .byte $0f,$04,$01,$b4,$1e,$e6,$00,$8c,$be,$de,$bf,$0f,$04,$01,$00,$e6
        .byte $3e,$00,$8c,$be,$de,$bf,$0f,$04,$01,$46,$e6,$98,$00,$8c,$be,$de
        .byte $bf,$0f,$04,$01,$8c,$e6,$f2,$00,$94,$be,$e0,$bf,$05,$04,$01,$00
        .byte $4e,$00,$00,$9a,$be,$e4,$bf,$02,$04,$01,$00,$62,$41,$01,$94,$be

    L_c263:
        cpx #$bf
        ora $04
        ora ($00,x)
        ror $00,x

        .byte $00,$9a,$be,$e4,$bf,$02,$04,$01,$00,$8a,$41,$01,$94,$be,$e0,$bf
        .byte $05,$04,$01,$00,$9e,$00,$00,$9a,$be,$e4,$bf,$02,$04,$01,$00,$c6
        .byte $41,$01,$94,$be,$e0,$bf,$02,$04,$01,$00,$da,$00,$00,$90,$be,$e8
        .byte $bf,$0f,$04,$01,$00,$f0,$a5,$00,$90,$be,$e8,$bf,$0f,$04,$01,$32
        .byte $f0,$50,$00,$90,$be,$e8,$bf,$0f,$04,$01,$32,$f0,$fa,$00,$ec,$bd
        .byte $6e

    L_c2bc:
        .byte $bf
        .byte $05,$3c,$01,$00,$e6,$82

    L_c2c3:
        .byte $00,$f2
        .byte $bd,$72,$bf,$05,$3c,$01,$00,$e6,$be,$00,$ec,$bd,$6e,$bf,$02,$3c
        .byte $01,$5a,$e6,$82,$00,$f2,$bd,$72,$bf,$02,$3c,$01,$5a,$e6,$be,$00
        .byte $ec,$bd,$6e

    L_c2e8:
        .byte $bf
        .byte $05,$3c,$01,$82,$e6,$82,$00,$f2,$bd,$72,$bf,$05,$3c,$01,$82,$e6
        .byte $be,$00,$ec,$bd,$6e,$bf,$02,$3c,$01,$aa,$e6,$82,$00,$a0,$be,$ea
        .byte $bf,$02,$04,$00,$00,$28,$a0,$00,$a0,$be,$ea,$bf,$02,$04,$00,$1e
        .byte $28,$a0,$00,$a0,$be,$ea,$bf,$02,$04,$00,$3c,$28,$a0,$00,$a0,$be
        .byte $ea,$bf,$02,$04,$00,$5a,$28,$a0,$00,$a0,$be,$ea,$bf,$02,$04,$00
        .byte $78,$28,$a0,$00,$a0,$be,$ea,$bf,$02,$04,$00,$96,$28,$a0,$00,$a0
        .byte $be,$ea,$bf,$02,$04,$00,$b4,$28,$a0,$00,$b4,$be,$fc,$bf,$05,$08
        .byte $01,$00,$1e,$32,$00,$b4,$be,$fc,$bf,$05,$08,$01,$00,$1e,$05,$01
        .byte $b4,$be,$fc,$bf,$02,$08,$01,$14,$1e,$5a,$00,$b4,$be,$fc,$bf,$02
        .byte $08,$01,$14,$1e,$f0,$00,$b4,$be,$fc,$bf,$05,$08,$01,$28,$1e,$78
        .byte $00,$b4,$be,$fc,$bf,$05,$08,$01,$28,$1e,$c8,$00,$b4,$be,$fc,$bf
        .byte $02,$08,$01,$3c,$1e,$a0,$00,$b8,$be,$fe,$bf,$05,$04,$00,$00,$e6
        .byte $32,$00,$b8,$be,$fe,$bf,$05,$04,$00,$00,$e6,$5a,$00,$b8,$be,$fe
        .byte $bf,$05,$04

    L_c3bc:
        .byte $00,$00
        .byte $e6,$82,$00,$b8,$be,$fe,$bf,$05,$04,$00,$00,$e6,$c8,$00,$bc,$be
        .byte $00,$c0,$02,$04,$00,$00,$1e,$50,$00,$bc,$be,$00,$c0,$02,$04,$00
        .byte $00,$1e,$a0,$00,$bc,$be,$00,$c0,$02,$04,$00,$00,$1e,$f0,$00,$c0
        .byte $be,$9e,$bf,$0f,$04,$01,$00,$e6,$82,$00,$8c,$be,$e8,$bf,$0f,$04
        .byte $01,$00,$f0,$3e,$00,$8c,$be,$e8,$bf,$0f,$04,$01,$46,$f0,$3e,$00
        .byte $8c,$be,$e8,$bf,$0f,$04,$01,$8c,$f0,$3e,$00,$d2,$be,$02,$c0,$02
        .byte $04,$00,$00,$1e,$f0,$00,$d2,$be,$02,$c0,$02,$04,$00,$1e,$1e,$f0
        .byte $00,$d2,$be,$02,$c0,$02,$04,$00,$3c,$1e,$f0,$00,$d2,$be,$02,$c0
        .byte $02,$04,$00,$5a,$1e,$f0,$00,$d2,$be,$02,$c0,$02,$04,$00,$78,$1e
        .byte $f0,$00,$d2,$be,$02,$c0,$02,$04,$00,$96,$1e,$f0,$00,$d2,$be,$02
        .byte $c0,$02,$04,$00,$b4,$1e,$f0,$00

    L_c466:
        dec L_0cbe,x
        cpy #$05

        .byte $04,$00,$00,$78,$14,$00,$e2,$be,$0e,$c0,$05,$04,$00,$00,$78,$50
        .byte $01,$9c

    L_c47d:
        lda L_bf22 + $2,x
        ora $04
        ora ($00,x)

        .byte $32,$46,$00,$9c,$bd,$24,$bf,$05,$04,$01,$00,$32,$28,$01,$9c,$bd
        .byte $24,$bf,$02,$04,$01,$28,$32,$64,$00,$9c,$bd,$24,$bf,$02,$04,$01
        .byte $28,$32,$0a,$01,$e6,$be,$24,$bf,$0f,$04,$01,$50,$32,$82,$00,$e6
        .byte $be,$24,$bf,$0f,$04,$01,$50,$32,$e6,$00,$e6,$be,$24,$bf

    L_c4c2:
        ora $04
        ora ($78,x)

        .byte $32,$b4,$00,$ee,$be,$10,$c0,$05,$04,$01,$00,$b4,$1e,$00,$f6,$be
        .byte $16,$c0,$05,$04,$01,$00,$b4,$28,$01,$ee,$be,$10,$c0,$05,$04,$01
        .byte $32,$b4,$1e,$00,$f6,$be,$16,$c0,$05,$04,$01,$32,$b4,$28,$01,$ee
        .byte $be,$10,$c0,$05,$04,$01,$64,$b4,$1e,$00,$f6,$be,$16,$c0,$05,$04
        .byte $01,$64,$b4,$28,$01,$fe,$be,$1c,$c0,$05,$04,$01,$00,$a0,$14,$00
        .byte $fe,$be,$1c,$c0,$05,$04,$01,$1e,$a0,$14

    L_c520:
        .byte $00
        .byte $fe,$be,$1c,$c0,$05,$04,$01,$3c,$a0,$14,$00,$fe,$be,$1c,$c0,$05
        .byte $04,$01,$5a,$a0,$14,$00,$fe,$be,$1c,$c0,$05,$04,$01,$78,$a0,$14
        .byte $00,$fe,$be,$1c

    L_c545:
        cpy #$05

        .byte $04,$01,$96,$a0,$14,$00,$fe,$be,$1c,$c0,$05,$04,$01,$b4,$a0,$14
        .byte $00,$0c,$bf,$28

    L_c55b:
        cpy #$0f
        asl $00

        .byte $00,$14,$3c,$00,$0c,$bf,$28,$c0,$0f,$06,$00,$00,$14,$be,$00,$10
        .byte $bf,$e0,$bf,$07,$04,$01,$00,$46,$00,$00,$16,$bf,$e4,$bf,$03,$04
        .byte $01,$00,$5a,$41,$01,$10,$bf,$e0,$bf,$04,$04,$01,$00,$6e,$00,$00
        .byte $16,$bf,$e4,$bf,$0d,$04,$01,$00,$82,$41,$01,$10,$bf,$e0,$bf,$05
        .byte $04,$01,$00,$96,$00,$00,$16,$bf,$e4,$bf,$0a,$04,$01,$00,$be,$41
        .byte $01,$10,$bf,$e0,$bf,$02,$04,$01,$00,$d2,$00,$00,$1c,$bf,$2a,$c0
        .byte $02,$04,$00,$00,$e6,$46,$00,$1c,$bf,$2a,$c0,$02,$04,$00,$00,$e6
        .byte $28,$01,$1c,$bf,$2a,$c0,$0a,$04,$00,$28,$e6,$64,$00,$1c,$bf,$2a
        .byte $c0,$0a,$04,$00,$28,$e6,$0a,$01,$1c,$bf,$2a,$c0,$04,$04,$01,$50
        .byte $e6,$82,$00,$1c,$bf,$2a,$c0,$04,$04,$01,$50,$e6,$e6,$00,$1c,$bf
        .byte $2a,$c0,$02,$04,$01,$78,$e6,$b4,$00,$fe,$00,$05,$30,$c0,$3b,$c0
        .byte $46,$c0,$51,$c0,$5c,$c0,$67,$c0,$72,$c0,$9f,$00,$80,$7d,$c0,$88
        .byte $c0,$93,$c0,$9e,$c0,$a9,$c0,$b4,$c0,$fe,$00,$05,$bf,$c0,$ca,$c0
        .byte $d5,$c0,$e0,$c0,$eb,$c0,$f6,$c0,$01

    L_c638:
        cmp ($1e,x)
        jsr L_0c80

        .byte $c1,$17,$c1,$22,$c1,$2d,$c1,$38,$c1,$fe,$00,$80,$43,$c1,$4e,$c1
        .byte $59,$c1,$64,$c1,$6f,$c1,$7a,$c1,$85,$c1,$9f,$00,$05,$43,$c1,$4e
        .byte $c1,$59,$c1,$64,$c1,$6f,$c1,$b4,$c0,$fe,$00,$80,$9b,$c1,$a6,$c1
        .byte $b1,$c1,$bc,$c1,$c7,$c1,$30,$c0,$3b,$c0,$87,$80,$80,$9b,$c1,$a6
        .byte $c1,$b1,$c1,$b4,$c0,$d2,$c1,$fe,$00,$04,$dd,$c1,$e8,$c1,$f3,$c1
        .byte $fe,$c1,$09

    L_c690:
        .byte $c2,$14,$c2,$1f,$c2,$87,$80,$80
        .byte $dd,$c1,$e8,$c1,$f3,$c1,$b4,$c0,$d2,$c1,$fe,$00,$80,$9b,$c1,$a6
        .byte $c1,$b1,$c1,$bc,$c1,$c7,$c1,$17,$c1,$22,$c1,$fe,$00,$05,$dd,$c1
        .byte $e8,$c1,$f3,$c1,$fe,$c1,$09,$c2,$17,$c1,$22,$c1,$87

    L_c6c5:
        .byte $80,$80
        .byte $dd,$c1,$e8,$c1,$f3,$c1,$b4,$c0,$d2,$c1,$1e

    L_c6d2:
        jsr L_bf80

        .byte $c0,$ca,$c0,$d5,$c0,$e0,$c0,$38,$c1,$01,$c0,$80,$2a,$c2,$35,$c2
        .byte $40,$c2,$fe,$00,$05,$4b,$c2,$56,$c2,$61,$c2,$6c,$c2,$77,$c2,$82
        .byte $c2,$8d,$c2,$01,$c0,$80,$98

    L_c6fc:
        .byte $c2,$a3,$c2
        .byte $ae,$c2,$fe,$00,$03,$b9,$c2,$c4,$c2,$cf,$c2,$da,$c2,$e5,$c2,$f0
        .byte $c2,$fb,$c2,$fe,$00,$80,$06,$c3,$11,$c3,$1c,$c3,$27,$c3,$32,$c3
        .byte $3d,$c3,$48,$c3,$fe,$00,$80,$53,$c3,$5e,$c3,$69,$c3,$74,$c3,$7f
        .byte $c3,$8a,$c3,$95,$c3,$fe,$00,$80,$a0,$c3,$ab,$c3,$b6,$c3,$c1,$c3
        .byte $cc,$c3,$d7,$c3,$e2,$c3,$1e,$20,$80,$43,$c1,$4e,$c1,$59,$c1,$64
        .byte $c1,$ed,$c3,$1e,$20,$80,$43,$c1,$4e,$c1,$59,$c1,$64,$c1,$38,$c1
        .byte $01,$c0,$80,$f8,$c3,$03,$c4,$0e,$c4,$fe,$00,$05,$19,$c4,$24,$c4
        .byte $2f,$c4,$3a,$c4,$45,$c4,$50,$c4,$5b,$c4,$fe,$00,$80,$66,$c4,$71
        .byte $c4,$30,$c0,$3b,$c0,$46,$c0,$51,$c0,$5c,$c0,$fe,$00,$05,$7c,$c4
        .byte $87,$c4,$92

    L_c792:
        cpy $9d
        cpy $a8
        cpy $b3
        cpy $be
        cpy $fe

        .byte $00,$80,$c9,$c4,$d4,$c4,$df,$c4,$ea,$c4,$f5,$c4,$00,$c5,$51,$c0
        .byte $e0,$c0,$80,$4b,$c2,$56,$c2,$61,$c2,$98,$c2,$a3,$c2,$00,$e0,$80
        .byte $b4,$c0,$d2,$c1,$ed,$c3,$e0,$c0,$80,$43,$c1,$4e,$c1,$59,$c1,$b4
        .byte $c0,$d2,$c1,$fe,$00,$05,$0b,$c5,$16

    L_c7d5:
        cmp $21
        cmp $2c
        cmp $37
        cmp $42
        cmp $4d
        cmp $87

        .byte $80,$80,$43,$c1,$4e,$c1,$59,$c1,$58,$c5,$63,$c5,$fe,$00,$80,$6e
        .byte $c5,$79,$c5,$84,$c5,$8f,$c5,$9a,$c5,$a5,$c5,$b0,$c5,$fe

    L_c7ff:
        .byte $00,$80,$bb
        .byte $c5,$c6,$c5,$d1,$c5,$dc,$c5,$e7,$c5,$f2,$c5,$fd,$c5,$00,$10,$80
        .byte $90,$c1,$00,$00,$00,$08,$c6,$19,$c6,$28,$c6,$39,$c6,$46,$c6,$46
        .byte $c6,$57,$c6,$66,$c6,$77,$c6,$45,$c7,$84,$c6,$95,$c6,$a2,$c6,$66
        .byte $c6,$52,$c7,$b3,$c6,$c4,$c6,$39,$c6,$d1,$c6,$46,$c6,$39,$c6,$14
        .byte $c8,$e7,$c6,$de,$c6,$d1,$c6,$46,$c6,$f8,$c6,$14,$c8,$e7,$c6,$39
        .byte $c6,$46,$c6,$d1,$c6,$01,$c7,$14,$c8,$de,$c6,$12,$c7,$19,$c6,$46
        .byte $c6,$b3,$c6,$14,$c8,$01,$c7,$28,$c6,$23,$c7,$0f,$c8,$34,$c7,$08
        .byte $c6,$66,$c6,$23,$c7,$e7,$c6,$84,$c6,$5f,$c7,$12,$c7,$45,$c7,$46
        .byte $c6,$68,$c7,$52,$c7,$79,$c7,$45,$c7,$46,$c6,$84,$c6,$45,$c7,$79
        .byte $c7,$68,$c7,$28,$c6,$8a,$c7,$77,$c6,$28,$c6,$e7,$c6,$46,$c6,$19
        .byte $c6,$9b,$c7,$45,$c7,$39,$c6,$46,$c6,$84,$c6,$ac,$c7,$b9,$c7,$c2
        .byte $c7,$cf,$c7,$68,$c7,$08,$c6,$c2,$c7,$ac,$c7,$0f,$c8,$01,$c7,$b9
        .byte $c7,$e0,$c7,$8a,$c7,$52,$c7,$b3,$c6,$9b,$c7,$cf,$c7,$46,$c6,$e0
        .byte $c7,$8a,$c7,$ed,$c7,$79,$c7,$45,$c7,$46,$c6,$52,$c7,$66,$c6,$01
        .byte $c7,$ed,$c7,$e0,$c7,$84,$c6,$34,$c7,$79,$c7,$e0,$c7,$45,$c7,$08
        .byte $c6,$fe,$c7,$23,$c7,$9b,$c7,$39,$c6,$84,$c6,$e0,$c7,$19,$c6,$52
        .byte $c7,$fe,$c7,$23,$c7,$e0,$c7,$79,$c7,$fe,$c7,$0f,$c8,$00,$00,$80
        .byte $50,$08,$04,$01,$15,$15,$00,$80,$45,$15,$14,$54,$55,$55

    L_c920:
        .byte $04,$50,$40
        .byte $20,$11,$05,$15,$45,$02,$41,$14,$81,$44,$55,$55,$55,$55,$55,$55
        .byte $55,$5f,$ff,$fb,$ff,$15,$45,$45,$45,$e1,$bf,$fb,$ff,$55,$55,$55
        .byte $5f,$7e,$fb,$ff,$ff,$45,$75,$35,$ff,$ee,$ff,$ff,$ff,$55,$55,$55
        .byte $57,$ff,$ef,$ff,$ff,$ff,$ff,$af,$eb,$ea,$bc,$ff,$ff,$ff,$ef,$bb
        .byte $ff,$ff,$bf,$ff,$ff,$ff,$ef,$fa,$ff,$ff,$ef,$ff,$ff,$00,$00,$00
        .byte $00,$30,$30,$00,$00,$fb,$ee,$ff,$ff,$ef,$bb,$ff,$ff,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$9a,$9a,$9a,$9a,$6a,$6a,$6a,$6a,$00,$00,$20
        .byte $a8,$a8,$a9,$25,$00,$00,$00,$00,$24
        .fill $12, $0
        .byte $08,$24,$00,$00,$00,$00,$00,$00,$00,$90,$2a,$2a,$09,$20,$a8,$a9
        .byte $24,$00,$40,$40,$00,$00,$00,$00,$00,$00,$aa,$56,$a9,$a6,$a6,$5a
        .byte $05,$00,$aa,$55,$5a,$9a,$a6,$a9,$a9,$66,$aa,$55,$a9,$a5,$99,$65
        .byte $99,$55,$00,$00,$00,$00,$00,$00,$00,$00,$56,$16,$06,$05,$05,$05
        .byte $05,$05,$69,$5a,$95,$95,$a5,$56,$66,$65,$00,$00,$00,$00,$00,$00
        .byte $00,$00

    L_ca00:
        .fill $2a, $20
        .byte $20,$20,$00,$00,$4f,$50,$51,$52,$e3,$00,$00,$00,$00,$e8,$c5,$c6
        .byte $c7,$c8,$c9,$00,$00,$22,$23,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$55,$56,$57,$58
        .byte $52,$ea,$eb,$ec,$ed,$ee,$cb,$cc,$cd,$ce,$cf,$6b,$24,$25,$26,$00
        .byte $00,$00,$00,$00,$00,$00,$49,$00,$00,$00,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$00,$00,$5b,$5c,$5d,$5e,$ef,$f0,$f1,$f2,$f3,$f4,$d1,$d2
        .byte $d3,$d4,$d5,$d6,$27,$28,$00,$00,$00,$00,$00,$2f,$30,$31,$32,$33
        .byte $00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$61,$62,$63,$64
        .byte $64,$f6,$f7,$f8,$f9,$fa,$d7,$d8,$d9,$da,$db,$dc

    L_cab6:
        rol 

        .byte $00,$00,$00,$00,$00,$00,$34,$35,$36,$37,$38,$00,$00,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$00,$00,$67,$68,$69,$6a,$fb,$fc,$fd,$fe,$ff
        .byte $01,$dd,$de,$df,$e0,$e1,$e2,$00,$00,$0b,$0c,$0d,$0e,$0f,$39,$3a
        .byte $3b,$3c,$3d,$00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00
        .byte $6e,$6f,$70,$89,$8a,$8b,$8c,$8d,$8e,$a7,$a8,$a9,$aa,$ab,$00,$00
        .byte $00,$10,$11,$12,$13,$14,$3e,$3f,$40,$41,$42,$00,$00,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$00,$72,$73,$74,$75,$76,$8f,$90,$91,$92,$93
        .byte $94,$ad,$ae,$af,$00,$00,$00,$00,$1c,$15,$16,$17,$18,$19,$43,$44
        .byte $45,$46,$47,$48

    L_cb3b:
        .byte $00,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$77,$78,$79,$7a,$7b,$7c,$95,$96,$97,$98,$99,$9a,$b3,$bf
        .byte $b5,$00,$00,$00,$1d,$1e,$1a,$00,$00,$00,$00,$00,$49,$4a,$4b,$4c
        .byte $49,$00,$20,$20,$20,$20,$20,$20,$20,$20,$7d,$7e,$7f,$80,$81,$82
        .byte $9b,$9c,$9d,$9e,$9f,$a0,$bf,$bf,$bf,$b5,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$48,$49,$48,$00,$00,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$83,$84,$85,$86,$87,$88,$a1,$a2,$a3,$a4,$a5,$bf,$a5,$c0
        .byte $c1,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$b6,$b7,$b6,$e0,$df,$bb
        .byte $2d,$03,$bf,$bf,$06,$07,$08,$0a,$c9,$ce,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$6d,$84,$df,$a8,$21,$e1,$e2,$ce,$04,$05,$05,$09,$0a,$c9
        .byte $ce,$48,$48,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$da,$7d,$a8,$e4,$e5,$00
        .byte $00,$48,$00,$48,$48,$44,$48
        .fill $13, $0

    L_cc2c:
        .byte $20,$20,$20,$20,$20,$20
        .byte $20,$20,$b0,$b1,$b2

    L_cc37:
        .fill $1d, $0

    L_cc54:
        .fill $2a, $20
        .byte $20,$20,$59,$59,$59,$59,$99,$99,$99,$95,$11,$04,$11,$04,$01,$04
        .byte $11,$04,$52,$54,$15,$55,$14,$56,$16,$55,$20,$11,$44,$00,$05,$10
        .byte $21,$20,$18,$52,$04,$16,$44,$02,$02,$06,$aa,$95,$6a,$aa,$aa,$aa
        .byte $aa,$aa,$01,$04,$01,$04,$01,$04,$11,$05,$15,$56,$16,$54,$58,$55
        .byte $61,$40,$00,$20,$00,$54,$21,$00,$40,$90,$06,$1a,$12,$4a

    L_cccc:
        .byte $62
        .byte $4a,$12,$1a,$00,$00,$00,$00,$00,$01,$09,$05,$41,$06,$18,$10,$56
        .byte $41,$48,$90,$02,$20,$01,$90,$40,$14,$05,$51,$40,$00,$11,$06,$12
        .byte $18,$4a,$60,$62,$8a,$2a,$aa,$aa,$aa,$8a,$2a,$10,$51,$54,$15,$15
        .byte $15,$04,$04,$00,$44,$10,$00

    L_cd04:
        bvc L_cd5b

        .byte $14,$00,$00,$00,$01,$10,$40,$40,$50,$00,$42,$10,$06,$54,$11,$40
        .byte $00,$00,$aa

    L_cd19:
        rol 
        txa 

        .byte $22,$0a,$52,$05,$11,$40,$90,$90,$91,$a4,$a0,$a4,$a4,$00,$00,$10
        .byte $40,$04,$04,$01,$01,$80,$04,$40

    L_cd33:
        asl 
        jsr L_1208

        .byte $02,$00,$88,$08,$51,$16,$16,$85,$15,$04,$84,$24,$54,$15,$05,$81
        .byte $09,$a9,$a9,$89

    L_cd4b:
        lda ($89,x)
        ldy $a4
        ldy $04

        .byte $42,$52,$04,$01,$48,$48,$08,$48,$41,$51

    L_cd5b:
        ora $15,x
        lda $05
        sta $55
        eor $55,x
        eor $55,x
        eor ($54),y
        ora ($55),y
        eor $55,x

        .byte $50,$00,$00,$40,$00,$24,$85,$10,$94,$11,$80,$80,$90,$08,$44,$11
        .byte $00,$50,$04,$48,$08,$85,$15,$54,$55,$14,$95,$94,$55,$44,$10,$44
        .byte $10,$40,$10,$44,$10,$40,$50,$50,$94,$a4,$a5,$a9,$a9,$90,$a4,$84
        .byte $a1,$89,$a1,$84,$a4,$00,$08,$00,$15,$48,$00,$01,$06,$54,$95,$94
        .byte $15,$25,$55,$49,$01,$40,$10,$40,$10,$40,$10,$44,$50,$44,$66,$11
        .byte $99,$60,$42,$1a,$9a,$89,$a2,$a8

    L_cdc3:
        tax 
        tax 
        tax 
        ldx #$a8
        ora ($00,x)

    L_cdca:
         .byte $44,$90,$84

    L_cdcd:
        bit $a1
    L_cdcf:
        ora #$80
    L_cdd1:
        php 
        rti 

    L_cdd3:
         .byte $06,$01,$14
        .byte $50,$45,$41,$90,$24,$04,$95,$41,$21,$06,$00,$00,$00,$00,$00,$40
        .byte $60,$50,$aa,$a8,$a2,$88,$a0,$85,$50,$44,$81,$04,$90,$15,$44

    L_cdf5:
        ora ($00,x)

        .byte $00,$00,$00,$40,$04,$01,$01,$05,$00,$00,$11,$04,$00,$05,$55,$14
        .byte $00,$04,$45,$15,$54,$54,$54

    L_ce0e:
        bpl L_ce20

        .byte $00,$00,$54,$54,$54,$54,$54,$54,$00,$00,$a8,$a8,$a8

    L_ce1d:
        tay 
        tay 
        tay 
    L_ce20:
        eor L_5557,x

        .byte $17,$15,$15,$07,$01,$00,$14,$01,$25,$25,$00,$00,$00,$55,$55

    L_ce32:
        eor $55,x
    L_ce34:
        eor $45,x
        ora $44,x
        and ($41,x)
        eor $54

    L_ce3c:
         .byte $54,$5a,$50,$52
        .byte $10,$81,$85,$10,$40,$21,$21,$20,$6a,$6a,$62,$4a,$62,$1a,$1a,$1a
        .byte $aa,$aa,$aa,$a9,$a6,$a6,$9a,$9a,$a9,$2a,$18,$15,$00,$00,$00,$00
        .byte $55,$aa,$aa,$aa,$55,$aa,$aa,$55,$96,$95,$96,$56,$96,$95,$96,$56
        .byte $a5,$99,$9a,$96,$99,$96,$99,$a5,$56,$55,$95,$a5,$95,$65,$95,$56
        .byte $00,$00,$fc,$fc,$fc,$fc,$fc,$fc,$aa,$56,$55,$95,$a5,$95,$56,$aa
        .byte $aa,$a5,$99,$9a,$96,$99,$a5,$aa,$a9,$a9,$a9,$a9,$a4,$a4,$a4,$a4
        .byte $90,$90,$90,$90,$40,$40,$40,$40,$95,$65,$6a,$59,$66,$95,$aa,$5a
        .byte $5a,$56,$56,$96,$56,$5a,$aa,$95,$44,$66,$11,$99,$aa,$aa,$aa,$aa
        .byte $aa,$aa,$55,$00,$55,$00,$aa,$00,$96,$96,$55,$14,$55,$14,$96,$00
        .byte $55,$55,$56,$56,$5a,$5a,$6a,$6a,$56,$96,$56,$5a,$aa,$95,$66,$59
        .byte $69,$5a,$66,$95,$aa,$56,$55,$95,$44,$66,$11,$99,$84,$a2,$aa,$aa
        .byte $05,$19,$19,$19,$66,$a6,$99,$49,$00,$00,$00,$00,$01,$05,$15,$5a
        .byte $69,$66,$96,$59,$9a,$92,$a6,$a6,$40,$55,$9a,$a5,$9a,$92,$92,$6a
        .byte $00,$01,$06,$06,$05,$19,$19,$56,$66,$66,$96,$99,$99,$a5,$a6,$a9
        .byte $00,$00,$00,$00,$00,$00,$00,$01,$aa,$aa,$aa,$aa,$6a,$5a,$95,$95
        .byte $6a,$6a,$6a,$6a,$1a,$1a,$1a,$1a,$06,$06,$06,$06,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$05,$04,$06,$99,$19,$66,$56,$66,$96,$99,$91
        .byte $96,$96,$99,$95,$99,$a5,$a6,$a9,$50,$50,$64,$94,$99,$99,$a5,$a6
        .byte $00,$00,$00,$00,$01,$06,$16,$59,$20,$02,$14,$58,$52,$60,$80,$80
        .byte $55,$65,$19,$19,$04,$00,$00,$00,$55,$55,$95,$95,$a5,$a5,$a9,$a9
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$50,$50,$64,$54,$59,$59,$56,$55
        .byte $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$44,$66,$11,$98,$46,$6a,$2a,$aa
        .byte $aa,$95,$9a,$96,$99,$96,$99,$95,$aa,$55,$a9,$66,$9a,$6a,$6a,$59
        .byte $aa,$95,$6a,$9a,$9a

    L_cfb5:
        lda $50

        .byte $00,$99,$65,$96,$56,$5a,$5a,$95,$9a,$a4,$80,$90,$10,$50,$50,$50
        .byte $50,$04,$40,$01,$10,$00,$00,$04,$40,$69,$69,$69,$55

    L_cfd4:
        adc #$69
        txs 
        txs 
        rti 
        rti 
    L_cfda:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $00,$80,$40,$02,$00,$20,$12,$80,$5a,$55,$5a,$9a,$9a,$55,$56,$96
        .byte $40,$40,$40,$40,$40,$80,$80,$80,$00,$20,$10,$00,$80,$08

    L_cffe:
        .byte $04,$00,$00,$04,$00,$00
        .byte $15,$00,$00,$9a,$00,$00,$a5,$00,$00,$95,$00,$01,$9f,$00,$05,$bf
        .byte $80,$09,$9f,$40,$26,$97,$44,$14,$a5,$94,$10,$95,$a0,$20,$95,$c0
        .byte $24,$bf,$80,$04,$95,$80,$00,$a6,$00,$00,$92,$40,$02,$82,$40,$02
        .byte $40,$a0,$09,$00,$90,$09,$40,$94,$00,$40,$90,$01,$00,$04,$00,$00
        .byte $15,$00,$00,$9a,$00,$00,$a5,$00,$00,$95,$00,$01,$9f,$00,$05,$bf
        .byte $80,$09,$9f,$40,$06,$97,$40

    L_d05b:
        .byte $05,$a5,$80
        .byte $06,$95,$90,$09,$95,$d0,$01,$bf,$80,$00,$95,$80,$00

    L_d06b:
        lda $80
        asl 

        .byte $92,$40,$05,$82,$80,$04,$02,$40,$04,$02,$40,$00,$02,$40,$00,$02
        .byte $50,$01,$00,$04,$00,$00,$15,$00,$00,$9a,$00,$00,$a5,$00,$00,$95
        .byte $00,$01,$9f,$00,$01,$7f,$80,$01,$6f,$40,$02,$a7,$40,$01,$65,$80
        .byte $01,$99,$80,$02,$59,$c0,$02,$af,$80,$00,$a5,$80,$00,$26,$00,$00
        .byte $25,$00,$00,$a8,$00,$00,$64,$00,$00,$24,$00,$00,$25,$00,$00,$25
        .byte $00,$01,$00,$04,$00,$00,$15,$00,$00,$9a,$00,$00,$a5,$00,$00,$95
        .byte $00,$01,$9f,$00,$05,$bf

    L_d0d4:
        .byte $80
        .byte $09,$9f,$40,$06,$97,$40,$05,$a5,$80,$06,$95,$90,$09,$95,$d0,$01
        .byte $bf,$80,$00,$95,$40,$00

    L_d0eb:
        rol $80

        .byte $00,$92,$40,$00,$92,$50,$00

    L_d0f4:
        ldx #$50

        .byte $02,$40,$00,$02,$40,$00,$02,$50,$00

    L_d0ff:
        ora ($00,x)

        .byte $10,$00,$00,$54,$00,$00,$a6,$00,$00,$5a,$00,$00,$56,$00,$00,$f6
        .byte $40,$02,$fe,$50,$01,$f6,$60,$11,$d6,$98,$16,$5a,$14,$0a,$56,$04
        .byte $03,$56,$08,$02,$fe,$18,$02,$56,$10,$00,$9a,$00,$01,$86,$00,$01
        .byte $82,$80,$0a,$01,$80,$06,$00,$60,$16,$01,$60,$06,$01,$00,$01,$00
        .byte $10,$00,$00,$54,$00,$00,$a6,$00,$00,$5a,$00,$00,$56,$00,$00,$f6
        .byte $40,$02,$fe,$50,$01,$f6,$60,$01,$d6,$90,$02,$5a,$50,$06,$56,$90
        .byte $07,$56,$60,$02

    L_d165:
        inc $0240,x
        lsr $00,x

        .byte $02,$5a,$00,$01,$86,$a0,$02,$82,$50,$01,$80

    L_d175:
        bpl L_d177 + $1

    L_d177:
         .byte $80,$10,$01,$80,$00
        .byte $05,$80,$00,$01,$00,$10,$00,$00,$54,$00,$00,$a6,$00,$00,$5a,$00
        .byte $00,$56,$00,$00,$f6,$40,$02,$fd,$40,$01,$f9,$40,$01,$da,$80,$02
        .byte $59,$40,$02,$66,$40,$03,$65,$80,$02,$fa,$80,$02,$5a,$00,$00,$98
        .byte $00,$00,$58,$00,$00,$2a,$00,$00,$19,$00,$00,$18,$00,$00,$58,$00
        .byte $00,$58,$00,$01,$00,$10,$00,$00,$54,$00,$00,$a6,$00,$00,$5a,$00
        .byte $00,$56,$00,$00,$f6,$40,$02,$fe,$50,$01,$f6,$60,$01,$d6,$90,$02
        .byte $5a,$50,$06,$56,$90,$07,$56,$60,$02

    L_d1e5:
        inc $0140,x
        lsr $00,x

        .byte $02,$98,$00,$01,$86,$00,$05,$86,$00,$05,$8a,$00,$00,$01,$80,$00
        .byte $01,$80,$00,$05,$80,$01,$00,$04,$00,$00,$15,$04,$00,$9a,$04,$00
        .byte $a5,$04,$00,$95,$18,$01,$9f,$58,$05,$bf,$60,$19,$9f,$40,$5a,$97
        .byte $40,$60,$a5,$80,$00,$95,$80,$00,$95,$c0,$00,$bf,$91,$00,$95,$65
        .byte $04,$55,$89,$14,$62,$02,$19,$80,$00,$22,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$01,$00,$10,$00

    L_d243:
        .byte $10,$54,$00,$10,$a6,$00,$10,$5a,$00
        .byte $24,$56,$00,$25,$f6,$40,$09,$fe,$50,$01,$f6,$64,$01,$d6,$a5,$02
        .byte $5a,$09,$02,$56,$00,$03,$56,$00,$46,$fe,$00,$59,$56,$00,$62,$55
        .byte $10,$80,$89,$14,$00,$02,$64,$00,$00,$88,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$01,$09,$04,$00,$06,$15,$00,$06,$9a,$00,$06,$a5,$00
        .byte $09,$95,$00,$05,$9f,$00,$01,$bf,$80,$00,$9f,$40,$00,$97,$44,$00
        .byte $a5,$94,$00,$95,$a0,$00,$95,$c0,$00,$bf,$80,$00,$95,$80,$00,$a6
        .byte $00,$00,$92,$40,$02,$82,$40,$02,$40,$a0,$09,$00,$90,$09,$40,$94
        .byte $00,$40,$90,$01,$00,$01,$00,$00,$05,$40,$00,$26,$80,$00,$29,$40
        .byte $00,$25,$40,$00,$a7,$c0,$00,$5f,$c0,$00,$5b,$c0,$00,$66,$c0,$00
        .byte $95,$00,$00,$a6,$40,$00,$99,$50,$00,$ff,$d0,$00

    L_d2e8:
        sta $80,x

        .byte $00,$a5,$80,$0a,$92,$40,$05,$82,$80,$04,$02,$40,$04,$02,$40,$00
        .byte $02,$40,$00,$02,$50,$01

    L_d300:
        .byte $00,$10,$60,$00,$54
        .byte $90,$00

    L_d307:
        ldx $90

        .byte $00,$5a,$90,$00

    L_d30d:
        lsr $60,x

        .byte $00,$f6,$50,$02,$fe,$40,$01,$f6,$00,$11,$d6,$00,$16,$5a,$00,$0a
        .byte $56,$00,$03,$56,$00,$02,$fe,$00,$02,$56,$00,$00,$9a,$00,$01,$86
        .byte $00,$01,$82,$80,$0a,$01,$80,$06,$00,$60,$16,$01,$60,$06,$01,$00
        .byte $01,$00,$40,$00,$01,$50,$00,$02,$98,$00,$01,$68,$00,$01,$58,$00
        .byte $03,$da,$00,$03

    L_d353:
        sbc $00,x

        .byte $03,$e5,$00,$03,$99,$00,$00,$56,$00,$01,$9a,$00,$05,$66,$00,$07
        .byte $ff,$00,$02,$56,$00,$02,$5a,$00,$01,$86,$a0,$02,$82,$50,$01,$80

    L_d375:
        bpl L_d377 + $1

    L_d377:
         .byte $80,$10,$01,$80,$00
        .byte $05,$80,$00,$01,$24,$10,$00

    L_d383:
        bit $94

        .byte $00,$24,$94,$00,$28,$94,$10,$24,$94,$14,$25,$a8,$24,$06,$65,$58
        .byte $0a,$55,$58,$02,$55,$80,$02,$55,$00,$02,$55,$00,$03,$ff,$00,$16
        .byte $55,$00,$26,$56,$00,$0a,$99,$00,$09,$05,$00,$09,$09,$00,$25,$02
        .byte $80,$00,$02,$40,$00,$02,$40,$00,$02,$50,$01,$00

    L_d3c1:
        bpl L_d353

        .byte $00,$94,$90,$00,$94,$90,$24,$94,$a0,$94,$94,$90,$a8,$a8,$50,$96
        .byte $65,$60,$96,$55,$60,$0a,$55,$80,$02,$55,$00,$02,$55,$00,$03,$ff
        .byte $00,$02,$55,$50,$02,$56,$60,$01,$9a,$80,$09,$42,$40,$09,$82,$40
        .byte $0a,$02,$50,$09,$00,$00,$09,$00,$00,$25,$00,$00,$01,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$00,$24
        .byte $15,$00,$24,$9a,$00,$28,$a5,$00,$24,$95,$00,$29,$9f,$00,$05,$bf
        .byte $00,$09,$9f,$65,$02,$97,$5a,$00,$a5,$80,$00,$bf,$50,$00

    L_d431:
        sta $90,x

        .byte $00,$a6,$a0,$01,$18,$90,$09,$58,$98,$06,$a8,$94,$01

    L_d440:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $04,$00,$00,$15,$00,$00,$9a,$00,$00,$a5,$00,$00,$95,$00,$00,$9f
        .byte $00,$00,$7f,$00,$01,$5f,$80,$01,$67,$40,$02,$99,$80,$00,$56,$50
        .byte $00,$9a,$90,$00

    L_d474:
        lda $a0
        ora ($99,x)

        .byte $90,$09,$5a,$98,$06,$a8,$94,$01,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$00,$54,$18,$00,$a6,$18
        .byte $00,$5a,$28,$00,$56,$18,$00,$f6,$68,$00,$fe,$50,$59,$f6,$60,$a5
        .byte $d6,$80,$02,$5a,$00,$05,$fe,$00,$06,$56,$00,$0a,$9a,$00,$06,$24
        .byte $40,$26,$25,$60,$16,$2a,$90,$01,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$00,$54,$00,$00,$a6,$00
        .byte $00,$5a,$00,$00,$56,$00,$00,$f6,$00,$00,$fd,$00,$02,$f5,$40,$01
        .byte $d9,$40,$02,$66,$80,$05,$95,$00,$06,$a6,$00,$0a,$5a,$00,$06,$66
        .byte $40,$26,$a5,$60,$16,$2a,$90,$01
        .fill $18, $0
        .byte $05,$5a,$80,$65,$55,$55,$a5,$55,$6a,$0a,$a0,$00

    L_d524:
        .fill $1b, $0
        .byte $01,$00

    L_d541:
        .fill $17, $0
        .byte $02,$a5,$50,$55,$55,$59,$a9,$55,$5a,$00,$0a,$a0,$00

    L_d565:
        .fill $1a, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$cc,$00
        .byte $00,$0c,$c0,$03,$3c,$00,$00,$ef,$c0,$03,$bb,$30,$03,$ab,$c0,$03
        .byte $af,$c0,$03,$ab,$00,$01,$ef,$00,$01,$7c,$00,$05,$00,$00,$04

    L_d5ae:
        .fill $11, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$33,$00
        .byte $03,$30,$00,$00,$3c,$c0,$03,$fb,$00,$0c,$ee,$c0,$03,$ea,$c0,$03
        .byte $ba,$c0,$00,$ea,$c0,$00,$fb,$40,$00,$3d,$40,$00

    L_d5eb:
        .byte $00,$50,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00

    L_d5ff:
        ora ($00,x)

        .fill $15, $0
        .byte $10,$00,$00,$10,$00,$03,$d5,$50,$03,$d5,$54,$03,$da,$a0,$00,$10
        .byte $00,$00,$20
        .fill $16, $0
        .byte $01
        .fill $16, $0
        .byte $04,$00,$00,$04,$00,$05,$57,$c0,$15,$57,$c0,$0a,$a7,$c0,$00,$04
        .byte $00,$00,$08
        .fill $16, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$30,$00,$00,$70,$00

    L_d695:
        ora ($70,x)

        .byte $00,$05,$5c,$00,$05,$5c,$00,$01,$5c,$00,$00,$57,$00,$00,$13,$00
        .byte $00,$00,$c0,$00,$00,$c0,$00,$00,$30,$00,$00,$30,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$0d,$00,$00

    L_d6d6:
        ora.a $0040
        and $50,x

        .byte $00,$35,$50,$00,$35,$40,$00,$d5,$00,$00,$c4,$00,$03,$00,$00,$03
        .byte $00,$00,$0c,$00,$00,$0c,$00,$00,$00,$00,$00,$00

    L_d6f7:
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$55,$80,$00,$5d,$80,$00,$5d,$80,$00,$7f,$80,$00,$5d,$80,$00
        .byte $5d,$80,$00,$5d,$80,$00,$1e,$00,$00,$16,$00,$00,$08
        .fill $13, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$28,$00,$00,$66,$00,$02,$aa,$40
        .byte $02,$a6,$80,$02,$6a,$80,$02,$a9,$80,$03,$9a,$c0,$00

    L_d75c:
        .byte $eb,$00,$00,$ff,$80,$00,$3c,$80,$00,$02,$00,$00
        .byte $2a,$00,$00,$28,$00,$00,$a0,$00

    L_d770:
        .byte $00,$80,$00,$00,$80,$00,$00,$80,$00,$00
        .byte $20,$00,$00,$20,$00,$01,$00,$00,$00,$00,$24,$00,$00,$6a,$00,$02
        .byte $a6,$40,$02,$69,$80,$02,$9a,$80,$01,$11,$80,$01,$11,$80,$02,$ff
        .byte $40,$00,$7f,$40,$00,$76,$80,$00,$24,$80,$00,$02,$00,$00,$2a,$00
        .byte $00,$28,$00,$00,$a0,$00

    L_d7b0:
        .byte $00,$80,$00,$00,$80,$00,$00,$80,$00,$00
        .byte $20,$00,$00,$20,$00,$01,$00,$28

    L_d7c2:
        .byte $00,$00,$92,$00,$02
        .byte $11,$80,$01,$01,$80,$01,$00,$80,$02,$00,$80,$02,$00,$80,$02,$fc
        .byte $40,$03,$fc,$40

    L_d7db:
        .byte $0d,$f2,$80,$0f
        .byte $f6,$80,$0f,$e4,$80,$03,$c2,$00,$00,$2a,$00,$00,$28,$00,$00,$a0
        .byte $00

    L_d7f0:
        .byte $00,$80,$00,$00,$80,$00,$00,$80,$00,$00

    L_d7fa:
        jsr.a $0000
        jsr $0200

        .byte $00,$fc,$00,$03,$d4,$00,$03,$54,$00,$03,$68,$00,$03,$54,$00,$03
        .byte $14,$00,$00,$aa,$90,$02,$a8,$90,$02,$aa,$00,$02,$aa,$80,$02,$82
        .byte $90,$02,$a8,$10,$02,$a8,$00,$02,$80,$00,$02,$28,$00,$00,$a8,$00
        .byte $02,$88,$00,$02,$88,$00,$0a,$28,$00,$06,$28,$00,$05,$14,$00,$01
        .byte $00,$fc,$00,$03,$d4,$00,$03,$54,$00,$03,$68,$00,$03,$54,$00,$03
        .byte $14,$00,$00,$aa,$90,$02,$a8,$90,$02,$aa,$00,$02,$aa,$80,$02,$82
        .byte $90,$02,$a8,$10,$02,$a8,$00,$02,$80,$00,$02,$20,$00,$00,$a0,$00
        .byte $00,$a0,$00,$00,$a0,$00,$00,$a0,$00,$00,$a0,$00,$00,$50,$00

    L_d87f:
        ora ($00,x)

        .byte $3f,$00,$00,$17,$c0,$00,$15,$c0,$00,$29,$c0,$00,$15,$c0,$00,$14
        .byte $c0,$06,$aa,$00,$06,$2a,$80,$00,$aa,$80,$02,$aa,$80,$06,$82,$80
        .byte $04,$2a,$80,$00,$2a,$80,$00,$02,$80,$00,$28,$80,$00,$2a,$00,$00
        .byte $22,$80,$00,$22,$80,$00,$28,$a0,$00,$28,$90,$00,$14,$50,$01,$00
        .byte $3f,$00,$00,$17,$c0,$00,$15,$c0,$00,$29,$c0,$00,$15,$c0,$00,$14
        .byte $c0,$06,$aa,$00,$06,$2a,$80,$00,$aa,$80,$02,$aa,$80,$06,$82,$80
        .byte $04,$2a,$80,$00,$2a,$80,$00,$02,$80,$00,$08,$80,$00,$0a,$00,$00
        .byte $0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$05,$00,$01
        .fill $22, $0
        .byte $cc,$00,$00,$30,$00,$03,$fc,$00,$00,$f3,$00,$0c,$ff,$00,$03,$dc
        .byte $c0,$3f,$54,$fc,$33,$6b,$30,$cf,$d7,$9f,$ff,$16,$df,$01
        .fill $16, $0
        .byte $c0,$00,$00,$03,$00,$0c,$fc,$00,$0f,$d4,$c0,$03,$74,$c0,$33,$68
        .byte $00,$33,$57,$00,$03,$d7,$30,$30,$a8,$00,$02,$bb,$c0,$3f,$b8,$cc
        .byte $0e,$aa,$30,$c2,$ee,$4c,$fe,$ee,$7f,$01,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$fc,$00,$03,$d4,$00,$03,$54,$00,$03,$68,$00,$03
        .byte $54,$00,$03,$14,$00,$00,$a8,$c0,$32,$a8,$00,$02,$a8,$30,$02,$a8
        .byte $00,$32,$a8,$30,$32,$2a,$00,$02,$ae,$00,$0e,$8e,$30,$0f,$a9,$30
        .byte $0e,$b1,$00,$c2,$ec,$cc,$fe,$ec,$fc,$01
        .fill $1c, $0
        .byte $05,$00,$00,$5a,$40,$00,$66,$40,$01,$96,$40,$01,$a6,$40,$01,$99
        .byte $80,$06,$59,$80,$06,$99,$00,$06,$a6,$00,$06,$96,$00,$09,$68,$00
        .byte $02,$a0,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$80,$00
        .byte $08,$a0,$00,$17,$a0,$00,$0f,$e8,$00,$03,$e8,$00,$03,$ea,$00,$03
        .byte $ea,$00,$03,$ea

    L_da20:
        .byte $80,$00,$fa,$80,$00,$fa,$80,$00,$fa
        .byte $a0,$00,$3e,$a0,$00,$1f,$a0,$00,$10,$28,$00,$54,$08,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$01,$0c,$c2,$00,$0c,$c8,$00,$0f,$ea,$80
        .byte $03,$ea,$00,$03,$ea,$a0,$00,$ea,$80,$00,$ea,$00,$0a,$aa,$00,$22
        .byte $aa,$aa,$5f,$ff,$fa,$3f,$ff,$ff,$00,$ff,$c0,$00,$01,$00,$00,$00
        .byte $40
        .fill $15, $0
        .byte $01
        .fill $15, $0
        .byte $0a,$aa,$80,$22,$aa,$aa,$5f,$aa,$fa,$3f,$aa,$ff,$03,$ea,$80,$03
        .byte $22,$00,$00,$00,$40
        .fill $15, $0
        .byte $01
        .fill $15, $0
        .byte $0a,$aa,$80,$22,$aa,$aa,$5f,$aa,$fa,$3f,$aa,$ff,$03,$aa,$c0,$0f
        .byte $aa,$40,$0f,$ea,$00,$3f,$ea,$80,$3f,$ea,$a0,$33,$2a,$80,$03,$3a
        .byte $a0,$00,$02,$00,$00,$00,$80,$00,$00,$00,$01
        .fill $13, $0
        .byte $56,$00,$01,$a9,$00,$01,$55,$00,$02,$56,$00,$01,$aa,$80,$05,$56
        .byte $80,$05,$55,$80,$05,$56,$80,$05,$5a,$80,$05,$55,$80,$05,$56,$80
        .byte $01,$5a,$80,$01,$55,$00,$00,$56,$00,$00,$00,$00,$01
        .fill $1d, $0
        .byte $50,$00

    L_db5f:
        ora.a $0098

        .byte $2b,$28,$00,$56,$20,$00,$56,$00,$01,$5a,$80,$01,$55,$80,$02,$55
        .byte $80,$00,$96,$80,$00,$aa,$80,$00,$2a,$00,$00,$00,$00,$01
        .fill $1f, $0
        .byte $54,$00,$00,$a6,$00,$00,$5a,$00,$00,$a6,$00,$00,$56,$00,$01,$99
        .byte $80,$02,$66,$80,$01,$65,$80,$01,$a9,$80,$02,$56,$80,$01,$99,$80
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$00
        .byte $00,$05,$00,$00,$44,$40,$00,$66,$40,$00,$2b,$00,$01,$5e,$50,$00

    L_dbdf:
        adc #$40

        .byte $00,$2f,$00,$00,$44,$40,$00,$14,$00,$00,$04
        .fill $13, $0
        .byte $01,$00,$04,$00,$01,$04,$10,$00,$44,$40,$10,$40,$41,$04,$04,$04
        .byte $01,$0b,$10,$00,$3b,$80,$04,$fa,$c4,$00,$ab,$c0,$14,$ee,$c5,$00
        .byte $ab,$c0,$00,$ef,$c0,$14,$2b,$00,$00,$3f,$10,$04,$00,$04,$10,$44

    L_dc2f:
        ora ($00,x)

        .byte $44,$40,$01,$00,$40,$01,$04,$10,$00,$04,$00,$00,$00,$00,$01,$00
        .byte $04,$00,$01,$04,$10,$00,$00,$00,$10,$00

    L_dc4b:
        ora ($04,x)
        rol.a $0000

        .byte $ab,$c0,$00,$aa,$c0,$12,$af,$f0,$02,$e2,$b0,$02,$ae,$f1,$02,$88
        .byte $b0,$02,$af,$f0,$40,$ab,$c0,$00,$bb,$80,$00,$af,$f4,$10,$2f,$01
        .byte $40,$00,$00,$00,$00,$00,$01,$04,$10,$04,$04,$04,$00,$00,$00,$01
        .byte $00,$00,$00,$00,$00,$00,$00,$a8

    L_dc88:
        cpy #$00
        tax 
        cpy #$02
        tax 

        .byte $b0,$02,$ba,$f0,$0a,$ec,$bc,$0a,$8e,$bc,$0a,$f2,$bc,$0a,$f0,$fc

    L_dc9e:
        asl 

        .byte $82,$ac,$0a,$e8,$bc,$0a,$8a,$bc,$0a,$aa,$e0,$02,$bb,$f0,$02,$ae
        .byte $f0,$00,$bb,$c0,$00,$bf,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$aa,$c0,$02,$e0,$f0,$0a,$3e,$bc,$0b,$8b,$3c
        .byte $08,$f0,$ac,$2b,$30,$b3,$2f,$00,$2f,$28,$00,$a3,$23,$c0,$0f,$2f
        .byte $00,$2f,$2c,$00,$e3,$2e,$c0,$3f,$0b,$20,$8c,$0b,$b8,$bc,$08,$c3
        .byte $3c,$02,$be,$f0,$02,$88,$f0,$00,$af,$cc,$00,$00,$00,$00,$00,$00
        .byte $01,$02,$8a,$c0,$08,$ec,$30,$0b,$30,$ac,$2c,$08,$88,$20,$00,$0c
        .byte $2c,$00,$0b,$b0,$00,$03,$80,$00,$0b,$b0,$00

    L_dd1a:
        php 
        ldy $0300,x
        bit $0300
        ldy #$00
        php 
        bit L_0b00

        .byte $3c,$00,$03,$20,$00,$00,$2c,$00,$2b,$0b,$00,$20,$02,$c0,$8c,$00
        .byte $c2,$b0,$02,$a8,$c0,$00,$8f,$00,$01,$00

    L_dd41:
        .fill $1a, $0
        .byte $08,$8a,$20,$2a,$aa,$a8,$aa,$aa,$aa,$26,$66,$b8,$25,$6d,$be,$1d
        .byte $d7,$74,$15,$5f,$fc,$37,$77,$7c,$15,$55

    L_dd75:
        .byte $dc
        .byte $1d,$df,$f4,$04,$05,$30

    L_dd7c:
        .byte $00,$00,$00,$02
        .byte $01,$05,$c0,$05,$77,$c1,$06,$77,$c1,$19,$7f,$c5,$19,$bf,$c6,$19
        .byte $0c,$c6,$64,$3f,$16,$60,$c3,$3d,$63,$cc,$fe,$43,$f3,$ff,$4f,$3f
        .byte $ff,$44,$3f,$ff,$04,$3f,$f3,$0f,$0f,$f3,$0c,$0f,$f1,$00,$0f,$f1
        .byte $00

    L_ddb1:
        .byte $0f,$f3,$00,$3f,$f3,$00,$3c,$3c,$00,$70,$3c,$00,$70,$34,$00,$54
        .byte $00,$00,$a9,$00,$00,$69,$00,$00,$9a,$40,$00,$66,$40,$00,$66,$40
        .byte $00,$99,$90,$00,$99,$90,$00,$99,$90,$00,$99,$90,$00,$26,$64,$00
        .byte $26,$64,$00,$24,$44,$00,$04,$44,$00,$04

    L_ddeb:
        .fill $16, $0
        .byte $40,$04,$03,$c0,$04,$00,$c0,$0f,$00,$00,$0c

    L_de0c:
        .fill $35, $0
        .byte $06,$00,$00,$15,$80,$00,$15,$80,$01,$6a,$80

    L_de4c:
        ora ($4c,x)

        .byte $00,$05,$50,$40,$05,$51,$50,$05,$92,$60,$05,$91,$a0,$05,$99,$90
        .byte $05,$96,$50,$05,$66,$50,$09,$a9,$40,$05,$90,$20,$05,$99,$40,$05
        .byte $99,$20,$06,$9a,$50,$05,$52,$90,$01,$40

    L_de78:
        .byte $a8,$01,$40,$84,$00,$00
        .byte $08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$50,$06,$02
        .byte $60,$25,$a9,$88,$16,$59,$08,$15,$59,$f8,$15,$5a,$00,$e5,$66,$55
        .byte $f5,$56,$aa,$c9,$56,$00,$02,$5a,$48,$00,$aa,$90

    L_deaa:
        .fill $1f, $0
        .byte $05,$00,$00,$09,$80,$90,$22,$6a,$58,$20,$65,$94,$2f,$65,$54,$00
        .byte $a5,$54,$55,$99

    L_dedd:
        .byte $5b

    L_dede:
        tax 
        sta $5f,x

        .byte $00,$95,$63,$21,$a5,$80,$06,$aa
        .fill $21, $0
        .byte $14,$00,$00,$69,$00

    L_df0f:
        .byte $00
        .byte $69,$00,$01,$be,$40,$09,$be,$60,$09,$aa,$60,$09,$aa,$60,$0a,$69
        .byte $a0,$02,$69,$80,$00,$96,$00,$00,$28
        .fill $17, $0
        .byte $0c,$c0,$cc,$0c,$00,$c0,$03,$30,$33,$0b,$f0,$bf,$3b,$b3,$bb,$3e
        .byte $e3,$ee,$2e,$e2,$ee,$0a,$80,$a8,$00,$00,$00,$0c,$00,$c0,$00,$c0
        .byte $0c,$03,$00,$30,$cb,$0c,$b3,$33,$83,$38,$3e,$f3,$ef,$ee,$fe,$ef
        .byte $ff,$ef,$fe,$bb,$ae,$ba

    L_df76:
        .byte $bb,$ff,$bf,$3a,$83
        .byte $a8
        .fill $11, $0
        .byte $c0,$00,$0c,$33,$00,$00,$33,$00,$03,$3c,$30,$03,$3c,$00,$03,$fc
        .byte $c0,$00,$ff,$c0,$30,$ef,$00,$0c,$ef,$00,$0f,$ff,$30,$03,$fb,$30
        .byte $03,$bb,$c0,$03,$bb,$c0,$33,$ab,$00,$0f,$af,$30,$03,$af,$00,$00
        .byte $fc

    L_dfbe:
        .fill $24, $0
        .byte $30,$00,$00,$03,$00,$03,$30,$00,$00,$3c,$00,$03,$33,$00,$03,$f3
        .byte $00,$00,$ec,$00,$03

    L_dff7:
        .byte $fc,$00,$00,$ef,$00,$00
        .byte $ec,$00,$00

    L_e000:
        .byte $00

    L_e001:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_e007:
         .byte $00,$00,$00,$14,$14,$14

    L_e00d:
        asl L_0e06 + $8

    L_e010:
         .byte $00,$00,$00,$00,$00,$00,$3c,$3c
        .byte $28

    L_e019:
        .byte $04,$04,$04,$04,$04,$04,$00,$00,$02,$02,$02
        .byte $01,$01,$01,$00

    L_e028:
        .byte $00,$00,$04,$04,$04,$04,$04,$04,$00,$02,$02,$02

    L_e034:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_e03a:
         .byte $64,$64,$64

    L_e03d:
        ora SCREEN_BUFFER_0 + $32,y

    L_e040:
         .byte $04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02
        .byte $01,$01,$01,$00

    L_e054:
        .byte $00,$00,$14,$14,$14,$04,$04,$04,$04,$04,$04,$00,$00,$00,$00,$00

    L_e064:
        .byte $00,$00,$00,$00,$00,$00,$02,$02,$02

    L_e06d:
        ora ($01,x)
        ora ($04,x)

    L_e071:
         .byte $04,$04,$04,$04,$04,$20,$20,$20,$80,$80,$80,$00,$00,$00,$00,$00

    L_e081:
        .byte $00,$1f,$80

    L_e084:
        ldy #$c8
    L_e086:
        rti 
    L_e087:
        rti 
    L_e088:
        rti 

    L_e089:
         .byte $00,$00,$00,$00,$00,$00

    L_e08f:
        ora #$08
        ora #$69
        and #$49
    L_e095:
        php 
        php 
        ora ($01,x)
        ora ($01,x)

    L_e09b:
         .byte $07,$07,$02

    L_e09e:
        ora ($01,x)
    L_e0a0:
        ora ($01,x)

    L_e0a2:
         .byte $00,$00,$00,$00,$00,$00,$00,$04,$04,$04,$00,$00,$00,$00,$00,$00

    L_e0b2:
        .byte $00,$00,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00

    L_e0c3:
        ora ($01,x)
    L_e0c5:
        ora ($00,x)

    L_e0c7:
         .byte $00,$00,$02,$02,$00,$00,$00,$00,$00,$00

    L_e0d1:
        jsr L_e99b
        jsr L_e0e4
        jsr L_e9a9
        jsr L_e0e4
        jsr L_e9b9
        jsr L_e0e4
        rts 


    L_e0e4:
        ldx L_e0b2 + $5
        lda L_e09b
        and L_e0a2 + $4
        beq L_e141
        lda L_e000
        and L_e0a2 + $4
        beq L_e141
        lda L_e0a2,x
        bne L_e141
        lda L_e019 + $3,x
        beq L_e107
        dec L_e019 + $3,x
        jmp L_e141
    L_e107:
        dec $e004,x
        bne L_e141
        lda L_e001,x
        sta $e004,x
        jsr L_e120
        cmp L_e00d,x
        bcc L_e141
        jsr L_e134
        jmp L_e141
    L_e120:
        clc 
        lda $e098,x
        adc L_e010 + $6,x
        sta $e098,x
        lda L_e095,x
        adc L_e010 + $3,x
        sta L_e095,x
        rts 


    L_e134:
        lda L_e007 + $3,x
        sta $e098,x
        lda L_e007,x
        sta L_e095,x
        rts 


    L_e141:
        lda L_e09b
        and L_e0a2 + $4
        beq L_e15e
        lda L_e028 + $8
        and L_e0a2 + $4
        beq L_e15e
        lda L_e0a2,x
        bne L_e1d5
        lda L_e040,x
        beq L_e161
        dec L_e040,x
    L_e15e:
        jmp L_e1d5
    L_e161:
        dec L_e034,x
        bne L_e1d5
        jsr L_e16c
        jmp L_e1d5
    L_e16c:
        lda L_e028 + $9,x
        sta L_e034,x
        lda L_e040 + $9,x
        bne L_e180
        jsr L_e1c8
        lda #$01
        sta L_e040 + $9,x
        rts 


    L_e180:
        cmp #$01
        bne L_e19d
        clc 
        lda L_e040 + $6,x
        adc L_e03a,x
        sta L_e089 + $3,x
        lda L_e040 + $3,x
        adc $e037,x
        sta L_e089,x
        lda #$02
        sta L_e040 + $9,x
        rts 


    L_e19d:
        cmp #$02
        bne L_e1aa
        jsr L_e1c8
        lda #$03
        sta L_e040 + $9,x
        rts 


    L_e1aa:
        cmp #$03
        beq L_e1af
        rts 


    L_e1af:
        sec 
        lda L_e040 + $6,x
        sbc L_e03a,x
        sta L_e089 + $3,x
        lda L_e040 + $3,x
        sbc $e037,x
        sta L_e089,x
        lda #$00
        sta L_e040 + $9,x
        rts 


    L_e1c8:
        lda L_e040 + $6,x
        sta L_e089 + $3,x
        lda L_e040 + $3,x
        sta L_e089,x
        rts 


    L_e1d5:
        lda L_e09b
        and L_e0a2 + $4
        beq L_e23c
        lda L_e064 + $5
        and L_e0a2 + $4
        beq L_e23c
        lda L_e0a2,x
        bne L_e23c
        lda L_e071 + $2,x
        beq L_e1f5
        dec L_e071 + $2,x
        jmp L_e23c
    L_e1f5:
        dec L_e06d,x
        bne L_e23c
        jsr L_e200
        jmp L_e23c
    L_e200:
        lda L_e064 + $6,x
        sta L_e06d,x
        lda L_e071 + $b,x
        bne L_e22c
        lda #$01
        sta L_e071 + $b,x
        lda L_e071 + $e,x
        and #$01
        ora L_e071 + $5,x
    L_e218:
        cpx #$00
        bne L_e220
        sta sVoc1Control
        rts 


    L_e220:
        cpx #$01
        bne L_e228
        sta sVoc2Control
        rts 


    L_e228:
        sta sVoc3Control
        rts 


    L_e22c:
        lda #$00
        sta L_e071 + $b,x
        lda L_e071 + $e,x
        and #$01
        ora L_e071 + $8
        jmp L_e218
    L_e23c:
        rts 


    L_e23d:
        lda L_e09b
        and #$01
        beq L_e250
        ldx #$00
        ldy #$00
        lda L_e0a2,x
        bne L_e250
        jsr L_e277
    L_e250:
        lda L_e09b
        and #$02
        beq L_e263
        ldx #$01
        ldy #$07
        lda L_e0a2,x
        bne L_e263
        jsr L_e277
    L_e263:
        lda L_e09b
        and #$04
        beq L_e276
        ldx #$02
        ldy #$0e
        lda L_e0a2,x
        bne L_e276
        jsr L_e277
    L_e276:
        rts 


    L_e277:
        lda L_e089,x
        sta sVoc1FreqHi,y
        lda L_e089 + $3,x
        sta sVoc1FreqLo,y
        lda L_e095,x
        sta sVoc1PWidthHi,y
        lda $e098,x
        sta sVoc1PWidthLo,y
        lda L_e08f,x
        sta sVoc1AttDec,y
        lda $e092,x
        sta sVoc1SusRel,y
        rts 


    L_e29c:
        dec L_e09e
        beq L_e2a2
        rts 


    L_e2a2:
        lda L_e09b + $2
        sta L_e09e
        lda L_e09b + $1
        and #$01
        bne L_e2b2
        jmp L_e332
    L_e2b2:
        ldy #$00
        jsr L_e99b
        lda $f0
        sta $f6
        lda $f1
        sta $f7
        jsr L_e4c3
        bcs L_e332
        beq L_e2c9
        jmp L_e332
    L_e2c9:
        lda ($f0),y
        bne L_e2d3
        jsr L_e53e
        jmp L_e2b2
    L_e2d3:
        cmp #$f0
        bcc L_e2e7
        iny 
        lda ($f0),y
        sta L_e0c3
        dey 
        lda ($f0),y
        iny 
        jsr L_e5bf
        jmp L_e325
    L_e2e7:
        cmp #$c8
        bcc L_e2f1
        jsr L_e6d9
        jmp L_e2b2
    L_e2f1:
        sta $e09f
        iny 
        lda ($f0),y
        beq L_e30c
        jsr L_e443
        jsr L_e491
        jsr L_e4fc
        lda L_e09b
        and #$01
        bne L_e30c
        jmp L_e324
    L_e30c:
        txa 
        pha 
        ldx L_e086
        stx sVoc1Control
        stx L_e071 + $e
        lda ($f0),y
        beq L_e322
        inx 
        stx sVoc1Control
        stx L_e071 + $e
    L_e322:
        pla 
        tax 
    L_e324:
        nop 
    L_e325:
        iny 
        clc 
        tya 
        adc $f0
        sta $f0
        lda $f1
        adc #$00
        sta $f1
    L_e332:
        lda L_e09b + $1
        and #$02
        bne L_e33c
        jmp L_e3bc
    L_e33c:
        ldy #$00
        jsr L_e9a9
    L_e341:
        lda $f2
        sta $f6
        lda $f3
        sta $f7
        jsr L_e4c3
        bcs L_e3bc
        beq L_e353
        jmp L_e3bc
    L_e353:
        lda ($f2),y
        bne L_e35d
        jsr L_e53e
        jmp L_e332
    L_e35d:
        cmp #$f0
        bcc L_e371
        iny 
        lda ($f2),y
        sta $e0c4
        dey 
        lda ($f2),y
        iny 
        jsr L_e5bf
        jmp L_e3af
    L_e371:
        cmp #$c8
        bcc L_e37b
        jsr L_e6d9
        jmp L_e332
    L_e37b:
        sta L_e0a0
        iny 
        lda ($f2),y
        beq L_e396
        jsr L_e443
        jsr L_e491
        jsr L_e4fc
        lda L_e09b
        and #$02
        bne L_e396
        jmp L_e3ae
    L_e396:
        txa 
        pha 
        ldx L_e087
        stx sVoc2Control
        stx L_e071 + $f
        lda ($f2),y
        beq L_e3ac
        inx 
        stx sVoc2Control
        stx L_e071 + $f
    L_e3ac:
        pla 
        tax 
    L_e3ae:
        nop 
    L_e3af:
        iny 
        clc 
        tya 
        adc $f2
        sta $f2
        lda $f3
        adc #$00
        sta $f3
    L_e3bc:
        lda L_e09b + $1
        and #$04
        bne L_e3c4
        rts 


    L_e3c4:
        ldy #$00
        jsr L_e9b9
        lda $f4
        sta $f6
        lda $f5
        sta $f7
        jsr L_e4c3
        bcs L_e3d8
        beq L_e3d9
    L_e3d8:
        rts 


    L_e3d9:
        lda ($f4),y
        bne L_e3e3
        jsr L_e53e
        jmp L_e3bc
    L_e3e3:
        cmp #$f0
        bcc L_e3f7
        iny 
        lda ($f4),y
        sta L_e0c5
        dey 
        lda ($f4),y
        iny 
        jsr L_e5bf
        jmp L_e435
    L_e3f7:
        cmp #$c8
    L_e3f9:
        bcc L_e401
        jsr L_e6d9
        jmp L_e3bc
    L_e401:
        sta $e0a1
        iny 
        lda ($f4),y
        beq L_e41c
        jsr L_e443
        jsr L_e491
        jsr L_e4fc
        lda L_e09b
        and #$04
        bne L_e41c
        jmp L_e434
    L_e41c:
        txa 
        pha 
        ldx L_e088
        stx sVoc3Control
        stx L_e081
        lda ($f4),y
        beq L_e432
        inx 
        stx sVoc3Control
        stx L_e081
    L_e432:
        pla 
        tax 
    L_e434:
        nop 
    L_e435:
        iny 
        clc 
        tya 
        adc $f4
        sta $f4
        lda $f5
        adc #$00
        sta $f5
        rts 


    L_e443:
        sta L_e0a2 + $b
        and #$0f
        asl 
        stx L_e0a2 + $a
        tax 
        lda L_e4a4,x
        sta L_e0a2 + $5
        inx 
        lda L_e4a4,x
        sta L_e0a2 + $6
        lda L_e0a2 + $b
        and #$70
        lsr 
        lsr 
        lsr 
        lsr 
        cmp #$05
        beq L_e48d
        bcc L_e47e
        clc 
        asl L_e0a2 + $6
        rol L_e0a2 + $5
        cmp #$06
        beq L_e48d
        clc 
        asl L_e0a2 + $6
        rol L_e0a2 + $5
        jmp L_e48d
    L_e47e:
        tax 
        lda L_e4be,x
        tax 
    L_e483:
        clc 
        lsr L_e0a2 + $5
        ror L_e0a2 + $6
        dex 
        bpl L_e483
    L_e48d:
        ldx L_e0a2 + $a
        rts 


    L_e491:
        lda L_e0a2 + $5
        sta L_e089,x
        sta L_e040 + $3,x
        lda L_e0a2 + $6
        sta L_e089 + $3,x
        sta L_e040 + $6,x
        rts 



    L_e4a4:
         .byte $00,$00
        .byte $21,$87,$23,$86,$25,$a2,$27,$df,$2a,$3e,$2c,$c1,$2f,$6b,$32,$3c
        .byte $35,$39,$38,$63,$3b,$be,$3f,$4b

    L_e4be:
        .byte $04,$03,$02
        .byte $01,$00

    L_e4c3:
        lda L_e0a2,x
        beq L_e4cd
        jsr L_e5bf
        sec 
        rts 


    L_e4cd:
        dec $e09f,x
        lda L_e09b
        and L_e0a2 + $4
        beq L_e4f7
        lda $e09f,x
        cmp L_e0a2 + $7,x
        beq L_e4e5
        bcc L_e4e5
        jmp L_e4f7
    L_e4e5:
        lda L_e086,x
        stx L_e0a2 + $a
        ldx L_e0a2 + $3
        sta sVoc1Control,x
        ldx L_e0a2 + $a
        sta L_e071 + $e,x
    L_e4f7:
        lda $e09f,x
        clc 
        rts 


    L_e4fc:
        lda L_e028 + $2,x
        sta L_e028 + $5,x
        lda #$00
        sta $e027,x
        lda L_e019,x
        sta L_e019 + $3,x
        lda L_e019 + $6
        and L_e0a2 + $4
        beq L_e521
        lda L_e007,x
        sta L_e095,x
        lda L_e007 + $3,x
        sta $e098,x
    L_e521:
        lda L_e03d,x
        sta L_e040,x
        lda L_e054 + $5,x
        sta L_e054 + $8,x
        lda $e070,x
        sta L_e071 + $2,x
        lda #$00
        sta L_e071 + $b,x
        lda #$01
        sta L_e064 + $4
        rts 


    L_e53e:
        lda L_e0a2 + $f,x
        sta $f8
        lda L_e0a2 + $c,x
        sta $f9
        ldy L_e0b2 + $2,x
        lda ($f8),y
        cpx #$00
        bne L_e565
        sta $f0
        iny 
        lda ($f8),y
        bne L_e560
        ldy #$00
        sty L_e0b2 + $2
        jmp L_e53e
    L_e560:
        sta $f1
        jmp L_e58e
    L_e565:
        cpx #$01
        bne L_e57d
        sta $f2
        iny 
        lda ($f8),y
        bne L_e578
        ldy #$00
        sty L_e0b2 + $3
        jmp L_e53e
    L_e578:
        sta $f3
        jmp L_e58e
    L_e57d:
        sta $f4
        iny 
        lda ($f8),y
        bne L_e58c
        ldy #$00
        sty L_e0b2 + $4
        jmp L_e53e
    L_e58c:
        sta $f5
    L_e58e:
        iny 
        tya 
        sta L_e0b2 + $2,x
        lda #$01
        sta $e09f,x
        rts 


    L_e599:
        jsr L_e443
        ldx L_e0b2 + $5
        lda L_e0a2 + $6
        sta L_e064 + $1,x
        lda L_e0a2 + $5
        sta L_e054 + $e,x
        cmp L_e089,x
        bcc L_e5b9
        beq L_e5b9
        lda #$01
        sta L_e054 + $b,x
        bne L_e5be
    L_e5b9:
        lda #$00
        sta L_e054 + $b,x
    L_e5be:
        rts 


    L_e5bf:
        sta L_e0b2 + $6
        sty L_e0c7 + $4
        ldx L_e0b2 + $5
        lda L_e0a2,x
        beq L_e5d0
        jmp L_e668
    L_e5d0:
        lda #$00
        sta L_e089,x
        sta L_e040 + $3,x
        sta L_e089 + $3,x
        sta L_e040 + $6,x
        lda L_e0b2 + $6
        sec 
        sbc #$f0
        sta L_e0a2,x
        sta L_e0b2 + $7,x
        inc L_e0a2,x
        lda L_e0a2,x
        sta L_e0c7 + $5,x
        clc 
        asl L_e0b2 + $7,x
        lda L_e0b2 + $7,x
        tax 
        lda L_e9c9,x
        sta $fa
    L_e600:
        inx 
        lda L_e9c9,x
        sta $fb
        ldy #$00
        ldx L_e0a2 + $3
        lda L_e09b
        and L_e0a2 + $4
        beq L_e668
        lda ($fa),y
        sta sVoc1AttDec,x
        iny 
        lda ($fa),y
        sta sVoc1SusRel,x
        iny 
        lda ($fa),y
        sta sVoc1PWidthHi,x
        iny 
        lda ($fa),y
        sta sVoc1PWidthLo,x
        iny 
        lda ($fa),y
        beq L_e638
        lda L_e0a2 + $4
        ora L_e081 + $2
        sta sFiltControl
    L_e638:
        iny 
        lda ($fa),y
        sta sVoc1Control,x
        clc 
        adc #$01
        sta sVoc1Control,x
        iny 
        lda ($fa),y
        sta sVoc1FreqHi,x
        iny 
        lda ($fa),y
        sta sVoc1FreqLo,x
        ldx L_e0b2 + $5
        lda $fa
        sta L_e0b2 + $e,x
        lda $fb
        sta L_e0b2 + $b,x
        iny 
        tya 
        sta $e0c6,x
        dec L_e0c3,x
        jmp L_e6d5
    L_e668:
        ldx L_e0b2 + $5
        dec L_e0c3,x
        bne L_e6d5
        lda #$00
        sta L_e0a2,x
        lda #$01
        sta $e09f,x
        jmp L_e6a0
    L_e67d:
        ldx L_e0b2 + $5
        lda L_e09b
        and L_e0a2 + $4
        beq L_e6d5
        lda L_e0c7 + $5,x
        beq L_e6d5
        ldy $e0c6,x
        lda L_e0b2 + $e,x
        sta $fa
        lda L_e0b2 + $b,x
        sta $fb
        lda ($fa),y
        cmp #$ff
        bne L_e6bb
    L_e6a0:
        lda L_e0a2 + $4
        and L_e081 + $2
        bne L_e6b3
        lda L_e0a2 + $4
        eor #$ff
        and L_e081 + $2
        sta sFiltControl
    L_e6b3:
        lda #$00
        sta L_e0c7 + $5,x
        jmp L_e6d5
    L_e6bb:
        ldx L_e0a2 + $3
        sta sVoc1Control,x
        iny 
        lda ($fa),y
        sta sVoc1FreqHi,x
        iny 
        lda ($fa),y
        sta sVoc1FreqLo,x
        iny 
        ldx L_e0b2 + $5
        tya 
        sta $e0c6,x
    L_e6d5:
        ldy L_e0c7 + $4
        rts 


    L_e6d9:
        sta L_e0b2 + $6
        iny 
        lda L_e0b2 + $6
        sec 
        sbc #$c8
        clc 
        asl 
        tax 
        lda L_e71d,x
        sta L_e0c7 + $8
        inx 
        lda L_e71d,x
        sta L_e0c7 + $9
        ldx L_e0b2 + $5
        bne L_e703
        lda $f0
        sta $fa
        lda $f1
        sta $fb
    L_e700:
        jmp (L_e0c7 + $8)
    L_e703:
        cpx #$01
        bne L_e712
        lda $f2
        sta $fa
        lda $f3
        sta $fb
        jmp (L_e0c7 + $8)
    L_e712:
        lda $f4
        sta $fa
        lda $f5
        sta $fb
        jmp (L_e0c7 + $8)

    L_e71d:
         .byte $4b,$e7,$5b,$e7,$63,$e7,$6b,$e7,$73,$e7,$7b,$e7,$89,$e7,$af,$e7
        .byte $f1,$e7,$0b,$e8,$31,$e8,$60,$e8,$86,$e8,$a0,$e8,$af,$e8,$be,$e8
        .byte $c2,$e8,$d1,$e8

    L_e741:
        .byte $e3
        .byte $e8,$eb,$e8,$ff,$e8,$19,$e9,$24,$e9,$ad,$82,$e0,$29,$f0,$11,$fa
        .byte $8d,$18,$d4,$8d,$82,$e0,$4c,$30,$e9,$b1,$fa,$8d,$9d,$e0,$4c,$30
        .byte $e9,$b1,$fa,$9d,$8f,$e0,$4c,$30,$e9,$b1,$fa,$9d,$92,$e0,$4c,$30
        .byte $e9,$b1,$fa,$9d,$86,$e0,$4c,$30,$e9,$b1,$fa,$9d,$95,$e0,$c8,$b1
        .byte $fa,$9d,$98,$e0,$4c,$30,$e9,$ad,$a6,$e0,$0d,$83,$e0,$8d,$83,$e0
        .byte $8d,$17,$d4,$b1,$fa,$0d,$82,$e0,$8d,$82,$e0,$8d,$18,$d4,$c8,$b1
        .byte $fa,$8d,$16,$d4,$c8,$b1,$fa

    L_e7a9:
        sta sFiltFreqLo
        jmp L_e930
        lda L_e0a2 + $4
        ora L_e000
        sta L_e000
        lda ($fa),y
        sta L_e001,x
        iny 
        lda ($fa),y
        sta L_e019,x
        sta L_e019 + $3,x
        iny 
        lda ($fa),y
        sta L_e010 + $3,x
        iny 
        lda ($fa),y
        sta L_e010 + $6,x
        iny 
        lda ($fa),y
        bne L_e7e5
        lda L_e0a2 + $4
        eor #$ff
        and L_e019 + $6
        sta L_e019 + $6
        jmp L_e930
    L_e7e5:
        lda L_e0a2 + $4
        ora L_e019 + $6
        sta L_e019 + $6
        jmp L_e930
        lda L_e0a2 + $4
        ora L_e019 + $7
        sta L_e019 + $7
        lda ($fa),y
        sta L_e019 + $8,x
        iny 
        lda ($fa),y
        sta L_e028 + $2,x
        sta L_e028 + $5,x
        jmp L_e930
        lda L_e0a2 + $4
        ora L_e028 + $8
        sta L_e028 + $8
        lda ($fa),y
        sta L_e028 + $9,x
        iny 
        lda ($fa),y
        sta L_e03d,x
        sta L_e040,x
        iny 
        lda ($fa),y
        sta $e037,x
        iny 
        lda ($fa),y
        sta L_e03a,x
        jmp L_e930
        lda L_e0a2 + $4
        ora L_e040 + $c
        sta L_e040 + $c
        lda ($fa),y
        sta L_e054 + $5,x
        sta L_e054 + $8,x
        iny 
        lda ($fa),y
        jsr L_e443
        ldx L_e0b2 + $5
        lda L_e0a2 + $5
        sta L_e089,x
        lda L_e0a2 + $6
        sta L_e089 + $3,x
        iny 
        lda ($fa),y
        jsr L_e599
        jmp L_e930
        lda L_e0a2 + $4
        ora L_e064 + $5
        sta L_e064 + $5
        lda ($fa),y
        sta L_e064 + $6,x
        iny 
        lda ($fa),y
        sta $e070,x
        sta L_e071 + $2,x
        iny 
        lda ($fa),y
        sta L_e071 + $5,x
        iny 
        lda ($fa),y
        sta L_e071 + $8,x
        jmp L_e930
        lda L_e0a2 + $4
        eor #$ff
        and L_e000
        sta L_e000
        lda L_e0a2 + $4
        eor #$ff
        and L_e019 + $6
        sta L_e019 + $6
        dey 
        jmp L_e930
        lda L_e0a2 + $4
        eor #$ff
        and L_e019 + $7
        sta L_e019 + $7
        dey 
        jmp L_e930
        lda L_e0a2 + $4
        eor #$ff
        and L_e028 + $8
        sta L_e028 + $8
        dey 
        jmp L_e930
    L_e8be:
        dey 
        jmp L_e930
        lda L_e0a2 + $4
        eor #$ff
        and L_e064 + $5
        sta L_e064 + $5
        dey 
        jmp L_e930
        lda L_e0a2 + $4
        eor #$ff
        and L_e081 + $2
        sta L_e081 + $2
        sta sFiltControl
        dey 
        jmp L_e930
        lda ($fa),y
        sta L_e0a2 + $7,x
        jmp L_e930
        lda ($fa),y
        sta L_e040 + $d,x
        iny 
        lda ($fa),y
        sta $e053,x
        iny 
        lda ($fa),y
        sta L_e054 + $2,x
        jmp L_e930
        lda ($fa),y
        sta L_e007,x
        iny 
        lda ($fa),y
        sta L_e007 + $3,x
        iny 
        lda ($fa),y
        sta L_e00d,x
        iny 
        lda ($fa),y
        sta L_e010,x
        jmp L_e930
        lda ($fa),y
        sta L_e0c7 + $2
        sta L_e0c7 + $3
        jmp L_e930
        lda #$00
        sta L_e09b + $1
        sta L_e09b
        dey 
        jmp L_e930
    L_e930:
        lda #$01
        ldx L_e0b2 + $5
        sta $e09f,x
        clc 
        iny 
        tya 
        adc $fa
        sta $fa
        lda $fb
        adc #$00
        sta $fb
        ldx L_e0b2 + $5
        bne L_e953
        lda $fa
        sta $f0
        lda $fb
        sta $f1
        rts 


    L_e953:
        cpx #$01
        bne L_e960
        lda $fa
        sta $f2
        lda $fb
        sta $f3
        rts 


    L_e960:
        lda $fa
        sta $f4
        lda $fb
        sta $f5
        rts 


        adc #$00
        sta $f5
        rts 


    L_e96e:
        jsr L_e29c
        jsr L_e23d
        jsr L_e0d1
        jsr L_e23d
        dec L_e0c7 + $3
        bne L_e997
        lda L_e0c7 + $2
        sta L_e0c7 + $3
        jsr L_e99b
        jsr L_e67d
        jsr L_e9a9
        jsr L_e67d
        jsr L_e9b9
        jsr L_e67d
    L_e997:
        jsr L_ea0e
        rts 


    L_e99b:
        ldx #$00
        stx L_e0b2 + $5
        stx L_e0a2 + $3
        lda #$01
        sta L_e0a2 + $4
        rts 


    L_e9a9:
        ldx #$01
        stx L_e0b2 + $5
        lda #$07
        sta L_e0a2 + $3
        lda #$02
        sta L_e0a2 + $4
        rts 


    L_e9b9:
        ldx #$02
        stx L_e0b2 + $5
        lda #$0e
        sta L_e0a2 + $3
        lda #$04
        sta L_e0a2 + $4
        rts 



    L_e9c9:
         .byte $cf
        .byte $e9,$cf,$e9,$cf,$e9,$09,$49,$00,$00,$00,$80,$14,$00,$81,$14,$00
        .byte $81,$64,$00,$81,$14,$00,$81,$64,$00,$81,$14,$00,$81,$64,$00,$81
        .byte $14,$00,$81,$64,$00,$81,$14,$00,$81,$64,$00,$81,$14,$00,$81,$64

    L_e9fa:
        .byte $00,$80,$14,$00,$80,$64,$00,$80,$14,$00,$ff,$00,$00,$00,$00,$00

    L_ea0a:
        .byte $00,$00,$00,$00

    L_ea0e:
        lda L_e9fa + $c
        bne L_ea1c
        lda L_e9fa + $d
        beq L_ea1b
        jmp L_eae5
    L_ea1b:
        rts 


    L_ea1c:
        clc 
        asl 
        sta L_e9fa + $d
        tax 
        lda L_eb56,x
        sta $fc
        inx 
        lda L_eb56,x
        sta $fd
        ldy #$00
        sty L_e9fa + $c
        lda #$fe
        and L_e09b
        sta L_e09b
        lda ($fc),y
        sta L_ea0a + $2
        sta L_ea0a + $3
        iny 
        lda ($fc),y
        sta sVoc1AttDec
        iny 
        lda ($fc),y
        sta sVoc1SusRel
        iny 
        lda ($fc),y
        sta sVoc1PWidthHi
        iny 
        lda ($fc),y
        sta sVoc1PWidthLo
        lda #$00
        sta sVoc1Control
        iny 
        lda ($fc),y
        beq L_ea7e
        sta sFiltControl
        iny 
        lda ($fc),y
        and #$f0
        ora L_e081 + $1
        sta sFiltMode
        iny 
        lda ($fc),y
        sta sFiltFreqHi
        iny 
        lda ($fc),y
        sta sFiltFreqLo
    L_ea7e:
        iny 
        lda ($fc),y
        beq L_eaa8
        iny 
        lda ($fc),y
        sta sVoc2AttDec
        iny 
        lda ($fc),y
        sta sVoc2SusRel
        iny 
        lda ($fc),y
        sta sVoc2PWidthHi
        iny 
        lda ($fc),y
        sta sVoc2PWidthLo
        lda #$00
        sta sVoc2Control
        lda #$01
        sta L_ea0a + $1
        jmp L_eaad
    L_eaa8:
        lda #$00
        sta L_ea0a + $1
    L_eaad:
        iny 
        lda ($fc),y
        sta sVoc1Control
        iny 
        lda ($fc),y
        sta sVoc1FreqHi
        iny 
        lda ($fc),y
        sta sVoc1FreqLo
        lda L_ea0a + $1
        beq L_ead6
        iny 
        lda ($fc),y
        sta sVoc2Control
        iny 
        lda ($fc),y
        sta sVoc2FreqHi
        iny 
        lda ($fc),y
        sta sVoc2FreqLo
    L_ead6:
        iny 
        sty L_e9fa + $e
        lda $fc
        sta L_e9fa + $f
        lda $fd
        sta L_ea0a
        rts 


    L_eae5:
        dec L_ea0a + $3
        beq L_eaeb
    L_eaea:
        rts 


    L_eaeb:
        lda L_ea0a + $2
        sta L_ea0a + $3
        ldy L_e9fa + $e
        lda L_e9fa + $f
        sta $fc
        lda L_ea0a
        sta $fd
    L_eafe:
        lda ($fc),y
        cmp #$ff
        bne L_eb2d
        lda #$03
        ora L_e09b
        sta L_e09b
        lda L_e081 + $1
        sta sFiltMode
        lda L_e081 + $2
        sta sFiltControl
        lda L_e084
        sta sFiltFreqHi
        lda $e085
        sta sFiltFreqLo
        lda #$00
        sta L_e9fa + $c
        sta L_e9fa + $d
        rts 


    L_eb2d:
        sta sVoc1Control
        iny 
        lda ($fc),y
        sta sVoc1FreqHi
        iny 
        lda ($fc),y
        sta sVoc1FreqLo
        lda L_ea0a + $1
        beq L_eb53
        iny 
        lda ($fc),y
        sta sVoc2Control
        iny 
        lda ($fc),y
        sta sVoc2FreqHi
        iny 
        lda ($fc),y
        sta sVoc2FreqLo
    L_eb53:
        jmp L_ead6

    L_eb56:
         .byte $70,$eb,$70,$eb
        .byte $96,$eb,$e6,$eb,$37,$ec,$58,$ec,$7e,$ec,$aa,$ec,$09,$ed,$3e,$ed
        .byte $94,$ed,$e1,$ed,$0d,$ee,$08,$00,$cf,$00,$6e,$00,$00,$41,$04,$3c

    L_eb7a:
        eor ($04,x)

        .byte $3c,$41,$04,$3c,$41,$04,$3c,$41,$04,$3c,$41,$04,$3c,$41,$04,$3c
        .byte $41,$04,$3c,$41,$04,$3c,$40,$04,$3c,$ff,$04,$00,$cf,$00,$6e,$00
        .byte $00,$41,$07,$fa,$41,$07,$fa,$41,$07,$c8,$41,$07,$96,$41,$07,$64
        .byte $41,$07,$32,$41,$07,$00,$41,$06,$fa,$41,$06,$c8,$41,$06,$96,$41
        .byte $06,$64,$41,$06,$32,$41,$06,$00,$41,$05,$fa,$41,$05,$c8,$41,$05
        .byte $96,$41,$05,$64,$41,$05,$32,$41,$05,$00,$41,$04,$c8,$41,$04,$96
        .byte $41,$04,$64,$40,$04,$3c,$40,$04,$3c,$ff,$04,$00,$cf,$00,$6e,$00
        .byte $00,$41,$04,$3c,$41,$04,$64,$41,$04,$96,$41,$04,$c8,$41,$04,$fa
        .byte $41,$05,$00,$41,$05,$32,$41,$05,$64,$41,$05,$96,$41,$05,$c8,$41
        .byte $05,$fa,$41,$06,$00,$41,$06,$32,$41,$06,$64,$41,$06,$96,$41,$06
        .byte $c8,$41,$06,$fa,$41,$07,$00,$41,$07,$32,$41,$07,$64,$41,$07,$96
        .byte $41,$07,$c8,$41,$07,$fa,$40,$07,$fa,$ff,$ff,$08,$00,$cf,$00,$6e
        .byte $00,$00,$41,$07,$fa,$41,$07,$fa,$41,$07,$fa,$41,$07,$fa,$41,$07
        .byte $fa,$41,$07,$fa,$41,$07,$fa,$40,$07,$fa,$ff,$ff

    L_ec58:
        ora $09

        .byte $89,$00,$00,$f1,$10,$c8,$c8,$00,$81,$14,$00,$81,$14,$00,$80,$14
        .byte $00,$80,$14,$00,$80,$14,$00,$80,$14,$00,$80,$14,$00,$80,$14,$00
        .byte $80,$14,$00,$ff,$06,$09,$8a,$00,$00,$f1,$10,$b4,$b4,$00,$81,$07
        .byte $00,$81,$07,$00,$80,$07,$00,$80,$07,$00,$80,$07,$00,$80,$07,$00
        .byte $80,$07,$00,$80,$07,$00,$80,$07,$00,$80,$07,$00,$80,$00,$00,$ff
        .byte $02,$09,$e9,$01,$01,$00,$00,$11,$fa,$00,$11,$f5,$00,$11,$f0,$00
        .byte $11,$eb,$00,$11,$e6,$00,$11,$e1,$00,$11,$dc,$00,$11,$d7,$00,$11
        .byte $d2,$00,$11,$cd,$00,$11,$c8,$00,$11,$c3,$00,$11,$be,$00,$11,$b9
        .byte $00,$11,$b4,$00,$11,$af,$00,$11,$aa,$00,$11,$a5,$00,$11,$a0,$00
        .byte $11,$9b,$00,$11,$96,$00,$11,$91,$00,$11,$8c,$00,$11,$87,$00,$11
        .byte $82

    L_ecfb:
        .byte $00,$10,$7d,$00
        .byte $10,$78

    L_ed01:
        .byte $00,$10,$76,$00,$10,$00,$00,$ff,$03,$07
        .byte $86,$00,$00,$f1,$10,$c8,$c8,$00,$81,$14,$00,$80,$14,$00,$81,$14
        .byte $00,$80,$14,$00,$81,$14,$00,$80,$14,$00,$81,$14,$00,$80,$14,$00
        .byte $81,$14,$00,$80,$14,$00,$81,$14,$00,$80,$14,$00,$81,$14,$00,$80
        .byte $14,$00,$ff,$01,$09,$49,$00,$00,$f1,$10,$c8,$c8,$00,$81,$28,$00
        .byte $81,$28,$00,$81,$28,$00,$81,$28,$00,$80,$28,$00,$80,$28,$00,$81
        .byte $32,$00,$81,$32,$00,$81,$32,$00,$80,$32,$00,$80,$32,$00,$80,$32
        .byte $00,$81,$1e,$00,$81,$1e,$00,$81,$1e,$00,$81,$1e,$00,$80

    L_ed79:
        asl L_7fff + $1,x
        asl L_7fff + $1,x
        asl L_7fff + $1,x

        .byte $1c,$00,$80,$18,$00,$80,$14,$00,$80,$14,$00,$80,$14,$00,$80,$14
        .byte $00,$ff,$01,$09,$49,$00,$00,$f1,$10,$c8,$c8,$00,$81,$14,$00,$81
        .byte $14,$00,$81,$14,$00,$81,$14

    L_eda9:
        .byte $00,$80,$14,$00,$80,$14,$00
        .byte $81,$19,$00,$81,$19,$00,$81,$19,$00,$80,$19,$00,$80,$19,$00,$80
        .byte $19,$00,$81,$19,$00,$81,$0f,$00,$81,$0f,$00,$81,$0f,$00,$80,$0f
        .byte $00,$80,$0e,$00,$80,$0e,$00,$80,$0c,$00,$80,$0a,$00,$80,$0a

    L_eddf:
        .byte $00,$ff,$03,$07
        .byte $86,$00,$00,$f1,$10,$c8,$c8,$00,$81,$0f

    L_eded:
        .byte $00,$80,$0f,$00
        .byte $81,$0f,$00,$80,$0f,$00,$81,$0f,$00,$80,$0f,$00,$81,$0f,$00,$81
        .byte $0f,$00,$80,$0f,$00,$81,$0f,$00,$80,$0f,$00,$ff,$01,$08,$47,$08
        .byte $08,$00,$00,$41,$64,$00,$41,$5f,$00,$41,$5a,$00,$41,$55,$00,$41
        .byte $50,$00,$41,$4b,$00,$41,$46,$00,$41,$41,$00,$41,$3c,$00,$40,$37
        .byte $00,$40,$32,$00,$40,$32,$00,$ff,$6d,$78,$a9,$ba,$8d,$b1,$e0,$a9
        .byte $ee,$8d,$ae,$e0,$a9,$d0,$8d,$b2,$e0,$a9,$ee,$8d,$af,$e0,$a9,$e6
        .byte $8d,$b3,$e0,$a9,$ee,$8d,$b0,$e0,$a9,$fc,$85,$f0,$a9,$ee,$85,$f1
        .byte $a9,$b0,$85,$f2,$a9,$f0,$85,$f3,$a9,$28,$85,$f4,$a9,$f3,$85,$f5

    L_ee71:
        lda L_e081 + $1
        sta sFiltMode
        lda L_e081 + $2
        sta sFiltControl
        lda L_e084
        sta sFiltFreqHi
        lda $e085
        sta sFiltFreqLo
        lda #$07
        sta L_e09b
        sta L_e09b + $1
        lda #$02
        sta $e09f
        sta L_e0a0
        sta $e0a1
        sta L_e0b2 + $2
        sta L_e0b2 + $3
        sta L_e0b2 + $4
        lda #$04
        sta L_e09b + $2
        sta L_e09e
        lda #$00
        sta L_e0a2
        sta L_e0a2 + $1
        sta L_e0a2 + $2
        cli 
        rts 



        .byte $fc,$ee,$20,$ef,$4a,$ef,$4a,$ef

    L_eec2:
        cpx #$ef
        lsr 

        .byte $ef,$4a,$ef,$e0,$ef,$46,$f0,$00,$00,$00,$00,$b0,$f0,$d2,$f0,$fc
        .byte $f0,$fc,$f0,$1e,$f2,$fc,$f0,$fc,$f0,$1e,$f2,$be,$f2,$00

    L_eee3:
        .byte $00,$00,$00
        .byte $28,$f3,$43,$f3,$59,$f3,$59

    L_eeed:
        .byte $f3,$9b,$f4
        .byte $59,$f3,$59,$f3,$9b,$f4,$4d,$f5,$00,$00,$00,$00,$c8,$0f

    L_eefe:
        cmp #$02
        dex 
        php 

        .byte $cb,$89,$cc,$40,$d4,$d5,$d6,$d7,$d8,$d9,$da,$02,$cf,$01,$01,$00
        .byte $40,$01,$dc,$00,$32,$0e,$00,$d1,$02,$32,$01,$64

    L_ef1e:
        .byte $00,$00,$04
        .byte $56,$04,$56,$04,$56,$04,$56,$04,$56,$04,$56,$08,$56,$08

    L_ef2f:
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $04,x
        lsr $08,x
        lsr $08,x
        lsr $04,x
        lsr $04,x
        lsr $00,x

        .byte $00,$04,$41,$04,$41,$04,$41,$04,$46,$04,$48,$04,$4b,$08,$4a,$38
        .byte $51,$08,$00,$04,$41,$04,$41,$04,$41,$04,$46,$04,$48,$04,$4b,$40
        .byte $4a,$08,$00,$04,$41,$04,$41,$04,$41,$04,$46,$04,$48,$04,$4b,$08
        .byte $4a,$08,$46,$04,$48,$04,$4b,$08,$4a,$08,$46,$04,$48,$04,$4b,$08
        .byte $4a,$08,$46,$04,$4a,$04,$51,$58,$53,$08,$00,$04,$43,$04,$43,$04
        .byte $43,$04,$48,$04,$4a,$04,$51,$08,$4c,$38,$53,$08,$00,$04,$43,$04
        .byte $43,$04,$43,$04,$48,$04,$4a,$04,$51,$40,$4c,$08,$00,$04,$43,$04
        .byte $43,$04,$43,$04,$48,$04,$4a,$04,$51,$08,$4c,$08,$48,$04,$4a,$04
        .byte $51,$08,$4c,$08,$48,$04,$4a,$04,$51,$08,$4c,$08,$48,$04,$4c,$04
        .byte $53,$58,$55,$08,$00,$00,$00,$0c,$4c,$0c,$55,$04,$57,$04,$5a,$04
        .byte $57,$0c,$59,$04,$57

    L_efee:
        .byte $04,$5a,$04,$57
        .byte $08

    L_eff3:
        eor L_5504,y

    L_eff6:
         .byte $04,$57,$04,$5a,$04,$57
        .byte $08,$59,$04,$55

    L_f000:
        .byte $0c
        .byte $4c,$0c,$55,$04,$57,$04,$5a,$04,$57

    L_f00a:
        php 
        eor L_5504,y
        bmi L_f069

        .byte $0c,$44,$0c,$49,$04,$4b,$04,$52,$04,$4b,$0c,$51,$04

    L_f01d:
        .byte $4b,$04,$52,$04,$4b
        .byte $08,$51,$04,$49,$04,$4b,$04,$52,$04,$4b,$08,$51,$04,$49,$0c,$51
        .byte $0c,$48,$0c,$4a,$04,$4c,$04,$51,$04,$53,$50,$51,$08,$51,$04,$51
        .byte $04,$51,$00,$00,$04,$41,$04,$41,$04,$41,$04,$46,$04,$48,$04,$4b
        .byte $08,$4a,$38,$51,$08,$00,$04,$41,$04,$41,$04,$41,$04,$46,$04,$48
        .byte $04,$4b,$40,$4a,$08,$00,$04

    L_f069:
        eor ($04,x)
        eor ($04,x)
        eor ($04,x)
        lsr $04
        pha 

        .byte $04,$4b,$08,$4a,$08,$46,$04,$48,$04,$4b,$08,$4a,$08,$46,$04,$48
        .byte $04,$4b,$08,$4a,$08,$46,$04,$4a,$04,$51,$48,$53,$0c,$53,$0c,$55
        .byte $10,$56,$04,$53,$04,$55,$10,$56,$04,$53,$04,$55,$04,$56,$04,$58
        .byte $04,$55,$10,$56,$08,$00,$0c,$58,$34

    L_f0ab:
        lsr $2c,x

        .byte $00,$00,$00,$ca,$08,$cb,$39,$cc,$40,$d4,$d5,$d6,$d7,$d8,$d9,$da
        .byte $02,$cf,$01,$01,$00,$40,$01,$dc,$00,$32,$0e,$00,$00,$00,$d1,$02
        .byte $32,$01,$64,$00,$00,$04,$4a,$04,$4a,$04,$4a,$04,$4a,$04,$4a,$04
        .byte $4a,$08,$4a,$08,$4a,$04,$4a,$04,$4a,$04,$4a,$04,$4a,$04,$4a,$04
        .byte $4a,$04

    L_f0ef:
        lsr 

        .byte $04,$4a,$08,$4a,$08,$4a,$04,$4a,$04,$4a,$00,$00,$04,$3a,$04,$3a
        .byte $04,$3a,$04,$41,$04,$45,$04,$48,$08,$46,$38,$4a,$08,$00,$04,$3a
        .byte $04,$3a,$04,$3a,$04,$41,$04,$45,$04,$48,$40,$46,$08,$00,$04,$3a
        .byte $04,$3a,$04,$3a,$04,$41,$04,$45,$04,$48,$08,$46,$08,$41,$04,$45
        .byte $04,$48,$08,$46,$08,$41,$04,$45,$04,$48,$08,$46,$08,$41,$04,$46
        .byte $04,$4a,$cf,$01,$01,$00,$40,$00,$cb,$29,$ca,$05,$d3,$03,$02,$40
        .byte $10,$04,$7a,$04,$77,$04,$73,$04,$77,$04,$73,$04,$6a,$04,$73,$04
        .byte $6a,$04,$67,$04,$6a,$04,$67,$04,$63,$04,$67,$04,$63,$04,$5a,$04
        .byte $63,$04,$5a,$04,$57,$04,$5a,$04,$57,$04,$53,$04,$57,$04,$53,$04
        .byte $4a,$cf,$01,$01,$00,$40,$01,$cb,$39,$ca,$08,$d8,$04,$3c,$04,$3c
        .byte $04,$3c,$04,$43,$04,$43,$04,$48,$08,$48,$38,$4c,$08,$00,$04,$3c
        .byte $04,$3c,$04,$3c,$04,$43,$04,$43,$04,$48,$40,$48,$08,$00,$04,$3c
        .byte $04,$3c,$04,$3c,$04,$43,$04,$43,$04,$48,$08

    L_f1bb:
        pha 
        php 

        .byte $43,$04,$43,$04,$48,$08,$48,$08,$43,$04,$43,$04,$48,$08,$48,$08
        .byte $43,$04,$48,$04,$4c,$cf,$01,$01,$00,$40,$00,$cb,$29,$ca,$05,$d3
        .byte $03,$02,$40,$10,$04,$7c,$04,$79,$04,$75,$04,$79,$04,$75,$04,$6c
        .byte $04,$75,$04,$6c,$04,$69,$04,$6c,$04,$69,$04,$65,$04,$69,$04,$65
        .byte $04,$5c,$04,$65,$04,$5c,$04,$59,$04,$5c,$04,$59,$04,$55,$04,$59
        .byte $04,$55,$04,$4c,$cf,$01,$01,$00,$40,$01,$cb,$39,$ca,$08,$d8,$00
        .byte $00,$0c,$49,$0c,$4c,$04,$4c,$04,$55,$04,$4c,$0c,$55,$04,$4c,$04
        .byte $55,$04,$4c,$08,$55,$04,$4c,$04,$4c,$04,$55,$04,$4c,$08,$51,$04
        .byte $4c,$0c,$49,$0c,$4c,$04,$4c,$04,$55,$04,$4c,$08,$55,$04,$4c,$30
        .byte $51,$0c,$41,$0c,$44,$04,$44,$04,$49,$04,$44,$0c,$49,$04,$44,$04
        .byte $49,$04,$44,$08,$49,$04,$44,$04,$44,$04,$49,$04,$44,$08,$49,$04
        .byte $44,$0c,$48,$0c,$45,$0c,$46,$04,$48,$04,$48,$04,$4c,$cf,$01,$01
        .byte $00,$40,$00,$cb,$29,$ca,$05,$04,$71,$04,$68,$04,$65,$04,$68,$04
        .byte $71,$04,$68,$04,$6b,$04,$68,$04,$65,$04,$68,$04,$6b,$04,$68,$04
        .byte $6a,$04,$65,$04,$61,$04,$65,$04,$6a,$04,$65,$04,$6b,$04,$68,$cf
        .byte $01,$01,$00,$40

    L_f2b1:
        .byte $01,$cb,$39,$ca,$08,$08,$45,$04,$45,$04,$45,$00,$00,$04,$3a,$04
        .byte $3a,$04,$3a,$04,$41,$04,$45,$04,$48,$08,$46,$38,$4a,$08,$00,$04
        .byte $3a,$04,$3a,$04,$3a,$04,$41,$04,$45,$04,$48,$40,$46,$08,$00,$04
        .byte $3a,$04,$3a,$04,$3a,$04,$41,$04,$45,$04,$48,$08,$46,$08,$41,$04
        .byte $45,$04,$48,$08,$46,$08,$41,$04,$45,$04,$48,$08,$46,$08,$41,$04
        .byte $46,$04,$4a,$48,$47,$0c,$47,$0c,$48,$10,$53,$04,$4b,$04,$4b,$10
        .byte $53,$04,$4b,$04,$4b,$04,$53,$04,$53,$04,$4b,$10,$53,$08,$00,$0c
        .byte $4b,$34,$4a,$2c,$00,$00,$00,$ca,$08,$cb,$88,$cc,$40,$d4,$d5,$d6
        .byte $d7,$d8,$d9,$da,$02,$cf,$01,$01,$00,$28,$01,$dc

    L_f33d:
        .byte $04,$00,$0c,$00,$00,$00,$0c
        .byte $26,$0c,$21,$08,$26,$08

    L_f34a:
        rol $08
    L_f34c:
        and ($0c,x)
        rol $0c
        and ($08,x)
        rol $08
        rol $08
        and ($00,x)

        .byte $00,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04
        .byte $26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08
        .byte $16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04
        .byte $26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04
        .byte $26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04
        .byte $26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04
        .byte $26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08
        .byte $16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$13,$04,$23,$04,$23,$04
        .byte $23,$04,$23,$08,$13,$04,$23,$04,$23,$04,$23,$04,$23,$08,$13,$04
        .byte $23,$04,$23,$04,$23,$04,$23,$08,$13,$04,$23,$04,$23,$04,$23,$04
        .byte $23,$08,$18,$04,$28,$04,$28

    L_f3ff:
        .byte $04
        .byte $28,$04,$28,$08,$18,$04,$28,$04,$28,$04,$28,$04,$28,$08,$18,$04
        .byte $28,$04,$28,$04,$28,$04,$28,$08,$18,$04,$28,$04,$28,$04,$28,$04
        .byte $28,$08,$18,$04,$28,$04,$28,$04,$28,$04,$28,$08,$18,$04,$28,$04
        .byte $28,$04,$28,$04,$28,$08,$18,$04,$28,$04,$28,$04,$28,$04,$28,$08
        .byte $18,$04,$28,$04,$28,$04,$28,$04,$28,$08,$18,$04

    L_f44c:
        plp 

        .byte $04,$28,$04,$28,$04,$28,$08,$18

    L_f455:
        .byte $04
        .byte $28,$04,$28,$04,$28,$04,$28,$08,$18,$04,$28,$04,$28,$04,$28,$04
        .byte $28,$08,$18,$04,$28,$04,$28,$04,$28,$04,$28,$08,$15,$04

    L_f474:
        and $04
        and $04
        and $04
        and $08
        ora $04,x
    L_f47e:
        and $04
        and $04
        and $04
        and $08
        ora $04,x
    L_f488:
        and $04
        and $04
        and $04
        and $08
        ora $04,x
        and $04
        and $04
        and $04
        and $00

        .byte $00,$08,$15,$04,$25,$04,$25,$04,$25,$04,$25,$08,$15,$04,$25,$04
        .byte $25,$04,$25,$04,$25,$08,$15,$04,$25,$04,$25,$04,$25,$04,$25,$08
        .byte $15,$04,$25,$04,$25,$04,$25,$04,$25,$08,$15,$04,$25,$04,$25,$04
        .byte $25,$04,$25,$08,$15,$04,$25,$04,$25,$04,$25,$04,$25,$08,$19,$04
        .byte $29,$04,$29,$04,$29,$04,$29,$08,$1b,$04,$2b,$04,$2b,$04,$2b,$04
        .byte $2b,$08,$19,$04,$29,$04,$29,$04,$29,$04

    L_f4f4:
        and #$08
        ora L_2904,y

        .byte $04,$29,$04,$29,$04,$29,$08,$19,$04,$29,$04,$29,$04,$29,$04,$29
        .byte $08,$19,$04,$29,$04,$29,$04,$29,$04,$29,$08,$21,$04,$31,$04,$31
        .byte $04,$31,$04,$31,$08,$23,$04,$33,$04,$28,$04,$28,$04,$28,$08,$21
        .byte $04,$31,$04,$31,$04,$31,$04,$31,$08,$1b,$04,$2b,$04,$2b,$04,$2b
        .byte $04,$2b,$08,$1a,$04,$2a,$04,$2a,$04,$2a,$04,$2a,$08,$18,$08,$18
        .byte $08,$18

    L_f54b:
        .byte $00,$00
        .byte $08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26
        .byte $04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16
        .byte $04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26
        .byte $04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26
        .byte $04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26
        .byte $08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26,$04,$26
        .byte $04,$26,$04,$26,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16
        .byte $04,$26,$04,$26,$04,$26,$04,$26,$08,$13,$04,$23,$04,$23,$04,$23
        .byte $04,$23,$08

    L_f5d0:
        .byte $13,$04,$23,$04,$23,$04,$23,$04,$23
        .byte $08

    L_f5da:
        .byte $13,$04,$23,$04,$23,$04,$23,$04,$23
        .byte $08,$13,$04,$23,$04,$31,$04,$31,$04,$31,$08,$1b,$04,$2b,$04,$2b
        .byte $04,$2b,$04,$2b,$08,$1b,$04,$2b,$04,$2b,$04,$2b,$04,$2b,$08,$1b
        .byte $04,$2b,$04,$2b,$04,$2b,$04,$2b,$08,$1b,$04,$2b,$04,$31,$04,$31
        .byte $04,$31,$08,$16,$04,$26,$04,$26,$04,$26,$04,$26,$08,$16,$04,$26
        .byte $04,$26,$04,$26,$04,$26,$04,$26,$04,$00,$04,$21,$04,$21,$04,$21
        .byte $04,$21,$04,$26,$04,$00,$04,$21,$04,$21,$04,$21,$04,$21,$00,$00
        .byte $ff

    L_f644:
        sei 
        lda #$7e
        sta L_e0a2 + $f
        lda #$f6
        sta L_e0a2 + $c
        lda #$8c
        sta L_e0b2
        lda #$f6
        sta L_e0a2 + $d
        lda #$9a
        sta L_e0b2 + $1
        lda #$f6
        sta L_e0a2 + $e
        lda #$a4
        sta $f0
        lda #$f6
        sta $f1
        lda #$80
        sta $f2
        lda #$f7
        sta $f3
        lda #$56
        sta $f4
        lda #$f8
        sta $f5
        jmp L_ee71

        .byte $a4,$f6,$1a,$f7,$a4,$f6,$24,$f7,$2e,$f7,$00,$00,$00,$00,$80,$f7
        .byte $f0,$f7,$80,$f7,$fa,$f7,$04,$f8,$00,$00,$00,$00,$56,$f8,$56,$f8
        .byte $f1,$f8,$00,$00,$00,$00,$c8,$0f,$c9,$03,$ca,$09,$cb,$c9,$cc,$10
        .byte $d4,$d5,$d6,$d7,$d8,$d9,$da,$02,$d1,$02,$2d,$01,$64,$dd,$01,$dc
        .byte $03,$00,$0f,$00,$cf,$01,$01,$00,$28,$00,$10,$00

    L_f6ca:
        php 
        lsr 
        php 
        jmp L_5108

        .byte $08,$4a,$08,$51,$08,$55,$18,$58,$04,$56,$04,$55,$20,$56,$10,$00
        .byte $08,$48,$08,$4a,$08,$4c,$08,$48,$08,$4c,$08,$53,$18,$56,$04,$55
        .byte $04,$54,$20,$55,$10,$00

    L_f6f6:
        php 
        eor $08
        lsr $08
        lsr 
        php 
        eor ($08),y
        eor $08,x
        eor ($18),y
        eor $04,x

        .byte $53,$04,$52,$20,$53,$10,$00,$08,$45,$08,$49,$08,$4c,$08,$53,$08
        .byte $51,$08,$4c,$00,$00,$18,$53,$04,$51,$04,$4c,$20,$51,$00,$00,$18
        .byte $4c,$04,$4a,$04,$49,$20,$4a,$00,$00,$ca,$00,$cc,$40,$cb,$4a,$10
        .byte $00

    L_f736:
        .byte $10,$5a,$10,$55,$10,$5a
        .byte $18,$56,$08,$58,$20,$53,$10,$00,$08,$5c,$08,$5a,$08,$58,$08,$56
        .byte $08,$55,$08,$53,$18,$55,$04,$58,$04,$5a,$20,$58,$10,$00,$08,$5a
        .byte $08,$58,$08,$56,$08,$55,$08,$53,$08,$51,$04,$53,$04,$55,$04,$53
        .byte $04,$55,$40,$53,$10,$53,$10,$51,$10,$4c,$04

    L_f777:
        jmp L_5100 + $4

        .byte $30,$4a,$08,$00,$00,$00,$ca,$09,$cb,$89,$cc,$10,$d4,$d5,$d6,$d7
        .byte $d8,$d9,$da,$02,$d1,$02,$2d,$00,$c8,$dc,$03,$00,$0f,$00,$cf,$01
        .byte $01,$00,$28,$00,$10,$00

    L_f7a0:
        php 
        eor $08
        eor $08
        lsr 
        php 
        eor $08
        lsr 
        php 
        eor ($18),y

    L_f7ad:
         .byte $53,$04,$53,$04,$52
        .byte $20,$53,$10,$00,$08,$43,$08,$43,$08,$48,$08,$43,$08,$48,$08,$4c
        .byte $18,$51,$04

    L_f7c5:
        eor ($04),y
        jmp L_5120

    L_f7ca:
         .byte $10,$00,$08,$41,$08,$41,$08,$46,$08,$4a,$08,$51,$08,$4a,$18,$4a
        .byte $04,$4a,$04,$49,$20,$4a,$10,$00

    L_f7e2:
        php 

        .byte $3c,$08,$45,$08,$49,$08,$4c,$08,$49,$08,$49,$00,$00,$18,$4a,$04
        .byte $4a,$04,$49,$20,$4a,$00,$00,$18,$45,$04,$45,$04,$44,$20,$41,$00
        .byte $00,$ca

    L_f805:
        .byte $00,$cb,$3a
        .byte $cc,$40,$10,$00,$10,$55,$10,$51,$10,$55,$18,$53,$08,$53,$20,$4a
        .byte $10,$00,$08,$53,$08,$51,$08,$4c,$08,$4a,$08,$48,$08,$46,$18,$51
        .byte $04,$55,$04,$56,$20,$55,$10,$00,$08,$51,$08,$4c,$08,$4a,$08,$48

    L_f838:
        php 
        lsr $08
        eor $04
        jmp L_5100 + $4

        .byte $04,$4c,$04,$51,$40,$4c,$10,$4c,$10,$49,$10,$49,$04,$45,$04,$4a
        .byte $30,$41,$08,$00,$00,$00,$ca,$05,$cb,$29,$cc,$40,$d4,$d5,$d6,$d7
        .byte $d8

    L_f861:
        cmp $02da,y

        .byte $cf,$01,$01,$00,$28,$01,$dc,$04,$00,$0c,$00,$08,$1a,$08,$1a,$f2
        .byte $08,$08,$15,$08,$1a,$08,$1a,$f2,$08,$08,$25,$08,$23,$08,$23,$f2
        .byte $08,$08,$1a,$08,$23,$08,$23,$f2,$08,$08,$1a,$08,$18,$08,$18,$f2
        .byte $08

    L_f895:
        php 
        clc 
        php 
        clc 
        php 
        clc 

        .byte $f2,$08,$08,$23,$08,$21,$08,$21,$f2,$08,$08,$18,$08,$21,$08,$21
        .byte $f2,$08,$08,$28,$08,$26,$08,$26,$f2,$08,$08,$21,$08,$26,$08,$26
        .byte $f2,$08,$08,$21,$08,$23,$08,$23,$f2,$08,$08,$1a,$08,$23,$08,$23
        .byte $f2,$08,$08,$1a,$08,$25,$08,$25,$f2,$08,$08,$1c,$08,$25,$08,$25
        .byte $f2,$08,$08,$1c,$08,$1a,$08,$1a,$f2,$08,$08,$15,$08,$1a,$08,$1a
        .byte $f2,$08,$08,$15,$00,$00,$08,$1a,$08,$1a,$f2,$08,$08,$15,$08,$1a
        .byte $08,$1a,$f2,$08,$08,$25,$08,$23,$08,$23,$f2,$08,$08,$1a,$08,$23
        .byte $08,$23,$f2,$08,$08,$1a,$08,$18,$08,$18,$f2,$08,$08,$18,$08,$18
        .byte $08,$18,$f2,$08,$08,$23,$08,$21,$08,$21,$f2,$08,$08,$18,$08,$21
        .byte $08,$21,$f2,$08,$08,$28,$08,$26,$08,$26,$f2,$08,$08,$21,$08,$26
        .byte $08,$26,$f2,$08,$08,$21,$08,$25,$08,$25,$f2,$08,$08,$1c,$08,$25
        .byte $08,$25,$f2,$08,$08,$1c,$08,$25,$08,$25,$f2,$08,$08,$1c,$08,$25
        .byte $08,$25,$f2,$08,$08,$1c,$08,$1a,$08,$1a,$f2,$08,$08,$15,$08,$1a
        .byte $08,$1a,$f2,$08,$08,$15,$00,$00,$41,$78,$a9,$ae,$8d,$b1,$e0,$a9
        .byte $f9,$8d,$ae,$e0,$a9,$be,$8d,$b2,$e0,$a9,$f9,$8d,$af,$e0,$a9,$ce
        .byte $8d,$b3,$e0,$a9,$f9,$8d,$b0,$e0,$a9,$de,$85,$f0,$a9,$f9,$85,$f1
        .byte $a9,$78,$85,$f2,$a9,$fa,$85,$f3,$a9,$2b,$85,$f4,$a9,$fb,$85,$f5
        .byte $4c,$71,$ee,$de,$f9,$06,$fa,$3a,$fa,$06,$fa,$3a,$fa,$72,$fa,$00
        .byte $00,$00,$00,$78,$fa,$98,$fa,$cc,$fa,$98,$fa,$cc,$fa,$25,$fb,$00
        .byte $00,$00,$00,$2b,$fb,$48,$fb,$8a,$fb,$48,$fb,$8a,$fb,$c4,$fb,$00
        .byte $00,$00,$00,$c8,$0f,$c9,$02,$ca,$08,$cb,$89,$cc,$40,$d4,$d5,$d6
        .byte $d7,$d8,$d9,$da,$02,$cf,$01,$01

    L_f9f3:
        .byte $00
        .byte $40,$01,$dc,$00,$32,$0e,$00,$d1,$02,$32,$00,$c8,$08,$48,$04,$48
        .byte $00,$00,$08,$51,$04,$51,$08,$51,$04,$51,$08,$51,$04,$51,$04,$53
        .byte $04,$51,$04,$53,$08,$55,$04,$55,$08,$55,$04,$55,$0c,$55,$04,$58
        .byte $04,$58,$04,$58,$20,$61,$04,$58,$04,$55,$04,$53,$04,$51,$24,$55
        .byte $08,$48,$04,$48,$00,$00,$08,$51,$04,$51,$08,$51,$04,$51,$08,$51
        .byte $04,$51,$04,$53,$04,$51,$04,$53,$08,$55,$04,$55,$08,$55,$04,$55
        .byte $0c,$55,$04,$58,$04,$58,$04,$58,$0c,$59,$0c,$58,$0c,$59,$0c,$58
        .byte $08,$61,$04,$51,$04,$51,$04,$51,$04,$51,$18,$51,$00,$00,$18,$51
        .byte $de,$00,$00,$00,$ca,$08,$cb,$49,$cc,$40,$d4,$d5,$d6,$d7,$d8,$d9
        .byte $da,$02,$cf,$01,$01,$00,$40,$01,$dc,$00,$32,$0e,$00,$08,$43,$04
        .byte $43,$00,$00,$00,$08,$45,$04,$45,$08,$45,$04,$45,$08,$45,$04,$45
        .byte $04,$48,$04,$48,$04,$48,$08,$51,$04,$51,$08,$51,$04,$51,$0c,$51
        .byte $04,$55,$04,$55,$04,$55,$20,$55,$04,$55,$04,$51,$04,$48,$04,$48
        .byte $24,$51,$08,$45,$04,$45,$00,$00,$08,$45,$04,$45,$08,$45,$04,$45
        .byte $08,$45,$04,$45,$04,$48,$04,$48,$04,$48,$08,$51,$04,$51,$08,$51
        .byte $04,$51,$0c,$51,$04,$55,$04,$55,$04,$55,$cf,$01,$01,$00,$40,$00
        .byte $02,$59,$02,$61,$02,$64,$02,$69,$02,$71,$02

    L_faff:
        .byte $74,$0c
        .byte $55,$02,$59,$02,$61,$02,$64,$02,$69,$02,$71,$02,$74,$cf,$01,$01
        .byte $00,$40,$01,$0c,$55,$08,$55,$04,$45,$04,$45,$04,$45,$04,$45,$18
        .byte $45,$00,$00,$00,$18,$45,$64,$00,$00,$00,$ca,$08,$cb,$88,$cc,$40
        .byte $d4,$d5,$d6,$d7,$d8,$d9,$da,$02,$cf,$01,$01,$00,$28,$01,$dc,$04
        .byte $00,$0c,$00,$0c,$00,$00,$00,$08,$21,$04,$31,$08,$1c,$04,$2c,$08
        .byte $1a,$04,$2a,$08,$18,$04,$28,$08,$21,$04,$31,$08,$1c,$04,$2c,$08
        .byte $1a,$04,$2a,$08,$18,$04,$28,$08,$21,$04,$31,$08,$1c,$04,$2c,$08
        .byte $1a,$04,$2a,$08,$18,$04,$28,$08,$21,$04,$31,$08

    L_fb7d:
        .byte $1c,$04
        .byte $2c,$08,$1a,$04,$2a,$08,$18,$04,$28,$00,$00,$08,$21,$04,$31,$08
        .byte $1c,$04,$2c,$08,$1a,$04,$2a,$08,$18,$04,$28,$08,$21,$04,$31,$08
        .byte $1c,$04,$2c,$08,$1a,$04,$2a,$08,$18,$04,$28,$0c,$29,$0c,$28,$0c
        .byte $29,$0c,$28,$08,$21,$04,$31,$08,$1c,$04,$2c,$08,$1a,$04,$2a

    L_fbbe:
        php 
        clc 

        .byte $04,$28,$00,$00,$18,$21,$64,$00,$00,$00,$ff,$ff,$00,$57,$80,$00
        .byte $de,$c0,$03,$fe,$f0,$0f,$ba,$f0,$0f,$ae,$b0,$03,$ea,$b0,$03,$5a
        .byte $b0,$02,$7a,$90,$03,$aa,$d0,$02,$ff,$80,$02,$aa

    L_fbec:
        .byte $b0,$02
        .byte $8a,$b0,$0a,$8a,$b0,$0a,$0a,$30,$0a

    L_fbf7:
        .byte $00,$00,$0f,$00,$00,$3c,$00,$00,$00,$00

    L_fc01:
        ora $eceb,y
        ldy #$b0

        .byte $80,$80,$bf,$af,$eb,$3b

    L_fc0c:
        asl 
        asl $0202

        .byte $80,$80,$a0,$20,$e8,$ca,$f2,$fc,$02,$02,$0a,$08,$2b,$a3,$8f,$3f
        .byte $4a,$49,$4b,$45,$47,$c5,$4d,$00,$95,$57,$dd,$ff,$77,$75,$55,$00
        .byte $9d,$57,$7f,$75,$fd,$57,$55,$00,$33,$cf,$fc,$33,$ff,$33,$fc,$cf
        .byte $33,$cf,$fc,$cf,$3f,$f3,$cc,$ff,$d5,$5d,$d5,$77,$55,$dd,$57,$75
        .byte $c0,$33,$cc,$00,$33,$c0,$0c,$33,$dd,$55,$77,$d5,$5d,$17,$44,$00
        .byte $d4,$54,$70,$d3,$50,$43,$cc,$33,$05,$0d,$05,$0d,$07,$05,$07,$01
        .byte $68,$00,$98,$00,$68,$00,$64,$00,$a8,$68,$00,$03,$a4,$00,$98,$00
        .byte $68,$00,$a4,$03,$a8,$64,$00,$00,$aa,$9a,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$aa,$69,$00,$00,$7e,$a9,$99,$9f,$6e,$95,$b6,$67
        .byte $a6,$7d

    L_fca2:
        .byte $5a,$e7,$9e,$02,$00,$00,$00,$3f,$3f,$3f,$00,$f3,$f3,$f3
        .byte $01,$02,$0b,$08,$34,$23,$60,$8c,$99,$a6,$00,$33,$0c,$f3,$f3,$f3
        .byte $80,$c0,$90,$20,$38,$04,$fa,$c3,$9a,$97,$80,$c0,$80,$40,$40,$40
        .byte $40,$cf,$4f,$4f,$c0,$43,$c3,$43,$a6,$96,$5d,$00,$00,$00,$f3,$f3
        .byte $80,$4f,$4f,$0f,$00,$00,$f3,$f3,$49,$c9,$48,$48,$c8,$48,$c8,$48
        .byte $c0,$c0,$c0,$80,$80,$80,$80,$80,$89,$4b,$40

    L_fcfb:
        .byte $00,$00,$f3,$f3,$f3

    L_fd00:
        pla 

        .byte $7b,$cb,$4b,$48,$48,$48,$48,$98,$eb,$7b,$00,$00,$00,$f3,$f3

    L_fd10:
        ldx.a $00a6
        tax 

        .byte $6b

    L_fd15:
        ldx $ea
        txs 
        tax 

        .byte $00

    L_fd1a:
        ldx $89,y

        .byte $00,$00,$c0,$0c,$a9,$ba,$00,$ae,$ae,$b6,$ba,$a9,$b6,$00,$ab,$9a
        .byte $00,$00,$0c,$c0,$23,$23,$20,$2a,$25,$20,$23,$20,$cc,$03,$00,$aa
        .byte $55,$00,$fc,$33,$08,$c8,$08,$a8,$58,$08,$c8,$c8

    L_fd48:
        cmp $d7,x
        cmp $55,x
        eor $d5d5,x
        eor $5c,x

    L_fd51:
         .byte $50,$5c,$7c,$5c,$5c,$50,$7c,$fc
        .byte $cd,$fa,$f9,$d4,$24,$e4,$90,$aa

    L_fd61:
        ror $55

        .byte $02,$02,$0e,$0e,$ce,$a8,$66,$de,$01,$00,$00,$00,$00,$ff,$3f,$4f
        .byte $83,$93,$63,$60,$24,$93,$d3,$90,$9e,$97,$7f,$90,$90,$ce,$fd,$fd
        .byte $a6,$76,$01,$c1,$f3,$f0,$c3,$c3,$a9,$dd,$00,$00,$00,$e4,$1c,$d4
        .byte $a4,$64,$14,$2c,$f4,$9f,$90,$9b,$e6,$55,$00,$c0,$f0,$02,$01,$8a

    L_fda3:
        adc $55

        .byte $00,$00,$00,$2c,$24,$64,$b4,$50,$00,$00,$00,$5e,$a9,$95,$d0,$50
        .byte $d0,$50,$90,$a8,$64,$a4,$2c,$24,$34,$14,$14,$0f,$0f,$0f,$0f,$0f
        .byte $0f,$0f,$0f,$00,$04,$03,$0f,$1c,$0f,$0d,$0f,$c4,$c7,$34,$dd,$15
        .byte $04

    L_fdd6:
        .byte $c7,$04,$d3,$1c,$1c,$77,$74,$13,$d0,$1c,$9b
        .byte $7d,$00,$aa,$55,$00,$7f,$31,$21,$63,$20,$ea,$25,$20,$23,$23

    L_fdf0:
        .byte $48,$c8,$08,$a8,$58,$08,$c8,$c8,$ba,$fb
        .byte $fd,$76,$96

    L_fdfd:
        rol 

        .byte $eb,$6f

    L_fe00:
        rol L_b6aa + $c
        txs 
        plp 

        .byte $83,$ef

    L_fe07:
        sbc L_9f85 + $1a
        sbc $58

        .byte $ab,$91,$7a,$68,$69,$66,$9e,$98,$8d,$e6,$62,$28,$58,$63,$8d,$35
        .byte $35,$d5,$55,$a5,$d8,$5a,$56,$56,$56,$56,$5a,$68,$34,$d6,$d6,$d6
        .byte $5a,$aa,$3e,$d6,$a2,$db,$59,$6d,$b5,$95,$25,$d9,$a8,$63,$6d,$65
        .byte $65,$69,$59,$5a,$96,$a3,$6d,$4d,$b5,$b5,$a6,$4a,$5a,$58,$a0,$8c

    L_fe4c:
        ldx $16,y
        dec $5a,x

        .byte $8f,$35,$d5,$d5,$55,$95,$a5,$aa,$51,$52,$54,$56,$56,$5a,$a8,$81
        .byte $00,$03,$03,$03,$01,$03,$01,$00,$03,$0d,$05,$0a,$0d,$35,$35,$aa
        .byte $00,$80,$40,$60,$60,$60,$60,$a0,$fd,$f5,$f5,$fd,$fd,$76,$7e,$7e
        .byte $74,$b4,$b8,$b8,$38,$10,$10,$00,$44,$44,$84,$15,$15,$00,$84,$44
        .byte $55,$55,$aa,$55,$55,$00,$55,$55,$12,$12,$10,$54,$54,$00,$12,$12
        .byte $be,$d6,$d6,$56,$56,$aa,$9f,$b5,$aa,$7e,$d6,$d6,$aa,$a7

    L_feae:
        sbc L_b56b + $2
        lda $b5,x
        lda $aa

        .byte $bf,$b5,$aa,$65,$6a,$67,$ad,$ad,$ed,$6d,$ad,$06,$06,$04,$15,$15
        .byte $00,$06,$06,$00,$00,$00,$55,$55,$00,$00,$00,$10,$10,$10,$54,$54
        .byte $00,$10,$10,$95,$65,$6a,$66,$a6,$99,$59,$99,$aa,$96,$96,$69,$a5
        .byte $69,$66,$95,$98,$98,$98

    L_feeb:
        .byte $fc,$54,$54,$54,$00,$00,$02
        .byte $aa,$aa,$ab,$fd,$55,$54,$00

    L_fef9:
        ldy #$aa
        tax 

        .byte $fa,$5f

    L_fefe:
        eor $05,x

    L_ff00:
         .byte $00,$00,$00
        .byte $09,$60,$00,$05,$58,$00,$2a,$94,$00,$25,$64,$00

    L_ff0f:
        and #$a4

        .byte $00,$25,$64

    L_ff14:
        .byte $00,$27
        .byte $68,$00,$09,$a4,$00,$26,$96,$00,$1d,$d6,$00,$1d,$f6,$00,$1f,$d8
        .byte $00,$1f

    L_ff28:
        cld 

        .byte $00,$27,$6a,$00,$0a,$aa

    L_ff2f:
        .byte $00
        .byte $2a,$9a,$00,$25,$56,$80,$95,$56,$80,$95,$55,$80,$95,$55,$80

    L_ff3f:
        ora ($00,x)

    L_ff41:
         .fill $17, $0
        .byte $06,$82,$00

    L_ff5b:
        asl $69,x

        .byte $80,$26,$55,$80,$26,$95,$80

    L_ff64:
        asl 
        sta $00,x
        php 
        and $00

        .byte $00,$a6,$00,$02

    L_ff6e:
        txs 

    L_ff6f:
         .byte $00
        .byte $09,$95,$80,$09,$00,$80,$0a,$10,$80,$09,$65,$80,$09,$66,$80,$02

    L_ff80:
        .fill $40, $0
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$10

    L_ffc9:
        .byte $10,$10,$10,$10,$10,$10,$10,$00,$00,$00
        .byte $41,$14

    L_ffd5:
        .byte $00
        .byte $2a,$aa,$00,$00,$00,$54,$11,$a8,$aa,$12,$00,$0c,$c3,$03,$cf,$fc
        .byte $3c,$3f,$03,$30,$00,$3c,$0c,$0c,$3c,$3f,$dd,$65,$2a,$0e,$01,$02

    L_fff6:
        .byte $00,$00
        .byte $08,$85,$53

    L_fffb:
        dex 
    L_fffc:
        bmi $10019
