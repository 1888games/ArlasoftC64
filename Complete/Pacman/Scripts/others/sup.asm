//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $c800
.label SCREEN_BUFFER_2 = $cc00

    BasicUpstart2(L_0698)

//Start of disassembled code
* = $0400 "Base Address"


    L_0400:

  
        .byte $20,$20,$20

    L_0403:
        .fill $32, $20

        .fill 12, $20

    L_0442:
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20
        .fill $28, $20

    L_0478:
        .fill $27, $20
        .byte $20,$20,$41,$20,$0a,$70,$14,$71,$0b,$70,$0c,$0c,$70,$13

    L_04ad:
        jsr L_050c + $1

        .byte $0e,$14,$71,$13,$05,$20

    L_04b6:
        ora #$0c

        .byte $0c,$2e,$20,$14,$7a,$0c,$14,$71,$13,$05,$20,$0d,$0f,$13,$14,$20
        .byte $20,$0b,$01,$1a,$05,$14,$14,$70,$12,$01,$20,$0d,$6a,$0b,$64,$04
        .byte $09,$0b,$2c,$20,$0e,$05,$20,$14,$71,$16,$05,$13,$13,$1a,$05,$0e
        .byte $20,$0d,$05,$07,$20,$20,$20,$20,$20,$13,$05,$0e,$0b,$09,$14,$20
        .byte $01,$0d,$09,$14,$20,$01,$20,$10,$12,$0f,$07,$12,$01,$0d,$20,$0b
        .byte $09,$76,$12,$2e

    L_050c:
        .fill $35, $20
        .byte $41,$20,$53,$01,$16,$05,$20,$0f,$10,$03,$09,$6f,$20,$0b,$09,$16
        .byte $70,$0c,$01,$13,$1a,$14,$70,$13,$01,$20,$15,$14,$70,$0e,$20,$0b
        .byte $71,$12,$05,$0d,$20,$20,$20,$20,$0b,$64,$16,$05,$13,$13,$05,$20
        .byte $01,$20,$10,$12,$0f,$07,$12,$01,$0d,$20,$15,$14,$01,$13,$76,$14
        .byte $70,$13,$01,$09,$14,$2c,$20,$0d,$01,$0a,$04,$20,$01,$20,$20,$20
        .byte $0b,$71,$10,$05,$12,$0e,$19,$64,$20,$05,$0c,$16,$71,$14,$05,$0c
        .byte $05,$20,$15,$14,$70,$0e,$20,$0c,$05,$08,$05,$14,$20,$09,$0e,$04
        .byte $76,$14,$01,$0e

    L_05b5:
        ora #$20
        jsr $0120
        jsr $010d

        .byte $07,$0e,$6f,$14,$2e
        .fill $47, $20
        .byte $56,$71,$07,$09,$07,$0a,$70,$14,$13,$1a,$70,$13,$20,$05,$13,$05
        .byte $14,$71,$0e,$20,$01,$20,$10,$12,$0f,$07,$12,$01,$0d,$20,$01,$20
        .byte $27,$30,$32,$27,$20,$20,$20,$20,$03,$76,$0d,$6a,$20,$06,$09,$0c
        .byte $05,$2d,$14,$20,$01,$0b,$01,$12,$0a,$01,$20,$14,$64,$0c,$14,$05
        .byte $0e,$09,$2e
        .fill $34, $20
        .fill $18, $40

    L_0698:

        .break
        sei 
        lda #$37
        sta $01
        lda $ff
        sta $0867
        lda $0330
        sta $085d

        jmp $0810

    * = * "horse"

        .byte $20,$16,$01,$0e,$0e,$01,$0b,$20,$01,$20,$0c,$05,$07
        .byte $15,$0a,$01,$02,$02,$20,$10,$12,$07,$2d,$0f,$0b,$20,$0b,$01,$1a
        .byte $05,$14,$14,$70,$12,$01,$3a,$20,$42,$71,$0c,$19,$05,$07,$05,$13
        .byte $20,$02,$0f,$12,$76,$14,$71,$0b,$71,$12,$14,$20,$0c,$09,$13,$14
        .byte $70,$14,$20,$0b,$01,$10,$13,$1a,$21,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$7e,$20,$36,$34,$20,$53,$5a
        .byte $4f,$4c,$47,$20,$7c

    L_070d:
        .fill $1b, $20
        .byte $20,$7e,$20,$32,$30,$33,$30,$20,$72,$52,$44,$20,$7c
        .fill $1c, $20
        .byte $7e,$20,$50,$46,$2e,$3a,$34,$2e,$20,$20,$20,$7c
        .fill $3b, $20
        .byte $43,$4f,$4d,$4d,$4f,$44,$4f,$52,$45,$60,$56,$49,$4c,$41,$47,$2d
        .byte $0f,$14,$20,$15,$0a,$13,$70,$07,$70,$12,$15,$13,$0e,$70,$0c

    L_07b7:
        jsr $0114

        .byte $0c,$70,$0c,$13,$1a,$21
        .fill $21, $20
        .byte $2f,$13,$10,$01,$03

    L_07e6:
        ora $21

        .fill $18, $0

    L_0800:
        //sei 
       // lda #$37
       // sta $01
       // lda $ff
       // sta $0867
       // lda $0330
       // sta $085d

        * = $0810

    L_0810:
        lda $0331
        sta $0862
        jsr L_fd98 + $b
        jsr L_fd15
        jsr L_ff5b
        cli 
    L_0820:
        lda #$00
    L_0822:
        tay 
    L_0823:
        sta.a $0002,y
        sta $0200,y
        sta $023c,y
        iny 
        bne L_0823
        ldx #$3c
        ldy #$03
        stx $b2
        sty $b3
        jsr L_fd15
        cli 
        lda #$00
        sta vBorderCol
        sta vBackgCol0
        ldx #$00
    L_0845:
        lda #$00
        sta vColorRam + $00,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
        sta vColorRam + $300,x
        lda $6000,x
        sta SCREEN_BUFFER_0 + $00,x
        inx 
        bne L_0845
        lda #$6d
        sta $0330
        lda #$df
        sta $0331
        lda #$00
        sta SCREEN_BUFFER_0 + $100
        jmp L_0400

    L_086e:
         .fill $792, $0

    L_1000:
        jmp L_1079
    L_1003:
        jmp L_10d5

    L_1006:
         .byte $00,$0c,$0c,$0c,$00,$00,$00,$00
        .byte $01,$01

    L_1010:
        .byte $00,$07
        .byte $0e,$fe,$ff,$ff

    L_1016:
        ora ($01,x)
        ora ($01,x)

    L_101a:
         .byte $34,$33,$33

    L_101d:
        eor ($40,x)
        rti 

    L_1020:
         .byte $00,$00,$00,$04,$04,$04,$07
        .byte $0e,$0e,$08,$08,$08

    L_102c:
        .byte $02,$02,$02,$00,$00,$00

    L_1032:
        rti 
        rti 
        rti 

    L_1035:
         .byte $01,$04,$04,$04

    L_1039:
        ora ($00,x)

    L_103b:
         .byte $00,$02,$03,$03,$00
        .byte $01,$01

    L_1042:
        plp 
        rol $2f

    L_1045:
         .byte $00,$00,$00,$00,$30,$00,$00

    L_104c:
        ora #$08
        php 
    L_104f:
        eor ($11,x)
        ora ($48),y
        pla 
        pla 
    L_1055:
        dex 
        dex 
        dex 

    L_1058:
         .byte $04,$00,$00

    L_105b:
        ora ($00,x)

    L_105d:
         .byte $00,$00
        .byte $01,$01

    L_1061:
        .byte $10

    L_1062:
        .fill $17, $0

    L_1079:
        asl 
        asl 
        asl 
        sta L_1045 + $3
        tay 
        lda L_16e3,y
        sta $12bd
        lda #$03
        sta $10db
        lda #$08
        sta sFiltControl
        lda #$00
        ldy #$09
    L_1094:
        sta L_1006,y
        dey 
        bpl L_1094
        ldy #$08
    L_109c:
        sta.a $00e6,y
        dey 
        bpl L_109c
        ldy #$02
    L_10a4:
        lda #$fe
        sta $1013,y
        lda #$68
        sta.a $00e6,y
        lda #$08
        ldx L_1010,y
        sta sVoc1Control,x
        lda #$01
        sta.a $00f3,y
        sta L_1016,y
        sta.a $00e3,y
        dey 
        bpl L_10a4
        sta L_1035
        sta $1019
        ldy #$1f
        lda #$00
    L_10ce:
        sta sVoc1FreqLo,y
        dey 
        bpl L_10ce
    L_10d4:
        rts 


    L_10d5:
        lda L_1035
        beq L_10d4
        lda #$06
        sta sFiltMode
        ldx #$02
    L_10e1:
        ldy L_1010,x
        lda $f9,x
        sta sVoc1FreqLo,y
        lda $fc,x
        sta sVoc1FreqHi,y
        lda L_104c,x
        sta sVoc1PWidthHi,y
        lda L_1045 + $4,x
    L_10f7:
        sta sVoc1PWidthLo,y
        lda L_1055,x
        sta sVoc1SusRel,y
    L_1100:
        lda $1052,x
        sta sVoc1AttDec,y
        lda L_104f,x
        and $1013,x
        sta sVoc1Control,y
        dex 
        bpl L_10e1
        ldy L_1006
        beq L_1124
        dec $1019
        bne L_1124
        sty $1019
        dec $10db
        bmi L_117b
    L_1124:
        lda #$00
        sta $ff
    L_1128:
        dec $ef
    L_112a:
        bpl L_114f
        ldy L_1045 + $3
        lda L_16e2,y
        bpl L_1149
        lda $e2
        eor #$ff
        sta $e2
        bpl L_1146
        lda L_16e2,y
        and #$7f
        sec 
    L_1142:
        sbc #$01
        bpl L_1149
    L_1146:
        lda L_16e2,y
    L_1149:
        and #$7f
        sta $ef
        dec $ff
    L_114f:
        ldx #$02
    L_1151:
        lda $ff
        bpl L_116a
        lda L_1006 + $4,x
        bne L_1166
        lda $f3,x
        cmp L_1020 + $3,x
        bne L_1166
        lda #$fe
        sta $1013,x
    L_1166:
        dec $f3,x
        beq L_118f
    L_116a:
        lda $f0,x
        cmp #$ff
        beq L_1173
        jsr L_134a
    L_1173:
        lda #$00
        sta $ec,x
    L_1177:
        dex 
        bpl L_1151
        rts 


    L_117b:
        ldx #$02
    L_117d:
        lda #$00
        ldy L_1010,x
        sta sVoc1FreqHi,y
        sta sVoc1FreqLo,y
        dex 
        bpl L_117d
        sta L_1035
        rts 


    L_118f:
        ldy $e3,x
        lda L_16f3,y
        sta $e0
        lda L_171c,y
        sta $e1
        lda #$00
    L_119d:
        sta L_102c + $3,x
    L_11a0:
        ldy $e6,x
        lda ($e0),y
        cmp #$ff
        beq L_11ab
        jmp L_1212
    L_11ab:
        dec L_1016,x
        beq L_11b9
        ldy #$00
        sty $e6,x
        lda ($e0),y
    L_11b6:
        jmp L_1212
    L_11b9:
        txa 
        asl 
        adc L_1045 + $3
        tay 
        lda L_16db + $1,y
        sta $e0
        lda L_16dd,y
        sta $e1
        ldy $e9,x
        lda ($e0),y
    L_11cd:
        bne L_11db
        tay 
        sty $e9
        sty $ea
        sty $eb
        lda ($e0),y
        jmp L_11df
    L_11db:
        cmp #$fe
        beq L_117b
    L_11df:
        cmp #$80
        bcc L_11eb
        and #$7f
        sta L_1006 + $1,x
        iny 
        lda ($e0),y
    L_11eb:
        cmp #$70
        bcc L_11f7
        and #$0f
        sta L_1006 + $7,x
        iny 
        lda ($e0),y
    L_11f7:
        cmp #$40
        bcc L_1203
        and #$1f
        sta L_1016,x
        iny 
        lda ($e0),y
    L_1203:
        sta $e3,x
        lda #$00
        sta $e6,x
        inc L_1016,x
    L_120c:
        iny 
        sty $e9,x
        jmp L_118f
    L_1212:
        cmp #$fa
        bne L_121f
        iny 
        lda ($e0),y
        sta $10db
        iny 
        lda ($e0),y
    L_121f:
        cmp #$fd
        bne L_1246
        iny 
    L_1224:
        lda ($e0),y
        sta L_102c + $3,x
        iny 
        lda ($e0),y
        clc 
        adc L_1006 + $1,x
        adc $12bd
        sta $f0,x
        iny 
        lda ($e0),y
        clc 
        adc L_1006 + $1,x
        adc $12bd
        sta L_1032,x
    L_1242:
        iny 
        jmp L_12c1
    L_1246:
        cmp #$e0
        bcc L_1263
        and #$1f
        sta $f6,x
        lda #$ff
        sta $f0,x
        lda #$00
        sta L_104f,x
        sta $1052,x
        sta L_1055,x
        iny 
        sty $e6,x
        jmp L_1343
    L_1263:
        cmp #$c0
        bcc L_1285
        clc 
        adc L_1006 + $7,x
        and #$1f
        sta L_1020 + $6,x
        asl 
        asl 
        asl 
        sec 
        sbc L_1020 + $6,x
        sta L_1020 + $6,x
        iny 
        lda ($e0),y
        cmp #$fd
        beq L_121f
        cmp #$c0
        bcs L_12c1
    L_1285:
        cmp #$80
        bcc L_12a8
    L_1289:
        and #$7f
    L_128b:
        clc 
        adc $f3,x
        sta $f3,x
        sta $f6,x
        iny 
        lda ($e0),y
        cmp #$fd
        beq L_121f
        cmp #$fa
        bne L_12a0
        jmp L_1212
    L_12a0:
        cmp #$c0
    L_12a2:
        bcs L_12c1
        cmp #$80
        bcs L_1289
    L_12a8:
        cmp #$60
        bcc L_12b8
        and #$1f
        sta L_1062 + $2,x
        iny 
        lda ($e0),y
        cmp #$60
        bcs L_12c1
    L_12b8:
        clc 
        adc L_1006 + $1,x
        adc #$fd
        sta $f0,x
        iny 
    L_12c1:
        sty $e6,x
        inc $ec,x
        lda L_1006 + $4,x
        beq L_12d4
    L_12ca:
        lda #$00
    L_12cc:
        sta L_1006 + $4,x
        sta L_1039,x
        beq L_1330
    L_12d4:
        ldy L_1020 + $6,x
        lda $1869,y
        sta L_104f,x
        lda L_186a,y
        sta $1052,x
        lda L_186b,y
        sta L_1055,x
        lda #$00
        sta L_1045 + $4,x
        lda L_186c,y
        and #$0f
        sta L_104c,x
    L_12f6:
        and #$08
        beq L_12fe
        lda #$01
        bne L_1300
    L_12fe:
        lda #$00
    L_1300:
        sta L_105d + $1,x
        lda L_186c,y
        and #$f0
        lsr 
        lsr 
        lsr 
        cmp $f6,x
        bcs L_1314
    L_130f:
        sta L_1020 + $3,x
        bne L_1319
    L_1314:
        lda $f6,x
        sta L_1020 + $3,x
    L_1319:
        lda #$ff
        sta $1013,x
        lda L_1868,y
        sta L_1020,x
        and #$8f
        beq L_1330
        lda #$00
        sta $fc,x
        sta $f9,x
        beq L_1335
    L_1330:
        lda $f0,x
        jsr L_1644
    L_1335:
        ldy $e6,x
        lda ($e0),y
        cmp #$fb
        bne L_1343
        inc L_1006 + $4,x
        iny 
        sty $e6,x
    L_1343:
        lda $f6,x
        sta $f3,x
        jmp L_1177
    L_134a:
        lda $ec,x
        bne L_1351
        jmp L_13d3
    L_1351:
        lda L_102c + $3,x
        beq L_1376
        tay 
        lsr 
        lsr 
        lsr 
        lsr 
        sta $1029,x
        tya 
        and #$0f
        sta L_102c + $3,x
        lda $f6,x
        sec 
        sbc $1029,x
        sta $1029,x
        lda L_1032,x
        sec 
        sbc $f0,x
        sta L_102c,x
    L_1376:
        lda L_1020,x
        bmi L_1398
        and #$0f
        beq L_1398
    L_137f:
        tay 
        lda #$02
        sta L_1062 + $14,x
        lda $1947,y
        sta L_104f,x
        bpl L_1393
        lda #$ff
        sta $fc,x
        bne L_1398
    L_1393:
        lda $f0,x
        jsr L_1644
    L_1398:
        lda #$00
        sta L_1062 + $e,x
        sta L_1062 + $11,x
        sta L_1062 + $5,x
        ldy L_1020 + $6,x
        lda L_186c + $1,y
        sta L_101a,x
        lda L_186e,y
        sta L_101d,x
        lsr 
        lsr 
        lsr 
        lsr 
        sta L_1035 + $1,x
        lda $f6,x
        sec 
        sbc L_1035 + $1,x
        bcs L_13c8
        lda #$00
        sta L_101a,x
        bcc L_13d0
    L_13c8:
        sta L_1035 + $1,x
        lda #$00
        sta L_1039,x
    L_13d0:
        jmp L_14ca
    L_13d3:
        ldy L_102c + $3,x
        beq L_1440
        lda $1029,x
        cmp $f3,x
        bcc L_143d
        lda #$00
        sta $e1
        lda #$07
        dey 
    L_13e6:
        dey 
        bmi L_13ef
        asl 
        rol $e1
        jmp L_13e6
    L_13ef:
        sta $e0
        ldy L_102c,x
        bmi L_1415
        lda $f9,x
        clc 
        adc $e0
        sta $f9,x
        lda $fc,x
        adc $e1
        sta $fc,x
        lda $f9,x
        ldy L_1032,x
        sec 
        sbc L_1644,y
        lda $fc,x
        sbc $168a,y
    L_1411:
        bcc L_143d
        bcs L_1432
    L_1415:
        lda $f9,x
        sec 
        sbc $e0
        sta $f9,x
        lda $fc,x
        sbc $e1
    L_1420:
        sta $fc,x
        ldy L_1032,x
        lda $f9,x
        sec 
        sbc L_1644,y
        lda $fc,x
        sbc $168a,y
        bcs L_143d
    L_1432:
        tya 
        sta $f0,x
        jsr L_1644
        lda #$00
        sta L_102c + $3,x
    L_143d:
        jmp L_14ca
    L_1440:
        lda L_101a,x
        beq L_148d
        lda L_1035 + $1,x
        cmp $f3,x
        bcc L_148d
        lda L_1039,x
        bne L_1490
        lda #$00
        sta L_103b + $4,x
    L_1456:
        lda L_101a,x
        and #$0f
    L_145b:
        lsr 
        adc #$00
        sta L_103b + $1,x
        inc L_1039,x
        ldy $f0,x
        lda L_1644,y
        sec 
        sbc L_1643,y
        sta L_1042,x
        lda $168a,y
        sbc $1689,y
        sta L_1045,x
        lda L_101a,x
        lsr 
        lsr 
        lsr 
        lsr 
        tay 
    L_1481:
        dey 
        bmi L_14ca
        lsr L_1045,x
        ror L_1042,x
        jmp L_1481
    L_148d:
        jmp L_14ca
    L_1490:
        dec L_103b + $1,x
        bpl L_14a5
        lda L_101a,x
        and #$0f
        sta L_103b + $1,x
        lda L_103b + $4,x
        eor #$01
    L_14a2:
        sta L_103b + $4,x
    L_14a5:
        lda L_103b + $4,x
        bne L_14bb
        lda $f9,x
        clc 
        adc L_1042,x
        sta $f9,x
        lda $fc,x
        adc L_1045,x
        sta $fc,x
        bcc L_14ca
    L_14bb:
        lda $f9,x
        sec 
        sbc L_1042,x
        sta $f9,x
        lda $fc,x
        sbc L_1045,x
        sta $fc,x
    L_14ca:
        lda L_101d,x
        and #$0f
        bne L_14d4
        jmp L_155c
    L_14d4:
        ldy $ec,x
        beq L_14e4
        tay 
        lda #$00
        sta L_1058,x
        lda #$01
        sta L_105b,x
        tya 
    L_14e4:
        tay 
        lda L_1764,y
        sta $e0
        lda L_1768 + $1,y
        sta $e1
        ldy #$00
        lda ($e0),y
        sta $1556
        iny 
        lda ($e0),y
        sta $153a
        ldy L_1058,x
        bne L_1508
        lda #$02
        sta L_1058,x
        bne L_155c
    L_1508:
        ldy L_1058,x
        lda ($e0),y
        beq L_1522
        dec L_105b,x
    L_1512:
        bne L_1522
    L_1514:
        sta L_105b,x
        iny 
        lda ($e0),y
    L_151a:
        sta L_1061,x
        iny 
        tya 
        sta L_1058,x
    L_1522:
        lda L_105d + $1,x
        bne L_1543
        lda L_1045 + $4,x
        clc 
        adc L_1061,x
        sta L_1045 + $4,x
        lda L_104c,x
        adc #$00
        sta L_104c,x
        cmp #$0a
        bcc L_155c
        inc L_105d + $1,x
        jmp L_155c
    L_1543:
        lda L_1045 + $4,x
        sec 
        sbc L_1061,x
        sta L_1045 + $4,x
        lda L_104c,x
        sbc #$00
        sta L_104c,x
        cmp #$08
        bcs L_155c
        dec L_105d + $1,x
    L_155c:
        lda L_1020,x
        bpl L_15aa
        and #$0f
        sta $1587
        tay 
        lda L_1768 + $7,y
    L_156a:
        sta $e0
        lda L_1768 + $9,y
        sta $e1
        ldy L_1062 + $e,x
        lda ($e0),y
        bne L_157e
        iny 
        lda ($e0),y
        tay 
        lda ($e0),y
    L_157e:
        sta L_104f,x
        iny 
        tya 
        sta L_1062 + $e,x
        ldy #$ff
        lda L_1768 + $b,y
        sta $e0
        lda L_1768 + $d,y
        sta $e1
        ldy L_1062 + $11,x
        lda ($e0),y
        bne L_159f
        iny 
        lda ($e0),y
        tay 
        lda ($e0),y
    L_159f:
        pha 
    L_15a0:
        iny 
        tya 
        sta L_1062 + $11,x
        pla 
        jsr L_1644
        rts 


    L_15aa:
        lda L_1020,x
        bmi L_15cb
        and #$0f
        beq L_15cb
        dec L_1062 + $14,x
        bne L_15cb
        lda L_104f,x
        bpl L_15c2
        lda $f0,x
        jsr L_1644
    L_15c2:
        ldy L_1020 + $6,x
        lda $1869,y
        sta L_104f,x
    L_15cb:
        lda L_1020,x
        and #$40
        beq L_1643
        lda L_1062 + $2,x
        tay 
        lda L_173d + $9,y
        clc 
        adc #$c0
        sta $e0
        lda #$17
        adc #$00
        sta $e1
        ldy L_1062 + $5,x
        bne L_15f2
        lda ($e0),y
        sta L_1062 + $8,x
        iny 
        jmp L_1607
    L_15f2:
        lda L_1062 + $8,x
        sec 
        sbc #$10
        sta L_1062 + $8,x
        bpl L_163b
        ldy #$00
        lda ($e0),y
        sta L_1062 + $8,x
        ldy L_1062 + $5,x
    L_1607:
        lda ($e0),y
        cmp #$ff
        bne L_1617
        ldy #$00
        lda ($e0),y
    L_1611:
        and #$0f
        tay 
        iny 
        lda ($e0),y
    L_1617:
        cmp #$fe
        bne L_1629
        ldy L_1020 + $6,x
        lda L_1020,x
        and #$fb
        sta L_1020,x
        jmp L_1643
    L_1629:
        sta L_1062 + $b,x
        iny 
        tya 
        sta L_1062 + $5,x
    L_1631:
        lda L_104f,x
        bpl L_163b
        lda L_1062 + $14,x
        bne L_1643
    L_163b:
        lda L_1062 + $b,x
        clc 
        adc $f0,x
        bpl L_1644
    L_1643:
        rts 


    L_1644:
        tay 
        lda L_1644,y
        sta $f9,x
        lda $168a,y
        sta $fc,x
        rts 



        .byte $2e,$38,$5a,$7d,$a3,$cc,$f6,$23,$53,$86,$bb,$f4,$30,$70,$b4,$fb
        .byte $47,$98,$ed,$47,$a7,$0c,$77,$e9,$61,$e1,$68

    L_166b:
        .byte $f7,$8f,$30,$da,$8f
        .byte $4e,$18,$ef,$d2,$c3,$c3,$d1,$ef,$1f,$60,$b5,$1e,$9c,$31,$df,$a5
        .byte $87,$86,$a2

    L_1683:
        .byte $df
        .byte $3e,$c1,$6b,$3c,$39,$63,$be,$4b,$0f,$0c,$45,$bf

    L_1690:
        adc L_d683,x
        adc L_c76e + $5,y
        sbc $0202,x

        .byte $02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04

    L_16a6:
        ora $05
        ora $06
        asl $07

        .byte $07,$07,$08,$08,$09,$09,$0a,$0b,$0b,$0c,$0d,$0e,$0e,$0f,$10,$11
        .byte $12,$13,$15,$16

    L_16c0:
        .byte $17
        .byte $19,$1a,$1c,$1d,$1f,$21,$23,$25,$27,$2a,$2c,$2f,$32

    L_16ce:
        and $38,x

        .byte $3b,$3f,$43,$47,$4b,$4f,$54,$59,$5e,$64,$6a

    L_16db:
        .byte $70,$4c

    L_16dd:
        ora L_1960,y
        sta $19

    L_16e2:
         .byte $02

    L_16e3:
        sbc L_1d67,x

        .byte $6b,$1d,$6f,$1d,$04,$08,$fe,$1d,$07,$1e,$10,$1e,$82

    L_16f3:
        sbc $29c0,x

        .byte $2b,$30,$3b,$5f,$86,$e6,$f7,$04,$c4,$d1,$d1,$2e,$30,$51,$a2,$b8
        .byte $49,$6f,$b6,$2a,$74,$90,$eb,$4d,$de,$23,$c8,$42,$9f,$08,$5e,$f0
        .byte $3e,$1d,$2a,$35,$a3,$aa

    L_171c:
        lda ($19),y

        .byte $1a,$1a,$1a,$1a,$1a,$1a,$1a,$1a,$1b,$1a,$1a,$1b,$1c,$1b,$1b,$1b
        .byte $1b,$1c,$1c,$1c,$1d,$1d,$1d,$1d,$1e,$1e,$1f,$1f,$20,$1e,$1f

    L_173d:
        .byte $1e,$1e,$1f,$1e,$1e,$1e,$19,$19,$19,$00
        .byte $05,$0a,$0f,$14,$19,$1e,$22,$27,$2c,$31,$36,$3b,$41,$46

    L_1755:
        eor L_5998 + $1bc

        .byte $62,$69,$70,$76,$7c,$81,$86

    L_175f:
        .byte $8b,$8f
        .byte $95,$99,$9c

    L_1764:
        ldx #$9b
        ldy #$ab

    L_1768:
         .byte $b0,$b5,$17,$17,$17,$17,$17,$77,$8b,$17,$17,$7b,$93,$17,$17
        .byte $81,$41,$00,$01,$0c,$24,$22,$21,$20

    L_1780:
        .byte $1f
        .byte $1d,$1c,$1c,$1b,$1b,$1a,$1a,$19,$00,$0d,$81,$41,$41,$40,$80,$54
        .byte $00,$04,$48,$2e,$2b,$29,$48,$45,$00,$04,$08,$0a,$01,$10,$00,$03
        .byte $0d,$08,$ff,$08,$80,$18,$14,$01,$50,$00,$08,$0a,$01,$10,$00,$04
        .byte $0c,$01,$ff,$00,$04,$0c,$04,$80,$10,$40,$08,$18,$01,$10

    L_17bf:
        .byte $00,$10,$00,$03,$07,$ff,$10,$00,$04,$07,$ff
        .byte $10,$00

    L_17cc:
        ora $08

        .byte $ff,$10,$00

    L_17d1:
        ora $09

        .byte $ff,$10,$00,$03,$08,$ff,$10,$00,$04,$09,$ff

    L_17de:
        bvc L_17eb + $1

        .byte $00,$ff,$10,$00

    L_17e4:
        ora $0a

        .byte $ff,$10,$00

    L_17e9:
        ora $07

    L_17eb:
         .byte $ff,$10,$00,$04
        .byte $06,$ff

    L_17f1:
        .byte $10,$0c,$00,$00,$ff
        .byte $10,$00

    L_17f8:
        asl $09

    L_17fa:
         .byte $ff,$10,$00,$02,$03,$07,$ff,$00,$00,$03
        .byte $06,$ff,$00,$00,$05,$09,$09,$0c

    L_180c:
        .byte $ff,$00,$00,$04,$07,$07,$0c,$ff,$00,$00,$03
        .byte $08,$08,$0c,$ff,$00,$09,$09,$0c,$00,$05,$ff

    L_1822:
        .byte $00,$07,$07,$0c,$00,$04,$ff,$00
        .byte $08,$08

    L_182c:
        .byte $0c,$00,$03,$ff

    L_1830:
        jsr $0300

        .byte $07,$0c,$ff,$20,$07,$0c,$00,$03,$ff,$00,$00,$03,$07,$ff,$00,$00
        .byte $04,$09,$ff,$00,$00

    L_1848:
        ora $08

    L_184a:
         .byte $ff
        .byte $40,$0c,$00,$ff,$20,$00,$04

    L_1852:
        .byte $07,$0c,$ff,$70,$0c,$00,$ff,$00,$00
        .byte $fe,$20,$00,$05,$07

    L_1860:
        .byte $0c,$ff
        .byte $10,$0c,$07,$05,$00,$ff

    L_1868:
        eor ($41,x)
    L_186a:
        php 
    L_186b:
        dey 

    L_186c:
         .byte $13,$00

    L_186e:
        ora ($00,x)
    L_1870:
        eor ($48,x)
        dex 
        plp 

        .byte $34,$41,$00,$11,$68,$ca,$28,$33,$40,$00

    L_187e:
        eor ($48,x)
        dex 
        inx 

        .byte $34,$41,$00,$11,$68,$cb,$e8,$33,$40,$80,$11,$08,$a8,$f8,$00,$00
        .byte $81,$11,$0d,$e9,$f8,$00,$05,$43,$11,$08,$c9,$f8,$00,$00,$42,$41
        .byte $0a,$a9,$f8,$00,$02,$42,$41,$0a,$a9,$28,$33,$42,$81,$11,$00,$88
        .byte $f8,$00,$00

    L_18b5:
        ora ($43,x)
        php 
        tax 
        sed 

        .byte $03,$00,$42,$41,$00,$99,$f8,$00,$02,$42,$41,$00,$69,$f8,$00,$02
        .byte $42,$41,$00,$49,$f8,$00,$02,$01,$41,$00,$68

    L_18d5:
        clc 

        .byte $00,$00,$42,$41,$00,$6a,$48,$00,$03,$42,$41,$00,$6a,$e8,$00,$03
        .byte $02,$41,$00,$88,$18,$34,$61,$02,$41,$00,$8a

    L_18f1:
        inx 

        .byte $34,$61,$42,$21,$0a,$b9,$f8,$00,$00,$01,$41,$00,$68,$18

    L_1900:
        .byte $33,$00,$02
        .byte $41,$00,$88,$11,$00,$01,$04

    L_190a:
        eor ($00,x)
        dey 
        clc 

        .byte $33,$20,$00,$11

    L_1912:
        .byte $68,$ea,$18,$24,$80,$00

    L_1918:
        ora ($68),y
    L_191a:
        sbc L_24f0 + $8

        .byte $80,$00,$11,$da

    L_1921:
        tax 
        clc 

        .byte $23,$00,$02,$41,$0d,$fa,$f8,$00,$01,$42,$51,$08

    L_192f:
        .byte $fa,$f0,$00,$00,$02,$43,$00
        .byte $9a,$f8,$00,$00,$42,$41,$0a,$89,$24,$34,$44,$02,$41,$06,$ab,$2e
        .byte $34,$45,$81,$11

    L_194a:
        eor ($51,x)
        sty $0301

        .byte $02,$02,$01,$03,$02,$02,$06,$56,$09,$0e,$16,$4c,$09,$16

    L_195d:
        jmp L_2709

    L_1960:
         .byte $8c,$71,$02,$01,$03,$02
        .byte $98,$70,$0f,$8c,$43,$04

    L_196c:
        .byte $07,$0b,$07,$0c,$07,$0b,$07,$0c,$12
        .byte $98,$0d,$8c,$14

    L_1979:
        .byte $07,$0b,$07,$0c,$12,$14,$07,$0b,$07,$0c,$12
        .byte $28,$8c,$71,$02,$02,$01,$03

    L_198b:
        bvs L_199d
        ora $05
        asl 
        asl 
        php 
        asl 
        asl 
        php 
        ora ($13),y
        ora $0a,x
    L_1999:
        asl 
        php 
        ora ($15),y
    L_199d:
        asl 
        asl 
    L_199f:
        php 
        ora ($29),y
        inc L_b0cd,x
        ldy #$7e
        bmi L_1999

        .byte $ff,$c8,$b0,$a0,$7d,$24,$f0,$ff,$c0,$84,$0a,$0c,$0f,$0c,$11,$13
        .byte $16,$13,$c0,$9a,$0c,$e6,$ff,$fa,$06,$c1,$98,$30,$84,$32,$33,$88

    L_19c9:
        sbc L_3277 + $90,x
        and $30,x
        sty $35

        .byte $33,$32,$30,$88,$2f,$2b,$84,$37,$35,$33,$32,$88,$30,$37,$fd,$08
        .byte $35

    L_19e1:
        .byte $37
        .byte $84,$35,$37,$88,$38,$30,$35,$38,$37,$30,$33,$37,$36,$33,$32,$30
        .byte $98,$2f,$88,$2b,$2c,$35,$33,$32,$90,$fd,$07,$32,$33,$88,$30,$2b
        .byte $2c,$38,$35,$30,$98,$fd,$08,$35

    L_1a0a:
        .byte $37
        .byte $84,$35,$37,$38,$30,$35,$38,$3c,$3a,$38

    L_1a15:
        .byte $3a,$37,$30,$33,$37,$3c,$37,$33,$37

    L_1a1e:
        rol $2f,x
    L_1a20:
        and $2b,x

        .byte $33

    L_1a23:
        and #$32

        .byte $82,$27,$2b,$ff,$e6,$ff,$c3,$a0,$a0,$30,$ff,$c5,$94,$00,$86,$00
        .byte $00,$98,$00,$c6,$88,$ff,$c7,$84,$6a,$1f,$24,$26,$24,$27,$24,$26
        .byte $24,$1f,$24,$26,$24,$27,$24,$26,$2b,$20,$24,$26

    L_1a51:
        .byte $24,$27,$24,$26,$24,$20,$24,$26,$24,$27,$24,$26,$2b,$ff
        .byte $c0,$a0,$a0,$66,$0c,$fa,$07,$c0,$a0,$08

    L_1a69:
        .byte $fa
        .byte $08,$c0,$90,$05,$fa,$09,$07

    L_1a71:
        .byte $fa
        .byte $0a,$c0,$a0,$a0,$66,$0c,$fa,$0b,$c0,$a0,$08,$fa,$0c,$c0,$90,$05
        .byte $fa,$0d,$07,$ff,$fa,$0f,$c8,$84,$60,$30,$cd,$60,$c8,$67,$2b,$cd
        .byte $67,$c9,$88,$62,$2b,$c8,$84,$68,$65,$27,$e4,$cc,$84,$27,$e4,$cd
        .byte $84,$27,$e4,$cf,$82,$41,$43,$3f,$3e,$d5,$84,$3c,$c8,$60

    L_1ab0:
        .byte $30,$cd,$c8,$65,$2c,$cd,$c9,$88,$61,$c8,$84,$69,$c9,$8c,$61,$c8
        .byte $84,$60,$30,$ff,$c9,$88,$61,$2e,$d4,$84,$63,$35,$64,$32,$61,$2e
        .byte $ff,$c9,$8c,$61,$2e,$88,$63,$29,$a0,$27,$90,$67,$26,$88,$63,$26
        .byte $cb,$fd,$03,$43,$08,$ff,$c0,$8c,$66,$08,$c0,$c6,$84,$c0,$05,$07
        .byte $0b,$0e,$11,$88,$13,$c6,$ff,$c5,$84,$c7,$6a,$24,$26,$c5,$c5,$c7
        .byte $24,$26,$24,$ff,$c0,$88,$66,$0c,$c6,$84,$c0,$8c,$c6,$84,$c0,$c0
        .byte $88

    L_1b11:
        dec $84
        cpy #$8c
        dec $84
        cpy #$07
    L_1b19:
        dey 
        php 
    L_1b1b:
        dec $84
        cpy #$8c
        php 
        dec $84
        cpy #$07
        ora $11
        dec $c0

        .byte $07,$11,$13,$c6,$ca,$82,$ca

    L_1b2f:
        .byte $ff,$d0,$a0
        .byte $65,$1b,$60

    L_1b35:
        .byte $1d,$61,$1f,$62
        .byte $65,$20,$62,$1f,$6b,$1e,$61,$1f,$65,$20,$62,$1f,$24,$60,$62,$60
        .byte $64,$23,$d1,$ac,$a0,$6c,$24,$ff,$d2,$98,$0c,$84,$0e,$0f,$98,$11
        .byte $84,$13,$14,$8c,$13,$15,$88,$17,$94,$18,$84,$0c,$0e,$0f,$98,$11
        .byte $84,$0f,$0e,$98,$0c,$88,$13,$8c,$12,$15,$88,$0e,$98,$13,$88,$07
        .byte $94,$05,$84,$08,$07,$0b,$88

    L_1b80:
        .byte $0c,$07,$0f,$0c
        .byte $94,$11,$84,$14,$13,$17,$88,$18,$13,$0f,$0c,$94,$11,$84,$14,$11
        .byte $13,$88,$0c,$0e,$0f,$0c,$90,$0e,$07,$d3,$a6,$a6,$0c,$ff,$c0,$84
        .byte $66,$13,$0e,$0b,$0e,$88,$07,$c6,$c0,$a0,$07,$84,$0b,$0e,$11,$14
        .byte $88,$13,$c6,$ff,$c9,$90,$62,$2b,$88,$61,$cb,$fd,$03,$43,$08,$c9
        .byte $a0,$60,$30,$98,$64,$2f,$cb,$88,$fd,$03,$43,$08,$ff,$d7,$82,$24
        .byte $26,$27,$29,$84,$26,$82,$24,$22,$84,$1f,$24,$fd,$29,$22,$21,$21
        .byte $82,$24,$26,$27,$29,$84,$26,$82,$24,$22,$84,$1f,$fd,$29,$24,$26
        .byte $fd,$07,$25,$26,$82,$27,$29,$84,$fd,$29,$2b,$29,$2b

    L_1c01:
        sbc $2c29,x

        .byte $2b,$2c,$fd,$29,$29,$27,$29,$fd

    L_1c0c:
        and #$2b
        and #$2b
        sbc L_2729,x
        rol $27
        sbc L_2729,x
        rol $27
    L_1c1a:
        stx $fd
    L_1c1c:
        and $2326,y
        sbc $2939,x
        rol $88
        sbc L_2c49,x

        .byte $2b,$8a,$fd,$5a,$30,$2f,$ff,$d6,$88,$18,$16,$0f,$11,$18

    L_1c35:
        asl $84,x

        .byte $0f,$11,$88,$13,$18,$11,$16,$0f,$14,$0e,$86,$13,$17,$88,$1a,$8a
        .byte $1f,$ff,$d7,$84,$1f,$1b,$1d,$1a,$1f,$22,$21,$1d,$1f,$1b,$1d,$1a
        .byte $1f

    L_1c58:
        .byte $22,$23,$1f
        .byte $24,$22,$20,$24,$22,$1d,$1f,$22,$20,$1f,$1d,$20,$86,$1f,$23,$88
        .byte $26,$8a,$2b,$ff,$d8,$84,$1f,$24,$2b,$30,$d9,$b0,$2f,$90,$2c,$2b
        .byte $db,$0c,$0d,$0b,$8f,$0c,$e1,$db,$84,$18,$0c,$f0,$84,$13,$12,$e4
        .byte $84,$12,$e4,$8c,$11,$88,$0f,$84
        .fill $1c, $c
        .byte $de,$70,$32,$32,$32,$32,$ff,$d8,$84,$24,$2b,$30,$37,$d9,$b0,$36
        .byte $fb,$90,$35,$33,$dd,$88,$fd,$02,$18

    L_1cc8:
        php 

        .byte $dc

    L_1cca:
        jmp (L_dd30)

        .byte $fd,$02,$18,$08,$dc,$30,$dd,$fd,$02,$18,$08,$dc,$30,$dd,$fd,$02
        .byte $18,$08

    L_1cdf:
        .byte $dc,$87,$30,$e1,$fa,$0f
        .byte $de,$84,$76,$30,$30,$f0,$de,$84,$76,$30,$6d,$e4,$30,$e4,$8c,$77
        .byte $2c,$88,$78,$2b,$fa,$06,$de,$84,$6e

    L_1cfe:
        .byte $27,$27,$27,$27,$27,$27,$27,$27,$fa,$07

    L_1d08:
        and #$29
        and #$29
        and #$29
        and #$29

        .byte $fa,$08,$6f,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$fa,$09,$2e,$2e,$2e
        .byte $2e,$fa,$0f,$c6,$84,$00,$00,$00,$00,$ff,$da,$a0,$a0,$48,$fb,$48
        .byte $9f,$48,$e1,$c5,$84,$00,$c5,$f0,$84,$00

    L_1d3a:
        .byte $00
        .byte $e4,$00,$e4,$8c,$00,$88,$de,$84,$71,$27,$27,$27,$27,$27,$27,$27
        .byte $27,$29,$29,$29,$29

    L_1d50:
        and #$29
        and #$29

        .byte $72,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2e,$2e,$2e,$2e,$73,$32,$32
        .byte $32,$32,$ff

    L_1d67:
        stx L_8c17

        .byte $17,$82,$18,$80,$18

    L_1d6f:
        stx L_8c18 + $1
        ora L_fa00,y
        php 

        .byte $d2,$88,$0c,$07,$03,$00,$01,$05,$0a,$0d,$0c,$07,$03,$00,$05,$08
        .byte $07,$0a,$0c,$07,$03,$00,$90,$00

    L_1d8e:
        ora ($ff,x)
        cmp #$84

        .byte $7c,$24,$26,$27,$29,$88,$fd,$06,$29,$2b,$82,$24,$cd,$2b,$24,$ce
        .byte $2b,$c9,$88,$25,$29,$fd,$06,$2c,$2e,$86,$2c,$82,$fd,$1a,$2e,$2c
        .byte $9c,$fd,$06,$29,$2b,$82,$29,$2b,$84,$fd

    L_1dbc:
        ora $2b
    L_1dbe:
        bit $82cd
        and #$2b
    L_1dc3:
        bit SCREEN_BUFFER_1 + $1ce
        cmp #$2e
        dey 
        sbc L_2f05,x
        bmi L_1d50

        .byte $32,$cd,$30,$32,$ce,$c9,$86,$fd,$06,$30,$32,$82,$33

    L_1ddb:
        cmp SCREEN_BUFFER_2 + $232

        .byte $33,$c9,$94

    L_1de1:
        sbc L_2f05,x

        .byte $30,$d0,$94,$74,$24,$ec,$ff,$d0,$90,$65,$1b,$1b,$19,$19,$1b,$1b
        .byte $60

    L_1df5:
        .byte $1d,$1f,$62,$65,$1b,$f0,$7a,$19,$ff,$8c,$1a,$1a,$1f

    L_1e02:
        stx $1a21

        .byte $1f,$24,$8c,$1b,$1b,$20,$8e,$22,$1b,$20,$25,$8c,$1c,$1d,$1e,$80
        .byte $1e,$8e,$23,$1d,$1e,$1e,$26,$00

    L_1e1d:
        cpy #$88
        adc $c00c,y
        cpy #$18

        .byte $0c

    L_1e25:
        ora #$15
        ora $11

    L_1e29:
         .byte $ff
        .byte $d0,$90,$64,$28,$d0,$d0,$63,$24,$64,$21,$ff

    L_1e35:
        dec $7c88,x
        bmi L_1dbe
        dec L_88dd + $1
        bmi L_1dc3
        dec L_88dd + $1
        and L_2e84
        and L_2b88
        sty $29
        dec L_ff2b

        .byte $fa,$0f,$c0,$90,$7b,$0c,$0c,$0c,$0c,$0c,$0c,$0c

    L_1e59:
        sty $0c

        .byte $07,$0a,$07,$88,$0c,$0c,$84,$18

    L_1e63:
        dey 

        .byte $0c,$0a,$88,$0a,$84,$0a,$10,$11,$15,$16,$88,$05,$05,$84,$11,$88
        .byte $07,$0c,$84,$18

    L_1e78:
        asl $11,x

        .byte $13,$16,$11

    L_1e7d:
        .byte $10,$88,$0c,$0c
        .byte $84,$18

    L_1e83:
        dey 

        .byte $0c,$0a,$88,$0a,$84,$0a,$16,$0a,$0c,$10,$11,$05,$88,$11,$84

    L_1e93:
        .byte $07
        .byte $0a,$07,$88,$0c,$18,$84,$16,$13,$07,$0a,$07,$88,$0c,$0c,$84,$18
        .byte $88,$0c,$0a,$0a,$84,$0a,$16,$0a,$0c,$10,$88,$11,$11,$84,$1d,$07
        .byte $09,$88,$0c,$84,$18,$16,$13,$16,$18,$0a,$07,$88,$0c,$0c,$84,$18
        .byte $88,$0c,$0a,$0a,$84,$0a,$16,$0c,$10,$11,$88,$05,$11,$84,$07,$88
        .byte $13,$0c,$18,$84,$0c,$16,$18,$0a,$0b,$ff,$d0,$98,$64,$28,$88,$28
        .byte $98,$26,$88,$26,$98,$63,$24,$88,$24,$a0,$61,$24,$d0,$90,$64,$28

    L_1ef4:
        plp 
        rol $26

        .byte $63

    L_1ef8:
        bit $24
        adc ($24,x)
        bit $64
        plp 
        plp 
    L_1f00:
        rol $26
        adc ($29,x)
        and #$64
        plp 
        plp 

        .byte $90,$63,$2b,$2b,$29,$29,$64,$2d,$2d,$63,$2b,$2b,$61,$30,$63,$2b
        .byte $29,$61

    L_1f1a:
        rol L_3063

        .byte $64

    L_1f1e:
        and L_61a0

        .byte $30,$ff,$df,$98

    L_1f25:
        .byte $7c,$30,$84
        .byte $30,$ce,$df,$98,$2e,$84,$2e,$ce,$df,$98,$2d,$84,$2d,$ce,$df,$94
        .byte $2b,$cd,$84,$29,$28,$22,$c9,$90,$24,$88,$26,$84,$28,$cd,$26,$c9
        .byte $88,$29,$84

    L_1f4b:
        .byte $2b
        .byte $8c,$2d,$84,$29,$cd,$2d,$c9,$88,$30,$84,$2d,$cd,$30,$c9,$88,$29
        .byte $84,$28,$a4,$2b,$8c,$24,$84

    L_1f63:
        rol $28

        .byte $2b,$cd,$28,$c9,$8c,$2b,$84,$29,$cd,$2b,$c9,$28,$29,$cd,$28,$c9
        .byte $90,$29,$84,$24,$8c,$29,$84,$2b,$27,$26,$a0

    L_1f80:
        bit $c9
        sty $30
        cmp SCREEN_BUFFER_1 + $124
        dey 

        .byte $30,$84,$32,$cd,$30,$c9,$88,$c9,$84,$2e,$90,$c9,$84,$29,$8c,$2e
        .byte $84,$29,$2d

    L_1f9b:
        bit $29
        dey 

        .byte $2b,$84,$18

    L_1fa1:
        asl $13,x
        asl $18,x

        .byte $2b,$cd,$18,$c9,$88,$34,$84,$c9,$88,$c9,$84,$32,$30,$cd,$32,$c9
        .byte $88,$c9,$84,$2e,$88,$29,$84,$2e,$30,$32,$30,$2d,$29,$24,$29,$28
        .byte $24,$a4,$ff,$df,$98,$24,$84,$ce,$df,$98,$26,$84,$ce,$df,$88,$29
        .byte $84,$ce,$df,$2b,$2d,$ce,$2b,$df,$2e,$2d,$2b,$27,$26,$24,$28,$29
        .byte $2a,$de,$88,$2b,$84,$ce,$de,$cc,$de

    L_1fee:
        and #$28
        and #$28
        bit $88
        dec $2b84,x
        and L_2e2e + $2
        and L_2ec1 + $d
        dec SCREEN_BUFFER_2 + $229,x
        and $24de
    L_2003:
        dec L_de29
        sty L_842b
        rol SCREEN_BUFFER_2 + $230
        rol $37de
        dec L_de30
        sty L_843a

        .byte $3c,$ce,$3a,$de,$3c,$ce,$3a,$de,$3c,$ce,$3a,$de,$39,$3a,$39,$88

    L_2025:
        and $84,x
        and #$35

        .byte $3c,$39,$35,$ce,$39,$de,$2e,$ce,$35,$de,$30,$ce,$2e,$de,$88,$37
        .byte $84,$2b,$2e,$30,$34,$35,$36,$37,$ff,$de,$84,$3a

    L_2045:
        and L_46ce,y
        dec SCREEN_BUFFER_2 + $237,x
        eor $de
        and $ce,x

    L_204f:
         .byte $43

    L_2050:
        dec SCREEN_BUFFER_2 + $233,x
        eor ($de,x)
    L_2055:
        bmi L_2025

        .byte $3f,$de,$8c,$2e,$84,$30,$ce,$2e,$de,$3a,$39,$ce,$46,$de,$37,$ce
        .byte $45,$de,$35,$ce,$43,$de,$88,$33

    L_206f:
        sty $34

        .byte $30,$2b,$2e,$30,$36,$37,$3a,$39,$ce,$46,$de,$37,$ce

    L_207e:
        eor $de
        and $ce,x

        .byte $43,$de,$88,$3c,$84,$3a,$39,$3a,$39,$35,$30,$2d,$29,$30,$33,$35
        .byte $36,$37,$33,$98,$30,$84,$1f,$22,$23,$ff

    L_209c:
        .fill $64, $0

    L_2100:
        sei 
        lda #$fb
        sta vRaster
        lda #$12
        sta $fffe
        sta $fffc
        lda #$24
        sta $ffff
        sta L_fffd
        lda #$01
        sta vIRQFlags
        cli 
        rts 


    L_211d:
        ldx #$00
    L_211f:
        lda #$fe
    L_2121:
        sta cCia1PortA
        pha 
        lda cCia1PortB
        sta L_213a,x
        pla 
        inx 
        sec 
        rol 
        bcs L_2121
        lda L_213a + $1
        ora #$80
        sta L_213a + $1
        rts 



    L_213a:
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

    L_2142:
        ldx #$00
        ldy #$04
        lda L_22f9 + $4
        beq L_2159
        lda L_22f9 + $5
        bne L_216d
        lda L_227c + $1,x
        beq L_2170
        lda #$ff
        bmi L_2167
    L_2159:
        lda L_22f9 + $5
        beq L_216d
        lda L_227c + $1,x
        cmp #$08
        beq L_2170
        lda #$01
    L_2167:
        jsr L_21fe
        jmp L_2170
    L_216d:
        jsr L_21e7
    L_2170:
        ldy #$04
        ldx #$02
        lda L_22f9 + $6
        beq L_2187
        lda L_22f9 + $7
        bne L_219b
        lda L_227c + $1,x
        beq L_219e
        lda #$ff
        bmi L_2195
    L_2187:
        lda L_22f9 + $7
        beq L_219b
        lda L_227c + $1,x
        cmp #$08
        beq L_219e
        lda #$01
    L_2195:
        jsr L_21fe
        jmp L_219e
    L_219b:
        jsr L_21e7
    L_219e:
        ldx #$00
        lda L_227c + $1,x
        asl 
        tay 
        jsr L_220f
    L_21a8:
        ldx #$02
        lda L_227c + $1,x
        asl 
        tay 
        jsr L_220f
        lda L_2277 + $2
        sta vSprite0X
        sta vSprite1X
        lda vSpriteXMSB
        and #$fc
        ldx L_227a
        beq L_21c7
        ora #$03
    L_21c7:
        sta vSpriteXMSB
        lda $227b
        sta vSprite0Y
        sta vSprite1Y
        ldx #$41
        stx $cff8
        inx 
        stx $cff9
    L_21dc:
        lda #$0a
        sta vSpr0Col
        lda #$00
        sta vSpr1Col
        rts 


    L_21e7:
        ldy #$03
    L_21e9:
        lda L_227c + $1,x
        cmp #$04
        beq L_21fa
        bcs L_21f6
        lda #$01
        bne L_21fb
    L_21f6:
        lda #$ff
        bne L_21fb
    L_21fa:
        rts 


    L_21fb:
        jsr L_21fe
    L_21fe:
        dec L_227e,x
        bne L_220e
        clc 
        adc L_227c + $1,x
        sta L_227c + $1,x
        tya 
        sta L_227e,x
    L_220e:
        rts 


    L_220f:
        lda L_2277 + $2,x
        clc 
        adc L_225a,y
        sta L_2277 + $2,x
        lda L_227a,x
        adc L_225a + $1,y
    L_221f:
        sta L_227a,x
        lda L_227a,x
        lsr 
        lda L_2277 + $2,x
        ror 
        cmp L_2266 + $6,x
        bcs L_2243
        lda L_2270,x
        sta L_2277 + $2,x
        lda L_2271,x
        sta L_227a,x
        lda #$04
        sta L_227c + $1,x
        jmp L_2259
    L_2243:
        cmp L_226d,x
        bcc L_2259
        lda L_2271 + $3,x
        sta L_2277 + $2,x
        lda L_2275,x
        sta L_227a,x
        lda #$04
        sta L_227c + $1,x
    L_2259:
        rts 



    L_225a:
         .byte $fc,$ff
        .byte $fd,$ff,$fe,$ff,$ff,$ff,$00,$00,$01,$00

    L_2266:
        .byte $02,$00,$03,$00,$04,$00,$0c

    L_226d:
        tax 
        clc 

        .byte $7b

    L_2270:
        clc 

    L_2271:
         .byte $00,$30,$00,$54

    L_2275:
        ora ($f6,x)

    L_2277:
         .byte $00,$00,$17

    L_227a:
        ora ($e0,x)

    L_227c:
         .byte $00,$04

    L_227e:
        ora ($04,x)
        ora ($a0,x)

        .byte $03

    L_2283:
        ldx L_22f9 + $8,y
        lda L_213a,x
        and L_2306,y
        eor L_2306,y
        sta L_22f9 + $4,y
        dey 
        bpl L_2283
        lda L_213a + $7
        and #$10
        eor #$10
        sta L_22f9 + $1
        lda L_213a
        and #$02
        eor #$02
        ora L_22f9 + $1
        sta L_22f9 + $1
    L_22ac:
        lda L_22f9 + $4
        ora L_22f9 + $5
        ora L_22f9 + $6
        ora L_22f9 + $7
        ora L_22f9 + $1
        beq L_22be
        rts 


    L_22be:
        lda cCia1PortA
        tax 
        and #$01
        eor #$01
        ora L_22f9 + $6
        sta L_22f9 + $6
        txa 
        and #$02
        eor #$02
        ora L_22f9 + $7
        sta L_22f9 + $7
        txa 
        and #$04
        eor #$04
        ora L_22f9 + $4
        sta L_22f9 + $4
        txa 
        and #$08
        eor #$08
        ora L_22f9 + $5
        sta L_22f9 + $5
        txa 
        and #$10
        eor #$10
        ora L_22f9 + $1
        sta L_22f9 + $1
        rts 



    L_22f9:
         .byte $01,$00,$00,$00,$00,$00,$00,$00,$04
        .byte $05,$07,$01,$07

    L_2306:
        rti 

        .byte $02,$40,$04,$10,$a0

    L_230c:
        .byte $00
        .byte $a9,$00

    L_230f:
        lda SCREEN_BUFFER_1 + $00,y
        cmp #$af
        bcs L_2320
        lda #$00
        sta SCREEN_BUFFER_1 + $00,y
        lda #$01
        sta vColorRam + $00,y
    L_2320:
        lda SCREEN_BUFFER_1 + $100,y
        cmp #$af
        bcs L_2331
        lda #$00
        sta SCREEN_BUFFER_1 + $100,y
        lda #$01
        sta vColorRam + $100,y
    L_2331:
        lda SCREEN_BUFFER_1 + $200,y
        cmp #$af
        bcs L_2342
        lda #$00
        sta SCREEN_BUFFER_1 + $200,y
        lda #$01
        sta vColorRam + $200,y
    L_2342:
        lda SCREEN_BUFFER_1 + $2f8,y
        cmp #$af
        bcs L_2353
        lda #$00
        sta SCREEN_BUFFER_1 + $2f8,y
        lda #$01
        sta vColorRam + $300,y
    L_2353:
        dey 
        bne L_230f
        lda #$32
        sta L_2926
        rts 


    L_235c:
        lda #$00
        jsr L_1000
        jsr L_2100
    L_2364:
        ldy #$00
        sty $17
    L_2368:
        lda #$09
        sta vColorRam + $00,y
        sta vColorRam + $100,y
        sta vColorRam + $200,y
        sta vColorRam + $300,y
        lda #$00
        sta SCREEN_BUFFER_1 + $00,y
        sta SCREEN_BUFFER_1 + $100,y
        sta SCREEN_BUFFER_1 + $200,y
        sta SCREEN_BUFFER_1 + $2f8,y
        dey 
        bne L_2368
        ldy #$07
        lda #$40
    L_238b:
        sta L_cbf8,y
    L_238e:
        dey 
        bpl L_238b
        ldy #$00
    L_2393:
        lda L_2cee + $12,y
        sta L_c000,y
        lda $2e00,y
        sta $c100,y
        lda L_2eff + $1,y
        sta L_c1ff + $1,y
        lda $3000,y
        sta $c300,y
        lda $3100,y
        sta $c400,y
        lda $3200,y
        sta $c500,y
        lda L_3277 + $89,y
        sta L_c5c7 + $39,y
        lda $3400,y
    L_23c0:
        sta $c700,y
        dey 
        bne L_2393
        lda #$20
        sta vMemControl
        lda #$18
        sta vScreenControl1
        lda #$c2
    L_23d2:
        sta $02
        lda #$29
        sta $03
    L_23d8:
        ldy #$00
        jsr L_2927
        lda L_213a
        and L_213a + $1
    L_23e3:
        and L_213a + $2
        and L_213a + $3
        and L_213a + $4
        and L_213a + $5
        and L_213a + $6
        and L_213a + $7
        cmp #$ff
        bne L_23fe
        lda L_22f9 + $1
        beq L_2401
    L_23fe:
        jmp L_3328
    L_2401:
        jsr L_2407
        jmp L_23d8
    L_2407:
        lda #$00
        sta $275f
    L_240c:
        lda $275f
        beq L_240c
        rts 


        sta L_2760
        stx L_2760 + $1
        sty L_2760 + $2
        lda #$01
        sta vIRQFlags
        sta $275f
        jsr L_211d
        jsr $2281
    L_2429:
        lda $17
        bne L_2436
        jsr $2506
    L_2430:
        jsr L_2451
        jmp L_2444
    L_2436:
        jsr L_2142
        lda L_227a
        lsr 
        lda L_2277 + $2
        ror 
        sta L_2277 + $1
    L_2444:
        jsr L_1003
        lda L_2760
        ldx L_2760 + $1
        ldy L_2760 + $2
        rti 
    L_2451:
        dec L_275e
        beq L_2457
        rts 


    L_2457:
        lda #$02
        sta L_275e
        ldx #$00
    L_245e:
        lda L_2675 + $1,x
        beq L_246d
        txa 
    L_2464:
        clc 
        adc #$0b
        tax 
        cpx #$f2
        bne L_245e
        rts 


    L_246d:
        lda #$00
        sta L_266c,x
        lda #$c8
        sta L_266d,x
        lda #$6a
        sta L_266e,x
        lda #$26
        sta L_266f,x
        lda #$a0
        sta $2670,x
        lda #$00
        sta L_2671,x
        lda #$08
        jsr L_2c45
    L_2490:
        adc #$50
        sta $2674,x
        lda #$ff
        sta L_2675 + $1,x
        lda #$13
        jsr L_2c45
        asl 
        asl 
        tay 
        lda L_24b6,y
        sta L_2672,x
        lda L_24b6 + $1,y
        sta $2673,x
        lda L_24b6 + $2,y
        sta L_2675,x
        rts 


        rts 



    L_24b6:
         .byte $fc,$ff,$00,$00
        .byte $fd,$ff,$01,$00,$fe,$ff,$01,$00,$ff,$ff,$01,$00,$ff,$ff,$02,$00
        .byte $00,$00,$03,$00,$fd,$ff,$ff,$ff,$fe,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$fe,$ff,$00,$00,$fd,$ff,$03,$00,$01,$00,$02,$00,$01,$00
        .byte $01,$00,$01,$00,$01,$00

    L_24f0:
        .byte $02,$00,$04,$00,$00,$00,$03,$00,$ff,$ff,$02,$00,$ff,$ff
        .byte $01,$00,$ff,$ff,$01,$00,$fe,$ff,$a9,$af,$8d,$66,$26,$a2,$00

    L_250d:
        jsr L_2528
        txa 
        clc 
        adc #$0b
        tax 
        cpx #$f2
        bne L_250d
    L_2519:
        ldx #$00
    L_251b:
        jsr L_2608
        txa 
        clc 
    L_2520:
        adc #$0b
        tax 
        cpx #$f2
        bne L_251b
        rts 


    L_2528:
        lda L_2675 + $1,x
        beq L_2533
        jsr $25e3
    L_2530:
        jsr L_2540
    L_2533:
        rts 



        .byte $a9,$00,$9d,$72,$26,$9d,$74,$26,$f0,$f5,$00,$00

    L_2540:
        lda $2674,x
        sta L_2669
        lsr 
        lsr 
        lsr 
        tay 
        cmp #$19
        bcs L_25c0
        lda L_2671,x
        sta L_2668
        lda $2670,x
    L_2557:
        sta $2667
        lsr L_2668
        ror 
        lsr L_2668
        ror 
        lsr L_2668
        ror 
        cmp #$28
        bcs L_25c0
        clc 
        adc L_2634,y
        sta $0a
        sta L_266c,x
        lda L_264b + $2,y
        adc #$00
        sta $0b
        sta L_266d,x
        ldy #$00
        lda ($0a),y
        beq L_2589
        cmp #$af
        bcc L_25c6
        bcs L_2591
    L_2589:
        lda L_2666
        inc L_2666
        sta ($0a),y
    L_2591:
        sta $0c
        lda #$00
        asl $0c
        rol 
        asl $0c
        rol 
        asl $0c
        rol 
        adc #$c0
        sta $0d
        sta L_266f,x
        lda L_2669
        and #$07
        clc 
        adc $0c
        sta $0c
        sta L_266e,x
        lda $2667
        and #$07
        tay 
        lda L_25db,y
    L_25bb:
        ldy #$00
        sta ($0c),y
        rts 


    L_25c0:
        lda #$00
        sta L_2675 + $1,x
        rts 


    L_25c6:
        lda #$00
        sta L_266c,x
        lda #$c8
        sta L_266d,x
        lda #$6a
        sta L_266e,x
        lda #$26
        sta L_266f,x
        rts 



    L_25db:
         .byte $80
        .byte $40,$20,$10,$08,$04,$02,$01,$bd,$6c,$26,$85,$0a,$bd,$6d,$26

    L_25eb:
        sta $0b
        ldy #$00
        lda ($0a),y
        cmp #$af
        bcc L_2607
        lda #$00
        sta ($0a),y
        lda L_266e,x
        sta $0a
        lda L_266f,x
        sta $0b
        lda #$00
        sta ($0a),y
    L_2607:
        rts 


    L_2608:
        lda L_2675 + $1,x
        beq L_2633
        lda $2670,x
        clc 
        adc L_2672,x
    L_2614:
        sta $2670,x
        sta $2667
        lda L_2671,x
        adc $2673,x
        sta L_2671,x
        sta L_2668
        lda $2674,x
        clc 
        adc L_2675,x
        sta $2674,x
        sta L_2669
    L_2633:
        rts 



    L_2634:
         .byte $00
        .byte $28,$50,$78,$a0,$c8,$f0,$18,$40,$68,$90,$b8

    L_2640:
        cpx #$08
        bmi L_269c

        .byte $80,$a8,$d0,$f8,$20,$48,$70

    L_264b:
        .byte $98,$c0,$c8,$c8,$c8,$c8,$c8,$c8,$c8,$c9,$c9,$c9,$c9,$c9,$c9,$ca
        .byte $ca,$ca,$ca,$ca,$ca,$ca,$cb,$cb,$cb,$cb,$cb

    L_2666:
        ldx $b9,y

    L_2668:
         .byte $00

    L_2669:
        rol.a $0000,x

    L_266c:
         .byte $00

    L_266d:
        iny 
    L_266e:
        ror 
    L_266f:
        rol $37

    L_2671:
         .byte $00

    L_2672:
        sbc $33ff,x

    L_2675:
         .byte $ff,$ff,$00
        .byte $c8,$6a,$26,$b1,$00,$01,$00,$33,$fe,$ff,$e8,$ca,$7b,$c5,$c1,$00
        .byte $01,$00,$93,$02,$ff,$00,$c8,$6a,$26,$9f,$00,$ff,$ff,$50,$ff,$ff
        .byte $d4,$cb,$86,$c5

    L_269c:
        ldy #$00

        .byte $00,$00,$c9,$03,$00,$00,$c8,$6a,$26,$91,$00,$fd,$ff,$5c,$01,$ff
        .byte $47,$ca

    L_26b0:
        sta $c5
        lda $0100,x

        .byte $00,$75,$01

    L_26b8:
        .byte $ff,$13
        .byte $ca,$8f,$c5,$5b,$00,$fd,$ff,$6f,$01,$ff,$4e,$c8,$92,$c5,$36,$01
        .byte $02,$00,$0a,$ff,$ff,$03,$cb,$9a,$c5,$5d,$00,$ff,$ff,$9a,$01,$ff

    L_26da:
        .byte $67,$cb
        .byte $a4,$c5,$f9,$00,$01,$00,$ac,$01,$ff,$00,$c8,$6a,$26,$99,$00,$ff
        .byte $ff,$66,$02,$ff,$00,$c8,$6a,$26,$82,$00,$fe,$ff,$43,$ff,$ff,$00
        .byte $c8,$6a,$26,$97,$00,$fd,$ff,$57,$01,$ff,$00,$c8,$6a

    L_2709:
        rol $0c
        ora ($04,x)

        .byte $00,$56,$00,$ff,$00,$c8,$6a,$26,$93,$00,$ff,$ff,$43,$ff,$ff,$16
        .byte $ca,$ad,$c5,$76,$00,$fe,$ff,$6d,$01,$ff,$00,$c8

    L_2729:
        ror 
        rol $b9

        .byte $00,$01,$00,$23,$fe,$ff,$cf,$ca,$c5,$c5,$42,$01,$03,$00,$8e,$01
        .byte $00,$00,$c8,$6a,$26,$7a,$00,$fe,$ff,$3e,$ff,$ff,$44,$ca,$b0,$c5
        .byte $a0,$00,$00,$00,$73,$03,$ff,$00,$c8,$6a,$26,$85,$00,$fd,$ff,$60
        .byte $01,$ff

    L_275e:
        ora ($01,x)

    L_2760:
         .byte $00,$00,$00

    L_2763:
        cmp #$20
        beq L_27ce
        tax 
        ldy $05
        lda $2828,y
        sta $06
        lda L_282e,y
        sta $07
        lda L_2834,y
        sta $08
        lda L_283a,y
        sta $09
        lda $04
        tay 
    L_2781:
        clc 
        adc #$28
        sta $279e
        sta $27c1
        adc #$28
        sta $27ab
        sta $27c8
        lda L_27b3,x
        sta ($06),y
        clc 
        adc #$01
        iny 
        sta ($06),y
        ldy #$4d
        clc 
        adc #$01
        sta ($06),y
        iny 
        clc 
        adc #$01
        sta ($06),y
        ldy #$75
        clc 
        adc #$01
        sta ($06),y
        iny 
        clc 
    L_27b3:
        adc #$01
        sta ($06),y
        ldy $04
        lda #$00
        sta ($08),y
        iny 
        sta ($08),y
    L_27c0:
        ldy #$4d
        sta ($08),y
        iny 
        sta ($08),y
        ldy #$75
        sta ($08),y
        iny 
        sta ($08),y
    L_27ce:
        inc $04
        inc $04
        rts 



    L_27d3:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a9,$9d,$00,$00,$00,$00,$00,$00,$00,$a3,$00,$00,$00,$00,$00,$00
        .byte $00,$01,$07,$0d,$13,$19,$1f,$25,$2b,$31,$37,$3d,$43,$49,$4f,$55
        .byte $5b,$61,$67,$6d,$73,$79,$7f,$85,$8b

    L_280c:
        sta ($97),y
        ora ($05,x)
        ora #$0d
        ora ($15),y
        ora L_211d,y
        and $29
        and $3531
        and $413d,y
        eor $49
        eor L_5551
        eor $615d,y
        adc $a0
        clc 
        bcc L_2834

        .byte $80,$f8

    L_282e:
        iny 
    L_282f:
        cmp #$c9
        dex 
        dex 
        dex 
    L_2834:
        ldy #$18
        bcc L_2840

        .byte $80,$f8

    L_283a:
        cld 
        cmp vColorRam + $2d9,y

        .byte $da,$da

    L_2840:
        php 
    L_2841:
        ldy L_2840
        lda $291d,y
        sta vBackgCol1
        lda L_2914,y
        sta vBackgCol2
        sta vBackgCol3
        ldx #$27
    L_2855:
        lda SCREEN_BUFFER_1 + $a0,x
        cmp #$af
        bcs L_2862
        jsr L_28fa
        sta vColorRam + $a0,x
    L_2862:
        lda SCREEN_BUFFER_1 + $118,x
        cmp #$af
        bcs L_286f
        jsr L_28fa
        sta vColorRam + $118,x
    L_286f:
        lda SCREEN_BUFFER_1 + $190,x
        cmp #$af
        bcs L_287c
        jsr L_28fa
        sta vColorRam + $190,x
    L_287c:
        lda SCREEN_BUFFER_1 + $208,x
        cmp #$af
        bcs L_2889
        jsr L_28fa
        sta vColorRam + $208,x
    L_2889:
        lda SCREEN_BUFFER_1 + $280,x
        cmp #$af
        bcs L_2896
        jsr L_28fa
        sta vColorRam + $280,x
    L_2896:
        lda SCREEN_BUFFER_1 + $2f8,x
        cmp #$af
        bcs L_28a3
        jsr L_28fa
        sta vColorRam + $2f8,x
    L_28a3:
        dex 
        bne L_2855
        ldx #$4f
    L_28a8:
        lda SCREEN_BUFFER_1 + $c8,x
        cmp #$af
        bcs L_28b5
        jsr L_28fe
        sta vColorRam + $c8,x
    L_28b5:
        lda SCREEN_BUFFER_1 + $140,x
    L_28b8:
        cmp #$af
        bcs L_28c2
        jsr L_28fe
        sta vColorRam + $140,x
    L_28c2:
        lda SCREEN_BUFFER_1 + $1b8,x
        cmp #$af
        bcs L_28cf
    L_28c9:
        jsr L_28fe
        sta vColorRam + $1b8,x
    L_28cf:
        lda SCREEN_BUFFER_1 + $230,x
        cmp #$af
        bcs L_28dc
        jsr L_28fe
        sta vColorRam + $230,x
    L_28dc:
        lda SCREEN_BUFFER_1 + $2a8,x
        cmp #$af
    L_28e1:
        bcs L_28e9
        jsr L_28fe
        sta vColorRam + $2a8,x
    L_28e9:
        lda SCREEN_BUFFER_1 + $320,x
        cmp #$af
        bcs L_28f6
        jsr L_28fe
        sta vColorRam + $320,x
    L_28f6:
        dex 
        bne L_28a8
        rts 


    L_28fa:
        lda L_2902,y
        rts 


    L_28fe:
        lda L_290b,y
        rts 



    L_2902:
         .byte $00
        .byte $06,$02,$04

    L_2906:
        ora $03

        .byte $07,$01,$01

    L_290b:
        php 
        asl L_086e + $39c
        ora L_086e + $69d
        ora #$09

    L_2914:
         .byte $00

    L_2915:
        asl $06

    L_2917:
         .byte $0b,$0b,$04,$04
        .byte $0e,$0e,$00,$00,$00,$06,$06,$06,$06,$06,$06

    L_2926:
        .byte $03

    L_2927:
        lda L_2926
        beq L_2930
        dec L_2926
        rts 


    L_2930:
        ldy #$00
        lda ($02),y
        cmp #$60
        bcs L_2941
        jsr L_2763
        jsr L_29b5
        jmp L_2927
    L_2941:
        cmp #$ff
        bne L_2948
        jmp L_3328
    L_2948:
        cmp #$80
        bne L_2953
        jsr $230b
        jsr L_29b5
        rts 


    L_2953:
        cmp #$81
    L_2955:
        bne L_2963
        iny 
        lda ($02),y
        sta L_2926
        jsr L_29b5
        jmp L_29b5
    L_2963:
        cmp #$82
        bne L_297e
        lda L_2840
        clc 
        adc #$01
        sta L_2840
        jsr L_2841
        lda L_2840
        cmp #$08
        beq L_297b
        rts 


    L_297b:
        jmp L_29b5
    L_297e:
        cmp #$83
        bne L_2997
        lda L_2840
        sec 
        sbc #$01
    L_2988:
        sta L_2840
        jsr L_2841
        lda L_2840
        beq L_2994
        rts 


    L_2994:
        jmp L_29b5
    L_2997:
        sec 
        sbc #$84
        sta $05
        lda #$fe
        sta $04
    L_29a0:
        iny 
        inc $04
        inc $04
        lda ($02),y
        bpl L_29a0
        lda #$28
        sec 
        sbc $04
        lsr 
        sta $04
        jsr L_29b5
        rts 


    L_29b5:
        inc $02
        bne L_29bb
        inc $03
    L_29bb:
        rts 


    L_29bc:
        inc vBorderCol
        jmp L_29bc

        .byte $80,$84,$50,$20,$49,$20,$4e,$20,$59,$20,$4f,$20,$48,$4f,$55,$53
        .byte $45,$86,$50,$52,$4f,$55,$44,$4c,$59,$20,$50,$52,$45,$53

    L_29e0:
        eor $4e

        .byte $54,$53,$82,$81,$96,$83,$80,$85,$53,$20,$55,$20,$50,$20,$52,$20
        .byte $45,$20,$4d,$20,$41,$20,$43,$20

    L_29fa:
        .byte $59,$82,$81,$c8,$83,$80
        .byte $84,$43,$4f,$50,$59,$52

    L_2a06:
        eor #$47
        pha 

        .byte $54,$20,$31,$39,$39,$30,$85,$56,$49,$52,$47,$49,$4e,$20,$4d,$41

    L_2a19:
        .byte $53,$54

    L_2a1b:
        eor $52

        .byte $54,$52,$4f,$4e,$49,$43,$86,$41,$4c,$4c,$20,$52

    L_2a29:
        eor #$47
        pha 

        .byte $54,$53,$20,$52,$45,$53,$45,$52,$56,$45,$44,$82,$81,$96,$83,$80
        .byte $84,$50

    L_2a3e:
        .byte $52,$4f,$47,$52
        .byte $41,$4d,$4d,$49,$4e,$47,$20,$42,$59,$86,$4e,$49,$43,$4b,$20,$4a
        .byte $4f

    L_2a53:
        .byte $4e,$45,$53,$82
        .byte $81,$fa,$83,$80,$84,$47,$52

    L_2a5e:
        eor ($50,x)
    L_2a60:
        pha 
        eor #$43

        .byte $53,$20,$42,$59,$86,$48,$55,$47,$48,$20,$52,$49,$4c,$45,$59,$82
        .byte $81,$fa,$83,$80,$84,$4d,$55,$53,$49,$43

    L_2a7d:
        jsr L_4e35 + $c

        .byte $44,$20,$46,$58,$86,$4a,$45,$52,$4f,$45,$4e,$20,$54,$45,$4c,$87
        .byte $54

    L_2a91:
        .byte $48,$45,$20,$53,$4f
        .byte $4e,$49,$43,$20,$43,$49,$52,$43,$4c,$45,$82,$81,$af,$83,$80

    L_2aa5:
        sty $43

        .byte $4f,$4e,$43,$45,$50,$54,$20,$42,$59

    L_2ab0:
        stx $44
        eor ($56,x)
        eor #$44
    L_2ab6:
        jsr L_4550

        .byte $52,$52,$59,$87,$4e,$49,$43,$4b

    L_2ac1:
        jsr L_5242

        .byte $55,$54,$59,$82,$81,$96,$83,$80,$84,$54,$41,$50,$45,$20,$50,$52
        .byte $4f,$54,$45,$43,$54,$49,$4f,$4e,$86,$4e

    L_2ade:
        eor #$43

        .byte $4b,$20,$4a,$4f,$4e,$45,$53,$87,$4a,$4f,$48,$4e,$20,$54,$57,$49
        .byte $44,$44,$59,$82,$81,$96,$83,$80,$84,$44,$45,$56,$45,$4c,$4f

    L_2aff:
        bvc L_2b46

        .byte $44,$20,$42,$59,$86,$50,$52,$4f,$42,$45,$20,$53,$4f,$46,$54,$57
        .byte $41,$52,$45,$20,$4c,$54,$44,$82,$81,$96,$83,$80,$84,$44,$45,$53
        .byte $49,$47,$4e,$20,$53

    L_2b26:
        eor $50,x
        bvc L_2b79

        .byte $52,$54,$86,$44,$41,$56,$49,$44,$20,$42,$49,$53,$48,$4f,$50,$87
        .byte $49,$41,$4e,$20,$4d,$41,$54,$48,$49,$41,$53,$88

    L_2b46:
        lsr 

        .byte $4f,$20,$42,$4f,$4e,$41,$52,$89,$4a,$4f,$48,$4e,$20,$4d,$41,$52
        .byte $54,$49,$4e,$82,$81,$4e,$83,$80,$84,$4d,$41,$4e,$55,$41,$4c,$86
        .byte $47,$52,$41,$45,$4d,$45,$20,$4b,$49,$44,$44,$82,$81,$4e,$83,$80
        .byte $84,$50

    L_2b79:
        eor ($43,x)

        .byte $4b,$41,$47,$49,$4e,$47,$86,$44,$45,$52,$4d,$4f,$54

    L_2b88:
        jsr $4f50

        .byte $57,$45,$52,$87,$4b,$48,$41,$52,$54,$4f,$4d,$42,$82,$81,$4e,$83
        .byte $80,$84,$51,$55,$41,$4c,$49,$54,$59,$20,$41,$53,$53,$55,$52,$41
        .byte $4e,$43,$45,$86,$44,$41,$56,$49,$44,$20,$42,$49,$53,$48,$4f,$50
        .byte $82

    L_2bbc:
        sta ($4e,x)

        .byte $83,$80,$84,$47,$41,$4d,$45,$20,$54,$45,$53,$54,$49,$4e,$47,$86
        .byte $41,$4e,$44,$52,$45,$57,$20,$57,$52

    L_2bd7:
        .byte $49,$47,$48,$54,$87,$54
        .byte $45,$52

    L_2bdf:
        .byte $52

    L_2be0:
        eor L_4820,y
        eor ($59,x)
        lsr L_5343 + $2
        dey 

        .byte $53,$54,$45,$56,$45,$20,$43,$4c,$41,$52

    L_2bf3:
        .byte $4b,$82
        .byte $81,$4e,$83,$80,$84,$50,$52,$4f,$44,$55,$43,$54

    L_2c01:
        eor #$4f
        lsr L_5286

    L_2c06:
         .byte $4f,$53
        .byte $45,$20,$44,$41,$4c,$54,$4f,$4e,$87,$4a,$55,$4c,$49,$45,$20,$53
        .byte $4e,$45,$4c,$4c,$82,$81,$4e,$83,$80,$84,$44,$49,$52,$45,$43,$54
        .byte $45,$44,$20,$42,$59

    L_2c2d:
        .byte $86,$46,$45,$52,$47
        .byte $55,$53,$20,$4d,$43,$47,$4f,$56,$45,$52,$4e,$82,$81,$c8,$83,$80
        .byte $81,$30,$ff

    L_2c45:
        clc 
        adc #$01
        pha 
    L_2c49:
        lda L_2ce6
        clc 
        adc #$07
        sta $2ce8
        sta $2cea
        lda L_2ce7
        adc #$00
        sta L_2ce9
        sta L_2ceb
        asl $2ce8
        rol L_2ce9
        asl $2ce8
        rol L_2ce9
        lda L_2ce9
        sta L_2cec + $1
        lda $2ce8
        sta L_2cec
        asl $2ce8
        rol L_2ce9
        lda $2ce8
        clc 
        adc L_2cec
        sta $2ce8
        lda L_2ce9
        adc L_2cec + $1
    L_2c8e:
        sta L_2ce9
        lda $2ce8
        clc 
        adc $2cea
        sta $2ce8
        sta L_2ce6
        lda L_2ce9
        adc L_2ceb
        sta L_2ce9
        sta L_2ce7
        eor L_2ce6
        sta $2ce8
        pla 
        pha 
        lda #$00
        sta $2cea
        sta L_2ceb
        lda #$08
        sta L_2cec
        pla 
    L_2cc0:
        asl $2cea
        rol L_2ceb
        asl 
        bcc L_2cdd
        pha 
        lda $2cea
        clc 
        adc $2ce8
        sta $2cea
        lda L_2ceb
        adc #$00
        sta L_2ceb
        pla 
    L_2cdd:
        dec L_2cec
        bne L_2cc0
        lda L_2ceb
        rts 



    L_2ce6:
         .byte $00

    L_2ce7:
        adc #$69
    L_2ce9:
        adc #$34
    L_2ceb:
        php 

    L_2cec:
         .byte $00,$34

    L_2cee:
        .fill $1a, $0
        .byte $3f

    L_2d09:
        bvs L_2d6b
        jmp (L_c067 + $1)

    L_2d0e:
         .byte $c0,$c0,$f0,$18
        .byte $08

    L_2d13:
        .byte $00,$00,$00
        .byte $c0,$c0,$c3,$c0,$c0,$d5,$c0,$d4,$c0,$d4,$c0,$00

    L_2d22:
        .byte $00,$54,$00,$54
        .byte $c0,$d4,$d4,$d4,$d4,$e8,$d4,$e8,$e8,$c0,$d4,$d4,$d4,$e8

    L_2d34:
        .byte $d4
        .byte $e8,$e8,$c0,$ff,$c0,$c0,$d8,$d0,$c0,$c0,$c0,$e0,$30,$18,$00,$00
        .byte $00,$c0,$c0,$c3,$c0,$c0,$d5,$c0,$d4,$c0,$d4,$c0,$00,$00,$70,$08
        .byte $5c,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$ea,$c0,$d4,$d4,$54,$a8,$54
        .byte $a4,$90,$00,$0f,$38,$60

    L_2d6b:
        jmp (L_c0c7 + $1)

        .byte $c0,$c0,$e0,$30,$18,$00,$00,$00,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4
        .byte $c0,$d4,$c0,$c0,$c0,$00

    L_2d84:
        sed 

        .byte $d4,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$3a,$0c,$d4,$54,$54,$a8,$54
        .byte $a4,$90,$00,$ff,$c0,$cc,$c8,$c0,$c0,$c0,$c0,$e0,$30,$18

    L_2da3:
        .byte $00,$00,$00
        .byte $c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0,$d4,$c0,$d4
        .byte $c0,$d4,$d4,$d7,$d5,$ea,$d7

    L_2dbd:
        nop 
        nop 
        cpy #$d4

        .byte $d4,$54,$a8,$54,$a4,$90,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc

    L_2dd1:
        .byte $00,$00,$00,$00,$00,$00,$00
        .byte $c0,$c3,$c0,$d4,$c0,$d4,$c0,$d4,$00,$f0,$00,$00,$00,$00,$00,$00
        .byte $d4,$d7,$d5,$ea,$d5,$ea,$ea,$c0,$00,$fc,$54,$a8,$54,$a8,$a8,$00
        .byte $ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc

    L_2e01:
        .byte $00,$00,$00,$00,$00,$00,$00
        .byte $c0,$c3,$c0,$d4,$c0,$d4,$c0,$d4

    L_2e10:
        .byte $00,$f0,$00,$00,$00,$00,$00,$00,$d4,$d4,$d4
        .byte $e8,$d4

    L_2e1d:
        inx 
        inx 
        cpy #$00

        .byte $00,$00,$00,$00,$00,$00,$00,$0f,$38,$60,$6c,$c8,$c0

    L_2e2e:
        .byte $c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00
        .byte $c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$00,$00,$00,$00,$f8,$d4,$c0,$d4
        .byte $d4,$d7,$d5,$ea,$d5,$ea,$3a,$0c,$d4,$54,$54,$a8,$54,$a4,$90,$00
        .byte $fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0

    L_2e63:
        cpy #$c0
        cpy #$c0
        cpy #$c3
        cpy #$c0
        cmp $c0,x
        cmp $c0,x

        .byte $d4,$c0,$00,$00,$54,$00,$54,$00,$54,$d4,$d4,$d4,$e8,$d4

    L_2e7d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8

    L_2e84:
        .byte $d4
        .byte $e8,$e8,$c0,$ff,$c0,$d8

    L_2e8b:
        .byte $d0,$c0
        .byte $c0,$c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c,$0d,$0c
        .byte $0d,$0c,$0d,$00,$00,$00,$40,$00,$40,$00,$40,$0d,$fd,$d5,$ea,$d5
        .byte $ea,$ea,$c0,$40,$7c,$54,$a8,$54,$a8,$a8,$00,$ff,$c0,$d8,$d0,$c0
        .byte $c0,$c0,$c0,$fc

    L_2ec1:
        .byte $00,$00,$00,$00,$00,$00,$00,$03,$03,$03,$03,$03,$03,$03,$03,$00
        .byte $00,$00,$50,$00

    L_2ed5:
        bvc L_2ed7

    L_2ed7:
         .byte $50,$0d
        .byte $fd,$d5,$ea,$d5,$ea

    L_2ede:
        nop 
        cpy #$50

        .byte $50,$50,$a0,$50,$40,$00,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc
        .byte $c0,$c0,$c0,$c0

    L_2ef5:
        cpy #$c0

        .byte $80,$c3,$c0,$c0,$d5,$c0,$d5,$c0

    L_2eff:
        .byte $d4,$00,$00,$00
        .byte $70,$08

    L_2f05:
        .byte $5c,$00,$54,$d4,$d4,$d4
        .byte $e8,$d4

    L_2f0d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$d4,$d7,$d5,$ea,$d5,$ea,$ea,$c0,$00
        .byte $fc,$54,$a8,$54,$a8,$a8,$00,$f8,$cc,$c6,$d3,$d1,$c1,$c0,$c0,$3c
        .byte $60,$c0,$80,$00,$00,$00,$00,$c0,$c0,$c0,$d5,$c0,$d4,$c0,$d4,$00
        .byte $00,$00,$54,$c0,$d4,$c0,$d4,$d4,$d4,$d4,$e8,$d4,$e8,$e8,$c0,$d4
        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$f0,$d8,$d8,$cc,$cc,$c6,$d6,$c2

    L_2f80:
        .byte $fc
        .byte $c0,$c0

    L_2f83:
        cpy #$c0
        cpy #$c0
        cpy #$c3
        cpy #$c0
        cmp $c0,x
    L_2f8d:
        cmp $c0,x

        .byte $d4,$c0,$00

    L_2f92:
        .byte $00,$54,$00,$54,$00,$54,$d4,$d4,$d4

    L_2f9b:
        inx 

        .byte $d4

    L_2f9d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4

    L_2fa3:
        inx 

        .byte $34,$38,$38,$00,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0,$30,$18,$00
        .byte $00,$00,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0,$d4
        .byte $c0,$d4,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea

    L_2fce:
        .byte $3a,$0c,$d4,$54,$54
        .byte $a8,$54,$a4,$90,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$e0,$30,$18
        .byte $00,$00,$00,$c0,$c0,$c0,$c3,$c0,$d5,$c0,$d5,$c0,$d4,$c0,$00,$00
        .byte $50,$00

    L_2ff5:
        rti 

        .byte $00,$00,$d4,$d4,$d4

    L_2ffb:
        inx 

        .byte $d4

    L_2ffd:
        inx 
        inx 
        cpy #$00

    L_3001:
         .byte $00,$00,$00,$00,$00,$00,$00,$0f
        .byte $38

    L_300a:
        rts 


        jmp (L_c0c7 + $1)

    L_300e:
         .byte $c0,$c0,$e0,$30,$18,$00,$00,$00
        .byte $c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0,$d4,$c0,$d4
        .byte $c0,$d4

    L_3028:
        .byte $d7,$d4,$d4
        .byte $e8,$d4,$ea

    L_302e:
        .byte $3a,$0c,$d4,$74,$5c
        .byte $ac,$1c,$24,$28,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0

    L_303f:
        cpy #$e0
        bmi L_305b

        .byte $00,$00,$00,$c0,$c0,$c0,$c3,$c0,$d5,$c0,$d5,$c0,$d4,$c0,$00

    L_3052:
        .byte $14
        .byte $70,$08

    L_3055:
        .byte $5c,$00,$54,$d4,$d4,$d4

    L_305b:
        inx 

        .byte $d4

    L_305d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4

    L_3063:
        inx 

        .byte $d4,$e8,$e8,$c0,$0f

    L_3069:
        sec 
        rts 


        jmp (L_c0c7 + $1)

        .byte $c0,$c0,$e0,$30,$18,$00,$00,$00,$c0,$c0,$c0,$c0,$c0,$15,$03,$00
        .byte $fc,$d4,$00,$c0,$30,$58,$0c,$54,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea
        .byte $3a,$0c,$d4,$54,$54,$a8,$54,$a4,$90,$00,$ff,$c0,$d8

    L_309b:
        bne L_305d
    L_309d:
        cpy #$c0
        cpy #$fc

        .byte $00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c,$0d,$0c,$0d,$0c,$0d,$00
        .byte $00,$00,$40,$00,$40,$00,$40,$0d,$0d,$0d,$0e,$0d,$0e

    L_30be:
        asl L_400b + $1
        rti 
        rti 

        .byte $80,$40

    L_30c5:
        .byte $80,$80,$00,$fc
        .byte $c0,$d8,$d0,$c0

    L_30cd:
        cpy #$c0
        cpy #$fc
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0
        cpy #$c0

        .byte $d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$d4,$d7,$d5
        .byte $ea,$d5,$ea,$3a,$0c,$d4,$54,$54,$a8,$54,$a4,$90,$00,$fc,$c0,$d8

    L_30fb:
        .byte $d0,$c0
        .byte $c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$d4,$c0
        .byte $d4,$c0,$d4,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$d4,$d7,$d5,$2a,$35
        .byte $0a,$0e,$00,$d4

    L_3121:
        .byte $54,$54,$90,$50,$80
        .byte $40,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$c0,$d5,$c0,$d5,$c0,$d5,$c0,$c0,$c0,$d4,$00,$54
        .byte $00,$54,$d5,$d5,$d4,$e8,$d0,$e0,$c0,$c0,$54,$94,$d4,$28,$14,$08
        .byte $08,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0
        .byte $c0,$80,$c3,$c0,$00,$15,$30,$d5,$c0,$d4,$00,$00,$00,$70,$08,$5c
        .byte $00,$54,$d4,$d4,$d4,$e8,$d4

    L_317d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$f8,$c0,$d8,$d0,$c0,$c0,$c0,$c1,$fc
        .byte $c0,$c0,$c0,$c0,$c0,$c0,$80,$c0,$c0,$30,$0d,$0c,$0d,$0c,$0d,$00
        .byte $00,$00,$40,$00,$40,$00,$40,$0d,$0d,$0d,$0e,$0d,$0e,$0e,$0c,$40
        .byte $40,$40,$80,$40,$80,$80,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc
        .byte $00,$00,$00,$00,$00,$00,$00,$03,$03,$0c,$0d,$0c,$35,$30,$35,$00
        .byte $00,$00,$50,$00

    L_31d5:
        rti 

        .byte $00,$40

    L_31d8:
        .byte $35,$d5,$d5,$ea,$d5,$ea,$ea,$c0,$40,$7c,$54
        .byte $a8,$54,$a8,$a8,$00,$0f,$18,$30,$6c,$c8,$c0,$c0,$c0,$c0

    L_31f1:
        .byte $00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c
        .byte $0d,$0c,$0d

    L_31fe:
        .byte $0c
        .byte $0d,$00,$00,$00,$40,$00

    L_3205:
        rti 

        .byte $00,$40,$0d,$fd,$d5,$ea,$d5,$ea,$ea,$c0,$40,$7c,$54,$a8,$54,$a8
        .byte $a8,$00,$0f,$38,$60,$6c,$c8,$c0

    L_321e:
        .byte $c0,$c0,$e0,$30,$18,$00,$00,$00
        .byte $c0,$c0

    L_3228:
        cpy #$c0
        cpy #$55

    L_322c:
         .byte $00,$14,$00,$fc

    L_3230:
        cpy #$c0

        .byte $00,$54,$00,$54,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$3a,$0c,$d4,$54
        .byte $54,$a8,$54,$a4,$90,$00,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0,$30
        .byte $18,$00,$00,$00,$c0,$c0

    L_3258:
        cpy #$c0
        cpy #$d4
        cpy #$d4
        cpy #$d4
        cpy #$c0
    L_3262:
        cpy #$d4
        cpy #$d4
        cpy #$d4

        .byte $d4,$d7,$d5,$ea,$d5,$ea

    L_326e:
        .byte $3a,$0c,$d4,$54,$54
        .byte $a8,$54,$a4,$90

    L_3277:
        .fill $b1, $0

    L_3328:
        lda #$01
    L_332a:
        sta $17
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        jsr L_33df
        lda #$38
        sta vMemControl
        lda #$c0
    L_333e:
        ldx #$3b
        jsr L_3c84
        lda #$ff
        sta L_3935
    L_3348:
        jsr L_3498
        lda #$3b
        sta vScreenControl1
    L_3350:
        jsr L_3399
        bne L_3350
    L_3355:
        jsr L_2407
        jsr L_33b4
        jsr L_337e
    L_335e:
        beq L_3375
        lda #$04
        sta L_1006
        ldx #$46
    L_3367:
        jsr L_2407
        dex 
        bne L_3367
        lda L_3935
        sta $ff
        jmp L_0800
    L_3375:
        jsr L_3399
        beq L_3355
        bne L_3348
        beq L_3348
    L_337e:
        lda $227b
        sec 
        sbc #$d9
        cmp #$10
        bcs L_3396
    L_3388:
        lda L_2277 + $1
        sec 
        sbc #$7c
        cmp #$23
        bcs L_3396
        lda L_22f9 + $1
        rts 


    L_3396:
        lda #$00
        rts 


    L_3399:
        lda $227b
        sec 
        sbc #$d9
        cmp #$10
        bcs L_33b1
        lda L_2277 + $1
        sec 
        sbc #$40
        cmp #$34
        bcs L_33b1
        lda L_22f9 + $1
        rts 


    L_33b1:
        lda #$00
        rts 


    L_33b4:
        lda L_3935
        and #$03
        asl 
        asl 
        asl 
        tax 
        lda L_3457 + $1,x
        sta $16
        lda L_3457 + $2,x
        sta $14
    L_33c7:
        lda L_3457 + $3,x
        sta $10
        lda L_3457 + $4,x
        sta $11
        lda L_345c,x
        sta $0e
        lda L_345d,x
        sta $0f
        jsr L_33ea
        rts 


    L_33df:
        ldx #$08
        ldy #$00
    L_33e3:
        dey 
        bne L_33e3
        dex 
        bne L_33e3
        rts 


    L_33ea:
        lda $10
        sta $04
        lda $11
        sta $05
    L_33f2:
        inc L_3457
        lda L_3457
        and #$0f
        clc 
        adc $14
        tax 
    L_33fe:
        jsr L_3437
    L_3401:
        lda $04
        cmp $0e
        beq L_340c
        inc $04
        jmp L_33fe
    L_340c:
        jsr L_3437
        lda $05
        cmp $0f
        beq L_341a
        inc $05
        jmp L_340c
    L_341a:
        jsr L_3437
        lda $04
        cmp $10
        beq L_3428
        dec $04
        jmp L_341a
    L_3428:
        jsr L_3437
        lda $05
        cmp $11
        beq L_3436
        dec $05
    L_3433:
        jmp L_3428
    L_3436:
        rts 


    L_3437:
        ldy $05
        lda L_3fc0,y
        clc 
        adc $04
        sta $12
        lda L_3fd7 + $2,y
        adc #$00
        clc 
        adc #$cc
        sta $13
        ldy #$00
        lda ($12),y
        and $16
        ora L_3476 + $2,x
    L_3454:
        sta ($12),y
        rts 



    L_3457:
         .byte $00,$0f,$00,$00,$00

    L_345c:
        asl 
    L_345d:
        php 

        .byte $00,$00,$f0,$10,$00,$08

    L_3464:
        asl 

        .byte $10,$00,$00,$0f,$00,$00,$10,$0a,$18,$00,$00,$0f,$00,$00,$00,$0a
        .byte $18

    L_3476:
        .byte $00,$00,$00
        .byte $60,$b0,$40,$e0,$50,$f0,$70,$70,$f0,$50,$e0,$40,$b0,$60,$00,$00
        .byte $06,$0b,$04,$0e,$05,$0f,$07,$07,$0f

    L_3492:
        ora $0e

        .byte $04,$0b,$06,$00

    L_3498:
        ldy #$77
        ldx #$3a
        lda L_3935
        clc 
        adc #$01
        and #$03
        sta L_3935
        beq L_34b1
        cmp #$03
        bne L_34b8
        ldy #$36
        ldx #$39
    L_34b1:
        tya 
        jsr L_3c84
        jmp L_34bf
    L_34b8:
        lda #$d0
        ldx #$34
        jsr L_3c84
    L_34bf:
        jsr L_38d5
        lda L_3935
        asl 
        tay 
        lda L_34fb,y
        ldx $34fc,y
        jmp L_3c84

        .byte $86,$00,$00,$00,$18,$cc,$01,$86,$0a,$00,$0a,$18,$cc,$01,$86,$01
        .byte $00,$09,$00,$cc,$01,$86,$01,$08,$09,$08,$cc,$01,$86,$01,$10,$09
        .byte $10,$cc,$01,$86,$01,$18,$09,$18

    L_34f8:
        cpy $ff01
    L_34fb:
        ldy $37,x
        ldx $36

        .byte $9e,$35,$03,$35,$83,$0c,$02,$85,$a6

    L_3508:
        lsr 
        lsr L_4d35 + $c
    L_350c:
        eor $3a

        .byte $52,$4f,$52,$4e,$83,$0c,$03,$53,$50,$45,$43,$49,$45,$53,$3a,$55
        .byte $4e,$4b,$4e,$4f,$57,$4e,$83,$0c,$04,$47,$41,$4c

    L_352a:
        eor ($43,x)

        .byte $54,$49,$43,$20,$44,$4f

    L_3532:
        .byte $4d,$41,$49,$4e,$3a,$33,$32
        .byte $20,$50,$4c

    L_353c:
        .byte $41,$4e,$45,$54,$83,$0c
        .byte $05,$4e,$45,$55,$52,$41,$4c,$20,$43,$41,$50,$41,$43,$49,$54,$59
        .byte $3a,$39,$39,$20,$25,$83,$0c,$06,$50,$48,$59,$53,$49,$43,$41,$4c
        .byte $20,$43,$41,$50,$41,$43,$49,$54,$59,$3a,$39,$39,$20,$25,$83,$0c
        .byte $0b,$59,$4f,$55,$20,$48,$41,$56,$45,$20,$4d,$59,$20,$53,$59,$4d
        .byte $50,$41,$54

    L_3585:
        pha 
        eor L_832e,y

        .byte $0c,$10,$46,$45,$41,$54,$55,$52,$45,$53,$3a,$20,$55,$4e,$4b,$4e
        .byte $4f,$57,$4e,$2e,$ff,$83,$0c,$02,$85,$a6,$4a,$4e,$41,$4d,$45,$3a
        .byte $4b,$52,$41,$52,$54,$83,$0c,$03,$53,$50,$45,$43,$49,$45,$53,$3a
        .byte $41,$4d,$50,$48,$52,$45,$50,$83,$0c,$04,$47,$41,$4c,$41,$43,$54
        .byte $49,$43,$20,$44,$4f,$4d,$41,$49,$4e,$3a,$33,$32,$20,$50,$4c,$41
        .byte $4e,$45,$54,$83,$0c,$05,$4e,$45,$55,$52,$41,$4c,$20,$43,$41,$50
        .byte $41,$43,$49,$54,$59,$3a,$20,$37,$39,$25,$83,$0c,$06,$50,$48,$59
        .byte $53,$49,$43,$41,$4c,$20,$43,$41,$50,$41,$43,$49,$54,$59,$3a,$20
        .byte $38,$33,$25,$83,$0c,$09,$50,$48,$59,$53,$49,$43,$41,$4c,$4c,$59
        .byte $20,$41,$4e,$44,$20,$4d,$45

    L_3620:
        lsr L_4154
    L_3623:
        jmp L_594c

        .byte $83,$0c,$0a,$56,$45,$52,$59,$20,$53

    L_362f:
        .byte $54,$52,$4f
        .byte $4e,$47,$2c

    L_3635:
        jsr $414d

        .byte $4b,$45,$53,$20,$54,$48,$45,$83,$0c,$0b,$41,$4d,$50,$48,$52,$45
        .byte $50,$20,$53,$50

    L_364c:
        .byte $45,$43,$49,$45,$53
        .byte $20,$44,$45,$41,$44,$4c,$59,$20,$49,$4e,$83,$0c,$0c,$57,$41,$52
        .byte $46,$41,$52,$45,$2e,$83,$0c,$10,$46,$45,$41,$54,$55,$52,$45,$53
        .byte $3a,$20,$20,$20,$20,$20,$45,$58,$54,$45,$4e,$44,$45,$44,$20,$4a
        .byte $41,$57,$83,$1d,$11,$38,$30,$30,$4c,$42,$83

    L_368c:
        .byte $1c,$12,$50,$52
        .byte $45,$53,$53,$55,$52,$45,$85,$38,$4f,$83,$17,$10,$00

    L_369d:
        ora ($83,x)
        ora $11,x

        .byte $02,$03,$04,$05,$ff,$83,$0c,$02,$85,$a6,$4a

    L_36ac:
        lsr L_4d35 + $c
        eor $3a

        .byte $53,$4d,$49,$4e,$45,$83,$0c,$03,$53,$50,$45,$43,$49,$45

    L_36bf:
        .byte $53,$3a
        .byte $41,$50,$54,$45,$20,$54,$45,$4e,$44,$52,$49,$4c,$83,$0c,$04,$47
        .byte $41,$4c,$41,$43,$54,$49,$43,$20,$44,$4f,$4d,$41,$49,$4e,$3a,$31
        .byte $36,$20,$50,$4c,$41,$4e,$45,$54,$83,$0c,$05,$4e,$45,$55,$52,$41
        .byte $4c

    L_36f2:
        jsr $4143

    L_36f5:
         .byte $50,$41,$43
        .byte $49,$54,$59,$3a,$20,$37,$38,$25,$83,$0c,$06,$50,$48,$59,$53,$49
        .byte $43,$41,$4c,$20,$43,$41,$50,$41,$43,$49,$54,$59,$3a,$20,$31,$38
        .byte $25,$83,$0c,$0a,$41,$4c,$54,$48,$4f,$55,$47,$48,$20,$50,$48,$59
        .byte $53,$49,$43,$41,$4c,$4c,$59,$20,$57,$45,$41,$4b,$2c,$83,$0c,$0b
        .byte $54,$48,$45,$20,$20,$41,$50,$54,$45,$20,$54,$45,$4e,$44,$52,$49
        .byte $4c,$53,$20,$20,$54,$45,$4c,$45,$2d,$83,$0c,$0c,$50,$41,$54,$48
        .byte $49,$43,$20,$50,$4f,$57,$45,$52,$53,$20,$43,$4f,$4d,$50,$45,$4e
        .byte $53,$41,$54,$45,$2e,$83,$0c,$10,$46,$45,$41,$54

    L_3774:
        eor $52,x
        eor $53

        .byte $3a,$20,$20,$20,$20,$20,$20,$54,$45,$4c,$45,$50,$41,$54,$48,$49
        .byte $43,$83,$1c,$11,$54,$45,$4e,$44,$52,$49,$4c,$53,$85,$ac,$4e,$83
        .byte $16,$0f,$00,$89,$89,$01,$83,$16,$10,$02,$03,$04,$05,$83,$16,$11
        .byte $06,$07,$08,$09,$83,$16,$12,$0a,$0b,$0c,$0d,$ff,$83,$0c,$02

    L_37b7:
        sta $a6
        lsr 
        lsr L_4d35 + $c
        eor $3a

        .byte $50,$49,$4e,$59,$4f,$83,$0c,$03,$36,$34,$20,$53,$5a,$4f,$4c,$47
        .byte $20,$32,$30,$33,$30,$20,$45,$52,$44,$83,$0c,$04,$50,$46,$2e,$3a
        .byte $34,$2e,$20,$4d

    L_37e3:
        eor ($47,x)
        lsr L_534f
        rts 



        .byte $50,$52,$4f,$47,$52,$41,$4d,$4f,$4b,$21,$83,$0c

    L_37f5:
        ora $4e
        eor $55

        .byte $52,$41,$4c,$20,$43,$41

    L_37ff:
        .byte $50,$41,$43
        .byte $49,$54,$59,$3a,$20,$33,$25,$83

    L_380a:
        .byte $0c
        .byte $06,$50,$48,$59,$53,$49

    L_3811:
        .byte $43
        .byte $41,$4c,$20,$43,$41

    L_3817:
        .byte $50,$41,$43
        .byte $49,$54,$59,$3a,$20,$39,$30,$25,$83,$0c,$09,$50,$49,$4e

    L_3828:
        eor L_204f,y
        pha 
    L_382c:
        eor ($53,x)
        jsr L_4f44 + $a
        jsr L_5242

        .byte $41,$49,$4e,$2e,$83,$0c,$0a,$44,$45,$53,$50,$49,$54,$45,$20,$48
        .byte $49,$53,$20,$47,$52

    L_3849:
        .byte $45,$41,$54
        .byte $20,$53,$54,$52,$45,$4e,$47,$54,$48,$83,$0c,$0b,$59,$4f,$55,$20
        .byte $57,$49,$4c,$4c,$20,$4f,$4e,$4c,$59,$20,$52,$45

    L_3868:
        .byte $51,$55,$49,$52,$45,$20,$34,$30,$25,$83,$0c,$0c
        .byte $4e,$45,$55,$52,$41,$4c,$20,$43,$41,$50,$41,$43

    L_3880:
        eor #$54
        eor L_5420,y

        .byte $4f,$20,$57,$49

    L_3889:
        .byte $4e,$2e,$83,$0c
        .byte $10,$46,$45,$41,$54,$55,$52,$45,$53,$3a,$20,$20,$20,$20,$43,$59

    L_389d:
        .byte $41,$4e,$49,$44,$45,$20,$54
        .byte $49,$50

    L_38a6:
        bvc L_38ed

        .byte $44,$83,$1c,$11,$54,$49,$54,$41,$4e,$49,$55,$4d,$83,$1e,$12,$48
        .byte $4f,$52,$4e,$2e,$85,$52,$4e,$83,$16,$0f,$00,$83,$16,$10,$01,$02

    L_38c8:
        .byte $83
        .byte $16,$11,$03,$04,$05,$83,$16,$12,$06,$07,$08,$ff

    L_38d5:
        lda #$01
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        clc 
    L_38ed:
        adc #$01
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
        clc 
        adc #$01
        jsr L_390d
        jsr L_390d
        jsr L_390d
        jsr L_390d
    L_390d:
        pha 
        tay 
        lda L_3fc0,y
        sta $04
        sta $02
        lda L_3fd7 + $2,y
        clc 
        adc #$cc
        sta $05
        clc 
        adc #$0c
        sta $03
        ldy #$26
        lda #$00
    L_3927:
        sta ($02),y
        sta ($04),y
        dey 
        cpy #$0b
        bne L_3927
        pla 
    L_3931:
        clc 
        adc #$01
        rts 



    L_3935:
         .byte $00,$83,$00,$00
        .byte $85,$8a,$57,$00,$82,$09,$01,$02,$8b,$17,$80,$ff,$81,$01,$04,$8c
        .byte $83,$00,$01,$8b,$17,$03,$80,$ff,$81,$01,$8c,$05,$82,$09,$06,$07
        .byte $83,$01,$01,$85,$74,$4f,$00,$01,$02

    L_3962:
        .byte $03,$04
        .byte $05,$06,$07,$08,$83,$01,$02,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11
        .byte $83,$01,$03,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$83,$01,$04,$1b
        .byte $1c

    L_3985:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$05,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$06
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$07,$36,$37,$38,$39
        .byte $3a,$3b,$3c,$3d,$3e,$83,$01,$08,$3f,$40,$41,$42,$43,$44,$45,$46
        .byte $47,$83,$01,$09,$85,$44,$52,$00,$01,$02,$03,$04,$05,$06,$07,$08
        .byte $83,$01,$0a,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01,$0b,$12
        .byte $13,$14,$15,$16,$17,$18,$19,$1a,$83,$01,$0c,$1b,$1c

    L_39e8:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$0d,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$0e
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$0f,$36,$37,$38,$39
        .byte $3a,$3b,$3c,$3d,$3e,$83,$01,$10,$3f,$40,$41,$42,$43,$44,$45,$46
        .byte $47,$83,$01,$11,$85,$14,$55,$00,$01,$02,$03,$04,$05,$06,$07,$08

    L_3a2e:
        .byte $83
        .byte $01,$12,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01,$13,$12,$13
        .byte $14,$15,$16,$17,$18,$19,$1a,$83,$01,$14,$1b,$1c

    L_3a4b:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$15,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$16
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$17,$36,$37,$38,$39
        .byte $3a,$3b,$3c,$3d,$3e,$ff,$83,$00,$00,$85,$8a,$57,$00,$82,$09,$01

    L_3a81:
        .byte $02,$8b,$17,$80,$ff
        .byte $81,$01

    L_3a88:
        .byte $04
        .byte $8c,$83,$00,$01,$8b,$17,$03,$80,$ff,$81,$01,$8c,$05,$82,$09,$06
        .byte $07,$83,$00,$08,$08,$82,$09,$09,$0a,$8b,$07,$80,$ff,$81,$01,$0c
        .byte $8c,$83,$00,$09,$8b,$07,$0b,$80,$ff,$81,$01,$8c,$0d,$82,$09,$0e
        .byte $0f,$83,$01,$01,$85,$84,$44,$00,$01,$02,$03,$04,$05,$06,$07,$08
        .byte $83,$01,$02,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01,$03,$12
        .byte $13,$14,$15,$16,$17,$18,$19,$1a,$83,$01,$04,$1b,$1c

    L_3ae6:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83

    L_3aee:
        ora ($05,x)
        bit $25
        rol $27
        plp 
        and #$2a

        .byte $2b,$2c,$83,$01,$06,$2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01
        .byte $07,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$83,$01,$09,$85,$fa,$46
        .byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$83,$01,$0a,$09,$0a,$0b,$0c
        .byte $0d,$0e,$0f,$10,$11,$83,$01,$0b,$12,$13,$14,$15,$16

    L_3b34:
        .byte $17
        .byte $18,$19,$1a,$83,$01,$0c,$1b,$1c

    L_3b3d:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$0d,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$0e
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$0f,$36,$37

    L_3b61:
        sec 
        and $3b3a,y

        .byte $3c,$3d,$3e,$83,$01,$11,$85,$70,$49,$00,$01,$02,$03,$04,$05,$06
        .byte $07,$08,$83,$01,$12,$09,$0a

    L_3b7c:
        .byte $0b,$0c
        .byte $0d,$0e,$0f,$10,$11,$83,$01,$13,$12,$13,$14

    L_3b89:
        ora $16,x

        .byte $17,$18,$19,$1a,$83

    L_3b90:
        ora ($14,x)

        .byte $1b,$1c

    L_3b94:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$15,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$16
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$17,$36,$37,$38,$39
        .byte $3a,$3b,$3c,$3d,$3e,$ff,$83,$0b,$00,$85,$f2,$3f,$00,$82,$1b,$01
        .byte $02,$8b,$17,$80,$ff,$81,$01,$05,$8c

    L_3bd3:
        .byte $83,$0b
        .byte $01,$8b,$17,$03,$80,$ff,$81,$01,$8c,$06,$82,$1b,$07,$08,$83,$0c
        .byte $14,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$12,$13,$14,$15,$16,$17
        .byte $18,$83,$0c,$15,$19,$1a,$1b,$1c,$1d,$1e,$1f

    L_3c00:
        jsr $2221

        .byte $23

    L_3c04:
        bit $25
        rol $27
        plp 

        .byte $83,$0c,$16,$29,$2a,$2b,$2c,$2d,$2e,$2f,$30,$31,$32,$33,$34,$35
        .byte $36,$37,$38,$83,$0c,$17,$39,$3a,$3b,$3c,$3d,$3e,$3f,$40,$41,$42
        .byte $43,$44,$45,$46,$47,$48,$83,$1c,$14,$49,$4a,$4b,$4c,$4d,$4e,$4f
        .byte $50,$51,$52,$53,$83,$1c,$15,$54,$55,$56,$57,$58,$59,$5a,$5b,$5c
        .byte $5d,$5e,$83,$1c,$16,$5f,$60,$61,$62,$63,$64,$65,$66

    L_3c56:
        .byte $67
        .byte $68,$69,$83,$1c,$17,$6a,$6b,$6c,$6d,$6e,$6f,$70,$71,$72,$73,$74
        .byte $83,$0c,$08,$82,$1b,$04,$83,$0c,$0e,$82,$1b

    L_3c72:
        .byte $04,$ff
        .byte $a5,$06,$38,$e9,$01,$85,$06,$a5,$07,$e9,$00,$85,$07,$05,$06,$60

    L_3c84:
        sta $02
        stx $03
    L_3c88:
        jmp L_3c8e
    L_3c8b:
        jsr L_29b5
    L_3c8e:
        ldy #$00
        lda ($02),y
        bmi L_3c9a
        jsr L_3ddd
        jmp L_3c8b
    L_3c9a:
        jsr L_29b5
        cmp #$ff
        bne L_3ca2
        rts 


    L_3ca2:
        cmp #$80
        bne L_3cb0
        lda ($02),y
        clc 
        adc $04
        sta $04
        jmp L_3c8b
    L_3cb0:
        cmp #$81
        bne L_3cbe
        lda ($02),y
        clc 
        adc $05
        sta $05
        jmp L_3c8b
    L_3cbe:
        cmp #$82
        bne L_3cd7
        lda ($02),y
        sta $06
        jsr L_29b5
        lda ($02),y
    L_3ccb:
        pha 
        jsr L_3ddd
        pla 
        dec $06
        bne L_3ccb
        jmp L_3c8b
    L_3cd7:
        cmp #$83
        bne L_3ce9
        lda ($02),y
        sta $04
        jsr L_29b5
        lda ($02),y
        sta $05
        jmp L_3c8b
    L_3ce9:
        cmp #$84
    L_3ceb:
        bne L_3cf5
        lda ($02),y
        sta L_3dd2 + $2
        jmp L_3c8b
    L_3cf5:
        cmp #$85
        bne L_3d09
        lda ($02),y
        sta L_3dd2
        jsr L_29b5
        lda ($02),y
        sta L_3dd2 + $1
        jmp L_3c8b
    L_3d09:
        cmp #$86
        bne L_3d56
        lda ($02),y
        sta $04
        jsr L_29b5
        lda ($02),y
        sta $05
        sta $0f
        jsr L_29b5
        lda ($02),y
        sta $10
        jsr L_29b5
        lda ($02),y
        sta $11
    L_3d28:
        jsr L_29b5
        lda ($02),y
        sta L_3da5 + $1
        jsr L_29b5
        lda ($02),y
        sta L_3da5 + $2
    L_3d38:
        jsr L_3da8
        lda $05
        cmp $11
        beq L_3d45
        inc $05
        bne L_3d38
    L_3d45:
        lda $04
        cmp $10
        beq L_3d53
        lda $0f
        sta $05
        inc $04
        bne L_3d38
    L_3d53:
        jmp L_3c8b
    L_3d56:
        cmp #$87
    L_3d58:
        bne L_3d62
        lda #$ff
        sta L_3da5
        jmp L_3c8e
    L_3d62:
        cmp #$88
        bne L_3d6e
        lda #$00
        sta L_3da5
        jmp L_3c8e
    L_3d6e:
        cmp #$89
        bne L_3d77
        inc $04
        jmp L_3c8e
    L_3d77:
        cmp #$8b
        bne L_3d8a
        lda ($02),y
        jsr L_29b5
        pha 
        lda $02
        pha 
        lda $03
    L_3d86:
        pha 
        jmp L_3c8e
    L_3d8a:
        cmp #$8c
        bne L_3da4
        pla 
        tay 
        pla 
        tax 
        pla 
        sec 
        sbc #$01
        beq L_3da1
        pha 
        txa 
        pha 
        tya 
        pha 
        sty $03
        stx $02
    L_3da1:
        jmp L_3c8e
    L_3da4:
        rts 



    L_3da5:
         .byte $ff,$00,$00

    L_3da8:
        ldy $05
        lda L_3fc0,y
        clc 
        adc $04
        sta $12
        sta $18
        lda L_3fd7 + $2,y
        adc #$cc
        sta $13
        adc #$0c
        sta $19
        ldy #$00
        lda L_3da5 + $1
        sta ($12),y
        lda L_3da5 + $2
        sta ($18),y
        rts 


        clc 
        bpl L_3dd0
        sec 
    L_3dd0:
        rol 
        rts 



    L_3dd2:
         .byte $f2,$3f,$00
        .byte $a9,$20,$4c,$dd,$3d,$18,$69,$30

    L_3ddd:
        tax 
        lda L_3e38,x
    L_3de1:
        clc 
        adc L_3dd2
        sta $12
        lda L_3eba,x
        adc L_3dd2 + $1
        sta $13
        ldy $05
        ldx $04
        lda $3f70,x
        clc 
        adc L_3f3c,y
        sta $10
        lda L_3f98,x
        adc L_3f56,y
        sta $11
        ldy #$07
    L_3e06:
        lda ($12),y
        sta ($10),y
        dey 
        bpl L_3e06
        ldx $05
        lda L_3fc0,x
        clc 
        adc $04
        sta $3e2d
        sta $3e33
        lda L_3fd7 + $2,x
        adc #$cc
        sta $3e2e
        adc #$0c
        sta $3e34
        ldy #$08
        lda ($12),y
        sta $ffff
        iny 
        lda ($12),y
        sta $ffff
        inc $04
        rts 



    L_3e38:
         .byte $00
        .byte $0a,$14,$1e,$28,$32,$3c,$46,$50,$5a,$64,$6e,$78,$82,$8c,$96,$a0
        .byte $aa,$b4,$be,$c8,$d2,$dc,$e6,$f0,$fa,$04,$0e,$18,$22,$2c,$36,$40
        .byte $4a,$54,$5e,$68,$72,$7c,$86,$90,$9a,$a4,$ae,$b8,$c2,$cc,$d6,$e0
        .byte $ea,$f4,$fe,$08,$12,$1c,$26,$30,$3a,$44,$4e,$58,$62,$6c,$76,$80
        .byte $8a,$94,$9e,$a8,$b2,$bc,$c6,$d0,$da,$e4,$ee,$f8,$02,$0c,$16,$20
        .byte $2a,$34,$3e,$48,$52,$5c,$66,$70,$7a,$84,$8e,$98,$a2,$ac,$b6,$c0
        .byte $ca,$d4,$de,$e8,$f2,$fc,$06,$10,$1a,$24,$2e,$38,$42,$4c,$56,$60
        .byte $6a,$74,$7e,$88,$92,$9c,$a6,$b0,$ba,$c4,$ce,$d8,$e2,$ec,$f6,$00
        .byte $0a

    L_3eba:
        .fill $1a, $0
        .byte $01,$01

    L_3ed6:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_3eee:
         .fill $19, $2
        .fill $1a, $3

    L_3f21:
        .fill $19, $4
        .byte $05,$05

    L_3f3c:
        .byte $00
        .byte $40

    L_3f3e:
        .byte $80
        .byte $c0,$00,$40,$80,$c0,$00,$40,$80,$c0,$00,$40,$80

    L_3f4b:
        cpy #$00
        rti 

        .byte $80,$c0,$00,$40,$80,$c0,$00,$40

    L_3f56:
        .byte $e0,$e1,$e2,$e3
        .byte $e5,$e6,$e7,$e8,$ea,$eb,$ec,$ed,$ef,$f0,$f1,$f2,$f4,$f5,$f6,$f7
        .byte $f9,$fa,$fb,$fc,$fe,$ff,$00,$08,$10,$18,$20,$28,$30,$38,$40,$48
        .byte $50,$58,$60,$68,$70,$78,$80,$88,$90,$98,$a0,$a8,$b0,$b8

    L_3f88:
        cpy #$c8

        .byte $d0,$d8

    L_3f8c:
        cpx #$e8
        beq L_3f88

        .byte $00,$08,$10,$18,$20,$28,$30,$38

    L_3f98:
        .fill $20, $0
        .byte $01,$01,$01,$01,$01,$01,$01,$01

    L_3fc0:
        .byte $00
        .byte $28,$50,$78,$a0,$c8,$f0,$18,$40

    L_3fc9:
        .byte $68,$90,$b8,$e0,$08,$30,$58,$80
        .byte $a8,$d0,$f8

    L_3fd4:
        jsr L_7048

    L_3fd7:
         .byte $98,$c0,$00,$00,$00,$00,$00,$00,$00

    L_3fe0:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

        .byte $02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$6a,$9a,$da,$e6
        .byte $f6,$f9,$fa,$fb,$1f,$0c,$55,$55,$55,$55

    L_4000:
        eor $aa,x
        eor $ff,x
        sbc ($0c),y
        lsr $56,x
        eor L_675b,y

    L_400b:
         .byte $af,$5f,$df
        .byte $f1,$0c,$59,$59,$59

    L_4013:
        eor L_5959,y
        eor SCREEN_BUFFER_2 + $359,y

        .byte $00,$00,$00,$00,$55,$00

    L_401f:
        .byte $00,$00,$00
        .byte $b0,$00

    L_4024:
        adc $65
        adc $65
        adc $65
        adc $65

        .byte $cf,$00

    L_402e:
        eor L_555a,y

    L_4031:
         .byte $5f,$5f,$7f,$7f,$ff,$cf,$0b
        .byte $55,$aa,$55,$ff

    L_403c:
        .byte $ff,$ff,$ff,$ff,$cf,$0b
        .byte $65,$a5,$65,$d5,$f5,$f5,$fd,$fd,$cf,$0b,$15,$2a,$2a,$2a,$2a,$2a
        .byte $28,$28,$fb,$00,$55,$aa,$aa

    L_4059:
        tax 
        tax 
        tax 

        .byte $00,$00,$fb,$00

    L_4060:
        eor $aa,x
        tax 
        tax 
        tax 
    L_4065:
        tax 

        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa

    L_4070:
        .byte $00,$00,$fb,$00
        .byte $55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa
        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00

    L_4092:
        eor $aa,x
        tax 
        tax 
        tax 
        tax 

        .byte $00,$00,$fb,$00,$55,$aa

    L_409e:
        tax 
        tax 
        tax 
        tax 

        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa
        .byte $aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00
        .byte $fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa
        .byte $aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$2a,$2a,$fb,$00
        .byte $55,$aa,$aa,$aa,$aa,$aa,$a8,$a8,$fb,$00,$14,$14,$14,$14,$14,$14
        .byte $14,$14,$b0,$00

    L_40f6:
        eor $6a,x
        adc $65

        .byte $64,$64,$64,$64,$87,$00,$55,$aa,$55,$55,$44,$44,$44,$44,$87,$00
        .byte $55,$aa,$55,$55,$41,$45,$45,$45

    L_4112:
        .byte $87,$00
        .byte $55,$aa,$55,$55,$15,$11,$11,$11,$87,$00,$55,$aa

    L_4120:
        eor $55,x
        ora $15,x
    L_4124:
        ora $15,x

        .byte $87,$00,$55,$aa,$55,$55,$01,$11,$11,$11

    L_4130:
        .byte $87,$00
        .byte $55,$aa,$55,$55,$01,$11,$01,$01,$87,$00,$55,$aa,$55,$55,$01,$11
        .byte $01,$01,$87,$00,$55,$aa

    L_4148:
        eor $55,x
    L_414a:
        ora ($11,x)
        ora ($11),y

        .byte $87,$00,$55,$aa,$55,$55

    L_4154:
        ora $11
        ora ($11),y

        .byte $87,$00

    L_415a:
        eor $aa,x
    L_415c:
        eor $55,x

        .byte $04,$14,$14,$14,$87,$00,$55,$aa,$55,$55,$14,$45,$45,$45,$87,$00
        .byte $55,$ab

    L_4170:
        .byte $57,$57,$07,$17,$17,$17,$87
        .byte $09,$15,$15,$15,$15,$15,$15,$15,$15,$b0

    L_4181:
        .byte $00,$54,$54,$54,$54,$54,$54,$54,$54,$b0,$00,$14,$14,$14,$14,$14

    L_4191:
        .byte $14,$14,$14,$b0,$00,$64,$64,$64,$64,$54
        .byte $65,$ff,$ff,$87,$09,$04

    L_41a1:
        .byte $14,$14,$14,$14
        .byte $55,$aa,$aa,$89,$00,$41,$45

    L_41ac:
        eor $41
        eor ($55,x)
        tax 
        tax 

        .byte $89,$00,$11,$11,$11,$00,$11,$55,$aa,$aa,$89,$00,$15,$15,$15,$15
        .byte $15,$55,$aa,$aa,$89,$00,$11,$11,$11,$01,$01,$55,$aa,$aa,$89,$00
        .byte $15,$15,$15,$15,$15,$55,$aa,$aa,$89,$00,$15,$15,$15,$15,$15,$55

    L_41e2:
        tax 
        tax 

        .byte $89,$00,$11,$11,$11,$01,$01,$55,$aa,$aa,$89,$00,$11,$11,$11,$11
        .byte $11,$55,$aa,$aa,$89,$00,$04,$14,$14,$04,$04,$55,$aa,$aa

    L_4202:
        .byte $89,$00
        .byte $45,$45

    L_4206:
        eor $45
        eor $55
    L_420a:
        tax 
        tax 

        .byte $89,$00,$16,$16,$16,$16,$16,$56,$aa,$aa

    L_4216:
        .byte $89,$00
        .byte $15,$15,$15,$15,$15,$15,$15,$15

    L_4220:
        .byte $b0,$00,$54,$54,$54,$54,$54,$54,$54,$54,$b0,$00,$14,$14
        .byte $15,$15,$15,$15,$15,$15

    L_4234:
        .byte $b0,$00,$00,$00
        .byte $55,$55,$55,$55,$55,$55

    L_423e:
        .byte $b0,$00,$00,$00
        .byte $55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55,$55,$55,$55,$55
        .byte $b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55
        .byte $55,$55,$55,$55

    L_4266:
        .byte $b0,$00,$00,$00
        .byte $55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55,$55,$55,$55,$55
        .byte $b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55
        .byte $55,$55,$55,$55,$b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00
        .byte $00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55,$55,$55
        .byte $55,$55,$b0,$00,$00,$00

    L_42b0:
        eor $55,x
        eor $55,x
        eor $55,x
        bcs L_42b8
    L_42b8:
        ora $15,x
        eor $55,x
        eor $55,x
        eor $55,x

        .byte $b0,$00,$54,$54,$55,$55,$55,$55,$55,$55,$b0,$00

    L_42cc:
        eor $aa,x
        tax 
        tax 
        tax 
        tax 

        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa
        .byte $aa

    L_42e3:
        tax 
        tax 
        tax 

        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa
        .byte $aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa

    L_4303:
        tax 

        .byte $00,$00,$fb,$00,$55,$aa,$aa,$aa

    L_430c:
        tax 
        tax 

    L_430e:
         .byte $00,$00,$fb,$00
        .byte $55,$aa,$aa,$aa,$aa,$aa,$00,$00,$fb,$00,$55,$aa,$aa,$aa,$aa,$aa
        .byte $00,$00,$fb,$00,$55,$aa,$aa

    L_4329:
        tax 
        tax 
    L_432b:
        tax 
        rol 
        rol 

        .byte $fb,$00,$55,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$fb,$00,$55,$6a,$65,$65
        .byte $64,$64,$64,$64,$87,$00,$55,$aa,$55,$55,$11,$51,$51,$50

    L_434c:
        .byte $87,$00
        .byte $55,$aa,$55,$55,$10,$11,$11,$10,$87,$00,$55,$aa,$55,$55,$51,$11
        .byte $11,$11

    L_4360:
        .byte $87,$00
        .byte $55,$aa,$55,$55,$45,$45,$45,$45,$87,$00,$55,$aa,$55,$55

    L_4370:
        .byte $04,$14,$14,$04,$87,$00
        .byte $55,$aa,$55,$55

    L_437a:
        .byte $14,$44,$44,$44,$87,$00
        .byte $55,$aa,$55,$55,$04,$54,$54,$54,$87,$00,$55,$a9,$57,$57,$17,$57
        .byte $57,$17,$87,$09,$15,$15,$15,$15,$15,$15,$15,$15,$b0,$00,$55,$55
        .byte $55,$55,$55,$55,$55,$55,$b0,$00,$64,$64,$64,$64,$54,$65,$ff,$ff
        .byte $87,$09,$50,$51,$51,$11,$11,$55,$aa,$aa,$89,$00,$10,$11,$11,$11
        .byte $11,$55,$aa,$aa,$89,$00,$11,$11,$11,$10,$10,$55,$aa,$aa,$89,$00
        .byte $45,$45,$45,$41,$41,$55,$aa,$aa

    L_43d8:
        .byte $89,$00,$14,$14,$14,$04,$04
        .byte $55,$aa,$aa,$89,$00,$44,$44,$44,$44,$44,$55,$aa,$aa,$89,$00,$44
        .byte $44,$44,$04,$04,$55,$aa,$aa,$89,$00,$56,$56,$56,$16,$16,$56,$aa

    L_43ff:
        tax 

        .byte $89,$00,$15,$15,$15,$15,$15,$15,$15,$15,$b0,$00

    L_440c:
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x

    L_4414:
         .byte $b0,$00,$00,$00
        .byte $55,$55,$55,$55,$55,$55,$b0,$00,$00,$00

    L_4422:
        eor $55,x
        eor $55,x
        eor $55,x

        .byte $b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55
        .byte $55,$55,$55,$55,$b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00
        .byte $00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00

    L_4454:
        eor $55,x
        eor $55,x
        eor $55,x

        .byte $b0,$00,$00,$00,$55,$55,$55,$55,$55,$55,$b0,$00,$00,$00,$55,$55
        .byte $55,$55,$55,$55,$b0,$00

    L_4470:
        ora $15,x
        eor $55,x
        eor $55,x
        eor $55,x
        bcs L_447a
    L_447a:
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
        bcs L_4484
    L_4484:
        eor $55,x
        tax 
        eor $55,x
        eor $55,x
        tax 

        .byte $5c,$00,$55,$55,$aa,$55,$55,$57,$57,$ab,$5c,$0b,$55,$55,$5a,$aa
        .byte $96,$79,$75,$7d,$5b,$01,$55,$55,$00,$aa,$6a,$99,$56,$56,$5b,$00
        .byte $55,$55,$2a,$c5,$71,$fc,$df,$ff,$5c,$0b,$55,$55,$aa,$55,$55,$00
        .byte $00,$00,$5c,$00,$55,$55,$aa,$55,$55,$15,$05

    L_44c7:
        .byte $02,$5c,$00
        .byte $55,$55,$aa,$55,$55,$55,$55,$aa,$5c,$00,$55,$55,$aa,$55,$55,$55
        .byte $55,$aa,$5c,$00,$55,$55,$55,$aa,$55,$55,$aa,$55,$5c,$00,$56,$5e
        .byte $59,$f9,$59,$59,$fa,$59,$5b,$0c,$69,$ea,$ea,$ea,$ea,$5a,$de,$57
        .byte $b1,$0c,$56,$d9,$d5,$e6,$e9,$e5

    L_4502:
        adc $95

        .byte $5b,$0c,$5a,$55,$55,$aa,$5a,$56,$56,$55,$5b,$00,$40,$50,$54,$19
        .byte $56,$45,$51,$51,$b5,$00,$01,$00,$00,$00,$00,$80

    L_4520:
        rts 



        .byte $90,$5b,$00

    L_4524:
        eor $55,x
        ora $0a,x
        ora $01

        .byte $02,$01,$5c,$00,$55,$55,$55,$aa,$55,$55

    L_4534:
        tax 
        eor $5c,x

        .byte $00,$55,$aa,$55,$55,$ff,$55,$55,$ff,$5c,$0b,$59,$fb,$7a,$6b,$af
        .byte $6f,$4e,$a2,$5b,$0c,$65,$95,$a5,$e9

    L_4550:
        .byte $fa,$fb,$af
        .byte $0e,$5c,$07

    L_4556:
        lsr $6a,x
        tax 

        .byte $af,$ff,$ff,$f4,$e0,$cb,$07,$5a,$aa,$6a,$ea,$fa,$fe,$3e,$0a,$b5
        .byte $07,$54,$94,$55,$55,$99,$a6,$99,$a6,$b5,$00,$54,$18,$24,$14,$58
        .byte $58,$58,$48,$b5,$00,$01,$00,$00,$00,$00,$00,$00,$00,$50,$00

    L_4588:
        eor $aa,x
        eor $55,x

        .byte $ff,$55,$15,$3f,$5c,$0b,$55,$aa,$55,$aa,$aa,$aa,$55,$aa

    L_459a:
        .byte $5b,$00

    L_459c:
        rts 



        .byte $f3,$50,$fc,$fe,$fe,$5e,$fa,$5c,$0b,$01,$82,$c6,$3e,$6a,$82,$8e
        .byte $be,$87,$0c,$40,$09,$30,$3f,$ba,$26,$1a,$1a,$c7,$08

    L_45ba:
        lsr 

        .byte $cb,$3a,$fa,$fa,$7e,$7e,$5f,$75,$0c

    L_45c4:
        ror $a0
        tax 
        ror 
        eor $5956,y
        lsr $5b,x

        .byte $00,$10,$40,$12,$55,$51

    L_45d3:
        eor ($60),y

        .byte $90,$b5,$00,$00,$00,$00,$00,$40,$80,$80,$80,$5b,$00,$15,$2a,$15
        .byte $0a,$0a,$0a,$05,$0a,$5b,$00,$55,$55,$55,$55

    L_45f0:
        eor $55,x
        eor $55,x

        .byte $b0,$00,$5b,$5b,$5b,$5b,$6f,$6b,$6f,$6b,$bc,$07,$5a,$9a,$9e,$ae
        .byte $fe,$fe,$fe,$fd,$c7,$01,$6a,$6a

    L_460c:
        ror 
        tax 
        tax 
        tax 
    L_4610:
        tax 
        tax 

        .byte $c7,$00,$6a,$5a,$66,$5a,$56,$59,$56,$59,$7c,$00,$55,$56

    L_4620:
        sta $d6,x
        cmp $e5,x
        sbc $e5

        .byte $5b,$0c,$66,$99,$65,$99,$65,$95,$51,$95

    L_4630:
        lda $00,x
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $00,$10,$b0,$00,$05,$05

    L_463e:
        ora $05
        ora $05
        ora $05
        bcs L_4646
    L_4646:
        eor $55,x
        eor $55,x

        .byte $00,$55,$00,$00,$b0,$00,$5a,$66,$7a,$76,$72,$71,$3c,$0d,$b7,$01
        .byte $59,$bb,$55,$b7,$77,$ff,$00,$a9,$71,$0c,$55,$55,$5b,$58,$7b,$ca
        .byte $0a,$58,$71,$0c

    L_466e:
        lsr $5a,x

    L_4670:
         .byte $5a,$62
        .byte $81,$16,$a0,$aa,$7c,$00,$5a,$5b,$5a,$5b,$1b,$2c,$bf,$cf

    L_4680:
        cmp $0b

        .byte $50,$91,$46,$41,$15,$56,$48,$56,$b5,$00,$68,$94,$64,$91,$42,$15
        .byte $69,$55,$b5,$00,$05,$05,$05,$45,$40,$45,$00,$10,$b0,$00,$00,$00
        .byte $00,$00

    L_46a4:
        ora ($15,x)
        eor $55,x
        bvc L_46aa
    L_46aa:
        ora $05
        ora ($b1,x)
        lda L_abaf

        .byte $ab,$75,$0b,$55,$aa,$aa,$6a,$6a,$6b,$2c,$c3,$7c,$0b,$55,$a6,$a5
        .byte $a6,$b9,$bd,$01,$f0,$7c,$0b,$56,$59,$57,$6c,$73,$8f

    L_46ce:
        .byte $ce,$0a,$c5,$0b
        .byte $55,$19,$15,$56,$5a,$aa,$aa,$aa,$b5,$00,$66,$99,$66,$99,$56,$5a
        .byte $56,$5a,$5b,$00,$68,$a2,$6a,$aa,$6a,$aa,$aa,$aa,$5b,$00,$44,$11
        .byte $40,$11,$44,$41,$54,$55,$b0,$00,$55,$55,$aa,$55,$55

    L_46ff:
        eor $55,x
        tax 

        .byte $8f,$00,$55,$55

    L_4706:
        tax 
        eor $55,x
        eor $55,x
        tax 

        .byte $8f,$00,$55,$55,$aa,$55,$55,$55,$55,$aa,$8f,$00,$55,$55,$aa,$55
        .byte $55,$55,$55,$aa,$8f,$00,$55,$55,$aa,$55,$55,$5b,$6f,$be,$8f,$01
        .byte $55,$55,$aa,$55,$bf,$ff,$ea,$bf,$8f,$01,$55,$55,$aa,$55,$ff,$ff
        .byte $ff,$fe,$8f,$01,$55,$55,$aa

    L_4743:
        eor $95,x
        sbc $f8
        lda #$8f
        ora ($55,x)
    L_474b:
        eor $aa,x
        eor $55,x
        eor $55,x
        rol 

        .byte $8f,$00,$55,$55,$55,$55,$aa,$55,$55,$55,$8f,$00,$55,$55,$55,$55
        .byte $aa,$55,$55,$55,$8f,$00,$55,$55,$55,$55,$aa,$55,$55,$56,$8f,$00
        .byte $56,$57,$5b,$5e,$ae,$ba,$fb,$eb,$8f,$01,$5a,$69,$a5,$95,$55,$55
        .byte $55,$55,$1f,$00

    L_4786:
        eor $55,x
    L_4788:
        eor $55,x
        eor $55,x
        eor $55,x
        bpl L_4790
    L_4790:
        eor $55,x
        eor $55,x
        eor $55,x
        eor $55,x
    L_4798:
        bpl L_479a
    L_479a:
        ror 
        eor L_565e,y
        lsr $5e,x
        lsr L_1c58 + $2,x

        .byte $0f,$45,$81,$90,$e0,$e4,$a0,$b8,$f8,$8f,$01,$55,$55,$aa,$55,$55
        .byte $aa,$aa,$55,$89,$00,$55,$55,$aa,$55,$55

    L_47bd:
        tax 
        lda #$55

        .byte $89,$00,$56,$5e,$5a,$7b,$6b,$ef,$bf,$bf

    L_47ca:
        sta ($0f,x)
        adc $a5
        sta $95,x
        eor $55,x
        eor $55,x

        .byte $1f,$00,$55,$55

    L_47d8:
        eor $55,x
        eor $55,x
        eor $59,x

        .byte $1c,$00,$55,$55,$55,$55,$55,$56,$6f,$55,$1f,$0c,$55,$55,$55,$56
        .byte $6f,$fe,$ab,$55,$1f,$0c,$5b,$6e,$bd,$f9,$e5,$96,$5b,$5c,$1c,$0b
        .byte $68,$6c,$44,$84

    L_4802:
        .byte $34,$34,$34,$7c,$1f,$0b
        .byte $55,$55,$55,$55

    L_480c:
        eor $55,x
        eor $55,x
        bcc L_4812
    L_4812:
        lsr $57,x

        .byte $5b,$5b,$5e,$5e,$5e,$5e,$9b,$01,$5a,$5a,$da,$da

    L_4820:
        cmp L_756e,x
        eor $1c,x

        .byte $0b,$55,$55,$56,$5b,$5d,$7d,$fd

    L_482d:
        .byte $54,$1c,$0b
        .byte $65,$98,$50,$43,$49,$0d,$0d,$4b,$1c,$05,$55,$00,$aa,$aa,$ee,$7f
        .byte $ff,$fc,$1b,$05,$55,$2e,$cd,$c5,$85,$b6,$14,$1f,$1b,$0c,$6d,$2d
        .byte $b9,$35,$26,$d6,$db,$9d,$1c,$0b,$6c,$ec,$f8,$b0,$a0,$40

    L_485e:
        .byte $c0,$80,$1b,$0c
        .byte $55,$55,$55,$55,$55,$55,$55,$55,$90,$00,$5a,$7a,$69,$69,$6b

    L_4871:
        adc $e5ed
        sta ($0c),y
        adc #$96
        tax 
        tax 
        sbc $ff

        .byte $fa,$fe,$b1,$09

    L_4880:
        cli 
        sbc L_7575,y
        adc $e4,x
        stx $96,y

        .byte $1c,$0b,$6b,$5a

    L_488c:
        eor $95,x
        sta $69,x
        eor $65,x

        .byte $1b,$05,$50

    L_4895:
        lsr $ab,x

        .byte $af

    L_4898:
        tsx 
        tax 
        tax 
        lda #$b1

        .byte $0c,$5a,$69,$a5

    L_48a1:
        .byte $57
        .byte $5d,$76,$db,$ac,$1c,$0b,$5a,$77,$d8,$6c,$b0,$c0,$00,$00,$1c,$0b
        .byte $00,$00,$01,$01,$05,$05,$15,$15,$90,$00,$00,$00,$00,$55,$00,$00
        .byte $00,$00,$90,$00

    L_48c6:
        bvc L_4928
        rts 



        .byte $7f,$40,$40,$40,$40,$1c,$09,$00,$00,$00

    L_48d3:
        eor $00,x

        .byte $02,$03,$03,$9b,$0c

    L_48da:
        adc #$67

        .byte $a7,$a2,$a1,$90,$b1,$82,$c1,$0b,$6f,$6a

    L_48e6:
        .byte $7a,$5f
        .byte $5d,$57,$56,$5e,$1b,$0c,$56,$5b,$be,$ed,$74,$70,$70,$70,$bc,$01
        .byte $60

    L_48f9:
        cpy #$80

    L_48fb:
         .byte $00,$00,$00,$00,$00,$1b,$0c,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$90,$00

    L_490c:
        eor $00,x

        .byte $00,$00,$55,$00,$00,$00,$90,$00

    L_4916:
        eor $00,x

        .byte $00,$00,$00,$00,$00,$00,$90,$00

    L_4920:
        eor $00,x

    L_4922:
         .byte $00,$00,$00,$00,$00,$00

    L_4928:
        bcc L_492a
    L_492a:
        lsr $0a,x

        .byte $2b,$00,$00,$00,$00,$00,$91,$0c

    L_4934:
        .byte $6b,$43,$07,$0f,$0f,$1c,$3c,$7f
        .byte $c9,$01,$6a,$55,$55,$56,$51

    L_4943:
        eor L_a504 + $1,y

        .byte $1b,$00,$50,$90,$80,$80,$80,$80,$90,$a9,$c1,$00

    L_4952:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $55,$00,$00,$00,$00,$00,$00,$90,$00,$00,$55,$00,$00,$00,$00,$00
        .byte $00

    L_496e:
        bcc L_4970
    L_4970:
        eor $aa,x
        eor $aa,x
        eor $aa,x
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00,$55,$aa,$55,$aa

    L_4988:
        eor $aa,x
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00

    L_4998:
        eor $aa,x
        eor $aa,x
        eor $aa,x
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$af,$6b,$0c,$55,$aa,$55,$aa
        .byte $55,$aa,$55,$fa,$6b,$0c,$55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00
        .byte $55,$aa,$55,$aa,$55,$aa

    L_49c6:
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$55,$55,$55,$55,$55,$6b,$00,$55,$aa,$55,$55
        .byte $55,$55,$55,$55,$6b,$00,$55,$aa

    L_49e0:
        eor $55,x
        eor $55,x
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$55,$55,$55,$55,$56,$6b,$00,$56,$ab,$5f,$6b
        .byte $6f,$bf,$bf,$ff,$6b,$0c,$55,$55,$56,$5b,$6d,$b9,$e5,$95,$cf,$01
        .byte $56,$55,$e5,$59,$66,$5a,$6a,$69,$cb,$0f,$6a,$55,$da,$f6,$f6,$7e
        .byte $7e,$5d

    L_4a18:
        ldx $0c,y
        eor $aa,x
    L_4a1c:
        eor $55,x
        eor $55,x
        eor $aa,x

        .byte $6b,$00,$55,$6a,$aa

    L_4a27:
        tax 
        tax 
        tax 
        tax 
        tax 
        ldx $00,y
        eor $aa,x
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        ldx $00,y
        eor $aa,x
        tax 
        tax 
        tax 
        lda #$ab

        .byte $a7,$b6,$0c,$56,$f9,$d9,$65,$a6,$95,$96,$5a,$bc,$06,$6b,$af,$be
        .byte $b9,$f9,$ea,$da,$56,$bc

    L_4a55:
        .byte $0f
        .byte $59,$5a,$56

    L_4a59:
        stx $a9,y

        .byte $ab,$6e,$ba,$cb,$0f,$56,$6d,$b5,$d4,$d0,$50,$41,$01,$bc,$0f,$59
        .byte $5d,$1e,$1e,$6e,$5d,$6e,$a9,$bc,$0f,$55,$95,$95,$95,$a5,$a5,$a5
        .byte $a6,$6b,$00,$55,$aa,$aa,$aa,$aa

    L_4a83:
        tax 
        tax 
        tax 
        ldx $00,y
        eor $aa,x
        tax 
        tax 
        tax 
        tax 
        sbc #$e9
        ldx $01,y

    L_4a92:
         .byte $5a,$fa
        .byte $d9,$e9,$66,$a6,$9a,$9a,$bc,$06,$6f,$6f,$be,$75,$e5,$e9,$ea,$aa
        .byte $bc,$0f,$69,$5b,$57,$5e,$ba,$ba,$e8,$e0,$cb,$0f,$6c,$bc,$f1,$c1
        .byte $00,$0f

    L_4ab6:
        and $fcf9,x

        .byte $0b,$61,$a1,$93,$57,$1d,$f7,$fd

    L_4ac1:
        sbc $ba,x

        .byte $0c,$65,$99,$a5,$95,$99,$6a,$af,$7e,$bc,$0f,$56,$56

    L_4ad0:
        lsr $56,x
        dec $54,x

        .byte $d4,$54,$b6,$0c,$55,$55,$00,$55,$55,$55,$55,$00,$60,$00,$6a,$4b
        .byte $4b,$4b,$6f,$ad,$b6,$be,$fb,$0c,$59,$5b,$5f,$5f,$77,$75,$7d,$7d
        .byte $bf,$0c,$5b,$57,$95,$a5,$95,$75,$71,$77,$bc,$0f,$51,$46,$4a,$6b
        .byte $ab,$b6,$e5,$e4,$bc,$0f,$5b,$6f,$7f,$ff,$f0,$c0,$00,$00,$cf,$0b
        .byte $6a,$a8,$a8,$80,$0a,$0a,$28,$a0,$cb,$00,$15,$a5,$aa,$00,$80,$00
        .byte $00,$00,$cb,$00,$60,$a0,$80,$00,$00,$00,$00,$00,$cb,$00

    L_4b32:
        lsr $56,x

        .byte $02,$57,$57,$0f,$0e,$2c,$6b,$01,$15,$45,$a0,$9e,$99,$49,$28,$cf
        .byte $b1,$0c,$46,$14,$61,$11,$c1,$d4,$dc,$dc,$bc,$01,$1b,$1b,$1a,$00
        .byte $02,$8a,$a8,$a0,$1b,$0f,$60,$80,$00,$22,$88,$28,$00,$00,$cb,$00
        .byte $01,$15,$55,$54,$00,$00,$00,$00,$b0,$00

    L_4b6e:
        .byte $50,$40,$00,$00,$00,$00,$00,$00,$b0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$15,$60,$00,$00,$01,$00,$05,$15,$00,$00,$55,$60,$00,$52,$4a
        .byte $7a,$73,$72,$14,$05,$01,$b2,$01,$52,$54,$95,$56,$58,$0b,$fb,$f3
        .byte $21,$0b,$6c,$e3,$bf,$bc,$fc,$f0,$c0,$00,$21,$0b,$50,$40,$00,$00
        .byte $00,$00,$00,$00,$b0

    L_4bb3:
        .fill $17, $0
        .byte $55,$00

    L_4bcc:
        .byte $00,$00,$00,$00
        .byte $60,$00,$00,$00,$55,$00,$00,$00,$00,$00,$60,$00,$00,$00,$55,$00

    L_4be0:
        .byte $00,$00,$00,$00
        .byte $60

    L_4be5:
        .byte $00,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$1c,$00,$df,$df,$df,$df,$cf

    L_4bf5:
        .byte $df,$cf,$ff,$1c,$00,$77,$77,$33,$ff,$ff,$ff,$ff,$ff,$1c,$00,$77

    L_4c05:
        .byte $67,$47,$67,$47,$33,$ff,$ff,$1c,$00,$f7,$db,$63,$1f,$db,$63,$8f
        .byte $3f,$1c,$00,$77,$37,$d3,$df,$4f,$77,$33,$ff,$1c,$00,$ff,$df,$df
        .byte $57,$13,$df,$cf,$ff,$1c,$00,$df,$df,$cf,$ff,$ff,$ff,$ff,$ff,$1c
        .byte $00,$57,$43,$7f,$7f,$7f,$57,$03,$ff,$1c,$00,$57,$07,$f7,$f7,$f7

    L_4c45:
        .byte $57,$03,$ff,$1c,$00,$ff,$ff,$77,$13,$47,$33,$ff,$ff,$1c,$00,$ff
        .byte $df,$df,$57,$13,$df,$cf,$ff,$1c,$00,$ff,$ff,$ff,$ff,$df,$4f,$3f
        .byte $ff,$1c,$00,$ff,$ff,$57,$03,$ff,$ff,$ff,$ff,$1c,$00,$ff,$ff,$ff
        .byte $ff,$df,$cf,$ff,$ff,$1c,$00,$f7,$e7,$d3,$9f,$4f,$7f,$3f,$ff,$1c
        .byte $00,$ff,$9b,$47,$77,$77,$9b,$03,$ff,$1c,$00,$ff,$df,$5f,$1f,$df

    L_4c95:
        .byte $57,$03,$ff,$1c,$00,$ff,$5b,$07,$db,$63,$57,$03,$ff,$1c,$00,$ff

    L_4ca5:
        .byte $5b,$0b,$d7,$c7,$5b,$03,$ff,$1c,$00,$ff,$7f,$7f,$77,$57,$07,$f3
        .byte $ff,$1c,$00,$ff,$57,$43,$5b,$07,$5b,$03,$ff,$1c,$00,$ff,$97,$43

    L_4cc5:
        .byte $5b,$47,$9b,$03,$ff,$1c,$00,$ff,$57,$07,$e7,$d3,$df,$cf,$ff,$1c
        .byte $00,$ff,$9b,$47,$9b,$47,$9b,$03,$ff,$1c,$00,$ff,$9b,$47,$97,$07
        .byte $5b,$03,$ff,$1c,$00,$ff,$ff,$df,$cf,$df,$cf,$ff,$ff,$1c,$00,$ff
        .byte $ff,$df,$cf,$df,$4f,$3f,$ff,$1c,$00,$ff,$f7,$d3,$4f,$1f,$c7,$f3

    L_4d05:
        .byte $ff,$1c,$00,$ff,$ff,$57,$03,$57,$03,$ff,$ff,$1c,$00,$ff,$7f,$1f

    L_4d15:
        .byte $c7,$d3,$4f,$3f,$ff,$1c,$00,$57,$47,$37,$d7,$d3,$cf,$df,$cf,$1c

    L_4d25:
        .byte $00,$fb,$fb,$e7,$e7,$97,$97,$03,$ff,$1c,$00,$9b,$47,$57,$47,$77

    L_4d35:
        .byte $77,$33,$ff,$1c,$00,$5b,$47,$57,$47,$77,$5b,$0f,$ff,$1c,$00,$9b
        .byte $47,$73,$7f,$77,$9b,$03,$ff,$1c,$00,$5b,$47,$77,$77,$77,$5b,$0f

    L_4d55:
        .byte $ff,$1c,$00,$57,$43,$5f,$4f,$7f,$57,$03,$ff,$1c,$00,$57,$43,$5f
        .byte $4f,$7f,$7f,$3f,$ff,$1c,$00,$9b,$47,$73,$77,$77,$9b,$03,$ff,$1c

    L_4d75:
        .byte $00,$77,$77,$57,$47,$77,$77,$33,$ff,$1c,$00,$57,$13,$df,$df,$df

    L_4d85:
        .byte $57,$03,$ff,$1c,$00,$57,$07,$f7,$f7,$77,$9b,$03,$ff,$1c,$00,$77
        .byte $77,$53,$5f,$47,$77,$33,$ff,$1c,$00,$7f,$7f,$7f,$7f,$7f,$57,$03

    L_4da5:
        .byte $ff,$1c,$00,$77,$57,$67,$47,$77,$77,$33,$ff,$1c,$00,$5f,$47,$77

    L_4db5:
        .byte $77,$77,$77,$33,$ff,$1c,$00,$9b,$47,$77,$77,$77,$9b,$03,$ff,$1c
        .byte $00,$5b,$47,$5b,$43,$7f,$7f,$3f,$ff,$1c,$00,$5b,$47,$77,$57,$53
        .byte $0b,$f3,$ff,$1c,$00,$5b,$47,$5b,$47,$77,$77,$33,$ff,$1c,$00,$97

    L_4de5:
        .byte $43,$9b,$07,$77,$9b,$03,$ff,$1c,$00,$57,$13,$df,$df,$df,$df,$cf
        .byte $ff,$1c,$00,$77,$77,$77,$77,$77,$9b,$03,$ff,$1c,$00,$77,$77,$77
        .byte $67,$9b,$df,$cf,$ff,$1c,$00,$77,$77,$77,$67,$57,$47,$33,$ff,$1c
        .byte $00,$77,$67,$9b,$13,$57,$47,$33,$ff,$1c,$00,$77,$67,$9b,$df,$df

    L_4e25:
        .byte $df,$cf,$ff,$1c,$00,$57,$07,$d7,$53,$4f,$57,$03,$ff,$1c,$00,$7f

    L_4e35:
        .byte $7f,$7f,$7f,$7f,$7f,$3f,$ff,$1c,$00,$5f,$4f,$5f,$4f,$7f,$5f,$0f

    L_4e45:
        .byte $ff,$1c,$00,$5f,$4f,$5f,$4f,$7f,$7f,$3f,$ff,$1c,$00,$00,$00,$00

    L_4e55:
        .byte $00
        .byte $40,$40,$40,$60,$1c,$00,$60,$50,$5c,$58,$57,$55,$55,$55,$1f,$0c
        .byte $00,$00,$00,$00,$00,$00,$40,$80,$cf,$00,$6a,$6a,$6a,$ea,$2a,$2a
        .byte $2a,$2a,$f1,$0c,$60

    L_4e7b:
        .byte $78,$5e,$57,$55,$55,$55,$55,$1c,$0f,$00,$00,$00,$00
        .byte $40,$90,$e4,$f8,$cf,$01,$1a,$3a,$0a,$06,$0e,$02,$02,$03,$f1,$0c
        .byte $55,$55,$55,$55,$55,$55,$55,$5b,$1f,$0c,$54,$54,$54,$58,$5c,$60
        .byte $b0,$00,$1f,$0c,$05,$06,$06,$06,$06,$06,$06,$06,$c1,$00,$50,$90
        .byte $90,$90,$90,$90,$90,$90,$c1,$00,$06,$06,$06,$16,$0a,$16,$0a,$56
        .byte $c1,$00,$00,$00,$00,$00,$40,$00,$40,$00,$c0,$00,$00,$00,$00,$00
        .byte $01,$00,$01,$00,$c0,$00,$60,$60,$60

    L_4ee1:
        .byte $68,$50,$68,$50,$6a,$1c,$00
        .byte $05,$29,$05,$a9,$05,$29,$09,$29,$1c,$00,$40,$00,$50,$00

    L_4ef6:
        rti 

        .byte $00,$00,$50,$c0,$00,$01,$00,$05,$00,$01,$00,$00,$05,$c0,$00,$50
        .byte $68,$50,$6a,$50,$68,$60,$68,$1c,$00,$12,$01,$05,$04,$00,$01,$01
        .byte $01,$c1,$00,$40,$48,$60,$50,$98,$94,$24,$00,$1c,$00,$01,$21,$09
        .byte $05,$26,$16,$18,$00,$1c,$00,$48,$80,$a0,$20,$00,$80,$80,$80,$1c
        .byte $00,$00,$00,$00,$00,$06,$07

    L_4f3e:
        .byte $47,$6f,$1f,$0c,$00

    L_4f43:
        rts 



    L_4f44:
         .byte $50,$58,$94,$a6,$a5,$65,$1c,$00,$00,$00,$00
        .byte $6c,$eb,$1a,$3a,$06,$f1,$0b,$04,$06,$07

    L_4f59:
        .byte $1f
        .byte $ae,$55,$55,$55,$1f,$0c,$6a,$ae,$af,$af,$bf,$fc,$f4,$40,$fc,$01
        .byte $55

    L_4f6b:
        .byte $54,$50,$40,$00,$00,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$01,$01,$02,$02,$03,$03,$03,$03,$78,$06,$58,$55,$55
        .byte $55,$c5,$c0,$c0,$c0,$87,$06,$10,$9a

    L_4f94:
        .byte $7a,$7a,$7a
        .byte $78,$72,$7f,$18,$0b,$01,$55,$55,$55,$55,$55,$04,$aa,$8b,$00,$56
        .byte $55,$5e,$5e,$5e

    L_4fab:
        lsr L_086e + $5f0,x

        .byte $8b,$01,$66,$59,$66,$5a,$56,$59,$56,$56,$87,$00,$55,$55,$55,$55
        .byte $55,$55,$56,$5a,$7e,$00,$00

    L_4fc5:
        .fill $13, $0
        .byte $01,$01,$01,$01,$01,$01,$01,$00,$60,$00,$40,$40,$42,$42,$42,$42
        .byte $4a,$40,$6b,$00,$55,$56,$46,$46,$06,$06,$15,$14,$bc,$00,$6a,$ea
        .byte $ea,$6a,$6a,$aa,$02,$02,$cb,$01,$42,$02,$42,$12,$42,$52,$42,$52
        .byte $b1,$00,$40,$40,$6a,$43,$43,$43,$53,$53,$b8,$06,$5b,$5e,$fa,$5a
        .byte $6a,$5a,$6a,$5a,$6e,$07,$00

    L_501f:
        .fill $1d, $0

    L_503c:
        .byte $4b,$4b,$4b,$4b,$4b,$4b
        .byte $4a,$4a,$6b,$07,$12,$12,$12,$12,$13,$10,$11,$37,$b7,$0c,$56,$5e
        .byte $7a

    L_5053:
        nop 
        tax 
        tsx 

        .byte $fa,$fa,$7b,$0c,$52,$43,$46,$17

    L_505e:
        lsr $1a,x

        .byte $1a,$1a,$bc,$01,$63

    L_5065:
        .byte $63,$63,$63,$53,$53,$53,$50,$cb
        .byte $06,$6a,$69,$59,$69,$69,$59,$69,$68,$6e,$00,$00

    L_5079:
        .fill $1d, $0
        .byte $4a,$48,$48,$48,$48,$48,$48,$4b,$6b,$0f,$15,$11,$00,$a8,$a9,$a9

    L_50a6:
        .byte $ff,$00,$cb,$0f,$6f,$6f,$6f,$af,$6f,$af,$5f,$07,$1c,$0b,$1a,$1a
        .byte $1e,$0e,$06,$03,$43,$11,$bc,$01,$50,$58,$58,$58,$58,$58,$54,$d4
        .byte $cb,$0f,$68,$64,$64,$64,$60,$20,$a1,$a6,$6e,$00,$00,$00,$00,$00
        .byte $00,$54,$a8,$59,$6e,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$10,$54,$64,$65,$59,$55,$51,$6e,$00,$48,$08,$02,$02,$00,$40
        .byte $40,$50,$6f,$00,$00,$55,$55,$2a,$19,$09,$05,$09,$2a,$00,$00,$40
        .byte $50,$59,$5a,$5e,$97,$95,$2a,$01,$40

    L_510f:
        bpl L_5115

        .byte $00,$80,$e0,$f8

    L_5115:
        inc L_086e + $244,x
        pla 
        cld 
        cld 
        sec 
        sec 
        php 

    L_511e:
         .byte $0c,$00,$fc,$0b
        .byte $59,$66,$56,$5a,$58,$60

    L_5128:
        .byte $a2,$40,$e6,$00,$56,$56,$06,$12,$11,$01,$11,$11,$6e,$00,$01,$01
        .byte $01,$01,$01,$01,$01,$00,$60,$00,$41,$40,$40,$40,$40,$02,$0b,$2e
        .byte $62,$0a,$50,$50,$50,$15,$1a,$af,$8f,$ff,$62,$09,$05,$25,$95,$55
        .byte $5a,$da,$ff,$83,$2a,$09,$5a,$6b,$5a,$99,$95,$97,$ff,$73,$a2,$09
        .byte $69,$5a,$5a,$a6,$f7,$ff,$ff,$fb,$2a,$09,$54,$52,$52,$f0,$ff,$7f
        .byte $ff,$fa,$a2,$09,$48,$4a,$2a,$fa,$8a,$aa,$ba,$ab,$e2,$0a,$01,$01
        .byte $81,$a1,$e8,$f8,$fe,$bf,$69,$02,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$1b,$27,$2f,$67,$5f,$9e,$9d,$b6,$2a,$09,$55,$65,$57,$ff
        .byte $f7,$fb,$bf,$bf,$9a,$02,$55,$56,$aa,$98,$bb,$aa,$aa,$aa,$92,$0a
        .byte $55,$59,$d7,$ff,$ff,$ff,$fb,$eb,$9a,$02,$6a,$9a,$59,$5d,$55,$55
        .byte $55,$d6,$29,$0a,$6a,$aa,$aa

    L_51cf:
        txa 
        tsx 
        tax 
        tax 
        tax 

        .byte $92,$0a,$56,$66,$56,$66,$66,$66

    L_51dc:
        ldx $a6
        rol 

        .byte $00,$66,$e6,$ea,$fa,$7a,$7e,$5e,$de,$12,$0a,$01,$01,$05,$05,$05
        .byte $19,$19,$1a,$2a,$00,$56,$66,$65,$57,$5f,$6f,$6f,$63,$2a,$09,$6e
        .byte $6e,$6a,$6a,$96,$aa,$ea,$eb,$1a,$02,$56,$5a,$6a,$ba,$aa,$95,$57
        .byte $43,$2a,$09,$55,$55,$69,$5e,$f5,$ff,$0f,$03,$a1,$02,$6b,$aa,$aa
        .byte $ff,$ff,$a9,$55,$05,$2a,$01,$65,$55,$f5,$d5,$5a,$6a,$aa,$00,$a2
        .byte $01,$59,$e9,$6a,$8a,$8a,$8a,$03,$33,$a2,$09,$66,$66,$56,$55,$55
        .byte $d5,$f5,$ff

    L_5242:
        ldx #$09
    L_5244:
        ror 
        ror 
        ror 
    L_5247:
        ror 
    L_5248:
        ldx L_babe
        lda $012a,y

        .byte $63,$63,$6c,$7c,$bc,$fc,$f8,$a8,$a2,$09,$55,$54,$01,$15,$16,$5a
        .byte $6d,$65,$2a,$01,$06,$5f,$77,$fd,$dd,$75,$56,$da,$29,$0a,$5a,$bd
        .byte $af,$fe,$ff,$5f,$1f,$57,$9a,$02,$56,$f5,$ae,$5a,$f6,$a9,$6a,$96
        .byte $a2,$09,$58,$d8,$da,$7a,$7a,$58

    L_5286:
        .byte $da,$5a
        .byte $29,$0a,$10,$10,$16,$36,$36,$36,$76,$f4,$29,$0a,$55,$99,$aa,$ea
        .byte $ea,$fa,$fe,$ff,$92,$0a,$56,$56,$55,$55,$55,$56,$5a,$aa,$a2,$00
        .byte $64,$a7,$a4,$94,$50,$40,$40,$00,$2a,$09,$15,$16,$2d,$25,$16,$2d
        .byte $29,$15,$2a,$01,$55,$55,$96,$97,$5b,$5a,$56,$95,$2a,$01,$51,$64
        .byte $65,$79,$69,$69,$65,$55,$2a,$01,$6f,$d9,$f5,$7d,$ad,$af,$97,$b7
        .byte $29,$0a,$69,$eb,$e7,$6d,$6d,$94,$b4,$b4

    L_52e2:
        and #$0a
        rts 



        .byte $80,$00,$00,$00,$00,$03,$0f,$a2,$06

    L_52ee:
        adc $59
        cmp $d5,x
        and $3d,x

        .byte $0f,$03,$a1,$02,$54,$52,$02,$02,$02,$02,$02,$02,$26,$00,$40,$40
        .byte $40,$40,$40,$40,$40,$40,$60,$00,$06,$0b,$09,$06,$19,$14,$13,$0f
        .byte $2a,$0b,$6a,$aa,$a9,$65,$67,$a5,$a5,$25,$a2,$01,$15,$15,$69,$6a
        .byte $6e,$6c,$68,$68,$2a,$01,$6f,$7b,$7e,$ff,$ff

    L_532f:
        .byte $3f,$0f
        .byte $a0,$9a,$02,$50,$60,$60,$70,$70,$b0,$b0,$b0,$a2,$0b,$01,$41,$41
        .byte $45,$40

    L_5343:
        .byte $45,$41,$41,$60,$00,$42
        .byte $40,$40,$40,$44,$45,$45

    L_534f:
        eor ($62,x)

        .byte $00,$01,$01

    L_5354:
        ora $05
        ora $05
        ora $05
        rts 



        .byte $00,$40,$40,$00,$00,$02,$02,$00,$00,$6b,$00,$19,$59,$53,$4c,$01
        .byte $00

    L_536c:
        .byte $14,$3f
        .byte $b1,$0c,$1b,$87,$c6,$e1,$31,$80,$0f,$0f,$2b,$0a,$64,$61,$61,$47
        .byte $47,$1c

    L_5380:
        bvc L_53d3
        tsx 

    L_5383:
         .byte $0f,$5a,$da
        .byte $d6,$aa,$00,$2a,$b6,$e0

    L_538c:
        .byte $fb
        .byte $01,$18,$88,$a8,$aa,$02,$80,$a8,$02,$2b,$00,$45,$01,$05,$00,$85
        .byte $00,$01,$85

    L_53a0:
        .byte $6b,$00
        .byte $45,$41,$45,$45,$45,$41,$41,$41,$60,$00,$05,$05,$05,$05,$05,$04
        .byte $04,$14,$60,$00,$00,$00,$01,$06,$0a,$1a,$1a,$2a,$bc,$00,$01,$50
        .byte $59,$aa,$aa,$aa,$aa,$ae,$bc,$0f,$4b,$80,$3e,$ab,$82,$a8,$a4,$a6
        .byte $cb

    L_53d3:
        ora ($16,x)
        ora $1455,y

        .byte $44,$40,$10,$14,$bc,$00,$40

    L_53df:
        .byte $02,$1f,$1b,$6b,$6f,$af,$af
        .byte $bc,$0f,$00,$54,$a5,$a9,$86,$e6,$de,$da,$bc,$01,$01,$01,$80,$b1
        .byte $a8,$ac,$ab,$eb

    L_53fa:
        .byte $6b,$0c
        .byte $45,$41,$41,$41,$41,$45,$45,$45,$60,$00,$10,$10,$14,$14,$16,$12

    L_540c:
        .byte $12,$02,$6b,$00
        .byte $6a,$6a,$6a,$aa,$af,$bb,$a7,$92

    L_5418:
        ldy L_690f,x

        .byte $6b,$6b,$6b,$6b,$a7

    L_5420:
        lda $a5

        .byte $cf,$0b,$59,$1b,$1b,$7b,$7a,$ef,$7f,$c0,$b1,$0c,$44,$44

    L_5430:
        sty $90,x
        sta ($92),y

        .byte $42,$02,$bc,$00,$5b,$5b,$5a,$5a,$5a,$5a,$5a,$55,$cf,$01,$6b,$6b
        .byte $6b,$df,$bc,$b0,$f3

    L_5449:
        .byte $c3,$1f,$0c
        .byte $6a,$5a,$a5,$02,$00,$00,$a8

    L_5453:
        ror 

        .byte $cb,$00,$42,$4a,$6a,$52,$da,$2a,$2a,$0a,$c6,$0b,$06,$06,$16,$10
        .byte $10,$10,$42,$4a,$6b,$00,$41,$00,$14,$55,$56,$6a,$6b,$ab,$bc,$0f
        .byte $5a,$96,$da,$3a,$0e,$c3,$b0,$6c,$fc,$0b,$68,$62,$58,$55,$56,$6a
        .byte $0a

    L_5485:
        .byte $00,$cb,$00
        .byte $46,$06,$46,$06,$46,$46,$01,$00,$bc,$00,$69,$e5,$a5,$94,$a4,$91
        .byte $49,$1a,$bc,$0f,$06,$1a,$1b,$5b,$5b,$5b,$5b,$5b,$cf,$01,$56,$a5
        .byte $85,$b5,$a4,$a6,$a5,$a5,$cf,$01,$05,$05,$85,$85,$c5,$e5,$e5,$e1
        .byte $6b,$0c,$05,$05,$04,$04,$00,$00,$00,$00,$b0,$00,$5a,$db,$1a,$3a
        .byte $0a,$0e,$d3,$5c,$cf,$0b,$6f,$6b,$53,$57,$af,$bf,$bf,$ff,$fc,$0b
        .byte $40,$41,$45,$44,$45,$15

    L_54de:
        ora $11
        bcs L_54e2
    L_54e2:
        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $00,$00,$00,$b0,$00

    L_54ec:
        lsr $57,x
        eor $55,x

        .byte $50,$0a,$2a,$15,$cb,$0f,$5a,$5a,$5f,$70,$03,$f5,$55,$55,$cf,$0b
        .byte $6a

    L_5501:
        .byte $82,$00,$00,$f0,$6c,$6f,$6b,$fc,$0b,$52,$52,$52,$12,$12,$02,$02
        .byte $02

    L_5512:
        dec $00

        .byte $12,$43,$43,$4b,$4b,$0b,$08,$28,$6b,$0c,$67,$6b,$69,$aa,$ac,$c0
        .byte $00,$00,$cf,$0b,$14,$40,$55,$54,$00,$00,$20,$aa,$b2,$00,$50,$51
        .byte $05,$04

    L_5536:
        .byte $44,$44,$10,$10,$b0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_5546:
        .byte $1a
        .byte $06,$00,$28,$03,$33,$03,$03,$bc,$02,$45

    L_5551:
        adc $55
        ora $00,x

    L_5555:
         .byte $f0,$ff,$ff,$cf,$02

    L_555a:
        ror 
        tax 
        ror 
    L_555d:
        txs 
        asl 

        .byte $00,$f0,$7c,$1c,$09,$42,$42,$4a,$ca,$ca,$ca,$c2,$42,$b6,$0c,$10
        .byte $10,$02,$02,$02,$0f,$0a,$0a,$b2,$09,$15,$55,$56,$da

    L_557c:
        ror 
        ldy #$56
    L_557f:
        ror $29,x
        asl 

        .byte $5a,$6a,$aa

    L_5585:
        sta ($09,x)
        and $25
        lda $29

        .byte $00,$60,$63,$60,$40,$43,$43,$43,$43,$2b,$06,$00,$00,$01,$01,$01
        .byte $01,$00,$00,$60

    L_559f:
        .byte $00,$12,$1a,$1a
        .byte $0a,$0a,$02,$02,$02,$b2,$00,$55,$b5,$65,$6a,$60,$69,$59,$69,$a2
        .byte $01,$60,$48,$c2,$2b,$2a

    L_55b9:
        .byte $fa,$fb,$eb
        .byte $a9,$02,$01,$85,$01,$05,$01,$81,$c1,$e1,$69,$02,$05,$05,$05,$05
        .byte $05,$05,$05,$05,$20,$00,$6b,$9b,$5b,$6b,$5b,$6b,$6b,$5b,$a2,$09
        .byte $6e,$6a,$be,$ee,$be,$be,$ee,$ba,$92,$0a,$42,$42,$42,$42,$0a,$02
        .byte $0a,$02,$26,$00,$01,$11,$01,$11,$01,$11,$01,$11,$60,$00,$01,$81
        .byte $00,$80,$00,$00,$88,$88,$26,$00,$59,$69,$59,$b5,$b6,$96,$96,$9e

    L_560c:
        ldx #$01
        adc #$59
        cmp vColorRam + $1d9,y
        cmp vColorRam + $1d9,y
        and #$0a

        .byte $52,$52,$52,$52,$52,$52,$52,$52,$26,$00,$06,$05,$06,$05,$06,$05
        .byte $06,$05,$2a,$00,$67,$a7,$67,$a5,$55,$95,$55

    L_5633:
        stx $2a,y
        ora #$5a
        cli 
        cli 
        sei 
        sei 
        rts 


        pla 
        pla 
        ldx #$01
        ora $11
        ora $15
        ora $05
        ora $05
        rts 



        .byte $00,$01,$05,$05,$11,$05,$11,$05,$11,$60,$00,$44,$45,$41

    L_5657:
        eor $41
        eor $45
        eor ($60,x)

        .byte $00

    L_565e:
        eor $1d1d,y
        ora L_086e + $4a1

        .byte $0f,$07

    L_5666:
        and ($0a,x)
        ror 
        adc #$99

        .byte $9b,$9b,$9b,$99,$9a,$a2,$01,$52,$52,$52,$52,$d2,$d2,$d2,$d2,$26
        .byte $0a,$06,$06,$06,$06,$06,$06,$06,$0a,$2a,$00,$6a,$69,$69,$aa,$69
        .byte $a9,$b9,$b5,$a2,$09,$60,$60,$60,$80,$80,$80,$80,$80,$a2,$00,$01
        .byte $05

    L_569c:
        ora $05
        ora $15
        ora $05
        rts 



        .byte $00,$05,$11,$05,$11,$05,$11,$05,$11,$60,$00,$45,$41,$45,$45,$41
        .byte $45,$45,$45,$60,$00,$06,$02,$c2,$01,$01,$c1,$01,$cf,$2a

    L_56c1:
        asl $55
        adc $59
        sta L_9999,y
        sta L_2aff,y
        ora ($63,x)

        .byte $63,$63,$63,$63,$63,$a3,$a3,$a2,$06,$1a,$19,$1a,$19,$1a,$15,$55
        .byte $5f,$2a,$09,$6f,$67,$67,$6b,$6b,$69,$ab,$ab,$29,$0a,$42,$40,$40
        .byte $40,$40,$40,$40

    L_56f1:
        .byte $c0,$26,$0a,$45,$05,$05,$00,$00,$00,$00,$00
        .byte $60,$00,$05,$05,$01,$00,$00,$00,$00,$00,$60,$00

    L_5708:
        eor $05
        ora ($00,x)

        .byte $00,$00,$00,$00,$60,$00,$4b,$4b,$4b,$0b,$0b,$0b,$0b,$0a,$6b,$0c
        .byte $5a,$5a,$5b,$5b,$59,$7a,$6a,$ff,$fc,$0b,$58,$58,$58,$98,$d8,$58
        .byte $68,$a0,$cb,$0f,$65,$9d

    L_5732:
        .byte $7f
        .byte $7d,$ff,$ff,$fd,$55,$29,$0a,$6b,$67,$67,$67,$57,$55,$55,$55,$29
        .byte $0a,$40,$40,$40,$40,$80,$80,$80,$80,$a2,$00

    L_574e:
        .fill $19, $0
        .byte $06,$37,$35,$a1,$02,$01,$05,$16,$5a,$59,$d5,$57,$54,$2a,$01,$56
        .byte $56,$55,$99,$a9,$aa,$ca,$2b,$a2,$01,$50,$50,$90,$54,$95,$95

    L_5786:
        eor $d7,x
        rol 
        ora ($00,x)

        .byte $00,$00,$00,$15,$1f,$1c,$1c,$cc,$01,$00,$00,$00,$00,$55,$ff,$00
        .byte $00,$cc,$01,$00,$00,$00,$00,$54,$f4,$34,$34,$cc,$01,$1c,$1c,$1c
        .byte $1c,$1c,$1c,$1c,$1c,$cc,$01,$34,$34,$34,$34,$34,$34,$34,$34,$cc
        .byte $01,$1c,$1c,$1c,$1f,$15,$00,$00,$00,$cc,$01,$00,$00,$00,$ff,$55
        .byte $00,$00,$00,$cc,$01,$34

    L_57d1:
        .byte $34,$34,$f4,$54,$00,$00,$00

    L_57d8:
        cpy L_1c01

        .byte $1c,$1f,$15,$2a,$2f,$2c,$2c,$cc,$01,$00,$00,$ff,$55,$aa,$ff,$00
        .byte $00

    L_57ec:
        cpy L_3401

        .byte $34,$f4,$54,$a8,$f8,$38,$38,$cc,$01,$2c,$2c,$2c,$2c,$2c,$2c,$2c

    L_57ff:
        bit $01cc
    L_5802:
        sec 
        sec 
        sec 
    L_5805:
        sec 
        sec 
        sec 
        sec 
        sec 
        cpy L_2c01
        bit $2a2f
        ora $1f,x

        .byte $1c,$1c,$cc,$01,$00,$00,$ff,$aa,$55,$ff

    L_581c:
        .byte $00,$00
        .byte $cc,$01,$38,$38,$f8,$a8,$54,$f4,$34,$34,$cc,$01,$78,$a9,$35,$85
        .byte $01,$a9,$00,$8d,$00,$dc

    L_5834:
        jsr L_2c45
        lda cCia1PortB
        cmp #$ff
        bne L_5834
    L_583e:
        lda cCia1PortB
        cmp #$ff
        bne L_583e
        sei 
    L_5846:
        lda #$35
        sta $01
        lda #$00
        sta sFiltMode
        sta vBorderCol
        lda cCia2DDRA
        ora #$03
        sta cCia2DDRA
        lda #$08
        sta vScreenControl1
        lda #$ff
        sta vSprEnable
        lda #$17
        sta vScreenControl2
        ldy #$00
        lda #$00
    L_586d:
        sta vColorRam + $00,y
        sta vColorRam + $100,y
    L_5873:
        sta vColorRam + $200,y
    L_5876:
        sta vColorRam + $300,y
        dey 
        bne L_586d
        lda #$fe
        sta vIRQMasks
        lda #$01
        sta vIRQMasks
        lda #$01
        sta vBackgCol0
        lda #$0c
        sta vBackgCol1
        lda #$0b
        sta vBackgCol2
        sta vBackgCol3
        lda #$00
        sta vSprExpandY
        sta vIRQFlags
        sta vSprPriority
        sta vSprExpandX
        sta cCia1TimerAControl
        sta cCia1TimerbControl
        sta cCia2TimerAControl
        sta cCia2TimerbControl
        lda #$7f
        sta cCia1IntControl
        lda cCia1IntControl
        lda #$ff
        sta cCia1DDRA
        lda #$00
        sta cCia1DDRB
        lda #$01
        sta vSprMCMCol0
        lda #$09
        sta vSprMCMCol1
        lda #$00
        sta cCia2PortA
        lda #$64
        sta vSprite0X
        sta vSprite0Y
        lda #$ff
        sta vSprEnable
        lda #$00
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        sta vSprite6Y
        sta vSprite7Y
        sei 
    L_58fb:
        lda #$35
        sta $01
        lda #$c6
        sta vRaster
        lda #$81
        sta vIRQMasks
        lda #$08
        sta vScreenControl1
        lda #$18
    L_5910:
        sta vScreenControl2
        lda #$38
        sta vMemControl
        lda #$00
        sta vBackgCol0
        sta vBorderCol
    L_5920:
        lda #$34
        sta $01
        ldy #$c0
    L_5926:
        lda L_5998 + $188,y
        sta L_cfff,y
        dey 
        bne L_5926
        lda #$35
        sta $01
        jmp L_235c
        sei 
        lda #$37
        sta $01
        lda $ff
        sta SCREEN_BUFFER_2 + $58
        lda $0330
    L_5943:
        sta SCREEN_BUFFER_2 + $30
        lda $0331
        sta SCREEN_BUFFER_2 + $35
    L_594c:
        jsr L_fd98 + $b
        jsr L_ff5b
        jsr L_fd15
        lda #$08
        tax 
        tay 
    L_5959:
        jsr $ffba
        lda #$03
        ldx #$5f
        ldy #$cc
        jsr L_ffbd
        lda #$00
        sta $0330
        lda #$00
        sta $0331
        ldx #$00
    L_5971:
        lda #$00
        sta vColorRam + $00,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
        sta vColorRam + $300,x
        sta vBorderCol
        sta vBackgCol0
        inx 
        bne L_5971
        lda #$00
        jsr $ffd5
        lda #$00
        sta SCREEN_BUFFER_0 + $100
        jmp $080b

    L_5995:
         .byte $30,$31

    L_5997:
        rol 

    L_5998:
         .fill $1cc, $0
        .byte $40,$00,$00,$60,$00,$00,$38,$00,$00,$1d,$b0,$00,$0f,$f8

    L_5b72:
        .byte $00,$07,$fc,$00,$0b,$fc,$00
        .byte $0d,$fc,$00,$05,$fc,$00,$71,$fc,$00,$3f,$fc,$00,$07,$be,$00,$00
        .byte $7c,$00,$00,$38
        .fill $13, $0

    L_5ba0:
        ldy #$40

    L_5ba2:
         .byte $00,$00
        .byte $e0,$00,$00,$f0,$00,$00,$7d,$b0,$00,$3f,$f8,$00,$1f,$fc,$00,$0f
        .byte $fe,$00,$1f,$fe,$00,$1f,$fe,$00,$7f,$fe,$00,$ff,$fe,$00,$7f,$fe
        .byte $00,$3f,$ff,$00,$07,$fe,$00,$00

    L_5bcc:
        .byte $7c,$00,$00
        .byte $38
        .fill $14, $0
        .byte $03,$c0,$00,$02,$b0,$00

    L_5bea:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$ef,$00,$03,$97,$c0
        .byte $32,$b9,$c0,$de,$62,$c0,$ef,$62,$c0,$3b,$a2,$c0,$0c,$a2,$c0,$03
        .byte $fd,$c0,$0d,$ae,$c0,$36,$a0,$00,$1a,$ac,$00,$2b,$02,$00,$36,$0a
        .byte $c0,$0d,$ce,$80,$e4,$02,$b3,$b0,$00

    L_5c25:
        rts 



        .byte $a8,$03,$60,$f8,$02,$b0,$08,$00,$00,$08,$00,$00,$0c

    L_5c33:
        .fill $2d, $0
        .byte $e4,$00

    L_5c62:
        .byte $00,$00,$03
        .byte $c0,$00,$02,$b0,$00

    L_5c6a:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$ec,$00,$03,$9b,$00
        .byte $03,$b6,$c0,$32,$be,$c0,$df,$62,$c0,$eb,$ae,$00,$3c,$a2,$00,$03
        .byte $f6,$00,$03,$8b,$00

    L_5c91:
        asl.a $00b0
        and.a $00ac,y
        rol $b3,x

        .byte $00,$36,$ca,$00

    L_5c9d:
        asl 
        dec L_e3ff + $1
        ora $c0ce

        .byte $02,$b3,$b0,$00,$63,$a0,$03,$90,$f0,$02,$b0,$f0,$00,$00,$30

    L_5cb3:
        .fill $2d, $0
        .byte $e4,$00,$00,$00,$00,$00,$00,$03,$c0,$00

    L_5cea:
        .byte $02
        .byte $b0,$00

    L_5ced:
        ora ($b0,x)

    L_5cef:
         .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$9c,$00,$03
        .byte $98

    L_5cfe:
        .byte $00,$03,$e7,$00,$0f,$b7,$00,$37
        .byte $ba,$00,$38,$8a,$00,$00,$37,$00,$00,$db,$00,$03,$e8,$00,$03,$70
        .byte $00

    L_5d17:
        asl.a $00ac
        ora.a $00ac
        asl.a $00bb
        cpx $03

    L_5d22:
         .byte $7a,$00,$00
        .byte $ae,$c0,$00,$a2,$c0

    L_5d2a:
        .byte $00,$df,$80,$00,$eb,$80,$00,$df,$00,$00,$b0

    L_5d35:
        .fill $2b, $0
        .byte $e4,$00,$00,$00,$00,$00,$00,$03,$c0,$00,$02,$b0,$00

    L_5d6d:
        ora ($b0,x)

    L_5d6f:
         .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$b0,$00,$03,$9c,$00
        .byte $03,$d8,$00,$03,$e8,$00,$0f,$b7,$00,$0f,$b7,$00,$0c,$fb,$00,$00
        .byte $5b,$00,$03,$ac,$00,$03,$fc,$00,$03,$ac,$00,$03,$6c,$00,$03,$60
        .byte $00,$e4,$03

    L_5da2:
        .byte $70,$00,$00,$6c,$00,$00,$9f,$00,$00,$df,$00,$00,$2b,$00,$00,$34
        .byte $00,$00,$e8

    L_5db5:
        .fill $2b, $0
        .byte $e4,$00,$00,$00,$00,$00,$00,$03,$c0,$00,$02

    L_5deb:
        bcs L_5ded
    L_5ded:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$ac,$00,$03

    L_5dfd:
        .byte $9c,$00,$03,$dc,$00,$03,$dc,$00,$03,$dc,$00,$03
        .byte $e8,$00,$0d,$f8,$00,$0d,$68,$00,$02,$fc,$00,$03,$0c,$00,$03,$e8
        .byte $00,$0e,$db,$00,$0e,$ba,$00,$e4,$03,$76,$c0,$00,$be,$c0,$00,$e1
        .byte $80,$00,$2c,$b0,$00,$ec,$a0,$00,$e3,$70,$00,$b2,$c0,$00

    L_5e37:
        .fill $29, $0
        .byte $e4,$00,$00,$00,$03,$c0,$00

    L_5e67:
        .byte $02
        .byte $b0,$00

    L_5e6a:
        ora ($b0,x)

    L_5e6c:
         .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$f0,$00,$00,$9c,$00
        .byte $03,$df,$00,$3b,$de,$00,$37,$df,$00,$39,$ec,$00,$0e,$6c,$00,$03
        .byte $a0,$00,$00,$0c,$00,$03,$e8,$00,$0e,$eb,$00,$09,$e7,$00,$0e,$b7
        .byte $00,$02,$4a,$00,$e4,$03

    L_5ea2:
        lda $03c0,x
        ldx #$b0

        .byte $00,$e3,$60,$00,$ec,$e0,$03,$ac,$d0,$03,$f0,$20,$00,$00,$30

    L_5eb6:
        .fill $2a, $0
        .byte $e4,$00,$00,$00,$03,$c0,$00,$02,$b0,$00

    L_5eea:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$fc,$00,$00,$9f,$00
        .byte $00,$9e

    L_5efe:
        cpy #$18
        jmp (L_27c0)
        jmp ($39c0)

        .byte $bf,$00,$0e,$ba,$00,$03,$f8,$00,$00,$e8,$00,$0e,$eb,$00,$36,$27
        .byte $00,$37,$3a,$00,$0a,$c9,$c0,$0d,$ce,$80,$e4,$03,$b3,$70,$03

    L_5f25:
        .byte $b0,$a8,$0f,$b0,$e4
        .byte $0e,$80,$38,$00,$00,$08,$00,$00,$0c

    L_5f33:
        .fill $2d, $0
        .byte $e4,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00
        .byte $00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03
        .byte $e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0
        .byte $00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00
        .byte $c4,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00
        .byte $02,$08,$00,$aa,$0a,$a0,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_5fbf:
        tax 
        asl 
        ldy #$02
        php 

        .byte $00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14
        .fill $1e, $0
        .byte $bd,$20,$42

    L_6002:
        .byte $04
        .byte $20,$a3,$fd,$20,$15,$fd,$4c,$0b,$08

    L_600c:
        jsr L_0403 + $28
        rol $bd
        lda $bd
        cmp #$02
        bne L_600c
        ldy #$09
    L_6019:
        jsr L_04ad
        cmp #$02
        beq L_6019
    L_6020:
        cpy $bd
        bne L_600c
        jsr L_04ad
        dey 
        bne L_6020
        rts 


        lda #$10
    L_602d:
        bit cCia1IntControl
        beq L_602d
        lda cCia2IntControl
        sta vBorderCol
        sta sFiltMode
    L_603b:
        lsr 
        lda #$19
        sta cCia2TimerAControl
        rts 


    L_6042:
        jsr L_0478 + $1d
        jsr L_0403 + $9
    L_6048:
        jsr L_04ad
        sta.a $00ae,y
        iny 
        cpy #$05
        bne L_6048
        jsr L_04ad
    L_6056:
        cmp #$30
        bne L_6042
        jsr L_04ad
        cmp #$31
        bne L_6042
    L_6061:
        jsr L_04ad
        iny 
        cpy #$13
        bne L_6061
        jsr L_0478 + $13
        jsr L_0478 + $1d
        jsr L_0403 + $9
    L_6072:
        jsr L_04ad
        ror $01
        sta ($ae),y
        rol $01
        inc $ae
        bne L_6081
        inc $af
    L_6081:
        lda $ae
        cmp $b0
    L_6085:
        lda $af
        sbc $b1
        bcc L_6072
        dec $c0
        clc 
    L_608e:
        lda $01
        ora #$20
        sta $01
        rts 


        sei 
        ldy #$00
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        lda #$07
        sta $01
        sta cCia2TimerALo
        lda #$01
        sta cCia2TimerAHi
        rts 


        ldx #$08
    L_60af:
        jsr L_0403 + $28
        rol $bd
        dex 
        bne L_60af
        lda $bd
        rts 



    L_60ba:
         .byte $32,$c7,$97,$53
        .byte $95,$bc,$42,$66,$45,$a1,$9f,$9d,$ba,$1a,$03,$5c,$0f,$2a,$68,$1e
        .byte $5a,$41,$5a,$6c,$a7,$24,$a3,$38,$47,$97,$7e,$2f,$28,$15,$33,$40
        .byte $f2,$d1,$40,$f2,$bd,$81,$e5,$a0,$15,$a6,$8e,$72,$6a,$ac,$61,$48
        .byte $f3,$17,$94,$08,$20,$8a,$cd,$40

    L_60f6:
        .byte $a5,$11,$39,$45,$57,$04
        .byte $38

    L_60fd:
        .byte $cb,$1f,$43,$df
        .byte $46,$3f,$39,$00,$f0,$7e,$0c,$4d,$b8,$68,$25,$72,$aa,$c2,$f1,$2a
        .byte $c3,$41,$31,$9d,$2b,$8b,$c6,$2a,$09,$51,$19,$21,$01,$b9,$45,$e7
        .byte $4a,$a1,$9b,$56,$6e,$e2,$ac,$8e,$9e,$20,$4f,$09,$04,$13,$19,$50
        .byte $c1,$78,$90,$c1,$a0,$c9,$67,$4c,$62,$f0,$80,$11,$9d,$c6,$71,$e7
        .byte $04,$fd,$19,$d3,$08,$67,$35,$9b,$b4,$ab,$76,$98,$bf,$2c,$d4,$08
        .byte $a0,$3f,$08,$25,$5c,$10,$e3,$87,$1d,$1b,$9d,$31,$e9,$be,$0a,$19
        .byte $99,$66,$db,$9c,$e9,$54,$36,$26,$6f

    L_616a:
        clv 
        ldy $75

        .byte $9c,$00,$52,$8d,$99,$b6,$d9,$5d,$ab,$1d,$e2,$f2,$89,$8d,$2b,$e0
        .byte $f0,$78

    L_617f:
        .byte $2b,$53
        .byte $36,$dc,$e7,$4c,$21,$90,$0c,$df,$71,$48,$49,$ce,$84,$06,$74,$19
        .byte $90,$16,$05,$21,$e7,$9c,$01,$1a,$85,$3d,$a1,$cc,$bc,$ea,$9c

    L_61a0:
        .byte $53
        .byte $5e,$6a,$ce,$38

    L_61a5:
        jsr L_987c + $2

        .byte $a2,$af,$0d,$79,$63,$1a,$65,$9e,$5f,$77,$1e,$63,$eb,$c6,$05

    L_61b7:
        .byte $47,$d0,$28,$17
        .byte $90,$30

    L_61bd:
        .byte $64
        .byte $a0,$7e,$06,$a3,$d0,$1c,$5e,$2c,$a0,$5f,$50,$d4,$54,$87,$c0,$10
        .byte $28,$90,$d4,$62,$03,$8b,$c4,$e4

    L_61d6:
        php 
        sbc ($06,x)

        .byte $a3,$20,$1f,$00,$40,$b1,$e1,$82,$54,$0b,$86,$18,$2c,$82,$05,$ce
        .byte $0c,$12,$a0,$5c

    L_61ed:
        ldy #$c1
        asl $e8

        .byte $82,$9b,$57,$b8,$52,$eb

    L_61f7:
        rts 



        .byte $fa,$6f,$a5,$08,$ce,$44,$a8,$cb,$60

    L_6201:
        .byte $e6,$e8,$b3
        .byte $a8,$9d,$9f,$ae,$93,$45,$01,$82,$68,$98,$56,$13,$5d,$6a,$15,$ab
        .byte $e5,$7d,$41,$10,$c4,$01,$27,$bc,$67,$38

    L_621e:
        sta ($19),y
        eor ($64,x)
        and #$84
        and $84

        .byte $c2,$99,$30,$dd,$a6,$32,$8e,$10,$71,$78,$81,$8d,$45,$42,$8e,$56
        .byte $3c,$5a,$2d,$d9,$3d,$29,$33,$a8,$ea,$9d,$47,$54,$ea,$3a,$a7,$51
        .byte $d5,$41,$2a,$db,$d1,$aa,$ab,$04,$9c,$6c,$4a,$18

    L_6252:
        .byte $b3,$c3
        .byte $99,$52,$85,$cc,$b8,$42,$d4,$40,$87,$1f,$6a,$0e,$aa,$7b,$78,$68
        .byte $c0,$66,$f6,$8a,$6a,$92,$06,$a4,$96,$31,$1b,$dd,$99,$2c,$1a,$83
        .byte $18,$67,$92,$09,$45,$35,$47,$03,$75,$5a,$9b,$c2

    L_6280:
        stx $0c
    L_6282:
        sbc $e3c9,y

        .byte $3b,$2a

    L_6287:
        .byte $47,$7c
        .byte $28,$62,$4f,$89,$04,$11,$52

    L_6290:
        ora ($83,x)

        .byte $02,$1a,$dd,$61,$04,$14,$1b,$b8,$e7,$50,$56,$2c,$76,$d5,$0d,$12
        .byte $7c,$aa,$8b,$d0,$e3,$93,$41,$bb,$cd,$35,$1c,$8b,$e0,$b8,$5e,$e9
        .byte $e7,$7c,$39,$52,$ac,$5d,$06,$ef,$34,$d4,$73,$b3,$fc,$2a,$95,$1a
        .byte $3a,$0c,$08,$6b,$3d,$ff,$0c,$ed,$da,$df,$9b,$3f

    L_62ce:
        ora #$ed

        .byte $dc,$7d,$e9,$ef,$e1,$ca,$a3,$47,$43,$ea,$8e,$14,$d7,$36,$fd,$fa
        .byte $a9,$46,$ee,$3c,$04,$e2,$71,$bb,$70,$e0,$cb,$4a,$37,$71,$e0,$27
        .byte $33,$88

    L_62f2:
        .byte $cf

    L_62f3:
        eor L_6ef7 + $3,x
        cmp ($37,x)
        rol L_8414,x
        dex 

        .byte $1b,$b1,$72,$85,$48

    L_6301:
        cpx L_420a
        ldx $fc,y
        sta $05,x
        eor L_b522,y
        clv 

        .byte $07,$8c,$1d,$d4,$88,$29,$b6,$82,$0a,$62,$33,$d7,$7e,$33,$b4,$13
        .byte $f0,$75,$19,$e0,$dd,$8a,$cf,$04,$9e

    L_6325:
        rol SCREEN_BUFFER_0 + $cd,x
        cmp #$c6

        .byte $ef,$2b,$e2

    L_632d:
        cmp $e2
        adc $1b,x

        .byte $80,$d0,$75,$6a,$7f,$0e,$32,$b5,$c5,$88,$dd,$c7,$0b,$22,$cb,$86
        .byte $a3,$2e,$14,$26,$32,$c4,$75,$62,$a0,$43,$5e,$74,$0b,$21,$c7

    L_6350:
        ror $86
        adc ($18),y

        .byte $12,$89,$28,$64,$d9,$9c,$f5

    L_635b:
        .byte $13,$30,$25
        .byte $e5,$40,$6f,$49,$47,$2a,$12,$86,$76,$ba,$15,$04,$e4,$18,$4a,$34
        .byte $e0,$8c,$e5,$a0,$37,$38,$75,$c0,$52,$08

    L_6378:
        cpy $9835
        adc $29
        asl $10

        .byte $80,$a4,$11,$98,$6b,$20,$28,$c8,$40,$90,$2c,$80,$8c,$f4,$86,$34
        .byte $f9,$31,$6a,$06,$2e,$f0,$c5,$40,$85,$90,$40,$87,$32,$d3,$7a,$10
        .byte $53,$5f,$0a,$c0,$03,$0e,$7c,$3b,$0c,$ce,$73,$cd,$42,$8a,$82,$1f
        .byte $54,$76,$7c,$e8,$4a,$09,$c8,$6d,$9f,$8a,$09,$54,$e5,$1c

    L_63bd:
        .byte $b3,$42,$83,$c7

    L_63c1:
        rol $82

        .byte $63,$7e,$d6,$83,$3a,$55,$6f,$ca,$04,$f6,$32,$a3,$35,$03,$1e,$d8
        .byte $f1,$20,$83,$33,$61,$bd,$03,$5c,$30,$63,$20,$66,$87,$3a,$61,$66
        .byte $7b,$24,$70,$e6,$6c,$37,$e7,$4a,$e3,$0c,$7f,$39,$d2,$b8

    L_63f1:
        .byte $f0,$c7

    L_63f3:
        lsr L_5eb6 + $d
        cli 
        dec $bf
        ldx L_9114,y

        .byte $af,$2c,$63,$2e

    L_6400:
        .byte $2f
        .byte $05,$cc

    L_6403:
        cld 

    L_6404:
         .byte $6f
        .byte $11,$9d,$42,$4a,$95,$2b

    L_640b:
        cpy $0c
        cmp L_f179 + $d
        ora $24a4,y
        adc #$f2

        .byte $d0,$33,$43,$9d,$2b,$99,$b0,$de,$23,$6e,$08,$1d,$a4,$ac,$79,$71
        .byte $5e,$0e,$d1,$ae,$1c,$d0,$3c,$76,$ae,$1c,$b5,$c2,$86,$ac,$c9,$a0
        .byte $20,$80,$46,$96,$4d,$b8,$e4,$d0,$4a,$e5,$9a,$1c,$71,$a2,$25,$52
        .byte $ef,$0b,$e6,$68

    L_6449:
        adc ($c9),y

    L_644b:
         .byte $af

    L_644c:
        sta cCia1TODten,y
        php 
        dex 

        .byte $04,$88,$1e,$80,$fa,$56,$b6,$e1,$a0,$95,$a8,$a9,$0a

    L_645e:
        ldy $5a,x

        .byte $1a,$22

    L_6462:
        sta ($40,x)
        ora L_c189
        eor L_9446
        bpl L_6462
        cmp #$9f

        .byte $3b,$3a,$55,$da,$ce,$c9,$f7,$83,$22,$34,$1c,$32,$eb,$c4,$18,$14
        .byte $14,$35,$18,$84,$b4,$db,$a2,$df,$15,$c8,$c8,$05,$5a,$86,$12,$59
        .byte $80,$24,$30,$26,$80,$0a,$71,$81,$0c,$08,$6f,$22,$d0,$eb,$90,$5a
        .byte $17,$92,$a0,$92,$22,$86,$bc,$12,$c4,$50,$d7,$ce,$a1,$af,$0e,$57
        .byte $8a,$09,$8a,$8c,$d4,$0c,$70,$e3,$b7,$82

    L_64b8:
        rol $02,x
        and #$28
        and $6a
    L_64be:
        sec 
        lda ($c6,x)
    L_64c1:
        clc 
        inx 
        asl $79
        cmp $0c
        adc L_d280 + $e,y
        lsr $3d,x
        ror 
        stx $7128
        sbc ($76,x)

        .byte $92,$b3,$c3,$04,$15,$f3,$a6,$2b,$e7,$6e,$d0,$c1,$9b,$7f,$0f,$a6
        .byte $14,$e8,$62,$4f,$0e,$67,$45,$e4,$a8,$ca

    L_64ec:
        cpy #$9f
        ror 

        .byte $1b,$42,$d2,$a7,$9f,$40,$c3,$61,$55

    L_64f8:
        sta $11d3,y
        eor ($90),y

        .byte $33,$b2,$51,$53,$f0,$21,$b0,$1e,$23,$c4,$82,$ba,$cc,$80,$36,$76
        .byte $ee,$50,$c9,$e5,$f4,$0c,$56,$d2,$04,$18,$71,$59,$58,$10,$64,$ee
        .byte $95,$48,$91,$0c,$7e,$11,$43,$32,$7d,$97,$ce,$c9,$56,$54,$d0,$64
        .byte $a9,$01,$b7,$4c,$50,$a3,$49,$32,$ab,$a2,$c5,$3b,$54,$63,$c0,$a7
        .byte $31,$b0,$af,$04,$15,$e0,$a3,$31,$34,$b3,$70,$a3,$40,$1b,$33,$4c
        .byte $cb,$b7,$e1,$40,$20,$ce,$fb,$d6,$ef,$a4,$5e,$46,$45,$df,$40,$22
        .byte $d4,$cf,$25,$c7,$92,$6a,$9d,$8c,$53,$ac,$15,$8e,$fb,$c8,$91,$ff
        .byte $29,$e4,$60,$1d,$f6,$61,$4e,$ec,$34,$a1,$79,$10,$e3,$e1,$3c,$3c
        .byte $dc,$3c,$2d,$9e,$37,$91,$9a,$f8,$da,$29,$d3,$ca,$60,$a9,$5d,$5c
        .byte $ab,$40,$ed,$4a,$63,$4c,$d0,$6e,$d0,$d2,$d9,$b9,$48,$68,$0c,$d8
        .byte $73,$38,$7e,$33,$34,$bf,$fd,$a7,$90,$85,$1f,$2b,$15,$fe,$86,$7c
        .byte $ac,$77,$fa,$09,$cd,$38,$20,$fa,$cf,$08,$c9,$e8,$54,$f3,$e8,$1c
        .byte $aa,$e6,$2e,$56,$25,$62,$b9,$8b,$c4,$ea,$3d,$01,$8a,$ec,$07,$2a
        .byte $05,$8b,$75,$15,$21,$8b,$94,$39,$73,$b1,$72,$b1,$2b,$30,$5f,$1b
        .byte $08,$9d,$46,$20,$31,$5d,$a0,$e5,$a8,$c5,$ba,$8c,$80,$62,$b3,$c1
        .byte $82,$18,$a9,$e1,$4d,$60,$40,$3d,$22,$33,$5a

    L_65f8:
        dec $a951
        dex 

        .byte $02,$1a,$4c,$fd,$35,$19,$a8,$18,$da,$c9,$fe,$6a,$35,$d0,$3c,$a1
        .byte $20,$63,$2c,$f0,$e6,$4a,$ff,$cc,$83,$65,$e0,$f7,$8b,$9c,$39,$db
        .byte $bc,$61,$8b

    L_661f:
        .byte $fc,$32

    L_6621:
        stx $4f

        .byte $07,$8a,$dc

    L_6626:
        asl $08

        .byte $22,$b2,$e1,$83,$fa,$2a,$04,$22,$91,$7a,$ca,$5e,$30,$7a,$8a,$6a
        .byte $56,$00,$8c,$4d,$c5,$14,$d6,$5a,$b3,$1a,$a4,$6f,$22,$d4,$0a,$12
        .byte $2f,$83,$ae,$1f,$b2,$f5,$16,$c1,$43,$43,$66,$c8,$0b,$d0,$2c,$bc
        .byte $52,$30,$c5,$35,$cd,$ac,$05,$02,$71,$bb,$82,$94,$86,$80,$32,$71
        .byte $d5,$83,$09,$02,$b4,$0c,$36,$a6

    L_6670:
        .byte $44,$12,$d7,$83
        .byte $8d,$38,$dd,$e6,$40,$19,$38,$bf,$a8,$cd,$40,$c7,$32,$3a,$9a

    L_6683:
        ldx $f0

        .byte $c7,$45,$21,$a7,$47,$71,$b2,$b4,$21,$8f,$e9,$c4,$68,$43,$48,$95
        .byte $3f,$85,$0c,$48,$ea,$8a,$79,$6c,$c0,$c7

    L_669f:
        stx $3c
        sty $22,x
        ora ($0c),y
        clc 
        sbc ($f4,x)

        .byte $df,$15,$9e,$fc,$fc,$1b,$a5,$67,$dc,$21,$2d,$1d,$c9,$75,$6f,$9e
        .byte $ad,$f5,$02,$4a,$f9,$e9,$32,$2c,$b8,$61,$b0,$4b,$38,$65,$53,$a7
        .byte $17,$f5,$be,$0e,$96,$59,$e4,$a0,$95,$cb,$66,$06,$32,$4f

    L_66d6:
        and $04
        dec $74
        tay 
        sta L_1fa1
        rol 

        .byte $22,$62,$3c,$bc,$ad,$08,$63,$af,$5c,$46,$87,$3e,$0b,$ca,$f3,$38
        .byte $d4,$ea,$a3,$45,$34,$12,$82,$9a,$71,$b2,$c1,$0e,$3b,$d1,$dc,$8a
        .byte $90,$e0,$4f,$6d,$63,$5c,$fc,$1a,$15,$68,$45,$21,$bf,$95,$0c,$8c
        .byte $fd,$2c,$a1,$81,$3d,$00,$c8,$b0,$b0,$19,$16,$16,$06,$58,$21,$c6
        .byte $89

    L_6720:
        rti 

        .byte $ce,$c1,$31,$c2,$34,$31,$4d

    L_6728:
        jmp $064b

        .byte $e2,$8a,$6c,$79,$04,$04,$c8,$bf,$14,$d7,$99,$c6,$97,$0f,$cd,$46
        .byte $3a,$00,$8c,$cc,$23,$c0,$23,$3b,$72,$93,$55,$c8

    L_6747:
        lsr 
        cmp #$19
        sty $03
        sec 

        .byte $02,$10,$46,$74,$90,$70,$fb,$97,$b9,$47,$29,$39,$46,$8c

    L_675b:
        asl $4c
        and $f8bc,y
        tay 
        cmp $40
        stx SCREEN_BUFFER_1 + $3a2

        .byte $5c,$38,$e4,$d7,$82,$af,$cc,$80,$32,$95,$30,$e1,$32,$58,$d3,$27
        .byte $a4,$0a,$8b,$f0,$c7,$63,$aa,$3a,$61,$9f,$12,$95,$9c

    L_6783:
        .byte $cf,$03
        .byte $71,$96

    L_6787:
        .byte $bb,$0b
        .byte $8e,$bd,$20,$33,$cd,$38,$59,$b9,$74,$ac,$b3,$cc,$10,$59,$b2,$d7
        .byte $e1,$41,$42,$84,$42,$50,$75,$ea,$c1,$05,$b5,$f8,$5b

    L_67a6:
        lda $0d,x
        clv 

        .byte $0c,$25,$b2,$b0,$99,$61,$b0,$b6,$e2,$33,$1f,$30,$18,$87,$30,$de
        .byte $19,$bb,$b0,$a8,$3c,$72,$6d,$85,$84,$6e,$dd,$7c,$a0,$61,$6d,$b5
        .byte $41,$df,$8e,$3d,$b6,$9c,$39,$69,$30,$b6,$d4,$61,$cb,$71,$85,$b6
        .byte $c1,$86,$08,$2d,$a6,$03,$96,$33,$0a,$9c,$75,$e5,$4b,$97,$fd,$25
        .byte $fd,$e6,$4c,$05,$28,$2f,$85,$d6,$da,$84,$30,$41,$6d,$c4,$0e,$74
        .byte $c5,$ba,$21,$ce,$c9,$5b,$5f,$86,$bd,$20,$67,$a4,$84,$c6,$53,$c7
        .byte $25,$2b,$39,$57,$e1,$8f,$37,$2d,$10,$db,$2b,$09,$95,$c4,$0d,$b0
        .byte $30,$99,$5a,$a0,$d6,$25,$e3,$c2,$66,$55

    L_6823:
        php 
        ror $eb,x
        dex 
        tya 
        asl L_6325
        dey 

        .byte $14,$0b,$88,$1c

    L_6830:
        tax 

        .byte $10,$ab,$28,$85,$9b

    L_6836:
        dey 
        cmp ($28,x)

        .byte $c2,$c9,$b3,$30,$40,$81,$71,$03,$95,$a7,$0e,$39,$91,$d9,$c0,$63
        .byte $c5,$f0,$b5,$d0,$90,$2a,$10,$e5,$4c,$05,$ae,$84,$81,$4c,$07,$b2
        .byte $60,$3d,$94,$21,$ca,$a3,$0a,$06,$88,$73,$3b,$2e,$a6,$67,$d5,$d4

    L_6869:
        .byte $13,$44,$97,$6b
        .byte $c1,$2c,$00,$6b,$40

    L_6872:
        .byte $44,$d0,$00,$92
        .byte $86,$c9,$c4,$60,$98,$30,$b3,$62,$63,$28,$b5,$e0,$97,$18,$10,$c4
        .byte $67

    L_6887:
        eor ($48,x)
        and SCREEN_BUFFER_0 + $6f,y
        cpy #$23
        asl L_d2ef + $5,x
        sta ($f0,x)
    L_6893:
        sta $a9,x
        dex 

        .byte $63,$4e,$e5,$4b,$50,$3a,$b0,$f5,$4e,$4d,$30,$61,$40,$d1,$0b,$88
        .byte $bf,$0c,$f9,$db,$1d,$dd,$1b,$80,$c2,$57,$82,$58,$ac,$e3,$09,$53
        .byte $a8

    L_68b7:
        .byte $63,$b7
        .byte $50,$41,$17,$a8

    L_68bd:
        .byte $62,$a7
        .byte $58,$48,$a1,$9e

    L_68c3:
        .byte $f0,$90,$1b,$83
        .byte $15,$08,$18,$24,$8a,$ca,$06,$0d,$e8,$b9,$83,$05,$63,$17,$03

    L_68d6:
        ora #$07

        .byte $0c,$5d,$2c,$24,$12,$c5,$ea,$18,$2a,$da,$18,$6b

    L_68e4:
        cmp ($04,x)

        .byte $54,$eb,$09,$15,$49,$16,$f0,$36,$06,$4b,$09,$06,$5c,$54,$81,$4b
        .byte $96,$30,$34,$8c,$54,$e0

    L_68fc:
        rol 
        eor $0f

        .byte $43

    L_6900:
        ora L_8572
        sbc SCREEN_BUFFER_2 + $1ce,y

        .byte $44

    L_6907:
        sei 
        adc $45

        .byte $92,$c2,$57,$a9,$d4

    L_690f:
        and ($ed),y

    L_6911:
         .byte $54
        .byte $65,$10,$16,$70,$c9,$51,$06,$18,$b2,$58,$4a,$99,$86,$bf,$fb,$c3
        .byte $ac,$26,$7a,$58,$c4,$6e,$b0,$29,$a4,$58,$46,$41,$94,$0c,$f6,$d5
        .byte $3c,$84,$0e,$50,$62,$87,$0e,$a5,$83,$ca,$0c,$51,$5a,$e0,$b0,$79
        .byte $41,$8a,$2a

    L_6945:
        .byte $0c
        .byte $2c,$1a,$91,$08,$10,$bb,$c1,$d3,$15,$3a,$c2,$54,$6b,$83,$e5,$06
        .byte $19,$f2,$c4,$65,$43,$31,$6b,$33,$b8,$ea,$57,$11,$be,$96,$5f,$9a
        .byte $0f

    L_6967:
        dey 
        sty $22ab

        .byte $b3,$82,$8e,$59,$df,$1c,$73,$27,$b7,$13,$78,$3c,$04,$68,$3e,$35
        .byte $1e,$81,$19,$ec,$07,$2a,$38,$e6,$4f,$d1,$51,$52,$23,$3b,$e0,$73
        .byte $28,$a1,$2c,$51,$cf,$45,$08,$32,$44,$7c,$6e,$f8,$a7,$14,$1f,$4c
        .byte $ef,$95

    L_699d:
        .byte $65,$4d,$06,$12,$90,$1b,$77
        .byte $d1,$0d,$82,$7b,$91,$51,$14,$1a,$09,$58

    L_69ae:
        jsr $2553

        .byte $7f,$a9,$92,$bf,$d4,$c9,$5f,$fe,$23,$50,$a3,$9d,$2b,$e1

    L_69bf:
        ldy $a0
        sta $a4,x
        sta L_e868 + $5,y
        bne L_6967
        eor L_a2b7
        sbc L_333e

        .byte $f0,$e7,$9f,$b6,$5a,$9a,$7e,$32,$bb,$4f,$94,$79

    L_69da:
        .byte $d4
        .byte $e6,$28,$e0,$c2,$af,$9e,$7d,$71,$48,$6d,$f0,$45,$be,$58,$d4,$19
        .byte $26,$1f,$e0,$88,$38,$08,$4c,$61,$3b,$61,$4b,$26,$f8,$31,$06,$b8
        .byte $8c,$b1,$81,$7a,$0b

    L_6a00:
        txs 
    L_6a01:
        and #$af
        ldx #$3c
        lda ($a7),y
    L_6a07:
        ror L_4a92 + $1
        bit $36
        and SCREEN_BUFFER_2 + $b8

        .byte $d3,$32,$ff,$43,$ab,$78,$86,$9d,$1d,$34,$8f,$1c,$31,$92,$ee,$54
        .byte $fe,$1a,$d0,$0f,$05,$7d,$0f,$8b,$c5,$6c,$12,$ce,$0c,$ed,$d2,$c5
        .byte $21,$e1,$f4

    L_6a32:
        asl 

        .byte $32,$e9,$57,$83,$08

    L_6a38:
        .byte $53,$7a,$b3
        .byte $a0,$1e,$64,$fb,$2f,$0d,$d0,$65,$e3,$b6,$50,$63,$c5,$d8,$18

    L_6a4a:
        rol $77,x
        and ($d4),y
        stx $f9,y
        tya 
        ldx $e2,y
        php 

        .byte $22,$b0,$b0,$04,$66,$12,$04,$95,$83,$26,$41,$4d,$7b,$fd,$23,$00
        .byte $dd,$27,$1b,$b8,$68,$03

    L_6a6a:
        eor ($b3,x)
        clv 

        .byte $34,$a5,$0a,$6a,$93,$d2,$68,$59,$98,$47,$06,$1a,$f2

    L_6a7a:
        dec $3b
        sed 
        sta L_d548,x

        .byte $2f,$6c,$24,$26,$39,$34,$18,$49,$43,$0d,$07,$c6,$08,$27,$3e,$3a
        .byte $b1,$96,$b2,$a6,$83,$e5,$03,$6b,$c4,$8b,$1d,$89,$d4,$72,$02,$84
        .byte $42,$63,$4c,$d0,$7d,$22

    L_6aa6:
        rol $1f34,x

        .byte $1a,$40,$6d,$df,$1a,$13,$f3,$b0,$98,$ef,$ca,$19,$28,$38,$b9,$df
        .byte $44

    L_6aba:
        bit $47
        asl $83,x

        .byte $8b,$51,$14,$1a,$d1,$90,$94,$18,$78,$20,$ff,$11,$c5,$a0,$e2,$b6
        .byte $ee,$2d,$0a,$38,$e4,$c3,$4c,$38,$33,$f0,$e7,$a2,$84,$18,$61,$a6
        .byte $1c,$19,$e5,$a8,$98

    L_6ae3:
        .byte $af,$83,$67,$d3,$fa
        .byte $99,$f4,$fe,$a6,$7d,$3f,$e2,$a5,$dd,$38,$bf,$7b,$a3,$a0,$5b,$70
        .byte $c1,$06,$c7,$d1,$02

    L_6afd:
        .byte $ab,$0c,$10,$24,$53,$0f
        .byte $ea,$66,$17

    L_6b06:
        .byte $fc
        .byte $38,$89,$84,$ff,$8a,$96,$17,$ba,$3a,$05,$dd,$0c,$10,$6c,$61,$10
        .byte $28,$60,$e7,$5f,$c3,$5b,$ac,$2a,$33,$50,$27,$a2,$53,$8b,$fa,$44
        .byte $6d,$e3,$a0,$44,$85,$32,$03,$bc,$99,$68,$1b,$30,$10,$83,$22,$4b
        .byte $fa,$06,$10,$59,$f6,$de,$3a,$04,$30,$1a,$ca,$f8,$44

    L_6b44:
        adc $a1

        .byte $0b,$3e,$db,$c7,$41,$e3,$0a,$07,$bc,$0e,$dd,$e0,$6f,$42,$21,$10
        .byte $32,$60,$21,$10,$98,$c2,$81,$c1,$02,$08,$10,$2d,$e8,$50,$2a,$88
        .byte $1e,$71,$83,$1d,$94,$08,$60,$52,$96,$db,$c7,$aa,$d5,$5e,$20,$90
        .byte $db,$0d,$20,$08,$cd,$cf,$79,$8e,$03,$64,$15,$5e,$a6,$e3,$71,$44
        .byte $60,$77,$97,$48

    L_6b8a:
        ora L_f7d8,y
        ror 

        .byte $7c

    L_6b8f:
        adc L_f32e,y

    L_6b92:
         .byte $e2
        .byte $29,$aa,$9e,$ee,$ab,$df,$8c,$a2,$33,$e7,$dd,$4f,$5e,$a6,$d8,$13
        .byte $e2,$54,$4a,$40,$8e,$5a,$f9,$84,$85,$4e,$2f,$d0,$2d,$90,$50,$95
        .byte $a6,$20,$59,$67,$9e,$7a,$87,$f4,$0b,$6c,$23,$31

    L_6bbf:
        .byte $7d,$d8,$d9,$2d,$bc,$73,$d2
        .byte $94,$23,$5e,$55,$4a,$76,$a7,$c7,$a7,$ff,$ec,$cf,$b3,$ee,$12,$55
        .byte $42,$95,$9e,$d5,$d7,$67,$db,$78,$f4,$18,$f8,$25,$af,$95,$b6,$0d
        .byte $08,$f9,$59,$60,$d0,$60,$6b,$c3,$95,$e1,$07,$8f,$0c,$78,$1b,$da
        .byte $ec,$28,$3d,$e8,$3c,$61,$8f,$03,$7b,$5c,$14,$1e,$fa,$fd,$9b,$d0
        .byte $e5,$6f,$42,$e0,$60,$81,$0d,$8c,$7b,$a8,$51,$a5,$2e,$1a,$a1,$ee
        .byte $6d,$e3,$e2,$d9,$46,$85,$1a,$55,$9b,$78,$ee,$d5,$18,$f2,$db,$ba
        .byte $22,$32,$b1,$54,$f8,$57,$a5,$31,$b7,$8e,$81,$b6,$23,$32,$fd,$c9
        .byte $19,$02,$d9,$04,$46,$66,$48,$7a,$f7,$01,$3c,$b5,$d0,$94,$f3,$31
        .byte $8f,$70,$8c,$e5,$b4,$ce,$52,$71,$7f,$96,$10,$76,$bc,$aa,$5a,$22
        .byte $e6,$ee,$05,$34,$92,$72,$a3,$1d,$d5,$96,$9c,$5f,$bb,$29,$a8

    L_6c65:
        .byte $13,$f0,$bb
        .byte $2e,$84,$08,$f2,$9c,$06,$c8,$37

    L_6c70:
        clc 
        cmp L_86e1,y
        txs 

        .byte $7b,$b3,$65,$7b,$8f,$9d,$7f,$0d,$67,$bd,$38,$bf,$11,$9f,$30,$28
        .byte $27,$df,$cb,$26,$06,$38,$73,$cb,$5f,$2a,$a2,$06,$64,$73,$d4,$23
        .byte $19,$95,$9c,$25,$ea,$20,$04,$49,$5a,$86,$74,$e9,$05,$cd,$d1,$5e

    L_6ca5:
        .byte $5c,$22,$43
        .byte $68,$bd,$ad,$82,$29,$ae,$14,$20,$06,$5e,$36,$5f,$56,$36,$e1,$41
        .byte $f0,$56,$2a,$c3,$75,$02,$ab,$0e,$f4,$0b,$6e,$26,$81,$a5,$08,$75
        .byte $00,$1a,$92,$44,$14,$8a,$cb,$97,$00,$e9,$e1,$72,$55,$32,$a1,$d5
        .byte $c2,$ae,$af,$fa,$b5,$1d,$dd,$0a,$0f,$82,$b1,$0c,$1b,$a8,$14,$30
        .byte $77,$a0,$5d,$d0,$9a,$90,$32,$f7,$80,$86,$2c,$7c,$68,$68,$11,$e4
        .byte $e7,$6e,$f1,$e1,$8f,$43,$1c,$b4,$20,$c9,$57,$35,$87,$ab,$3b,$77

    L_6d08:
        sty $aab2
        dey 
        cpy L_2a91 + $2
        ldy #$95
        pha 
        and L_bcd8 + $3,y

        .byte $72,$e7,$92,$91,$78

    L_6d1a:
        .byte $50,$a2
        .byte $81,$54,$40,$c9,$7f,$0b,$80,$d5,$8f,$66,$75,$1a,$71,$c9,$3a,$8f
        .byte $66,$f4,$39,$70,$40,$ab,$95,$bd,$0c,$36,$31,$ee,$71,$a4,$c0,$c6
        .byte $1c,$5b,$28,$f8,$99,$56,$1a,$a1,$ee,$16,$85,$2a,$aa,$b1,$e9,$95
        .byte $c2,$7a,$db,$b7,$a9,$fc,$cf,$86,$e2,$bd,$5b,$5d,$2c,$d3,$e1,$d5
        .byte $56

    L_6d5d:
        ldy #$81
        cmp L_206f,y

        .byte $47,$9c,$81,$68,$43,$9a,$e3,$d4,$e2,$34,$21,$9e,$48,$27,$c5,$e3
        .byte $94,$39,$3a,$20,$a0,$37,$06,$ac,$36,$2d,$b8,$62,$1e,$b9,$8b,$1a

    L_6d82:
        nop 
        lda ($19),y
        lda L_2997,y

        .byte $df,$55,$fc,$0e,$d5,$b4,$76,$e3,$2c,$10,$e3,$97,$42,$8c,$aa,$e1
        .byte $28,$4c,$d0,$a3,$96,$08,$71,$cc,$a4,$bb,$e2,$21,$31,$6c,$4a,$f8
        .byte $62,$a8,$25,$55,$6f,$a8,$a6,$bb,$a4,$39,$d3,$0a,$b4,$48

    L_6db6:
        eor $aa,x
        lda ($eb),y

        .byte $9c,$66,$31,$78,$97,$41,$31,$bf,$c0,$27,$b6,$b0,$a7,$8c,$6e,$d5
        .byte $16,$6d,$cd,$55,$8e,$10,$a6,$b2,$64,$95,$fd,$30,$ab,$63,$c2,$ad
        .byte $43,$0b,$94,$f4,$ff,$fd,$4b,$3f,$fa,$ad,$9c,$73,$a4,$e7,$4c,$3b
        .byte $49,$56,$6e,$b4,$10,$5b,$72,$83,$6f,$e0,$6b,$c1,$84

    L_6df7:
        rol $89
        lda ($55,x)
        eor $d5,x
        eor $24,x

    L_6dff:
         .byte $73
        .byte $90,$f5,$48,$23,$56,$17,$3e,$8a,$a8,$6e,$7e,$e6,$f8,$46,$6a,$e5
        .byte $09,$68,$a4,$55

    L_6e14:
        rol $8a63

    L_6e17:
         .byte $6b,$b0,$d8
        .byte $81,$0b,$48,$90,$40,$81,$82,$1a,$f7,$72,$aa,$c2,$83,$ca,$db,$84
        .byte $de,$91,$37,$09,$c3,$57,$7a,$e5,$e9,$11,$9d,$09,$63,$27,$7f,$80
        .byte $47,$b2,$81,$f0,$28,$7c,$36,$b1,$50,$21,$81,$02

    L_6e46:
        asl 
        inc L_3a88

        .byte $87,$2a,$a0,$d5,$de,$b9,$69,$85,$cf,$33,$7f,$36,$52,$e4,$05,$e1
        .byte $56,$28,$df

    L_6e5d:
        ora $6948,x
        sbc L_e05a + $5,x

        .byte $c2,$dc

    L_6e65:
        asl 
        ora ($d4),y

        .byte $ab,$08,$6e,$83,$2f

    L_6e6d:
        asl L_7162,x
        adc ($9e,x)

        .byte $3a,$05,$8a,$80,$23,$3e,$de,$92,$52,$b3,$31,$6d,$c5,$78,$29,$7d
        .byte $c5,$cc,$cf,$3b,$f0,$61,$6e,$26,$66,$79,$df,$83,$0b,$70,$73,$33
        .byte $ce,$fc,$18,$5b,$a0,$0a,$6a,$7d,$bf,$d4,$78,$99,$99,$e7

    L_6ea0:
        ror $5f0a,x

        .byte $74,$ec,$cc,$f3,$bf,$05,$61,$40,$46,$c0,$df,$d3,$58,$e7,$58,$45
        .byte $4a,$40,$42,$21,$2a,$a1,$0f,$06,$56,$66,$2d,$b8,$82,$a2,$cd,$81
        .byte $e4,$11,$a9,$7a,$d5,$18,$46,$79,$9a,$61,$0a,$6f,$c9,$46,$5c,$05
        .byte $94,$df,$08,$20,$66,$78,$d4,$f0,$dd,$06,$5e,$3b,$a5,$51,$14,$18
        .byte $ac,$cc,$0a,$8f,$40,$62

    L_6ee9:
        ldy L_2ab0,x
        rol 

        .byte $43,$15,$d2,$81,$51,$88,$0c,$54

    L_6ef5:
        sty $01,x

    L_6ef7:
         .byte $1f,$fc,$32,$e3
        .byte $81,$06,$ce,$e4,$95,$29,$30,$9c,$ef

    L_6f04:
        php 

        .byte $62

    L_6f06:
        lda L_814f,x

        .byte $da,$d2,$43,$74,$19,$78,$eb,$a1,$48,$3c,$a6,$f9,$53,$ff,$fa,$79
        .byte $f4,$0a,$91,$cd,$81,$06,$44,$5d,$50,$20,$df,$8a

    L_6f25:
        sbc ($81,x)
        lda #$5e

        .byte $1b,$c8,$a2,$34,$52,$9e,$28,$8d,$40,$ab,$38,$a2,$9a,$e0,$17,$f9
        .byte $e2,$b1,$e1,$82,$fa,$45,$73,$83,$06,$74,$57,$c8,$30,$62,$45,$72
        .byte $82,$c8,$7c,$08,$8d,$51,$bf,$b6,$92

    L_6f52:
        stx $e8

        .byte $32,$f1,$db,$c1,$18,$f2,$aa,$c1,$85,$17,$e0,$62,$af,$a4,$3a,$3c
        .byte $23,$07,$0c,$30,$5f,$28,$ae,$70,$60,$c8,$8a,$df,$f6,$8b,$eb,$b4
        .byte $15,$15,$06,$72,$b8,$a6,$b1,$6c,$c1,$ce,$e1,$51,$dc,$54,$0c,$10
        .byte $a0,$51,$01,$40,$ff,$3c,$26,$8d,$de,$b5,$56,$06,$a2,$28

    L_6f92:
        .byte $32
        .byte $a5,$62,$d9,$44,$f9,$6b,$b1,$51,$51,$42,$33,$cf,$5a,$ab,$7f,$51
        .byte $d8,$0f,$a5,$cb,$d0,$1a

    L_6fa9:
        ora #$5a
        sta $b942,y

        .byte $54,$85,$07,$97,$3f,$78,$ab,$14,$6d,$fe,$01,$3d,$98,$a8,$ed,$07
        .byte $d2,$e5,$88,$0d,$04,$ad,$46,$78,$2b,$96,$40,$5e,$d8,$07,$20,$e7
        .byte $4d,$1c,$f2,$a3,$86,$1a,$a5,$b3,$a8,$23,$21,$19,$d3,$d4,$11,$95
        .byte $8c,$e9,$ea,$08,$cf,$53,$3b,$2a,$a0,$8d,$b1,$9d,$3c,$ea,$35,$37
        .byte $86,$7c,$aa,$51,$20,$82,$1b,$c0,$d9,$e6,$5e

    L_6ff9:
        rol $74,x
        ldx #$41

        .byte $97,$0d,$e0,$6c,$e9,$40,$11,$9c,$a7,$20,$f0,$dd

    L_7009:
        .byte $a9,$11,$06,$f2,$26,$0e,$2d,$94,$4f,$9e
        .byte $8e,$32,$35,$c4,$94,$32,$38,$49,$5d,$89,$5a,$b9,$53,$cd,$9d,$b6
        .byte $dc,$39,$5c,$a6,$ce,$da,$ac,$35,$e0,$02,$88,$53,$05,$96

    L_7031:
        asl L_6720

        .byte $c3,$f8,$b0,$c1,$b8,$0a,$4d,$e1,$52,$78,$0a,$92,$a0,$7f,$29,$10
        .byte $22,$32,$c5,$9d

    L_7048:
        bit $3d
        dec $50,x
    L_704c:
        plp 
        sbc $c7
        sbc #$89

        .byte $7a,$f9,$e8,$a7,$12,$b7,$62,$be,$a1,$52,$22,$42,$6c,$e9,$84,$e3

    L_7061:
        and $76
        plp 
        sbc ($05,x)
        pha 

        .byte $c7,$84,$d5,$e0,$b6,$82,$d0,$fa,$23,$cf,$a8,$82,$9b,$4a,$05,$59
        .byte $50,$5c,$98,$a8,$40,$c1,$87,$17,$30,$60,$b7,$31,$59,$c6,$12,$a2
        .byte $28,$28,$69,$73,$db,$fa,$8a,$90,$a1,$83,$3f,$6d,$47,$a0,$33,$1c
        .byte $d3,$37,$e1,$1c,$17,$bc,$b5,$18,$80,$cc,$74,$37,$11,$49,$b6,$07
        .byte $e5,$23

    L_70a9:
        .byte $6b,$03,$f2,$90,$46
        .byte $f5,$01,$2b,$15,$2d,$02,$0b

    L_70b5:
        ora L_2915,x

        .byte $02,$0a,$a3,$74,$0a,$4d,$aa,$8f,$c8,$18,$af,$0d,$a1,$69,$60,$aa
        .byte $62,$32,$42,$9a,$d6,$38,$c2,$b4,$86,$78,$e3,$96,$bc

    L_70d5:
        .byte $14,$1c,$5b
        .byte $c1,$86,$80,$34,$18,$51,$56,$c2,$33,$22,$ce,$30,$2d,$ac,$08,$6d
        .byte $33,$2f,$05,$61,$9b,$8b,$c9,$07,$bc,$55,$d0,$60,$82,$2a,$bc,$30
        .byte $70,$c5,$46,$86,$1e,$48,$c2,$9b,$b5,$c8,$5e,$5c,$dc,$55,$23,$20
        .byte $11,$1b,$53

    L_710b:
        sta ($64),y

        .byte $53,$53,$4e,$42,$09,$c1,$78,$61,$aa,$5b,$3d,$de,$54,$88,$a0,$fe
        .byte $52,$2b,$c3,$f9,$48,$8d,$0c,$10,$45,$5d,$06,$2a,$a4,$34,$93,$3b
        .byte $91,$dc,$31,$78,$7c,$d0,$31,$91,$28,$1a,$68,$9f,$ca,$0c,$6f

    L_713c:
        eor SCREEN_BUFFER_2 + $e9,y

        .byte $64,$60

    L_7141:
        .byte $b6,$98,$fb,$b7

    L_7145:
        sty $41

        .byte $a3,$15,$88,$08,$8c,$c1,$4a,$81,$0f,$b4,$88

    L_7152:
        bit $39c4
    L_7155:
        sbc ($a0),y

        .byte $b3,$11,$5c,$b0,$c1,$6d,$a2,$b9,$c1,$a4,$d7

    L_7162:
        tax 

        .byte $eb,$b1,$d6,$ee,$21,$e1,$57,$85,$15,$a0,$f7,$8a,$e1,$87,$70,$14
        .byte $a9,$56,$0d,$4a,$c9,$41,$6e,$e8,$51,$82,$cd,$d0,$4c,$6e,$9d,$0d

    L_7183:
        .byte $7c,$82
        .byte $11,$99

    L_7187:
        .byte $77
        .byte $20,$52,$b7,$31,$c2,$32,$c9,$b5,$9b,$05,$ae,$86,$e3,$aa,$30,$d0
        .byte $5f,$d2,$be,$e1,$28,$77,$4e,$86,$a8,$41,$67,$4c,$7a,$6f,$89,$4f
        .byte $1f,$c9,$02,$6f,$81,$41,$92,$86,$be,$41,$52,$97,$06,$14,$39,$f2
        .byte $2e,$39,$cf,$51,$67,$a4,$ed,$52,$8e,$87,$62,$14,$33,$1d,$64,$e2
        .byte $fe,$93,$75,$97,$0b,$1c,$f4,$f2,$63,$ed,$f2,$63,$ff,$28,$31,$84
        .byte $f4,$e6,$36,$4c,$42,$fe,$62,$4e,$0a,$12,$1a,$00,$d0,$65,$6e,$d2
        .byte $23,$2c,$9b,$59

    L_71ec:
        .byte $5b,$89
        .byte $95,$d8,$c9,$15,$74,$1c,$ae,$e6,$48,$a8,$d0,$d2,$68,$20,$80,$53
        .byte $5f,$54,$8a,$e7,$8c,$1a,$d4,$17,$f0,$d5,$4f,$63,$10,$bf,$9e,$f1
        .byte $7e,$98,$d3,$ee,$e5,$0d,$54,$f6,$7e,$9e,$97,$cc,$a6,$7b,$03,$7e
        .byte $77,$98,$98,$60,$82,$ad,$0a,$30,$69,$50,$4a

    L_7229:
        ldx $f4,y

        .byte $50,$d8,$27,$c0,$82,$07,$7a,$8b,$3f,$3d,$b6,$11,$9e,$54,$ec,$c5
        .byte $4c,$f6,$86,$bc,$37,$81,$8c,$87,$5b,$93,$65,$e3,$11,$5d,$b8,$2a
        .byte $53,$a9,$59,$64,$e3,$2d,$0d,$a2,$63,$18,$86,$5a,$63,$2d,$0e,$95
        .byte $d8,$6a,$b7,$0a,$1b

    L_7260:
        adc $76,x
        inc L_29e0

        .byte $54,$4a

    L_7267:
        .byte $54,$3b
        .byte $06,$a5,$a4,$68,$75,$58,$cc,$f4,$a7,$87,$32,$09,$8c,$42,$63,$2c
        .byte $45,$69,$f3,$a1,$f1,$96,$78,$54,$8a

    L_7282:
        cmp $c6,x
        ror $f0
        tay 
        pla 

        .byte $13,$d9,$2b,$a2,$33,$a6,$0f,$f9,$9b,$a7,$0a,$ec,$18,$82,$36,$b6
        .byte $62,$a9,$a2,$e9,$0c,$1b,$a2,$e4,$8b,$66,$31,$d5,$ab,$a8,$e2,$d0
        .byte $e7,$2f,$2d,$e4,$04,$8c,$d6,$cc,$c0,$07,$7e,$b1,$cf,$5a,$b8,$8c
        .byte $da,$b3

    L_72ba:
        .byte $1f,$e7
        .byte $84,$46,$50,$a0,$0f,$31,$9c,$83,$82,$2a,$46,$7e,$72,$45,$40,$4f
        .byte $ce,$78,$e1,$87,$d9,$c2,$83,$13,$33,$b7,$74,$53,$51,$2c,$2e,$ad
        .byte $12,$62,$0a,$d3,$6e,$8c,$3e,$a3,$8e,$ce,$2f,$6a

    L_72e8:
        .byte $3a
        .byte $50,$5e,$2a,$0e,$70,$a4,$32,$68,$01,$7b,$50,$2f,$33,$34,$3c,$a0
        .byte $af,$e2,$b3,$93,$e0,$df,$8a,$9a,$9f,$06,$74,$56,$f2,$7d,$27,$4a
        .byte $0b

    L_730a:
        eor L_9f6d
        lda $1f05,y
        ror SCREEN_BUFFER_1 + $23d

        .byte $73,$1b,$68,$32,$e9,$34,$02,$33,$d2,$a8,$66,$d2,$f4,$a4,$aa,$e7
        .byte $b3

    L_7324:
        asl $d8,x

        .byte $4b,$8a,$ba,$2c,$c5,$b4,$3d,$cb,$eb,$c6,$c8,$38,$62,$ba,$53,$e2
        .byte $a4,$a7,$c1,$24,$5c,$73,$e2,$ea,$9f,$b9,$e2,$52,$28,$97,$0a

    L_7345:
        .byte $47,$89
        .byte $70,$c1

    L_7349:
        lda #$12

        .byte $eb,$86,$0d,$48,$de,$ae,$20,$b7,$91,$4b,$3e,$28,$67,$c1,$66,$62
        .byte $c4,$9f,$16,$c8,$b4,$75,$66,$00,$3e,$fe,$a2,$92,$7c,$17,$72,$2c
        .byte $e9,$f0

    L_736d:
        adc #$45
        sta ($3e,x)
        ora #$22
        cpy SCREEN_BUFFER_0 + $39f
        jmp (L_335e)

        .byte $e0,$ce,$8a,$e6,$cf,$82,$e2,$45,$97,$3e,$0c,$28,$b2,$a7,$c1,$99
        .byte $15,$0e,$b8,$82,$bb,$8b,$5a,$7c,$16,$1a,$2f,$79,$e2,$33,$08,$80
        .byte $15,$06

    L_739b:
        .byte $22,$b3,$9b
        .byte $cc,$4f,$a7,$66,$f7,$55,$d1

    L_73a5:
        adc ($59,x)

        .byte $f4,$34,$29,$ea,$2f,$d3,$d8,$0e,$08,$35

    L_73b1:
        .byte $5a
        .byte $55,$85,$3a,$ae,$8b,$0b,$56,$9f,$ec,$50,$e3,$c2,$df,$55,$56,$98
        .byte $61,$50,$d0,$a7,$96,$bc,$37,$ca,$13,$3f,$99,$c1,$63,$33,$a8,$9a
        .byte $e2,$d0,$51,$08,$cc,$32,$30,$51,$d0,$f9,$ab,$5d,$83,$72,$2d,$32
        .byte $5d,$dc,$99,$cb,$49,$8a,$57,$3e,$9f,$a6,$28,$98,$35,$23,$31,$3d
        .byte $83,$52,$37,$33,$eb,$b7,$6a,$28,$e1,$cd,$7d,$cc,$83,$0e,$db,$26
        .byte $ee,$db,$8c,$d6,$db,$aa,$d6,$c1,$2d,$b6,$4d,$d3,$b7,$19,$aa,$b7
        .byte $55,$aa,$a7,$3d,$eb,$82,$f2,$50,$78,$a0,$ae,$28,$25,$f7,$35,$94
        .byte $93,$39,$6b,$b5

    L_7426:
        dec L_c4f1 + $2

        .byte $23,$3c,$d3,$8c,$f1,$7a,$6f,$b9,$50,$78

    L_7433:
        .byte $b3
        .byte $a5,$db,$e0,$50,$4b,$d1,$85,$3d,$42,$9c,$43,$fe,$50,$63,$0d,$04
        .byte $3c,$a1,$93,$17,$83,$d0,$56,$c5,$56,$ae,$13,$88,$7c,$ac,$f3,$17
        .byte $15,$7d,$3e,$0e,$da,$04,$af,$ba,$55,$20,$62,$87,$1e,$14,$10,$51
        .byte $2b,$c2,$e8,$12,$0a,$66,$1b,$e5,$0b,$3b,$c5,$8b,$c3,$6b,$0d,$f2
        .byte $85,$05,$d1,$86,$f9,$42,$83,$0c,$46,$5c,$2d,$e1,$c3,$6b,$9c,$c1
        .byte $1a,$3b,$40,$e7,$c3,$7c,$a1,$28,$de,$2c,$ef,$12,$1a,$cc,$f6,$12
        .byte $b1,$3c,$c2,$a6,$f4,$38,$0f,$28,$5b,$a0,$2a

    L_749f:
        nop 

        .byte $92,$13,$7e,$b9,$9f,$fd,$31,$b0,$11,$9b,$65,$bd,$d5,$59,$c9,$41
        .byte $96,$dd,$e6,$0b,$1d,$01,$0f,$89,$c5,$9d,$96,$c6,$a2,$8f,$32,$0b
        .byte $b9,$02,$fc,$77,$86,$f4,$df,$4b,$a0,$cb,$7e,$cc,$a7,$73,$33,$b2
        .byte $d8,$ec,$d6,$66,$e1,$be,$50,$a0,$82,$83,$2d,$fa,$8c,$29,$ec,$8c
        .byte $17,$38,$53,$72,$ad,$dc,$21,$63,$51,$4a,$ab,$ba,$4a

    L_74ed:
        ldx $1137
        ora $b740,y

        .byte $30,$8c,$86,$71,$9a,$b4,$f6,$d8,$14,$49,$1e,$5d,$28,$16,$e0,$86
        .byte $9c,$c4,$bc,$57,$28,$31,$59,$b1,$4d,$0e,$d5,$ca,$08,$52,$1c,$29
        .byte $42

    L_7514:
        txs 
        cpx $2236

    L_7518:
         .byte $9b,$62
        .byte $61,$ce,$9a,$11,$9c,$d6,$d6,$ad,$47,$d0,$31,$d8,$ed,$c5,$c7,$02
        .byte $79,$37,$42,$50,$62,$75,$1f,$40,$e3,$b3,$15,$f4,$0c,$a1,$19,$7d
        .byte $7c,$91,$98,$f8,$ce,$e6,$6a,$2e,$64,$1c,$3b,$a5,$52,$67,$61,$b1
        .byte $6d,$c6,$e0,$a8,$1a,$e0,$d6,$78,$45,$35,$d2,$5f,$08,$df,$a6,$35
        .byte $62,$30,$12,$2a,$76,$66,$04,$c8,$90,$76,$c3,$40

    L_7566:
        .byte $1b
        .byte $76,$91,$4d,$7b,$91,$94,$cb

    L_756e:
        eor ($99),y
        sta ($b6,x)
        lsr L_a364 + $1

    L_7575:
         .byte $4b
        .byte $48,$22,$9a,$a4,$db,$5a,$ad,$39,$8c,$b5,$7d,$c0,$52,$93,$2b,$a8
        .byte $14,$0b,$24,$48,$30,$d0,$34,$48,$c1,$d1,$89

    L_7591:
        rol L_bd38,x
        cmp L_5546,y

        .byte $d4,$74,$96,$a3,$92,$1b,$44,$c6,$41,$05,$03,$c5,$40,$4f,$dd,$01
        .byte $7e,$12,$03,$a5,$76,$1b,$75,$77,$75,$fa,$44,$11,$98,$f5,$bd,$3b
        .byte $30,$da,$e7,$32,$0c,$e8,$6c,$ab,$4a

    L_75c0:
        .byte $cd,$f7,$15,$ac,$88,$cc,$67,$50,$41,$3b
        .byte $55,$93,$74,$4c,$de,$12,$87,$17,$c7,$82,$e1,$d0,$3c,$1b,$d1,$54
        .byte $04,$17,$27

    L_75dd:
        ora $fc7d

        .byte $e7,$d0,$71,$90,$4c,$a2,$71,$c3,$82,$e8,$a0,$5b,$46,$b6,$1b,$9d
        .byte $0a,$1a,$86,$14,$75,$19,$fe,$0f,$4c,$77,$45,$0d,$e6,$3b,$d2,$86
        .byte $87,$1d,$50,$86,$79,$63,$e0,$43,$6d,$64,$d4,$28,$65,$53,$27,$dd
        .byte $0c,$8a

    L_7612:
        .byte $64,$da,$74,$34,$d3
        .byte $a8,$3a,$e2,$bd,$89,$c7,$0e,$8c,$48,$ec,$7a,$06,$89,$18,$35,$2b
        .byte $87,$9a,$0b,$d8,$92,$2a,$7e,$0e,$55,$bf

    L_7631:
        sty $68

        .byte $ab,$e4,$b2,$95,$c3,$cd,$05,$ec,$83,$3a,$83,$87,$9d,$c3,$86,$ca
        .byte $b4,$ac,$9b,$a1,$9d,$c3,$11,$9c,$d9,$4e,$65,$77,$59,$55,$d5,$22
        .byte $0d,$56,$cd,$92,$dd,$52,$6f,$b0,$1b

    L_765c:
        cpy $32

        .byte $9f,$e9,$8c,$8b,$10,$e1,$cc,$5f,$e6,$6a,$b2,$0a,$43,$20,$dd,$46
        .byte $b9,$2d,$b1,$22,$ae,$a9,$1d,$36,$6c

    L_7677:
        sta ($e2),y

        .byte $32,$75,$b3

    L_767c:
        .byte $34
        .byte $0d,$2d,$3f,$d3,$1b,$2c,$55,$fd,$57,$a8,$cc,$c0,$8a,$8a,$0d,$47
        .byte $96,$04,$57,$a0,$35,$1d,$28,$11,$55,$21,$a8,$92,$81,$15,$88,$0d
        .byte $4c,$70,$22,$b8,$9f,$37,$8a,$7a,$2b,$33,$02,$2d,$80,$c1,$6d,$45
        .byte $35,$cb,$92,$cf,$df,$54,$b6,$70,$dd,$a9,$02,$9a

    L_76b9:
        dec $8933,x

        .byte $0f,$4e,$28,$77,$56,$40,$b0,$b0,$3f

    L_76c5:
        jmp $c14b

        .byte $f3,$ba,$05,$2d,$22,$9a,$c2,$2f,$85,$34,$5e,$d6,$2b,$e4,$e3,$80
        .byte $9e,$3d,$9d,$cf,$0c,$19,$91,$5c,$b0,$e6,$67,$56,$a2,$b5,$89,$c6
        .byte $8f,$84,$4a,$66,$c2,$1a,$3d,$59,$1e,$4d,$47,$d0,$2d,$74,$03,$c1
        .byte $1d

    L_76f9:
        dec L_d12f + $1
        nop 
        iny 
        sbc $af

        .byte $9e,$8b,$bc,$98,$c9,$1d,$07,$85,$c8,$a6,$be,$7d,$d7,$88,$56,$99
        .byte $97,$83,$7f,$71,$69,$4b,$cc,$c5,$b7,$02,$33,$76,$f4,$e2,$99,$8e
        .byte $8d,$04,$c5,$46,$40

    L_7725:
        .byte $46,$40,$00,$54
        .byte $19,$21,$19,$ae,$f5,$37,$0a,$0c,$46,$56,$7a,$d1,$42,$80,$57,$5c
        .byte $55,$1f,$ea,$6a,$3f,$d0,$83,$24,$44,$c5,$04,$c5,$7c

    L_7746:
        .byte $ab
        .byte $75,$66,$2d,$89,$84,$0f,$c4,$0e,$42,$b3,$60,$8d,$29,$d1,$44,$d7
        .byte $86,$99,$84,$d6,$51,$4a,$95,$d0,$14,$d6,$7a,$c9,$fb,$25,$40,$32
        .byte $09,$9a,$6f,$1c,$6c,$3c,$71,$61,$e3,$8a,$58,$37,$49,$cb

    L_7775:
        adc ($8a),y

        .byte $8f,$01,$da,$a3,$1e,$77,$e9,$8f,$0d,$20,$d7,$cb,$3d,$8a,$a1,$46
        .byte $90,$2b,$d4,$5b,$c0,$9e,$d5,$c6,$87,$0f,$0a,$8b,$98,$35,$a2,$ad
        .byte $e0,$43,$68,$5a,$5c,$e9,$88,$ad,$d4,$0c,$ec,$94,$57,$46,$05,$44
        .byte $a4,$09,$ec,$3c,$19,$51,$52,$90,$20,$ca,$dd,$12,$94,$4c,$cc,$5b
        .byte $70,$9e,$5b,$c0,$fc,$a3,$3f,$08,$20,$a8,$dd,$40,$a0,$98,$a8,$e8
        .byte $c0,$a0,$c9,$09,$69,$a5,$d1,$1c,$a8

    L_77d0:
        rti 

        .byte $1c,$b1,$4a,$3d,$31,$19,$2e,$e8,$8b,$32,$e3

    L_77dc:
        sta $6444,x

        .byte $02,$60,$f0,$b9,$f8,$15,$95,$3c,$f0,$90,$2a,$8d,$a4,$04,$26,$38
        .byte $14,$28,$d4,$65,$60,$63,$0b,$5c,$18,$94,$71,$78,$a5,$48,$0e,$f2
        .byte $62,$a2,$7e,$00,$8d,$65,$d1,$9a,$23,$60,$c6,$c8,$47,$2d,$74,$11
        .byte $71,$fe,$ce,$2c,$cc,$e3,$8d,$4f,$42,$8f,$51,$c4,$96,$67,$29,$b4
        .byte $67,$44

    L_7821:
        ror $9d,x

        .byte $04,$18

    L_7825:
        .byte $97,$27,$1b
        .byte $45,$c5,$35,$ba,$71,$a3,$46,$cc,$c5,$b7,$1a,$17,$10,$ed,$f8,$2b
        .byte $28,$ae,$44,$08,$36,$77,$67,$e0,$c4,$7f,$33,$16,$dc,$57,$64,$1c
        .byte $88,$1b,$84,$6c,$3d,$db,$5d

    L_784f:
        .byte $b3,$e2
        .byte $41,$2a,$05,$25,$3f,$f4,$c6,$06,$bd,$05,$44,$f7,$48,$82,$3c,$17
        .byte $01,$cb,$04,$31,$28

    L_7866:
        .byte $d0,$a2
        .byte $29,$ad,$b6,$37,$24,$41,$40,$88,$ce,$3c,$a0,$e7,$a3,$1c,$b5,$d9
        .byte $17,$bb,$e4,$1d,$3b,$82,$81,$43,$05,$02,$d9,$07,$f4,$c6,$5a,$ba

    L_7888:
        .byte $7b
        .byte $6c,$0f,$d3,$c3,$99,$2f,$1b,$f3,$bf,$7c,$5a

    L_7894:
        eor ($79),y

        .byte $92,$ed,$4c,$37,$15,$67,$01,$d5,$58,$13,$71,$56,$69,$e5

    L_78a4:
        .byte $f7,$47
        .byte $e9,$ea,$65,$22,$18,$2a,$4f,$c1,$fc,$a4,$7d,$83,$04,$31,$52,$61
        .byte $82,$c2,$45,$6b,$43,$f2,$44,$36,$43,$8a,$27,$de,$2f,$40,$c5,$55
        .byte $86,$0d,$78,$b4,$a3,$e2

    L_78cc:
        cpy $61

        .byte $44,$85,$83,$5a,$2e,$e0,$c1,$6f,$22,$c1,$0c,$17,$36,$29,$c3,$06
        .byte $64,$56,$c8,$31,$63,$85,$91,$6f,$e0,$57,$fd,$3d,$ec

    L_78eb:
        .byte $dc
        .byte $58,$6a,$84,$14,$36,$91,$04,$c4,$51,$86,$be,$41,$6e,$04,$35,$42
        .byte $0a,$1e,$14,$15,$47,$d8,$38,$bc,$62,$a1,$46,$a2,$4c,$3e,$01,$41
        .byte $2b,$0d,$7c,$82,$cf,$45,$0c,$ee,$4f,$11,$af,$a4,$bd,$8a,$6c,$44
        .byte $7a,$b4,$41,$86,$d2,$20,$ab,$e5,$6d,$cd,$30,$c5,$55,$fb,$bc,$20
        .byte $32

    L_792d:
        .byte $8b,$43,$dc,$53,$43,$73
        .byte $e8,$32,$55,$f3

    L_7937:
        cmp ($6e),y

        .byte $d2,$b7,$50,$2d,$b8

    L_793e:
        sei 
        jsr $6155

        .byte $36,$74,$c3,$76,$c9

    L_7947:
        eor L_bb40,x
        lda ($e0,x)

        .byte $83,$79,$24,$d5,$f2,$db,$0b,$5c,$54,$0d,$b0,$d4,$4b,$43,$f3,$be
        .byte $13,$85,$ff,$4f,$b1,$b8,$b0,$da,$44,$16,$e8,$82,$33,$43

    L_796a:
        lda $a8,x

        .byte $c7,$db,$12,$19,$63,$1f

    L_7972:
        .byte $4b,$37,$5b
        .byte $c1,$28,$26,$20,$83,$35,$34,$17,$8e,$d4,$13,$10,$65

    L_7982:
        inc $a6
        stx $779d
        cmp ($28,x)
        eor ($83),y
        stx $82
        sta $09
        ora $f4,x

        .byte $0b,$22,$8f,$0c,$12,$ad,$d1,$e0,$21,$fa,$78,$a6,$a6,$92,$4b,$b5
        .byte $f8,$a0,$64,$f8,$b2,$2d,$fc,$0d,$d6,$72,$ad,$02,$86,$61,$63,$ce
        .byte $fd,$31,$b0,$cd,$d9,$04,$a5,$75,$61,$b4,$cc,$bc,$14,$6e,$64,$01
        .byte $ab,$8a,$44,$e4,$93,$34,$e3,$53,$3e,$7a,$28,$68,$51,$d6

    L_79cf:
        nop 
        and ($5e),y

    L_79d2:
         .byte $7a,$52
        .byte $48,$8e,$c7,$44,$76,$14,$d1,$35,$c9,$e5,$e3,$c8,$89,$39,$f1,$21
        .byte $6f,$8a

    L_79e6:
        ror 
    L_79e7:
        sta L_9712,x

        .byte $3c,$b1,$4d,$8c,$92,$6b,$e5,$d4,$7d,$86,$78,$3d,$0c,$35,$f2,$0a
        .byte $bb,$22,$df,$c0,$af,$07,$5c,$34,$01,$b7,$02,$1a,$a9,$ec,$50,$62
        .byte $f1,$b2,$2d,$b0,$b0,$74,$43,$3d,$81,$82,$0a,$d2,$f0,$ce,$14,$94
        .byte $a1,$25,$a2,$b6,$a2,$42,$25,$a9,$e1,$e3,$8b,$88

    L_7a26:
        sta L_8cb5
        stx L_f052 + $8

        .byte $d3

    L_7a2d:
        cpx $3cbc
    L_7a30:
        sta ($84),y
        ror $ad

        .byte $9c,$41,$67,$4c,$20,$c4

    L_7a3a:
        .byte $66,$8b,$68,$ef
        .byte $c5,$45,$07,$70,$14,$8a

    L_7a44:
        .byte $90,$b0
        .byte $6a,$46,$40,$30,$52,$91,$eb,$01,$7b,$e2,$b1,$03,$fe,$21,$66,$49
        .byte $39

    L_7a57:
        asl $58,x
        rts 



        .byte $42,$04,$20,$0e,$13,$0c,$26,$6b,$e8,$be,$26,$b1,$5d,$f7,$f7,$df
        .byte $fc,$6a

    L_7a6c:
        .byte $f0,$53,$bb
        .byte $98

    L_7a70:
        sbc ($19,x)
        inx 

        .byte $6f,$e1,$54,$72,$c3,$41,$31,$06,$65,$0a,$30,$49,$41,$2b,$0d,$5d
        .byte $19,$88,$a3,$31,$80,$af,$9d,$31,$41,$43,$04,$1e,$ac,$28

    L_7a91:
        .byte $7f,$fa,$b0,$a1,$ff
        .byte $41,$92,$ce,$95,$a0,$a3,$a4,$d7,$a8,$d4,$79,$d4,$78,$c2,$23,$30
        .byte $ee,$40,$00,$c7,$36,$ac,$90,$8c,$f2,$ed,$84,$d4,$a2,$d9,$61,$16
        .byte $85,$26,$d1,$7b,$b6,$42,$56,$63,$0f,$5d,$07,$07,$06,$e8,$14,$b0
        .byte $43,$62,$db

    L_7ac9:
        dey 
        sec 

        .byte $37,$44,$a5,$82,$10,$bc,$41,$05,$9f,$0f,$8b,$e8,$26,$05,$a2,$d6
        .byte $a6,$f4,$52,$14,$74,$73,$d1,$43,$24,$67,$b0,$35

    L_7ae7:
        cpy $66
        adc #$24

        .byte $9e,$66,$93,$cc,$e8,$72

    L_7af1:
        ldy #$d8

        .byte $ef,$4d,$f6,$28

    L_7af7:
        .byte $af,$80,$72,$f2,$63,$9b
        .byte $e0,$45,$4d,$87,$71,$60,$c2,$40,$ae,$c3,$05,$9f,$40

    L_7b0a:
        .byte $ae,$03,$04,$a8,$17,$54,$30,$6b
        .byte $20,$5c,$41,$14,$84,$eb,$29,$0c,$14

    L_7b1b:
        nop 
    L_7b1c:
        ora $81

        .byte $0f,$e9,$8d,$64,$15,$84,$57,$3c,$30,$41,$15,$bc

    L_7b2a:
        sty $22bc
        ldy $56,x
        ldy L_5430,x

        .byte $c2,$32,$71,$ba,$5e,$0a,$6d,$64,$90,$21,$2c,$f7,$10,$5a,$32,$a4
        .byte $81,$0b,$7a,$19,$8e,$8f,$df,$17,$82,$0a,$6d,$72,$ea,$f7,$5c,$8e
        .byte $c9,$4f,$ad,$51,$88,$0b,$b4,$98,$66,$c9,$47,$2f,$84,$2d,$92,$62
        .byte $6a,$32,$21,$8e,$e6,$c1,$2d,$05,$fa,$71,$7f,$51,$f3,$0e,$2f,$18
        .byte $68,$28,$6a,$38,$01,$f0,$0a,$0e,$bd,$47,$bc,$38,$bc,$4c,$a7,$37
        .byte $83,$78,$b1,$0f,$80,$50,$7a

    L_7b89:
        sbc ($b3,x)
        lda L_1045 + $6

        .byte $bf,$98,$e9,$d7,$dc,$41,$1b,$2a,$4b,$14,$c8,$08,$66,$7d,$93,$99
        .byte $91,$a0,$ee,$5e,$80,$29,$0c,$96,$d1,$68,$dc,$bc,$cc,$dc,$31,$32
        .byte $17,$80,$85,$10,$18,$ae,$c8,$62,$ed,$8d,$f0,$7c,$1f,$81,$b8,$10
        .byte $ca,$d4,$ee,$2c,$32,$b5,$35,$ea,$3d,$01,$f4,$eb,$d1,$a0,$a1,$a8
        .byte $a9,$0b

    L_7bd0:
        ldx L_4191 + $4

        .byte $e7

    L_7bd4:
        bvc L_7bd0

        .byte $6f,$b0,$ef,$6f,$f1,$00,$07,$cd,$46,$bc,$28,$64,$cc,$7b,$ec,$8b
        .byte $5e,$1c,$d3,$18,$da,$8d,$78,$63,$85,$90,$6b,$c2,$9e,$6b,$c3,$48
        .byte $19,$61,$b1,$d3,$0b,$4c,$46,$77,$13,$e0,$e1,$b1,$2b

    L_7c03:
        eor ($2b,x)
        eor ($ea),y
        asl 
        ora ($09),y
        sty L_b735
        cmp $72

        .byte $42,$dd,$a5,$73,$d1,$bb,$15,$f0,$0c,$57,$cc,$2e,$3a,$63,$f0,$72
        .byte $ab,$80,$13,$67,$4c,$20,$f1,$78,$40,$55,$ce,$c9,$1f,$c0,$2e,$c5
        .byte $58,$85,$c7,$7b,$c2,$a4,$5d,$87,$7c,$55,$c0,$4c,$94,$78,$45,$16
        .byte $64,$fa,$d0,$74,$ee,$93,$4a,$50,$8c

    L_7c48:
        lda $46,x

        .byte $37

    L_7c4b:
        tax 
        eor $fc,x

        .byte $37,$25,$ea,$51,$af,$e1,$b9,$2f,$55,$46,$44,$31,$f9,$43,$51,$b5
        .byte $35,$1e,$8f,$61,$e8

    L_7c63:
        stx $a101
        lsr $a2
        ldy $2b
        sty $d8,x

        .byte $50,$79,$e8,$88,$c0,$73,$47,$48,$f8,$37,$37

    L_7c77:
        sbc $45cf

        .byte $0c,$83,$66,$f5,$54,$62,$03,$e9,$72,$b8,$0d,$0a,$35,$19,$00,$ae
        .byte $57,$62,$9a,$d1,$25,$0f,$d3

    L_7c91:
        lsr $e6

        .byte $eb,$b2,$87,$3d,$fc,$f4,$50,$c8,$f6,$6e,$5d,$4b,$01,$8e,$16,$42
        .byte $c0,$6b,$ee,$0c,$56,$4f,$a6,$25

    L_7cab:
        cpx #$b4

        .byte $92,$6f,$e0,$f8,$53,$02,$82,$fe,$0c,$28

    L_7cb7:
        ldx $6108
        cmp #$d0
        cpy $2f

        .byte $e7,$bc,$30,$40,$29,$b2,$59,$9d,$02,$4f,$08,$d4,$22,$1b,$cb,$8c
        .byte $18,$ae,$3b,$d0,$05,$11,$9b,$b9,$cc,$12,$32,$08,$a6,$b4,$ca

    L_7cdd:
        tax 
        adc ($40,x)
        ldx $c1,y
        beq L_7cab
        lda ($83,x)
        cmp $2402,x
        bit L_881a + $1

        .byte $3f,$54,$40,$4a,$85,$bb,$c3,$f9,$18,$a8

    L_7cf6:
        and ($c6,x)
        dec $20,x
        rts 



        .byte $85,$4a,$bf,$82

    L_7cff:
        eor L_69da

        .byte $37,$22,$33,$de,$8f,$6b,$2b,$8a,$6b,$87,$e4,$4c,$a7,$2a,$8d,$78
        .byte $50,$88,$45,$2d,$1d,$74,$71,$86,$7a,$ea,$90,$55,$6a,$10,$5b,$a2
        .byte $0a,$73,$19,$68,$6b,$e4,$10,$a6,$b3,$e9,$44,$b5,$36,$e1,$03,$6c
        .byte $31,$13,$c4,$71,$68,$43,$04,$46,$69,$95,$42,$63,$90,$2d,$90,$b4
        .byte $3e,$29,$43,$3a,$48,$9b,$30,$20,$e1,$40,$86,$04,$16,$2d,$03,$04
        .byte $30,$49,$ba,$50,$8c,$df,$25,$30,$d7,$ca,$d9,$07,$1d,$c9,$ea,$21
        .byte $19,$ea,$66,$5a,$cc,$5e,$20,$0a,$42,$af,$50,$1a,$c0,$42,$db,$29
        .byte $0c

    L_7d73:
        cli 
        sbc $74a6

        .byte $c2,$19,$9f,$66

    L_7d7b:
        .byte $d7,$d0,$8f
        .byte $86,$08,$21,$48,$e8,$92,$02,$24,$0f,$a2,$6f,$e1,$14,$0a,$11,$90
        .byte $ac,$a8,$21,$b4,$0c,$b8,$a4,$3b,$a8

    L_7d97:
        .byte $f4
        .byte $48,$8c,$e1,$59

    L_7d9c:
        ora ($9f),y

        .byte $14,$90,$a3,$ce,$ca,$d0,$86,$39,$6b,$c3,$2b,$53,$5f,$1d,$19,$f9
        .byte $0f,$c8,$31,$c7,$31,$09,$8b,$c1,$22,$ba,$a1,$8a,$dd,$84,$53,$52
        .byte $9a,$97,$ac,$0b,$a0,$c8,$b5,$e1,$14,$d4,$44,$b5,$e3,$4f,$04,$14
        .byte $1e,$b8,$28,$3a,$0a,$38,$24,$a0,$eb,$c1,$81,$41,$42,$29,$b7,$59
        .byte $9b,$30,$9e,$b1,$5a,$c0,$94,$7d,$63,$3d,$0d,$db,$ea,$23,$36,$a9
        .byte $40,$57,$a9,$dd,$82,$ea,$38

    L_7df5:
        sta L_e598,y
        ldy $c021

        .byte $00,$d1,$e2,$33,$80,$8e,$98,$49,$73,$1d,$15,$e8,$06,$49,$77,$94
        .byte $12,$80,$32,$59,$bd,$2a,$50,$15,$8c,$3a,$67,$76,$2c,$b4,$9c,$21
        .byte $1b,$a2,$2c,$0c,$b5,$46,$ed,$c2,$8a,$c1,$44,$a8,$88

    L_7e28:
        .byte $70,$a2
        .byte $b8,$91,$2a,$3e,$ce,$14,$56,$b2,$26,$e8,$2e,$b2,$96,$8c,$48,$7c
        .byte $78,$fc,$0b,$a5,$c1,$02,$05,$92,$88,$29,$b7,$d0,$10,$ae,$34,$f1
        .byte $37,$44,$ca,$06,$71,$02,$d8,$c4,$fd,$31,$96,$64,$68

    L_7e57:
        cpy $ae
        iny 

        .byte $34,$f1,$23,$87,$36,$5a,$10,$65,$45,$69,$e2,$6e,$23,$89,$46,$24

    L_7e6a:
        .byte $f4,$82,$82,$83,$97
        .byte $29,$07,$2a,$57,$a7,$5d,$cb,$ab,$95,$82,$89,$6e,$03,$09,$be,$aa
        .byte $ad,$b1,$89,$41,$cb,$c5,$e0,$36,$db,$18,$8a,$b5,$cc,$4a,$0e,$77
        .byte $80,$5b,$5c,$c4,$a4,$46,$dd,$cb,$8e,$92,$40,$a8,$e2,$53,$6d,$dc
        .byte $b4,$0b,$25,$12,$09,$50,$2d,$f4,$4a,$6d,$bb,$96,$81,$a3,$12,$7b
        .byte $0a,$a0,$95,$55,$56,$06,$72,$db,$63,$11,$56,$53,$6a,$e6,$26,$66
        .byte $66,$85,$39,$24,$c7,$83,$07,$d1,$33,$2f,$68,$7e,$99,$6c,$52,$1d
        .byte $77,$a5,$87,$87,$bf,$54,$a6,$12,$a3,$25,$12,$28,$18,$4a,$87,$4f
        .byte $60,$01,$4a,$c2,$54,$50,$c4,$8b,$65,$84,$a8,$f5,$c4,$8b,$2d,$84
        .byte $a8,$eb,$c4,$8b,$7c,$88,$c1,$c0,$c2,$05,$83

    L_7efa:
        .byte $70,$01,$44,$f2,$df,$44,$8b
        .byte $01,$82,$bc,$22,$44,$f3,$d6,$24,$5e,$ec,$25,$46,$d8,$93,$d8,$08
        .byte $af,$f1,$89,$59,$21,$78,$75,$3d,$1e,$c1,$64,$42,$fb,$79,$be,$30
        .byte $ec,$3e,$46,$09,$b3,$71,$73,$db,$59,$2c,$b4,$68,$ff,$63,$ff,$4e
        .byte $96,$f6,$67,$18,$6d,$8c,$8b,$25,$92,$71,$39,$d3,$a2,$c9,$64,$e7
        .byte $b8,$75,$2a,$3b,$0e,$c3,$8a,$e2,$b4,$68,$17,$61,$12,$7b,$63,$23
        .byte $ac,$c5,$e3,$f0,$a3,$9e,$b2,$19,$18,$26,$09,$ac,$84,$7b,$63,$ad
        .byte $d3,$df,$b4,$2a,$15,$b3,$6c,$dc,$56,$1d,$5c,$ae,$cf,$9e,$dd,$b5
        .byte $92,$c8,$03,$4c,$ab,$58,$76,$1e,$0a,$b5,$87,$6a,$bf,$ac,$27,$c2
        .byte $1f,$b7,$c9,$c1,$91,$5d,$fc,$e7,$f0,$9c,$19,$15,$df,$c6,$45,$63
        .byte $60,$c3,$ba,$6f,$5a,$7b,$e1,$d5,$8c,$3b,$0e,$d8,$7c,$71,$1c,$47
        .byte $4f,$e0,$4b,$c1,$a8,$b5,$4c,$38,$c9,$e2,$13,$ae,$e5,$fc,$61,$d8
        .byte $78,$32,$05,$21,$98,$74,$3f,$b3,$02,$90,$75,$97,$ff,$09,$c0,$13
        .byte $c2,$43,$b4,$2e,$a5,$44,$e2,$b5,$87,$59,$78,$6b,$1d,$45,$b2,$c9
        .byte $04,$c0,$38,$bf,$c0,$34,$c8,$7c,$b7,$ee,$34,$26,$59,$05,$0a,$e4
        .byte $f4,$3b,$4f,$09,$96,$89,$ef,$3f,$8a,$64,$8f,$71,$a4,$ca,$20,$19
        .byte $6e,$dd,$9c,$44,$bf,$5a,$b1,$83,$7d,$76,$f0,$36,$4e,$53,$65,$0a
        .byte $33

    L_8002:
        bit $f8

        .byte $32,$4d,$b2,$62,$13,$64,$d9,$23,$e4,$f7,$bf,$26,$4d,$fe,$d0,$94
        .byte $4d,$8b,$36,$98,$8f,$47,$bc,$a1,$90,$80

    L_801e:
        ora L_c5c7 + $56,y
        asl SCREEN_BUFFER_1 + $a8

    L_8024:
         .byte $73
        .byte $ea,$00,$2e,$46,$b9,$72,$35,$c1,$91,$8f,$84,$d3,$34,$c8,$f4,$c8
        .byte $64,$c9,$43

    L_8038:
        lda ($d5,x)

        .byte $2f,$b3,$54,$81,$2f,$a8

    L_8040:
        .byte $04
        .byte $cd,$32,$3d,$a6,$d5,$2d,$7f,$be,$ad,$1a,$54,$a3,$01,$c1

    L_804f:
        .byte $72,$57
        .byte $ce,$95,$9e,$fd,$c2,$02,$d9,$4c,$a4,$1d,$24,$12,$0a

    L_805e:
        .byte $3c
        .byte $75,$24,$27,$8a,$13,$93,$09,$04

    L_8067:
        sta $2641,y
        jmp (L_6ca5 + $1)

        .byte $82

    L_806e:
        bpl L_8038
        cpy #$b9
        plp 
        adc $84e0,y
    L_8076:
        bmi L_806e
        sei 
        sta $1c65,y
        and ($c0,x)

        .byte $63,$e1,$26,$5d,$38,$48,$76,$4a,$10,$c2,$99,$41,$42,$73,$a1,$0c
        .byte $2b,$14,$7b,$6c,$8f,$78,$a1,$23,$e1,$0e,$02,$2d,$b6,$73,$af,$bb
        .byte $ed,$62,$39,$32,$82,$84,$c7,$a0,$a3,$ac,$61,$32,$d0,$bb,$28,$fb
        .byte $42,$72,$59,$38,$ea,$35,$1b,$02

    L_80b6:
        ldx #$78

        .byte $9e,$99,$32,$51,$d6,$14,$89,$94,$be,$16,$e9,$8f,$5c,$21,$9d,$d8
        .byte $4d,$63,$3b

    L_80cb:
        ora L_e970,x
    L_80ce:
        and ($f6),y
        sbc ($5e,x)
        ror $dc,x
        lda #$23
        asl 
        ror $e3

        .byte $03,$db,$b2,$1e,$3a,$1d,$0f,$c6,$b8,$c3,$1a,$35,$54,$3a,$1d,$25
        .byte $8b

    L_80ea:
        .byte $14
        .byte $e9,$c9,$c5,$6b,$04,$cb,$38,$ac,$03,$c2,$c2,$3c,$32,$53,$29,$95
        .byte $3a,$9d,$e0,$93,$25,$a7,$7b,$99,$66,$b1,$96,$6b,$1d,$69,$08,$f6
        .byte $3e,$14,$25,$63,$04,$e2,$c8,$84,$30,$a0,$98,$2c,$92,$34,$ac,$2b
        .byte $d7,$de,$32,$57,$53,$a9,$de,$07,$82,$48,$c8

    L_8126:
        tay 
        adc ($1e,x)
        asl $1f,x

        .byte $e3,$0e,$d9,$b8,$ae,$08,$06,$99,$92,$d7,$aa,$92

    L_8137:
        cpx L_a48b + $3

        .byte $bf,$50,$33,$6d,$8b,$b8,$ec,$d5,$d4,$7e,$f3,$ac,$c4,$40,$24,$52
        .byte $25,$aa,$b0,$d3,$02

    L_814f:
        asl $94

        .byte $02,$44,$e7,$4f,$22,$13,$c8,$8a,$48,$86,$c2,$8c,$28,$e8,$24,$93
        .byte $54,$06,$45,$37,$d5,$3c,$74,$41,$ce,$a2,$6b,$53,$07,$3a,$6b

    L_8170:
        lsr $a6,x
        eor ($36,x)

        .byte $9e,$ea,$71,$85,$36,$ec,$bb,$8f,$6a,$03,$92,$45,$25

    L_8181:
        .byte $3f,$30,$77,$54,$bb
        .byte $06,$c8,$fa,$4c,$55,$44,$1d,$10,$c8,$a6,$d3,$e4,$fd,$00,$0d,$33
        .byte $d9,$be,$6f,$b9,$f6,$6f,$9d,$75,$77,$66,$f9,$be,$e7,$d9,$be,$75
        .byte $d5,$cc,$3a,$cc,$64,$fe,$ae,$91,$21,$64,$b3,$19,$3f,$ab,$86,$45
        .byte $4b,$c4,$df,$28,$d8,$64,$2a,$ae,$42,$a5,$be,$6f,$9e,$25,$5a,$e5
        .byte $72

    L_81c7:
        .byte $a3
        .byte $55,$bc

    L_81ca:
        jmp L_ae13

        .byte $df,$0c,$8b,$28,$4d,$53,$a8,$ab,$6f,$9b,$ee,$67,$14,$8f,$4d,$e7
        .byte $5a,$6e,$75,$c9,$09,$ce,$63,$81,$21,$d6,$72,$de,$65,$9f,$66,$fb
        .byte $c2,$c9,$b2,$72,$d0,$3e,$11,$29,$7e,$aa,$ec,$30,$b0,$8c,$90,$b0
        .byte $e1,$96,$43,$c6,$86,$79,$60,$c2

    L_8205:
        dec L_1cdf
        lsr $77
        asl 

        .byte $7a,$fd,$f4,$f5,$fb,$fb,$59,$d4,$3a,$1d,$c4,$67,$1e,$59,$5b,$63
        .byte $b4,$a8,$77,$86,$13,$d6,$b2,$c2,$8f,$47,$d9,$81,$10,$a5,$3a,$79
        .byte $12,$e7,$2b,$51,$29,$e4,$e2,$78,$62,$72,$a7,$04,$27,$83,$8a,$a5
        .byte $12,$e5,$27,$16,$5d,$19,$83,$b2,$2c,$8a,$25,$12,$9e,$4e,$74,$68
        .byte $61,$36,$4a,$75,$9d,$b3,$9f,$6b,$6c,$f0,$b1

    L_8256:
        .byte $de,$a7,$3f,$47,$f4,$4b
        .byte $9d,$93,$1e,$2a,$8e,$67,$5e,$49,$4c,$b8,$c8,$f9,$d3,$99,$c6,$63
        .byte $a2,$7b,$2b,$9c,$89,$4f,$27,$13,$81,$92,$e3,$37

    L_8278:
        sbc L_58fb
        dec $42,x
        ora $c8
        sbc ($d0),y

    L_8281:
         .byte $e3
        .byte $0a,$3d,$1f,$66,$24,$4a,$d2,$88,$87,$8f,$72,$be,$fa,$b5,$69,$02
        .byte $4f,$96,$fd,$c6,$6f,$d8,$26,$58,$e9,$74,$ba,$2d,$c4,$45,$b2,$ce
        .byte $2b,$04,$c0,$38,$cd,$fb,$8d,$26,$48

    L_82ab:
        .byte $1a
        .byte $cc,$9d,$91,$6e,$23,$98,$97,$3c,$89,$02,$9e,$0d,$80,$ac,$48,$21
        .byte $7d,$a4,$10,$a3,$22,$b5,$b3,$71,$5b,$34,$2f,$b4,$2a,$41,$0a,$d9
        .byte $8c,$8c,$13,$00,$c0,$2b,$18,$21,$de,$0c,$09,$10,$99,$66,$09,$96
        .byte $60,$98,$07,$15,$d6,$71,$46,$46,$59,$82,$65,$98,$28,$4c,$14,$26
        .byte $09,$80,$62,$50,$06,$0a,$12,$43,$22,$14,$13

    L_82f7:
        eor ($96,x)

        .byte $00,$e1,$c7,$43,$ee,$a9,$4c,$e2,$e7,$a3,$c7,$36,$15,$16,$6d,$0e
        .byte $e0,$49,$f2,$ca,$b7

    L_830e:
        cpx $2bab
        bit $2b97
        ldy #$d0

        .byte $72,$e5,$a4,$a9,$00,$08,$f4,$7a,$7e,$04,$00,$81,$9d,$f5,$0c

    L_8325:
        .byte $03,$23
        .byte $1e,$00,$04,$00,$28,$01,$db

    L_832e:
        .byte $d4
        .byte $78,$53,$74,$1d,$24,$02,$39,$ad,$d2,$25,$13,$95,$ba,$a4,$97

    L_833e:
        sta $09

        .byte $5a,$82

    L_8342:
        sta $08

        .byte $14,$9e,$11,$91,$80,$56,$ab,$5b,$a5,$3a,$24,$61,$62,$a0,$42,$84
        .byte $d6,$42,$84,$82,$91,$11,$5a,$ac,$56,$8c

    L_835e:
        sty $a805

        .byte $92,$5a,$58,$4e,$33,$58,$d2,$c2,$67,$59,$d4,$3b,$0e,$c3,$be

    L_8370:
        .byte $4f,$93
        .byte $56,$92,$41,$35,$8c,$02,$ab,$c5,$3b,$0c,$30,$90,$fc,$87,$12,$3b
        .byte $01,$1c

    L_8384:
        .byte $64
        .byte $b8,$32,$72,$e5,$02,$05,$a2,$a2,$91,$52,$24,$5a,$19,$1f,$14,$8a
        .byte $46,$44,$86,$54,$64,$60,$06,$4c,$09,$09,$12,$3d,$aa,$06,$48,$ec
        .byte $04,$89,$0c,$03,$40,$d1,$79,$41,$32,$d2,$24,$32,$cd,$23,$49,$01
        .byte $01,$20,$10,$2d,$02,$f6,$b7,$05,$80,$19,$1c,$58,$4a

    L_83c2:
        cmp $6e,x
        asl L_2243
        dec $60,x
        iny 
        ora ($a6,x)
    L_83cc:
        eor ($e8),y
        and ($77,x)
        dey 

        .byte $80,$b5,$ec

    L_83d4:
        .byte $3b,$54,$c3,$33
        .byte $ac,$3a,$c8,$e8,$27,$16,$47

    L_83df:
        .byte $f7,$17,$ab,$64
        .byte $cc,$ca,$47,$b8

    L_83e7:
        tsx 

        .byte $bb,$30,$fc,$d6,$4c,$1a,$0b,$9d,$58,$3d,$98,$76,$1d,$66,$e5,$36
        .byte $7a,$3c,$3c,$5c,$f9,$c1,$56

    L_83ff:
        .byte $f3
        .byte $e6,$b5,$f8,$c3,$b2,$ec,$3f,$35,$97,$87,$19,$d6,$61,$d8,$7e,$a8
        .byte $b6,$1d,$87,$47

    L_8414:
        tsx 

        .byte $c2,$3f,$48,$2f,$fd,$58,$c3,$8c,$87,$68,$5d,$44,$f3,$42,$ea

    L_8424:
        and ($a7),y
        adc ($9b),y

        .byte $0f,$e0,$e0

    L_842b:
        .byte $07,$73,$5c,$67

    L_842f:
        eor $f8c0,y

        .byte $c3,$d5,$85,$cd,$87,$de,$01,$a6

    L_843a:
        .byte $64
        .byte $b9,$0e,$43

    L_843e:
        asl $9ec3

        .byte $13,$0e,$a2,$61,$c6,$43,$c9,$ca,$7f,$09,$87,$ea,$32,$23,$f5,$4a
        .byte $90,$eb,$42,$ea,$73,$70,$07,$49,$87,$3b,$64,$f4,$3d,$08,$f8,$3e
        .byte $77,$5d,$d7,$74,$dd,$3d,$c7,$3c,$26,$01,$d3,$74,$d3,$d3,$3f,$ac
        .byte $88,$50,$b8,$0c,$cf,$37,$c1,$91,$87,$84,$c6

    L_847c:
        asl $ec37

        .byte $23,$3c,$cd,$3a,$cb,$a9,$e1,$75,$30

    L_8488:
        .byte $a7,$82
        .byte $e1,$19,$1c,$d3,$a7,$58,$78

    L_8491:
        rti 

        .byte $95,$11,$57,$98

    L_8496:
        ror L_086e + $502
    L_8499:
        ldy L_930e + $3,x
        cmp #$9e

        .byte $80,$1c,$bd,$a2,$9a,$fc,$f0,$6d,$c5,$1f,$68,$07,$df,$6e,$d0,$0e
        .byte $58,$76,$88,$cb,$b6,$3b,$46,$1d,$a0,$c2,$8f,$c2,$01,$85,$aa,$6c
        .byte $1a,$a6,$c1,$a1,$7c,$24,$31,$70,$97,$61,$db

    L_84c9:
        asl $a8
        cpx L_603b
        ldy $4f

        .byte $54,$68,$dc,$38,$ae,$c6,$7f,$49,$36,$1d,$5d,$6d,$8b,$42,$ac,$e2
        .byte $a4,$fa,$74,$83,$d2,$09,$d8

    L_84e7:
        ldy $03,x

    L_84e9:
         .byte $3c
        .byte $28,$81,$b3,$76,$1c,$c4,$9c,$94,$7c,$21,$91,$ac,$75,$9b,$fb,$91
        .byte $d0,$e3,$23,$4e,$b5,$70,$5c,$64,$cb,$7e,$e3,$37,$52

    L_8507:
        dey 
        ora $12
        sbc L_4bcc,x
        sbc $39,x
        nop 

        .byte $ff,$e8,$cb

    L_8513:
        lda ($29,x)

        .byte $d4,$8b,$1a

    L_8518:
        and L_f0a2 + $a,y

        .byte $0b,$c1,$86,$2c,$f4,$0c,$9c,$f9,$c8,$1c,$04

    L_8526:
        rol 
        ora $03
        lda ($67),y
        dec L_8f42 + $2
    L_852e:
        sta SCREEN_BUFFER_2 + $39f
        asl 
        sbc $159b
        bne L_853f + $1

        .byte $42,$06,$10,$9b,$fc,$20,$9b,$09

    L_853f:
        .byte $0a,$90,$42
        .byte $a4,$1a,$c4,$83

    L_8546:
        eor L_ac14 + $d,y
        pha 
        and $89,x

        .byte $00,$0d,$33,$58,$7d,$de,$17,$69,$52,$49,$23,$ef,$85,$42,$ea,$03
        .byte $c8,$ec,$4d,$f8,$2e,$10,$0e,$4d,$61,$f7,$7a,$54,$50,$fc,$c9,$93
        .byte $7e,$5c,$b9,$32,$e4,$c9

    L_8572:
        .byte $97
        .byte $26,$5d,$f7,$5e,$24,$41,$78,$46,$1f,$2a,$5c,$a1,$c0,$50,$4a,$19
        .byte $12,$f2,$87,$66,$b5,$69,$63,$25,$69,$75,$ab,$4b,$ad,$2d,$00

    L_8592:
        .byte $e3
        .byte $e9,$07,$9f,$32

    L_8597:
        bvc L_8597
        lsr $1b

        .byte $e3,$89,$e6,$4d,$79,$7d,$17,$4a,$2e,$52,$80,$ac,$3e,$f3,$1a

    L_85aa:
        txa 
        sbc $8f24,x
        ldy $29ca,x
        cmp $89,x
        lsr $42

        .byte $00,$a3,$81,$58,$72,$4b,$1d,$0e,$86

    L_85be:
        .byte $87,$1c,$5a
        .byte $1e,$f4,$1e,$a8,$3f,$ca,$30,$f1,$28

    L_85ca:
        .byte $e7,$34,$ff
        .byte $95,$33,$98

    L_85d0:
        sta ($84),y

        .byte $a3,$08,$8c,$b6,$45,$8a,$01,$47,$dc,$0f,$90,$00

    L_85de:
        eor ($f7),y
        tya 

        .byte $e2,$fa,$ba,$51,$f7,$6d,$5a,$19,$6f,$89,$47,$dd,$89,$03,$12,$c4
        .byte $94

    L_85f2:
        sei 

        .byte $13,$e5,$1c,$e4,$3b,$60

    L_85f9:
        .byte $a5,$e4,$51,$19,$31,$ed,$a0,$b8,$01,$c4,$28,$fc
        .byte $cc,$11,$9c,$44,$1a,$47,$b8,$19,$04,$d0,$0a,$3e,$e0,$a6,$e0,$b9
        .byte $cc,$48,$e2,$15,$89,$98,$c4,$af,$93,$0d,$cc,$78,$6d,$8b,$12

    L_8624:
        bmi L_85aa
        adc ($1b),y

        .byte $f7,$4e,$22,$5d,$99,$87,$86,$b5,$90,$5f,$f3,$e6,$ff,$9a,$dd,$e5
        .byte $c9,$05,$f4,$c4,$b9,$65,$00,$6b,$4b,$60,$65,$cb,$c3,$26,$5c,$a0
        .byte $3a,$1d,$c1,$2e,$4c,$e8,$91

    L_864f:
        .byte $27,$44,$00,$2b,$77,$04
        .byte $e9,$cb,$77,$39,$b9,$76,$b6,$bb,$52,$98,$35,$c1,$f1,$af,$33,$03
        .byte $63,$be,$5c,$2e,$d3,$14,$b0,$58,$89,$5f,$99,$96,$43,$1b,$de,$55
        .byte $8f

    L_8676:
        lda $0b

        .byte $32,$97,$97,$5d,$19,$19,$d2,$af,$0e,$e4,$4e,$a4,$6f,$61,$a2

    L_8687:
        .byte $e7,$32,$10,$dd
        .byte $a4,$05,$46,$d6,$e4,$36,$d9,$9d,$4c,$4b,$a2,$91,$a3,$a5,$bd,$82
        .byte $ed,$20,$14,$78,$68,$b8,$cc,$1c,$b7,$89,$48,$86,$03,$9b,$b5,$ef

    L_86ab:
        rti 

        .byte $35,$b0,$d4,$44,$61,$31,$3b,$b0,$9e,$f9,$8d,$f0,$20,$c3,$78,$80
        .byte $c9,$d6,$43,$61,$8e,$0a,$2c,$cb,$57

    L_86c5:
        asl $8a
        sta $74,x

    L_86c9:
         .byte $12,$04
        .byte $85,$01,$40,$10,$5e,$4e,$ad,$0d,$92,$f5,$68,$62,$07,$ab,$43,$64
        .byte $b3,$df,$d0,$c8,$81,$20

    L_86e1:
        pha 
        cmp ($8c,x)
        and L_c3ee + $2

        .byte $3a,$24,$e8,$82,$33,$d6,$e2,$53,$a2,$c1,$b0,$61,$ea

    L_86f4:
        lda ($6f,x)
        sta $69

        .byte $db,$71,$11,$0f,$55,$10,$0d,$83,$4a

    L_8701:
        .byte $cb,$6f
        .byte $9d,$76,$86,$cc,$e1,$5a,$e8,$e2,$56,$49,$00

    L_870e:
        ora #$25

        .byte $1b,$06,$14,$c3,$7c,$df,$16,$04,$e1,$19,$a8,$71,$04,$c1,$bd,$6d
        .byte $0c,$46,$f9,$be,$64,$ac,$ce,$89,$38,$46,$dc,$e2,$18,$46,$6d,$dc
        .byte $4b,$c9,$86,$4a,$c9,$60,$0a,$43,$52,$e2,$38,$02,$33,$b8,$95,$96
        .byte $2d,$0a,$c7,$4d,$db,$38,$85,$21,$8d,$71,$0c,$a5,$63,$84,$29,$1a
        .byte $1d,$39,$90,$01,$a4,$56,$9f,$67,$10,$17,$a6,$4c,$00,$b4,$6b,$74
        .byte $ed,$02,$60,$ad,$38,$ee

    L_8766:
        jsr L_7ac9

        .byte $d4,$07,$5d,$42,$df,$4e,$ea,$d0,$8b,$42,$59,$d3,$45,$24,$60,$28
        .byte $d8,$31,$19,$c2,$71,$2f,$0b,$da

    L_8781:
        cmp ($d3),y
        lda $01,x

        .byte $14,$91,$80,$8d,$12,$5b,$3b,$89,$69,$1a,$cd,$48,$d2,$80,$91,$c9
        .byte $9c,$e7,$c8,$53,$52,$6e,$24,$ee,$82,$e6,$da,$ba,$77,$8b,$6c,$05
        .byte $90,$01,$68,$55,$3a,$60,$b4,$01,$5a,$7a,$9d,$35,$d8,$06,$1b,$c2
        .byte $90,$d9,$ba,$60,$1c,$09,$95,$84,$66

    L_87be:
        ora $ae

        .byte $07,$71,$87

    L_87c3:
        php 

        .byte $c3,$dc,$70,$30,$f7,$c2,$30,$f7,$f2,$30,$88,$cf,$5b,$88,$04,$ee
        .byte $00,$07,$4a,$00,$46,$a2,$e2,$5e,$11,$b2,$b8,$80,$67,$19,$65,$40
        .byte $49,$88,$85,$03,$72,$c2,$b3,$b7,$90,$03,$2c,$c0,$28

    L_87f1:
        tya 
        asl $c1
        stx $65,y

        .byte $9b

    L_87f7:
        ora $1b
        nop 

        .byte $00,$36,$0c,$b3,$60,$12,$06,$f9,$41,$7d,$80,$0d,$f6,$59,$b0,$be
        .byte $a2,$65,$98,$09,$24,$09,$19

    L_8811:
        cpx #$d0
    L_8813:
        adc $03

        .byte $00,$cb,$49,$23,$60

    L_881a:
        .byte $a2,$65,$a4,$cc,$51,$36,$0a,$22
        .byte $cc,$60,$19,$60,$92,$63,$60,$50,$16,$63,$60

    L_882d:
        .byte $c4,$49,$13,$df,$07
        .byte $66,$48,$81,$80,$48,$84,$89,$10,$14,$0c,$c7,$16,$29,$8e,$66,$38
        .byte $b1,$4c,$73,$31,$c5,$8a,$63,$99,$8e,$2c,$53,$1c,$c7

    L_884f:
        sec 
        adc #$c0
        cpy L_7514
        sta $78
    L_8857:
        rol $2360,x
        and ($4e),y
        sta SCREEN_BUFFER_2 + $e4,x
        bmi L_8861 + $5

    L_8861:
         .byte $d0,$4d,$10,$ad,$e2,$50,$0c
        .byte $c9,$02,$47,$94,$05,$03,$a4,$92,$14,$d4,$ab,$89,$32,$f0,$8c,$cb
        .byte $78,$8f,$30,$c7,$ab,$d0,$5c,$d5,$f3,$7e,$54,$fb,$2a,$e4,$10,$53
        .byte $5a,$86,$2e,$d0,$00

    L_888d:
        eor $b8
        pha 

        .byte $02,$94,$01,$74,$5d,$18,$85,$6e,$9b,$ab,$21,$db,$b6,$21,$68,$a5
        .byte $67,$04,$81,$23,$6a,$da,$23,$28,$b6,$ad,$a2,$31,$30,$29,$a5,$74
        .byte $ef,$4c,$a2,$95,$28,$13,$0c,$90,$a4

    L_88b9:
        and $246e,x

        .byte $00,$5a,$00,$8c,$f1,$b7,$e2,$f0,$f4,$4b,$af,$d4,$2a

    L_88c9:
        .byte $37
        .byte $ac,$85,$60,$db,$e1,$48,$50,$b8,$89,$19,$82,$9a,$d9,$34,$2d,$8b
        .byte $64

    L_88db:
        eor $cb

    L_88dd:
         .byte $22,$23

    L_88df:
        rol 
        cmp $0136,x

        .byte $42,$50,$15,$46,$12,$05,$83,$28,$0a,$07,$5f,$a8,$48,$f5,$80,$a0
        .byte $6f,$88,$11,$5a,$70,$1d,$37,$8e,$43,$c6,$8a,$90,$40,$14,$81,$af
        .byte $29,$52,$7f,$11,$d0,$8c,$ee,$3a,$62,$03,$62,$b9,$00,$51,$e1,$08
        .byte $08,$85,$08

    L_8916:
        asl 

        .byte $17,$a6,$3b,$56,$f4,$b5,$6c,$0b,$56,$d5,$b0,$23

    L_8923:
        .byte $0b
        .byte $56,$c0,$b5,$71,$da,$b5,$51,$18,$18,$ec,$0a,$a9,$81,$8e,$d5,$c7
        .byte $87,$de,$07,$60,$63,$b0,$2d,$5c,$76,$06,$3b,$03

    L_8940:
        ora L_6aa6,x
        cld 
        asl $04,x
    L_8946:
        lda $0233
        cpy #$c7
        ror 
        nop 

        .byte $1c,$00,$53,$05,$81,$6a,$da,$b8,$ec,$e1,$1d

    L_8958:
        and $9d,x

        .byte $04,$76,$05,$ab,$8f,$1d,$81,$11,$95,$4c,$32,$36,$3c,$76,$a8,$75
        .byte $ed,$65,$b6,$78,$50,$e8,$09,$45,$03,$19,$83,$79,$1a,$1b,$c2,$db
        .byte $36,$cf,$08,$b4,$25,$18,$68,$ef,$1c

    L_8983:
        eor ($1b),y

    L_8985:
         .byte $0b,$0c,$30,$b8
        .byte $cd,$79,$0a,$8f,$bc,$00,$a3,$ef,$10,$a8,$a5,$d0,$8c,$bf,$5f,$c4
        .byte $71,$9a,$f2,$81,$1f,$78,$24,$45,$2e,$84,$67,$4d,$7e,$e5,$38,$c5
        .byte $01,$51,$e1,$20,$51,$45,$01,$40,$af,$46,$eb,$22,$99,$a4,$41,$81
        .byte $ae,$42,$32,$82,$33,$8e,$bf,$85,$99,$a2,$5e,$b4,$02,$90,$ef,$ae
        .byte $a5,$2a

    L_89cb:
        .byte $44,$63
        .byte $2c,$f4,$4d,$0a,$d5,$0a,$b0,$2b,$cc,$90,$ae,$17,$b5,$f7,$62,$ca
        .byte $02,$8a,$6b,$b8,$bf,$c0,$db,$66,$68,$01,$9a,$42,$59,$a0,$11,$9d
        .byte $96,$19,$2e,$40,$91,$b1,$18,$57,$23,$08,$8c,$d0,$30,$cb,$26,$45
        .byte $72,$42,$b2,$2b

    L_8a01:
        bcc L_8a08
        sta ($57),y
        sbc $8c,x
        txa 
    L_8a08:
        cpx $53
        eor L_fdb6 + $f,x

        .byte $57

    L_8a0e:
        sta $b1,x
        ora SCREEN_BUFFER_1 + $02,y
        ldx L_2557

        .byte $64,$57,$25,$de,$12,$80,$6d,$52,$c9,$b1,$5c,$81,$72,$d9,$0a,$d5
        .byte $d6,$a9,$bb,$c6,$b2,$e1,$a8,$53,$59,$76,$a9,$2a,$05,$c8,$c8,$2d
        .byte $0b,$a6,$a8,$75,$a0,$0a,$6b,$0a,$d5,$40,$21,$be,$35,$03,$66,$61
        .byte $b9,$5d,$63,$02,$57

    L_8a4b:
        and ($ec),y
        plp 

        .byte $1a,$55,$60,$4a

    L_8a52:
        .byte $23,$34,$0c,$30,$04,$64,$b3
        .byte $0d,$11,$16,$82,$09,$23,$31,$25,$00,$8c,$92,$e2,$02,$7d,$a6,$bc
        .byte $6c,$54,$0f,$1b,$8e,$b9,$73,$86,$10,$8a,$d2,$59,$86,$bc,$cc,$de
        .byte $02,$ba,$2a,$90,$a0,$11,$9a,$ce,$3c,$9d,$b6,$a1

    L_8a85:
        .byte $5c,$b2,$57,$04,$5a,$12
        .byte $cc,$30,$24,$5a,$77,$88,$12,$35,$00,$28,$02,$29,$a9,$66,$18,$12
        .byte $05,$35

    L_8a9d:
        .byte $dc,$5f,$b3,$53,$1a
        .byte $3e,$00,$0d,$be,$82,$9b,$99,$86,$57,$48,$15,$aa,$de,$11,$0c,$8d
        .byte $ce,$cd,$00,$0e,$7b,$92,$50,$20

    L_8aba:
        .byte $5c,$b7
        .byte $38,$72,$42,$98

    L_8ac0:
        .byte $64
        .byte $a2,$16

    L_8ac3:
        .byte $90,$90
        .byte $a1,$dc,$ea,$84,$b4,$52,$b2,$c4,$63,$35,$5b,$05,$a3,$e4,$7e,$1d
        .byte $0d,$02,$00,$46,$5a

    L_8ada:
        lda $40,x
        ror L_91f2 + $1
        sec 
        sbc ($d5,x)

        .byte $82,$13,$a2,$1d,$92,$82,$a2,$78,$2e,$53,$36,$db,$95,$f6,$7c,$1f
        .byte $30,$bb,$0f,$43,$ea,$50,$3b,$8a,$b6,$c5,$72,$12,$32,$2d,$91,$5c
        .byte $a0,$90

    L_8b04:
        .byte $2f
        .byte $b1,$40,$57,$60,$24,$09,$19,$b6,$dc,$a0,$73,$e6,$50,$9a,$23,$e1
        .byte $79,$f7,$14,$1a,$42,$41,$68,$5a,$b5,$57,$81,$10,$46,$0b,$54,$06
        .byte $d9,$e1,$49

    L_8b28:
        ldy L_3277 + $ab,x
    L_8b2b:
        txs 

        .byte $c3,$01,$ab,$11,$9a,$d6,$18,$ad,$5c,$76,$74,$24,$67,$40,$51,$19
        .byte $32,$d5,$22,$85,$35,$34,$d5,$00,$0d,$35,$00,$15,$a6,$09,$03,$2f
        .byte $09,$a8,$4d,$35,$5c,$80,$01,$19,$18,$d5,$40,$55,$10,$24,$60,$55
        .byte $42,$9a,$d3,$b5,$50,$00,$2d,$09,$a6,$a8,$71,$1a,$87,$a4,$a0,$7a
        .byte $63,$c7,$6a,$da,$b6,$05,$ab,$60,$47,$ac,$11,$69,$99,$d3,$02,$cf
        .byte $48,$61,$48,$7a,$da,$a1,$d9,$bc,$08,$ed,$5b,$02,$32,$08,$cd,$e3
        .byte $0d,$1b,$e0,$f3,$80,$63,$94,$11,$d8,$10,$91,$81,$6a,$ca

    L_8b9a:
        .byte $00
        .byte $85,$81,$8e,$50,$47,$8e,$12,$30,$2d,$59,$40,$c0,$c7,$4d,$90,$24
        .byte $4d,$80,$a0,$43,$71,$1a,$6b,$1a,$d5,$14,$a9,$b2,$80,$a9,$b6,$e1
        .byte $c1,$bc,$35,$01,$c0,$16,$86,$a5,$aa,$b5,$32,$20,$a4,$46,$6a,$af
        .byte $01,$99,$97,$ff,$e8,$2b,$51,$9a,$a0,$2b,$ad,$02,$42,$6c,$61,$70
        .byte $08,$12,$38,$00,$28,$1c,$02,$04,$8e,$00,$a6,$b1,$ad

    L_8be8:
        .byte $53,$34,$07,$00
        .byte $a0,$2b,$80,$12,$05,$c0,$28,$0a,$e0,$04,$bc,$93,$a6,$a6,$da,$a9
        .byte $12,$05,$22,$53,$8b,$c9,$5c,$cd,$24,$45,$ee,$53,$8b,$9d,$1b,$7b
        .byte $63,$34,$27,$00,$61,$4d,$8e,$00,$0a,$01,$5a

    L_8c17:
        tax 

    L_8c18:
         .byte $e2,$da
        .byte $45,$a8,$3a,$08,$61,$13,$35,$69,$84,$33

    L_8c24:
        asl $bcb9,x

        .byte $5b

    L_8c28:
        cpy #$00
        sty $6192
        ora L_48a1,y
    L_8c30:
        ror L_4898

        .byte $02,$33,$00,$23,$2b,$5a

    L_8c39:
        lda $e2
        jmp (L_1852)

    L_8c3e:
         .byte $26,$11,$3d,$68,$04,$1c
        .byte $01,$48

    L_8c46:
        ldx $74d5,y
        ora ($64,x)
        rol $d7

        .byte $23,$22,$6c,$4b,$47

    L_8c52:
        .byte $19,$aa,$04,$4d,$77,$90,$09,$1e,$5a
        .byte $6d,$72,$14,$85,$c3,$08,$cd,$24,$74,$a3,$4a,$2d,$0a,$e5,$fd,$a4
        .byte $6a,$28,$a2,$e6,$f0,$2f,$d2,$30,$05,$6a,$13,$c7,$d4,$01,$51,$bd
        .byte $62,$32,$b9,$c5,$ea,$c1,$b7,$dd,$48,$d0,$c7,$5c,$81,$a1,$6c,$57
        .byte $22

    L_8c8c:
        .byte $1c
        .byte $65,$38,$8c,$e3,$3a,$7d,$5b,$e6,$fb,$ab,$49,$e4,$77,$c2,$3a,$16
        .byte $c5,$b1,$5c

    L_8ca0:
        bcc L_8d03

        .byte $2b,$06,$df,$75,$60,$e3,$b0,$31,$ca

    L_8cab:
        .byte $d0,$b5
        .byte $6d,$58,$a4,$70,$71,$7a,$a4,$52

    L_8cb5:
        .byte $33,$3a
        .byte $84,$24,$5c,$88,$ca,$c6,$10,$01,$67,$c4,$04,$5c,$97,$4c,$25,$a8
        .byte $02,$d0,$f7

    L_8cca:
        ldy L_4f6b + $5,x

        .byte $d2,$8a,$54,$94,$52,$ac,$92,$85

    L_8cd5:
        and ($45),y
        rol 

        .byte $42,$a6,$19

    L_8cdb:
        .byte $22
        .byte $08,$ce,$33,$a7,$33,$a9,$40,$d0,$ae,$42,$2d,$01,$6a,$a0,$0a,$68
        .byte $59,$12,$b2,$25,$6c,$82,$d9,$14,$85,$09,$04,$64,$3b,$54

    L_8cfa:
        txs 
        lsr 
        cmp ($4a),y
        cmp ($64),y

        .byte $93,$03,$5f

    L_8d03:
        dey 

        .byte $30,$46,$7a,$58,$47,$89,$30,$c9,$10,$bc,$01,$2f,$87,$01,$92,$21
        .byte $68,$a5,$40,$2d,$0d,$b3,$a6,$71,$ce,$a2,$14,$c3,$24,$98,$2d,$14
        .byte $a8,$05,$a1,$95,$75,$9d,$31,$7b,$03,$24,$2f,$69,$47,$59,$b4,$50
        .byte $13,$51,$ea,$8a,$6b,$0e,$eb,$25,$00,$2f,$6b,$e7,$59,$23,$7b,$4a
        .byte $37,$92,$00

    L_8d47:
        lsr $80d8,x

        .byte $57,$51,$f3,$cb,$95,$ad,$22,$01,$44,$cd,$7e,$75,$a6,$b6,$0f,$18
        .byte $d0,$02,$9a,$af

    L_8d5e:
        cld 
        ror $bd,x
        sty $78

        .byte $d2,$42,$10,$ad,$36,$0e,$b1,$98,$d7,$8c,$c0,$16,$8a,$6c,$21,$5f
        .byte $f8,$52

    L_8d75:
        ora $37,x

        .byte $b3,$ad,$32,$d0,$96,$88,$77,$5a,$65,$e9,$97,$81,$78,$00,$98,$01
        .byte $1b,$ab,$ac,$51,$5a,$a6,$c2

    L_8d8e:
        .byte $00
        .byte $76,$52,$a0,$6f,$50,$e0,$0a,$b7,$b0,$a6,$c1,$61,$07,$2e,$14,$2d
        .byte $78,$e7,$3d,$92,$c2,$84,$23,$67,$61,$26,$65,$54,$a2,$68,$dc,$77
        .byte $5a,$d4,$c4,$e8,$93,$ac,$8a,$6b,$8c,$e9,$cc,$01,$12,$ad,$f0,$c8
        .byte $c9,$4e,$89,$3a,$20,$8c,$d0,$ba,$60,$5c,$3d,$f1,$02,$ed,$31,$16
        .byte $4b,$45,$2b,$10,$70,$99,$f4,$31,$3f,$2e,$d6,$20,$0b,$20,$c7,$90
        .byte $b3,$df,$10,$28,$47,$59,$eb,$50,$8e,$b5,$15,$08,$e0,$26,$14,$23
        .byte $80,$c9,$28,$47,$2d,$2a,$a1,$a2,$a1,$18,$68,$a8

    L_8dfb:
        .byte $47,$12
        .byte $8a,$85,$42,$95,$50,$8e,$03,$ae,$a1,$1d,$66,$f9,$42,$38,$89,$51
        .byte $19,$bc,$61,$e2,$0c,$46,$55,$38

    L_8e15:
        eor $e0,x

        .byte $10,$b4,$6c,$90,$29,$89,$c0,$29,$7c,$21,$0a,$ab,$54,$58,$13,$84
        .byte $68,$ee,$98,$05,$35,$6a,$e2,$f2,$00,$8d,$25,$d6,$2b,$62,$12,$04
        .byte $46,$5c,$35,$46

    L_8e3b:
        jmp L_501f + $13

        .byte $28,$a5,$60,$59,$41,$f8,$00,$18,$7a,$29,$58,$0d,$54,$09,$8f,$08
        .byte $20,$4b,$7c,$9f,$46,$11,$e2

    L_8e55:
        adc $97,x
        sbc #$76
        ora L_4be0 + $2,y
        ldy $f0,x

        .byte $13,$0c,$91,$1c,$58,$14,$52,$ae,$9c,$04,$c3,$24,$c1,$40

    L_8e6c:
        .byte $a2,$95,$49,$97,$83,$50,$16
        .byte $8a,$56,$00,$a4,$67,$75,$81,$13,$98,$1c,$46,$b0,$53,$68,$71,$40
        .byte $48,$09,$02,$23,$3c,$cc,$3c,$08,$14,$bb,$c4,$a4,$01,$73,$aa,$eb
        .byte $6b,$90,$91,$91,$cc,$1a,$c4,$cd,$32,$ae,$b6,$80,$24,$56,$60,$05
        .byte $a0,$40,$18,$42

    L_8ea7:
        jmp L_11cd

        .byte $41,$69,$9a,$09,$39,$48,$28,$0c,$b3,$5e,$b4,$01,$22,$59,$68,$50
        .byte $73,$f6,$12,$68,$9a,$23,$4d,$61,$ca,$b5,$28,$0a,$f3,$04,$81,$7b
        .byte $4a,$02,$81,$0a,$b0,$09,$12,$15,$ca,$07,$dd,$8b,$08,$a4,$31,$47
        .byte $b4,$ce,$90,$03,$90,$9a,$5c

    L_8ee1:
        ldy $1130

        .byte $57

    L_8ee5:
        sta ($10,x)

        .byte $13,$26,$00,$73,$9a,$80,$08,$ce,$81,$c5,$ee,$40,$80,$80,$bc,$06
        .byte $47,$90,$14,$01,$68,$59,$b0,$e6,$02,$00,$53,$57,$ac,$3f,$30,$3d
        .byte $af,$bb,$16,$26

    L_8f0b:
        adc #$c0
        adc ($b5,x)
        iny 

        .byte $89,$22,$42,$37,$5f,$30,$90,$24,$d9,$62,$c2,$3b,$7f,$8f,$1f,$d9
        .byte $76,$e1,$b8,$75,$16,$ca,$75,$3b,$82,$f7,$3d,$4f,$53,$be,$f2,$36
        .byte $6d,$9f,$c2,$80

    L_8f34:
        ldy #$11
        tax 

        .byte $b0,$c5,$7b,$5f,$76,$2c,$24,$08,$8c,$bd,$61

    L_8f42:
        .byte $d2,$22,$33
        .byte $de,$c3,$68,$4c,$c3,$8f,$1d,$d0,$4d,$30,$2c,$0b,$78,$94,$8f

    L_8f54:
        .byte $d0,$72,$5c
        .byte $f1,$c9,$72,$47,$25,$02,$39,$22,$33,$e8,$e9,$81,$30,$c9,$44,$5c
        .byte $3d,$f3,$ac,$bb,$4c,$41,$40,$b8,$7b,$c2,$47,$69,$88,$11,$99,$77
        .byte $5b,$5c,$e0,$8a,$2f,$09,$42,$30,$04,$0b,$60,$50,$14

    L_8f84:
        lsr $7b

        .byte $1f,$11,$36,$00,$2b,$60

    L_8f8c:
        .byte $c0,$30,$01,$60,$0a,$02
        .byte $b6,$0a,$22,$04,$8c,$00,$19,$66,$00,$64,$65,$98,$05,$10,$0a,$c0
        .byte $32,$4e,$6b,$00,$38,$17,$db,$06,$02,$4b,$2c,$d8,$30,$0d,$83,$08
        .byte $3c,$1f,$11,$1c,$04,$c6,$01,$b0,$48,$b0,$24,$0c,$74,$07,$bb,$08
        .byte $f8

    L_8fc3:
        inx 
        ror 
        cpy #$56
        lsr $ef,x

        .byte $80,$42,$c0,$94,$05,$8f,$1c,$81,$23,$02,$01,$4d,$76,$dc,$53,$50
        .byte $60,$40,$56,$05,$81,$20,$52,$33

    L_8fe1:
        sta ($89,x)
        pha 

        .byte $17,$a1,$a3,$58,$15,$4c,$0c,$79,$e2,$a0,$9b,$19,$23,$b0,$2d,$33
        .byte $56,$c0,$b3,$a2,$e4,$ca,$ba,$ce,$03,$42,$21,$19

    L_9000:
        .byte $f0,$50
        .byte $4d,$bc,$29

    L_9005:
        tay 

        .byte $a7,$c6,$66,$b1,$4d,$c8

    L_900c:
        sed 
        dey 

        .byte $c2,$f6,$d8,$ba,$d1,$54,$91,$90,$e0,$08,$bd,$ac,$9d,$6e,$a0,$92
        .byte $7a,$4d,$30,$a6,$a2,$9f,$13,$a4,$85,$c9,$87,$75,$9a,$1b

    L_902c:
        ora #$26
    L_902e:
        sty $fa
        tsx 
        cmp $38,x
        sty $bed4
        and $3545,x

    L_9039:
         .byte $14

    L_903a:
        sed 
        cmp $49,x
        dey 
        dec L_e303

        .byte $d7,$2f,$e1,$60,$10,$c7,$c9,$1d,$81,$8f,$91,$81,$8f,$1f,$23,$03
        .byte $1d,$ab,$4f,$0e,$4b,$94,$39,$2c,$d8,$e4,$b6,$e3,$92,$fb,$0e,$4b
        .byte $e0,$39,$2a,$11,$cb,$a2,$a1,$1d,$f4,$c2,$84,$72,$a8,$a8,$46,$9a

    L_9071:
        ldx $6c
        cpx #$4d

        .byte $1c,$4b,$f4,$54,$23,$ee,$c9,$28,$54,$2c,$90,$b1,$02,$65,$bc,$23
        .byte $06,$f2,$b2,$4a,$11,$f1,$66,$54,$2c,$ca,$85,$e5,$6c,$19,$65,$0b
        .byte $d6,$a1,$19,$1a,$15,$0a,$85,$a1,$ea,$d8,$ae,$7a,$f5,$64,$5b,$2e
        .byte $aa,$11

    L_90a7:
        dec $67,x

        .byte $7a,$8c,$b2,$85,$e5,$50,$8e,$50,$b4,$23,$5f,$42,$24,$d8,$36,$73
        .byte $37,$2a,$21,$6f,$0b,$89,$cc,$d1,$5a,$68,$92,$03,$22,$84,$64,$cc
        .byte $a1,$cc,$bd,$68,$86,$4b,$49,$0b,$4d,$12,$41,$20,$bd,$68,$92,$16
        .byte $99,$a4,$85,$a4,$80,$c9,$c9,$20,$cd,$5a,$48,$24,$19,$a1,$85,$21
        .byte $c9,$20,$90,$62,$a0,$0e,$a1,$a2,$60,$1b,$80,$09,$0f,$6d,$13,$00
        .byte $d1,$34,$0d,$e9,$00,$64,$68,$1a,$26,$89,$20,$d0,$7b,$48,$30,$0d
        .byte $02,$85,$42,$90,$41,$f8,$cb,$d4,$83,$01,$ed

    L_9114:
        .byte $80
        .byte $48,$24,$3d,$b0,$0b

    L_911a:
        eor SCREEN_BUFFER_2 + $34,y
        cmp ($28),y
        adc $8c,x
        and #$93

        .byte $03,$06,$65,$ea,$4a,$fa,$16,$92,$02,$32,$e1,$f4,$3a,$15,$20,$90
        .byte $ae,$cd,$24,$2d,$34,$4d,$ab,$8c,$01,$9a,$48,$33,$49,$66,$69,$2c
        .byte $b7,$5f,$3f,$e2,$84,$87,$24,$82,$16,$d3,$45,$c9

    L_914f:
        and ($c6,x)
        asl $22

        .byte $f2,$41,$09,$59,$24,$18

    L_9159:
        rti 

        .byte $41,$52,$d1,$24,$12,$0c,$d2,$4e,$01,$c9,$a2,$48,$34,$8a,$91,$85
        .byte $98,$f3,$09,$04,$2a,$40

    L_9170:
        .byte $71,$39,$24,$06,$1e,$49,$01,$c0,$66,$b1,$1e,$15,$06,$4f
        .byte $69,$01,$93,$da,$41,$20,$85,$f6,$85,$48,$73,$e6,$c2,$0e,$4b,$8a
        .byte $39,$2c,$38,$e4,$ba,$c3,$92,$bf,$1c,$97,$4c,$72,$5a

    L_919b:
        .byte $a1,$c9,$61,$87,$25,$a7,$1c
        .byte $96,$08,$72,$5c,$41,$7d,$2b,$07,$26,$88,$e4,$a5

    L_91ae:
        .byte $47
        .byte $25,$30,$39,$2c,$90,$e4,$a8,$47,$25,$d0,$c1,$05,$1a,$f8,$8d,$63
        .byte $92,$c1,$8e,$4b,$7c,$39,$3d,$42,$8c,$01,$1c,$96,$c4,$72,$57,$28
        .byte $70,$88,$8e,$4b,$64,$39,$31,$c7,$25,$82,$04,$46,$a3,$8b,$61,$c9
        .byte $78,$40,$59,$00,$16,$f8,$40,$72,$59,$61,$c9,$51,$0e,$4b,$c9,$b2
        .byte $29,$75,$f8

    L_91f2:
        .byte $9e,$0f,$47
        .byte $25,$0e,$39,$2a,$d1,$c9,$ec,$3b,$37

    L_91fe:
        cli 
        dec $bedd

        .byte $64,$6c,$fb,$27,$52,$29,$d4,$8e,$97,$7d,$e4,$6c,$d3,$ae,$0b,$dc
        .byte $f5,$38,$38,$34,$e0,$09,$06,$c5,$40,$2a,$01,$b9,$c1,$89,$00,$39
        .byte $4a,$80,$60,$67,$10,$03,$ac,$a8,$29

    L_922b:
        .byte $50,$13,$00
        .byte $09,$93,$31,$20,$10,$0d

    L_9234:
        cpy $98c9
        bcc L_923c

        .byte $23,$30,$c2

    L_923c:
        ldy #$06
        asl $e6,x

        .byte $64

    L_9241:
        cpy L_f845 + $2
    L_9244:
        lsr L_480c,x

        .byte $02,$95,$00,$a8,$98,$01,$93,$4a,$45,$23,$a4,$00,$d2,$91,$19,$26
        .byte $01,$22,$30,$cc,$00,$c3,$82,$62,$00,$a5,$40,$0c

    L_9263:
        rol 

        .byte $89,$9a,$53,$a9,$dd,$20,$06,$94,$e8,$c8,$09,$89,$d1,$86,$60,$19
        .byte $ca,$78,$43,$30,$ce,$08,$c8

    L_927b:
        rol $79

        .byte $27,$2d,$50,$00,$33,$82,$91,$55,$f2,$d5,$ab

    L_9288:
        ldx $80a9
        cpy $80
        ror $18

        .byte $54,$03,$72,$52,$a0,$1b,$99,$83,$89,$8f,$2e,$e2,$0c,$67,$b5,$33

    L_929f:
        .byte $0c,$2b,$73,$32
        .byte $66,$2b,$f8,$c1,$89,$98,$61,$5b,$90,$59,$2a,$02

    L_92af:
        ror $02
        ror $0130,x
        cpy $c4

        .byte $23,$2a,$19,$ee,$aa,$8c,$02,$58,$05,$5c,$50,$1c,$49,$a2,$9b,$35
        .byte $9e,$49,$1e

    L_92c9:
        lsr $10,x
        sty $02,x
        rti 

        .byte $3d,$89,$86,$15,$b9,$93,$39,$ac,$e1,$6c,$1a,$01

    L_92da:
        .byte $2c,$a3,$e1,$12

    L_92de:
        ldx #$64
        dec $71

        .byte $50,$ce,$2a,$1d,$38,$04,$c0,$4c,$19,$00,$09,$80,$00,$72,$6c,$66
        .byte $f3,$8c,$c3,$0a,$80,$54,$14,$a8,$01,$ca,$54,$4c,$04,$c0

    L_9300:
        .byte $0e,$74,$5d,$80
        .byte $46,$1b

    L_9306:
        and.a $00d5,x

        .byte $23,$34,$6c,$f1,$1b

    L_930e:
        .byte $91,$4d,$ec,$cf,$1d,$83
        .byte $99,$83,$00,$af,$21,$d1,$00,$32,$00,$02,$33,$4a,$cf,$05,$b9,$c0
        .byte $0e,$4b,$9e,$62,$7e,$26,$78,$30,$20,$05,$36,$db,$3c,$9e,$8d,$30
        .byte $46,$66,$d9,$e0,$b7,$3a,$41,$31,$00,$51,$68,$58,$b3,$c9,$ea,$41
        .byte $69,$4a,$8c,$18,$19,$c1,$b5,$91,$9c

    L_934d:
        rti 

        .byte $27,$dd,$60,$03,$48,$01,$88,$a5,$c4,$23,$68,$67,$9d,$58,$82

    L_935d:
        .byte $33,$34
        .byte $b1,$a4,$a8,$60,$fb,$83,$80,$dc,$e0,$a2,$74,$13,$22,$a3,$01,$62
        .byte $10,$6c,$54,$e0,$92,$52,$d6,$b1,$09,$dc,$8e,$3c,$4e,$23,$21,$b8
        .byte $8c,$26,$1c,$00,$90,$71,$bf,$39,$e5,$8e,$11,$96,$1e,$c2,$5c,$0c
        .byte $51,$41,$c4,$00,$62,$98,$e5,$cc,$5a,$11,$91,$08,$27,$56,$c8,$a6
        .byte $ba,$48,$38,$c1,$09,$0c,$c5,$63,$b0,$43,$1a,$43,$e0,$d0,$65,$80
        .byte $00,$62,$80,$38,$12,$c0,$30,$e0,$29,$40,$54,$ce,$02,$80,$a0,$c0
        .byte $50,$31,$40,$63,$80,$06,$38,$1c,$4f,$d8,$03,$21,$45,$a1,$d2,$41
        .byte $a1,$42,$2c,$1c,$4a,$08,$8e,$81,$27,$03,$8f,$16,$2b,$81,$f8,$7a
        .byte $29,$8e,$e2,$01,$c0,$2e,$00,$0c,$46,$52,$30,$86,$63,$80,$50,$0e
        .byte $23,$1c,$c5,$00,$70,$18,$e0,$0e,$05,$f2,$13,$bb,$a0,$49

    L_93fd:
        cmp $01
        sei 

        .byte $80,$ac,$70,$38,$80,$46,$74,$16,$35,$84,$67,$41,$62,$e7,$85,$d0
        .byte $74,$20,$02,$1e

    L_9414:
        .byte $0c,$10,$c0
        .byte $09,$a5,$01,$40,$c5,$19

    L_941d:
        .byte $d3,$1c
        .byte $01,$91,$8a,$0a,$61,$ce,$3c,$85,$c0,$02,$82,$f9,$09,$85,$d0,$20
        .byte $8d,$7d,$84,$78,$ca,$f0,$91,$c0,$14,$db,$4c,$7b,$0c,$0e,$21,$c4
        .byte $60,$0c,$e1,$03,$a1,$38,$02

    L_9446:
        txs 
        cpy $ac
        eor ($e5),y

    L_944b:
         .byte $3c,$2b,$ab,$0c

    L_944f:
        sei 

        .byte $12,$e2,$9a,$b0,$f7,$1a,$49,$18,$a6,$38,$03,$80,$99,$00,$c2,$51
        .byte $68,$74,$90,$7d,$69,$35,$ec,$50,$0a,$00,$08,$cd,$9b,$1f,$d5,$8a
        .byte $00,$c8,$29,$ac,$ab,$1f,$4d,$54,$53,$3d,$a0,$6e,$9a,$81,$2e,$23
        .byte $36,$e9,$ae,$ac,$70,$8d,$a9,$62,$a0,$19,$04,$6b,$ac,$7f,$55,$6a
        .byte $38,$b4,$3c,$f8,$03,$ea,$ea

    L_9497:
        .byte $23,$47,$6b
        .byte $0e,$14,$44,$70,$62,$b0,$76,$12,$33,$4e,$c7,$ea,$e2,$01,$90,$5c
        .byte $d8,$06,$3d,$31,$18,$e9,$83,$f5,$60,$d8,$e9,$1e,$3b,$40,$8c,$a3
        .byte $63,$d1,$12,$ec,$8a,$6b,$92,$b1,$aa,$c1,$d9

    L_94c5:
        .byte $00,$0b,$80,$00
        .byte $11,$9a,$f6,$3d,$10,$30,$8a

    L_94d0:
        ror 
        ora L_aa86 + $9,x
        cmp ($86,x)
        cli 
    L_94d7:
        asl $11
        ora $b150,y
        sec 

        .byte $67,$2c,$c7,$59

    L_94e1:
        asl 

        .byte $b3,$1d,$98,$84,$1c,$09,$cf,$31,$87,$7d,$6a,$61,$f9,$48,$73

    L_94f1:
        .byte $00,$30,$00,$64,$6f
        .byte $19,$97,$94,$0c,$cb,$ca,$9a,$03,$78,$92,$03

    L_9501:
        ldy $01
        cpy #$e2
        ora ($c0,x)
        cmp ($ef,x)
        txs 
        pha 

        .byte $03,$23,$78

    L_950e:
        sbc #$26

        .byte $80,$30,$b3,$2f,$2e,$00,$01

    L_9517:
        ldy L_e200,x
        adc ($00),y
        iny 
        dec L_1df5 + $b,x
        sbc L_617f + $1,y

        .byte $62,$b8,$a6,$44,$64,$ab,$1e,$92,$6f,$00,$90,$42,$fc,$19,$81,$4d
        .byte $79,$19,$04,$91,$e2,$7b,$e6,$01,$c0,$74,$84,$66,$45,$8f,$8c,$30
        .byte $b7,$8e,$90,$07,$10,$46,$ae,$c2,$eb,$f0,$89,$7d,$f3,$00,$e7,$26
        .byte $40,$38,$05,$7c,$58,$46,$71,$99,$04,$f0,$05,$21,$85,$60,$4b,$18
        .byte $3f,$46,$e2,$38,$81,$90,$71,$3e,$02,$92,$00,$13,$45,$62,$03,$58
        .byte $80,$e9,$36,$4e,$eb,$78,$32,$68,$14,$d7,$19,$8f,$be,$a4,$9d,$c4
        .byte $03,$88

    L_9585:
        sta $9a11,y
        dec $42,x

        .byte $32,$68,$01,$2a,$01,$37,$88,$e0,$33,$bd,$48,$8c,$84,$64,$08,$17
        .byte $4b

    L_959b:
        dey 
        ldx $a5
        cli 
        sbc $24,x
        jmp (L_4bf5 + $b)

        .byte $a6,$83,$d7,$89,$b3,$32,$f2,$b7,$9c,$70,$01,$29,$c4,$03,$94,$29
        .byte $ad,$63,$1e,$41,$01,$32,$29,$af,$b3,$1f,$37,$31,$3d,$f1,$11,$99
        .byte $86,$3d,$cf,$1c,$44,$d0,$00

    L_95cb:
        cmp $0a
        adc L_3ed6
        rol 

        .byte $4f,$88,$c2,$00,$37,$80,$4d,$03,$df,$11,$19,$92,$63,$ca,$04,$a0
        .byte $06,$17,$48

    L_95e4:
        .byte $5a,$10,$ec
        .byte $7d,$e6,$04,$2c,$50,$8c,$8e,$64,$23,$80,$1c,$78,$ba,$40,$60

    L_95f6:
        .byte $e1,$62,$21,$e0,$73,$1c,$42
        .byte $c4,$12,$52,$82,$33,$0a,$8b,$aa,$92,$63,$80,$de,$9e,$0d,$19,$a1
        .byte $1a,$f2,$18,$02,$9b,$71,$90,$9c,$2e,$e9,$21,$19,$8e,$64,$0c,$0c
        .byte $1e,$c4,$67,$09,$90,$61,$ac,$e0,$07,$50,$84,$49,$01,$34,$08,$2c
        .byte $80,$2f,$01,$b6,$f0,$46,$5c,$b2,$0e,$7f,$13,$e1,$b1,$36,$3b,$3c
        .byte $56,$63,$98,$f6,$84,$83,$89,$29,$6b,$58

    L_9647:
        .byte $83,$d3,$00
        .byte $a0,$09,$25,$01,$5e,$32,$04,$92,$81,$58,$83,$81,$dc,$84,$ee,$41
        .byte $c4,$80,$02,$94,$05,$57,$cb,$00,$48,$49,$c0,$11,$95,$4b,$17,$28
        .byte $53,$5b,$66,$3f,$c9,$eb,$17,$c3,$70,$14,$02,$35,$b5,$88

    L_9678:
        asl 

        .byte $af,$27,$3c,$19,$00,$d7,$cf,$2c,$12,$c0,$50,$44,$80,$23,$05,$8f
        .byte $8d,$7c,$84,$9c,$02,$94,$11,$09,$38,$05,$00,$a6,$a9,$56,$7c,$41
        .byte $1f,$80,$a0,$89,$00,$46,$6e,$18,$f8,$d0,$01,$10,$83,$0f,$92,$80
        .byte $24,$18,$8d,$9d,$0c,$8c,$88,$41,$86,$4c,$a0,$14,$16,$40,$5c,$05
        .byte $04,$c0,$4c,$00,$0a,$23,$25,$67,$9c,$53,$59,$a6,$7e,$93,$4d,$12
        .byte $70,$03,$3b,$00,$04,$66,$31,$9f,$aa,$23,$3d,$cc,$fd,$22,$97,$01
        .byte $40,$53,$79,$8a,$eb,$2c,$5a,$63,$8b,$42,$0d,$9f,$49,$05,$40,$19
        .byte $c4,$ef,$0c,$c0,$02,$d0,$f7,$33,$f4,$c3,$ba,$f9,$27,$00,$b8,$05
        .byte $35,$a3,$63,$e9,$84,$46,$68,$d0,$ca,$92,$77,$9c,$01,$92,$27,$72
        .byte $0c,$32,$80,$52,$82,$58,$0a,$29,$ae

    L_9712:
        .byte $93,$3f
        .byte $4c,$9e,$40,$51,$19,$c8,$67,$fa,$b3,$8a,$80,$30,$3f,$16,$01,$48
        .byte $75,$96,$34,$c9,$d5,$24,$51,$68,$63,$d9,$f2,$51,$a5,$7e,$50,$0a
        .byte $02,$cc,$04,$c0,$59,$c4,$dc,$83,$13,$73,$64,$46,$8e,$b1,$00,$8c
        .byte $c1,$a1,$94,$02,$e6,$c7,$b3,$f4,$81,$d4,$00,$60,$c4,$23,$27,$d9
        .byte $f3,$2b

    L_9756:
        cmp $f8,x
        ora $ea,x
        beq L_9764

        .byte $cf,$1b,$3f,$a4,$46,$52,$21,$9c

    L_9764:
        sbc ($19),y

        .byte $b0,$58,$8a,$20,$ad,$3a,$ec,$fd,$50,$35,$02,$68,$a5,$88,$d8,$96
        .byte $2e,$38,$49,$86,$5a,$ce,$c7,$81,$0d,$42,$f9,$3c,$e0,$11,$84,$c7
        .byte $cd,$16,$86,$21,$9f,$71,$ba,$42,$40,$08,$f3,$57

    L_9792:
        sta $ac

    L_9794:
         .byte $02,$37
        .byte $35,$da,$5f,$00,$8c,$8a,$67,$d6,$56,$67,$00,$61,$2e,$24,$00,$c8
        .byte $dc,$94,$11,$04,$6a,$88,$61,$44,$24,$e4,$2d,$62,$0f,$0e,$12,$0e
        .byte $06,$12,$0e,$24,$e0,$90,$64,$ee,$41,$b7,$34,$6f,$00,$10,$6d,$88

    L_97c6:
        pha 

        .byte $00,$da,$99,$d0,$c3,$5b,$8c,$9a,$fe,$10,$84,$9d,$c8,$30,$c0,$01
        .byte $4b,$b2,$29,$0d,$00,$50,$7d,$63,$69,$a5,$22,$39,$da,$76,$82,$80
        .byte $2c,$82,$58,$b4,$45,$43,$68,$71,$d1,$20,$e7,$83,$46,$d0,$bb,$5b
        .byte $41,$19,$df,$67,$8f,$3b,$48,$01,$10,$83,$26,$12,$12,$70,$8c,$ed
        .byte $2e,$c7,$b5,$b4,$01,$40

    L_980d:
        .byte $d2,$1a,$04,$da
        .byte $e9,$fc,$49,$23,$23,$a3,$b4,$03,$89,$b4,$03,$20,$49,$38,$ad,$a0
        .byte $06,$12

    L_9823:
        sbc $3600

        .byte $80,$0e,$6a,$dc,$61,$da,$01,$ce,$da,$00,$14,$13,$6f,$93,$b9,$1d
        .byte $02,$61,$11,$9c,$b4,$30

    L_983c:
        .byte $9c
        .byte $d5,$ba,$dd,$7c,$23,$3b,$cb,$b3,$08,$cf,$6b,$3e,$d4,$cb,$2e,$0b
        .byte $e4,$24,$01,$68,$60,$19,$fa,$0d,$e0,$81,$2d,$6e,$be,$ad,$00,$01
        .byte $29,$7c,$1d,$2c,$46,$94,$b1,$30,$a6,$b3,$6c,$fb,$30,$e7,$cc,$28
        .byte $0b,$33,$00,$8c,$a4,$67,$e0,$ad,$d7,$b3

    L_9877:
        ora $a1
        jmp (L_d2c0 + $f)

    L_987c:
         .byte $0d,$52,$3c,$1c
        .byte $18,$36,$94,$46,$66,$d9,$fa,$53,$04,$65,$e3,$3e,$19,$82,$9a,$a7
        .byte $fc,$93,$49,$4b,$99,$65,$b5,$28,$2c,$e0,$2b,$6a,$5d,$ba,$45,$01
        .byte $44,$69,$9f,$88,$23,$38,$6c,$fa,$5c,$53,$64,$fe,$49,$04,$a9,$fe
        .byte $1b,$e2,$9a,$84,$67,$ce,$92,$da,$08,$47,$9f,$00,$93,$86,$cf,$86
        .byte $23,$a1,$38,$17,$c0,$01,$ba,$fd,$56,$a8,$5b,$40,$09,$78,$90,$31
        .byte $59,$f6,$36,$49,$1c,$cf,$20,$28,$8c,$ef,$ae,$ea,$ce,$9c,$2b

    L_98df:
        lsr L_e08f
        nop 
        ldy $01
        eor $4001,y

        .byte $0c,$05,$c0,$01,$1b,$f2,$ec,$ca,$c0,$92,$02,$b0,$24,$80,$ac,$0c
        .byte $e0,$15,$7c,$56,$d0,$00,$96,$0b,$22,$33,$9c,$c7,$d2,$00,$8d,$f9
        .byte $76,$f0,$56,$9c,$ac,$88,$49,$ca,$c8,$84,$9c,$ac,$01,$57,$a5,$c3
        .byte $f8

    L_9919:
        .byte $7a,$22
        .byte $20,$8c,$9d,$5d,$9d,$cc,$9d,$80,$b1,$04,$66,$71,$76,$1c,$24,$1f

    L_992b:
        sta $31cf,y

        .byte $93,$e3,$21,$94,$8f,$07,$13,$0f,$ba,$91,$e0,$4f,$99,$e7,$30,$48
        .byte $32,$40,$e6,$8c,$00,$8c,$b0,$42,$29,$02,$41,$84,$46,$4b,$a1,$a3
        .byte $12,$00,$19,$37,$79,$95,$03,$b6,$02,$ec,$f8,$34,$12,$a7,$c0,$8c
        .byte $65,$53,$ee,$f2,$33,$01,$70,$01,$3e,$a4,$78,$00,$f3,$bc,$e0,$c0
        .byte $29,$bb,$d9,$f0,$2a,$95,$cd,$f8,$76,$13,$0b,$85,$39,$95,$72,$00
        .byte $9f,$00,$18,$a4,$f9,$5c,$80,$32,$ac,$9b,$bc,$07,$6d,$db,$52,$3c
        .byte $02,$9a,$fb,$33,$f1,$80,$ed,$a3,$19,$50,$0c

    L_9999:
        .byte $9e,$d3,$fc,$00
        .byte $ca,$b1,$4a,$47,$81,$95,$2f,$00

    L_99a5:
        and #$1e

        .byte $04,$60,$1a,$86,$a1,$93,$77,$8a

    L_99af:
        .byte $23,$2f,$bf,$2f
        .byte $81,$0f,$c2,$07,$c0,$a4,$78,$38,$8c,$28,$c6,$4d,$de,$01,$51,$80
        .byte $64,$dd,$e6,$61,$85,$46,$01,$3e,$8c,$28,$22,$39,$93,$80,$ed,$b2
        .byte $a0,$65,$51,$80,$df,$90,$13,$40,$06,$15,$23,$c0,$8c,$28,$1c,$8c
        .byte $6b,$7e,$e1,$15,$d5,$c9,$3e,$f3,$94,$0f,$3b,$c1,$e8,$73

    L_99f1:
        bvc L_9a05

        .byte $0c,$30,$34,$29,$a7,$83,$87,$9c,$a0,$e0,$91,$48,$e0,$72,$12,$29
        .byte $10,$3b

    L_9a05:
        adc $72
        ora $6db7,x
        pha 

        .byte $f0,$23,$0a,$e4,$23

    L_9a10:
        asl $4b

        .byte $3c,$d1,$8e,$44,$b3,$20,$27,$dd,$bf,$f9,$80,$9d,$4e,$a3,$38,$27
        .byte $53,$a0,$6a,$0b,$c1,$a8,$6a,$1d,$7e,$18,$14,$38,$00,$64,$9b,$cc
        .byte $1c,$02,$db,$c3,$73,$2a,$d4,$15,$95,$03,$a2,$e8,$b3,$0c,$2b,$a3

    L_9a42:
        iny 
        php 

        .byte $c2,$8a,$42,$d3,$f4,$61,$19,$48,$8c,$19,$25,$f3,$09,$04,$64,$05
        .byte $95,$21,$40,$9f,$73,$57,$cc,$c3,$0a,$be,$5e,$a3,$00,$50,$50,$46
        .byte $71,$28,$04,$64,$1a,$ef,$87,$32,$a3,$02,$3f,$8c,$c8,$00,$5c,$0c
        .byte $aa

    L_9a75:
        .byte $7c,$03
        .byte $0a,$7c,$18,$0a,$f0,$6c,$9b,$99,$f4,$ba,$91,$e0,$00,$c8,$8c,$f7
        .byte $cc,$53,$5f,$26,$7c,$08,$f7,$9e,$21,$07,$2f,$bc,$e1,$19,$f7,$5d
        .byte $f5,$6e,$c0,$01,$e7,$07,$be,$76,$41,$f3,$89

    L_9aa2:
        adc L_bbd2 + $b,y
    L_9aa5:
        adc $f864,y
        ora ($2c,x)
        php 

        .byte $c2,$a8,$73,$14,$3e,$9d,$aa,$49,$f5,$fc,$3b,$30,$ed,$83,$df,$31
        .byte $19,$0c,$c7,$89,$db,$6a,$00,$e4,$60,$79,$d9,$57,$9c,$05,$00,$a4
        .byte $65,$63,$cd,$89,$de,$3d,$06,$55,$93,$77,$95,$c0,$f7,$5e,$b1,$30
        .byte $92,$52,$7d,$66,$b3,$72,$16,$6e,$da,$15,$db,$72,$22,$0a

    L_9ae9:
        ror 
        adc $77,x

        .byte $54,$44,$9c,$b3,$59,$a5,$fc,$31,$14,$fb,$da,$f3,$18,$72,$d3,$e6
        .byte $5a,$98

    L_9afe:
        .byte $73,$9e
        .byte $94,$fb,$7e,$39,$6a,$ad,$3a,$c7,$2d,$95,$4f,$80,$0f,$3b,$ce,$a4
        .byte $78,$1e,$70,$7a,$65,$40,$d7

    L_9b17:
        clv 

        .byte $c2,$32

    L_9b1a:
        sta $da,x

        .byte $9b,$e9,$e9,$47,$b7,$e3,$88,$aa,$d6,$0f,$7c,$3c,$30,$ed,$bb,$6c
        .byte $9b,$bc,$ed,$a7,$da,$64,$7b,$7e,$aa,$02,$99,$5f,$7b,$06,$02,$fa
        .byte $f5,$ac,$0e,$32,$33,$02,$bd,$af,$f5,$ad,$3e,$ca,$81,$e7,$4f,$b5
        .byte $00,$03,$50,$ca,$83,$5a,$7f,$d0,$0a,$04,$52,$e8,$46,$d8,$37,$5d
        .byte $18,$af,$03

    L_9b5f:
        lsr $7f05,x
        lda $a86c

        .byte $fa,$40,$76,$d9,$5d,$63,$9c,$ca,$fa,$14,$d8,$8f,$7b,$1c,$3f,$5e
        .byte $b5,$a8,$0b,$47,$19,$c6,$46,$60,$fe,$78,$69,$bb,$cd,$43,$cf,$ad
        .byte $3e,$07,$90,$2f,$7c,$67,$c0,$9f,$6f,$c7,$13,$5b,$16,$fb,$b7,$e1
        .byte $5f,$15,$7e,$eb,$65,$40,$32,$3b,$7a,$d9,$50,$36,$ac,$ca,$81,$95
        .byte $00,$c2,$67,$68,$60,$35,$fb,$d1,$ac,$6c,$54,$d1,$68,$62,$9e,$f9
        .byte $cc,$89,$de,$74,$f8,$13,$e0,$06,$b9,$de,$01,$ac,$00,$52,$3c,$09
        .byte $f1,$4d,$5b,$3d,$e9,$36,$44,$1a,$fd,$97,$02,$bd,$5e,$a6,$00,$1d
        .byte $be,$b9,$55,$23,$c0,$6f,$c3,$2c,$a8,$35,$80,$46,$fe,$ed,$1c,$aa
        .byte $fc,$05,$04,$bd,$72,$e2,$08,$d0,$ff,$24,$d3,$2d,$43,$2a,$00,$32
        .byte $6e,$f6,$b1,$d9,$09,$09,$3a,$f2,$bc,$46,$73,$5d,$ae,$bc,$c0,$12
        .byte $0e,$24,$0d,$20,$4c,$e9,$52,$3c,$1a,$40

    L_9c0f:
        .byte $6e,$1b,$69,$53
        .byte $28,$a8,$1e,$0e,$8a,$f0,$8d,$55,$0c,$7e,$60,$2a,$be,$f0,$c8,$05
        .byte $7d,$90,$56,$24,$a6,$4d,$de,$ac,$42,$4a,$01,$40,$8a,$45,$2e,$95
        .byte $e5,$5e,$34,$28,$cf,$7c,$c0,$5c,$07,$ea,$02,$00,$24,$94,$00

    L_9c42:
        asl 
        ror 

        .byte $89,$0c,$93,$eb,$01,$18,$01,$1a,$43,$20,$79,$fc,$1d,$ae,$c1,$ef
        .byte $98,$05,$35,$06,$bb,$38,$81,$a4,$05,$c0,$8d,$18,$4a,$00,$23,$00
        .byte $3b,$2f,$3f,$ba,$eb,$31,$ce,$42,$ac,$c6,$44,$7e,$13,$91

    L_9c72:
        and $66,x
        and vColorRam + $4e,y
        sta $ef05

        .byte $47,$db

    L_9c7c:
        ora L_230c,y

        .byte $6b,$1b,$ce,$d2,$18,$61,$11,$9c,$e4,$37,$5e,$20,$09,$06,$17,$30
        .byte $46,$3a,$ef,$ae,$02,$e0

    L_9c95:
        adc #$00

        .byte $d2,$12,$1d,$d3,$48,$12,$4e,$03,$48,$00,$34,$85,$e6,$02,$88,$cd
        .byte $c3,$b4,$1f

    L_9caa:
        jsr L_b78f + $1

        .byte $5f,$00,$a4,$6c,$18,$de,$0c,$90,$46,$76,$90,$46,$6c,$1e,$fa,$4e
        .byte $64,$ee,$62,$33,$cb,$f8,$32,$80,$54,$ce,$35,$ba,$f5,$a4,$28,$00
        .byte $d1,$fc,$32,$9b,$cf,$f1,$e9,$4e,$69,$01,$80,$7a,$50,$4b,$f8,$2e
        .byte $51,$88,$09,$c0,$50,$39,$ab,$7e,$42,$9a

    L_9ce7:
        .byte $da,$0c,$52,$30,$60
        .byte $28,$0a,$d2,$00,$01,$24,$0f,$7a,$0c,$f5,$00,$c1,$80,$05,$04,$85
        .byte $bd,$a0,$0c

    L_9cff:
        sta L_1a20
        rti 

        .byte $01,$06,$50,$17,$00,$e8,$32,$80,$b2,$e8,$10,$46,$90,$c8,$30,$40
        .byte $68,$16,$fa,$98,$a4,$23,$28

    L_9d1a:
        .byte $00,$92,$0f,$7c,$22,$22,$82
        .byte $20,$a6,$c3,$fd,$43,$57,$be,$7c,$46,$14,$1b,$5c,$83,$6b,$90,$6d
        .byte $72,$dd,$6e,$c5,$31,$59,$84,$65,$33,$3e,$71,$19,$ca,$5d,$d5,$94
        .byte $06,$fc,$1e,$8a,$a6,$42,$13,$48,$30,$a4,$46,$16,$90,$0d,$71,$70
        .byte $08,$ce,$72,$19

    L_9d55:
        cmp $11,x
        sta L_3454,x
        adc ($48,x)
    L_9d5c:
        adc ($1d),y

        .byte $d0,$88,$cc,$82,$72,$69,$f6,$98,$fe,$11,$09,$39,$ae,$00,$1a,$e0
        .byte $14,$05,$41,$81,$a4,$11,$9a,$67,$74,$0d,$70,$8e,$1c,$4b,$ac,$33
        .byte $74,$dd,$31,$43,$ee,$50,$17,$4f,$18,$80,$8c,$91,$64,$05,$2d,$9a
        .byte $5b,$ad,$d8,$a9,$d8,$73,$80,$83,$00,$10,$8c,$a1,$5a,$48,$84,$80
        .byte $0f,$7c,$c5,$a1,$ee,$76,$a6,$e1,$7a,$78,$2e,$13,$5b,$ad,$f9,$00
        .byte $08,$31,$19,$60,$ee,$8d,$ae,$06,$68,$82,$33,$2e,$f7,$ba,$5e,$f9
        .byte $95,$06,$07,$71,$d3,$23,$48,$57,$35,$6e,$b7,$d4,$84,$65,$1b,$21
        .byte $01,$2b,$e5,$00,$18,$5a,$e2,$e0,$2a,$0f,$df,$32,$e0,$03,$5c,$07
        .byte $a9,$51,$9d,$8d,$6e,$32,$3b,$e1,$28,$00,$0c,$cd,$23,$14,$c5,$20
        .byte $d8,$a1,$86,$21,$27,$03,$dd,$71,$1a,$c3,$3f,$25,$67,$6c,$61,$59
        .byte $b5,$c8,$56,$b9,$66,$3c,$2f,$6a,$f9,$2c,$e6,$ad,$c7,$01,$7a,$ed
        .byte $d7,$cb,$d1,$50,$9c,$94,$46,$53,$bb,$5d,$71,$ad,$c7,$2c,$24,$80
        .byte $d0,$13,$a7,$15,$f5,$69,$4a,$4c,$01,$bf,$83,$e1,$9a,$5a,$72,$00
        .byte $c8,$55,$b8,$eb,$17,$04,$49,$49,$11,$90,$00,$48,$8c,$20,$03,$40
        .byte $96,$5e,$80,$64,$2b,$9a,$b7,$5b,$af,$9c,$d0,$c8,$31,$99,$40,$96
        .byte $9d,$18,$c4,$e8,$c2,$0f,$5e,$cc,$ca,$ee,$ac,$41,$19,$55,$71,$af
        .byte $14,$d8,$57,$0f,$54,$ad,$10,$c8,$cc,$30,$a0,$15,$52,$02,$ec,$5e
        .byte $a5

    L_9e6f:
        .byte $14
        .byte $18,$d6,$eb,$7d,$45,$5b,$8e,$21,$40,$02,$ad,$c6,$46,$61,$85,$5a
        .byte $79,$cb,$55,$f0,$0a,$b7,$19,$17,$c5,$11,$b3,$ae,$d5,$56

    L_9e8e:
        .byte $52

    L_9e8f:
        adc L_086e + $2d2,y

    L_9e92:
         .byte $dc,$6b,$87,$3a,$5c,$e7
        .byte $ea,$bd,$c0,$00,$1d,$ae,$27,$5f,$2f,$4a,$01,$c4,$48,$8c,$95,$10
        .byte $df,$a0,$ab,$22,$9b,$a1,$70,$23,$33,$0c,$2b,$9b,$ab,$1e,$ae,$45
        .byte $73,$5d,$ed,$b0,$44,$14,$d6,$0c,$6a,$a7,$09,$3a,$23,$2f,$57,$15
        .byte $74,$08,$c8,$d5,$c0,$97,$a0,$c6,$9e,$0d,$82,$9b,$cd,$70,$66

    L_9ed7:
        tya 
        sty $21d7
        eor L_d06f + $3
        lsr L_9a10
        and ($91,x)
        ror L_4b32
        ora ($96),y

        .byte $0b,$83,$e0,$06,$3d,$5f,$be,$0e,$0b,$d0,$14,$12,$c5,$37,$6a,$ef
        .byte $a8,$8a,$01,$19,$c2,$b9,$20,$46,$80

    L_9f01:
        clv 
        adc ($b9),y

        .byte $63,$5b,$8c,$22,$33,$1b,$f9,$e7,$7a,$66,$0e,$6d,$85,$89

    L_9f12:
        tay 
        cmp $c7
        lda $00,x

        .byte $50,$b6,$79,$40,$02,$bf,$f8,$3e,$71,$c4,$5f,$60,$c0,$5c,$05,$68
        .byte $17,$a0,$18,$6c,$88,$c8,$47,$76,$2c,$06,$80,$a2,$33,$2c,$bb,$72
        .byte $ab,$49,$27,$90,$00,$2f,$63,$98,$78,$42,$60,$c6,$be,$4b,$39,$ba
        .byte $8a,$cd,$14,$00,$09,$07,$3a,$00,$04,$6f,$ce,$d0,$85,$21,$b6,$63
        .byte $cd,$96,$84,$2c,$12,$16

    L_9f5d:
        sbc $c6

        .byte $5c,$00,$2e,$38,$f8,$40

    L_9f65:
        .byte $30,$6a
        .byte $2e,$00,$34,$a0,$69,$40

    L_9f6d:
        .byte $29,$af,$27
        .byte $e1,$68,$03,$9b,$a9,$69,$8d,$7c,$55,$bc,$42,$12,$72,$dc,$73,$a2
        .byte $10,$93,$90,$b1,$08,$4e,$f8,$48,$03,$a4,$ee,$d1,$9d,$39,$cd,$d2
        .byte $6d,$2e,$a1,$86,$15,$81,$87,$01,$97,$5a

    L_9f9a:
        tya 

        .byte $72,$99,$76,$5d,$d4,$58,$32,$fa,$70,$69,$6e,$30,$03,$62,$64,$00
        .byte $b0,$07,$f4,$84,$00,$11,$88,$e0,$0c,$9b,$fc,$01,$33

    L_9fb8:
        .byte $ff,$63
        .byte $2e,$cb,$e0,$07,$bb,$dc,$08,$c5,$86,$cb,$00,$02,$c3,$60,$11,$20
        .byte $36,$7c,$22,$10,$cb,$80,$61,$fe,$0d,$80,$19,$36,$32,$ec,$bb,$a9
        .byte $ed,$d4,$d8,$cb,$81,$97,$75,$01,$b1,$97,$65,$dd,$40,$2c,$01,$63
        .byte $62,$30,$00

    L_9fed:
        cli 

        .byte $23,$80,$fa,$8d,$60,$00,$60,$02,$31,$97,$f6,$cb,$b7,$00,$47,$03
        .byte $7f,$8f,$ee,$a2,$c2,$44,$15,$3f,$8e,$f7,$87,$f8,$6e,$00,$0d,$80

    L_a00e:
        adc $f0
        ora ($33,x)
        lda ($18),y

        .byte $0c,$1e,$f9,$a6,$76,$00,$1f,$c0,$dc,$6c,$67,$5e

    L_a020:
        .byte $0e,$9d,$80,$d8,$05,$87,$f0,$0e
        .byte $06,$ff,$0c,$b8

    L_a02c:
        asl $1d

        .byte $82,$33

    L_a030:
        asl $f7

        .byte $d0,$65

    L_a034:
        cmp $5077,y

        .byte $03,$0e,$c4,$77,$f4,$60,$1b,$82,$d4,$36,$00,$03,$f8,$06,$48,$e5
        .byte $a5,$c0,$0f,$7a,$00,$cb,$ec,$6e,$16,$0c,$b8,$13,$37,$1c,$0c,$df
        .byte $e0,$16

    L_a059:
        .byte $37,$80,$64,$b2,$8f
        .byte $84,$48,$cb,$0d,$c0,$06,$45,$80,$8c,$ae,$6b,$52,$ee,$a3,$2f,$b0
        .byte $00

    L_a06f:
        cmp L_086e + $2f2,y

        .byte $0f,$ec,$be,$c0,$37,$00,$19,$19,$75,$82,$c3,$fe,$c0,$23

    L_a080:
        .byte $13
        .byte $26,$1d,$3e,$68,$e4,$c8,$16,$07,$01,$94,$cb,$0d,$fe,$31,$a4,$48

    L_a091:
        cpy $75
        cld 

        .byte $00

    L_a095:
        ora L_6c70,y

        .byte $b2,$9f,$80,$7c,$65,$f6,$7b,$65,$c0,$38,$09,$e5,$10,$99,$66,$84
        .byte $64,$fa,$e1,$3d,$c8,$08,$c4,$cd,$8c,$3c,$19,$aa,$64,$08,$c6,$e1

    L_a0b8:
        .byte $97
        .byte $d9,$b3,$df,$30,$5d,$ff,$b2,$e8,$11,$c8,$cd,$f8,$d6,$e3,$81,$6b
        .byte $7f,$80,$6f,$fd,$f8,$c0,$6c,$1c,$0f,$7c,$ee,$84,$2f,$c3,$b7,$18
        .byte $64,$88,$c9,$ff,$03,$40,$b7,$b4,$8e

    L_a0e2:
        .byte $02,$34
        .byte $c5,$97,$67,$1b,$3e,$da,$a1,$97,$58,$7b,$e6,$05,$85,$df,$e0,$06
        .byte $c0,$27,$46,$4b,$0c,$d6,$35,$be,$af,$0b,$10,$21,$b9,$bd,$08,$8a
        .byte $86,$5f,$df,$3c,$17,$41,$63,$65,$d0,$23,$37,$b4,$4d,$10,$cf,$28
        .byte $08,$c3,$e1,$18,$99,$03,$38,$80,$40,$37,$38,$31,$37

    L_a121:
        sbc ($ac,x)
        and ($03),y
        cmp L_9a75,x
        cmp L_5997
        sty $ba8c
    L_a12e:
        cmp L_6c65 + $2

        .byte $73,$96,$63,$ac,$cb,$ac,$c6,$47,$b4,$24,$1f,$7e,$e4,$68,$c4,$66
        .byte $ad,$0c,$d0,$f7,$14,$d7,$35,$76,$15,$21,$40,$3a,$d3,$30,$15,$5f
        .byte $81,$5e,$5c,$02,$33,$a8,$c4,$04,$99,$41,$a4,$11,$b6,$bb,$69,$de
        .byte $f3

    L_a162:
        and L_608e,x
    L_a165:
        sty L_fcba

        .byte $c2,$f7,$c2,$f6,$39,$84,$f2,$8d,$45,$0c,$8b,$a2,$3b,$3e,$17,$cd
        .byte $50,$ce,$16,$92,$88,$cf,$bb,$ba,$93,$d2,$af,$d2,$0c,$05,$03,$4a
        .byte $0d,$20,$d2,$55,$7e,$9c,$1a,$45,$69,$28,$cf,$88,$ce,$b3,$84,$2f
        .byte $22,$33,$8e,$c3,$25,$66,$2b,$e6,$2b,$c0,$50,$08,$de,$ff,$02,$1f
        .byte $bc,$2e,$90,$fd,$24,$a0,$d3,$83,$48,$bd,$a5,$ff,$5c,$02,$a9,$9b
        .byte $07,$5c,$0a,$f2,$80,$75,$8a,$01,$84

    L_a1c1:
        ldx SCREEN_BUFFER_0 + $358
        eor $541a,y
        pla 
        sty L_2ef5
        cmp $4039,y
        dey 

        .byte $23,$57,$62,$00,$e7,$02,$b1,$07,$2f,$01,$a1

    L_a1da:
        sed 
        jmp L_070d + $3

        .byte $10,$a5,$00,$f0,$04,$83,$97,$e4,$a0

    L_a1e7:
        php 
        sty L_569c
        sbc $18,x
        sta L_ddf7 + $2
        ldy $23
        and $60e8,y

        .byte $2b,$c4,$64,$b8,$fa,$8a,$6b,$d9,$fa,$b8,$91,$a0,$18,$53,$f7,$0e
        .byte $21,$51,$b8,$04,$64,$77

    L_a20b:
        sbc #$ae

    L_a20d:
         .byte $64,$00
        .byte $05,$cc,$11,$ae,$fe,$79,$44,$66,$16,$e3,$85,$3c,$b6,$37,$0d,$e4
        .byte $53,$68

    L_a221:
        .byte $33
        .byte $e6,$be,$55,$79,$40,$54,$0f,$c4,$31

    L_a22b:
        eor $9061

        .byte $e7,$a7

    L_a230:
        bmi L_a24a
        asl 

        .byte $af

    L_a234:
        lsr $94

        .byte $02,$d0,$fb,$33,$f7,$fa,$a4,$84,$65,$da,$ed,$a6,$16,$85,$90,$ce
        .byte $92,$6b,$c2,$42

    L_a24a:
        adc $af98,y
        tya 

        .byte $02,$de,$11,$92,$10,$b7,$44,$24,$e5,$7c,$42,$4e,$57,$88,$cd,$4b
        .byte $1f,$1b,$01,$40,$06,$94,$18,$2c,$82,$62,$bd,$1a,$54,$52,$ea,$c0
        .byte $27,$98,$80,$72,$c4,$64,$e3,$1e,$d7,$8b,$42,$59,$ad,$50,$46,$67
        .byte $f0,$70,$99,$0e,$d7,$60,$8a,$6a,$eb,$f4,$66,$bf,$b8,$b4,$2e,$bf
        .byte $55,$8d,$e9,$a3,$ac,$23,$36,$c8,$6a,$b0,$3b,$88

    L_a29a:
        .byte $d7,$50,$fb
        .byte $f0,$68,$e5,$14,$ba,$03,$4b,$83,$03,$4a,$09,$78,$0b,$80,$02,$33
        .byte $ac,$87,$bf,$a4,$03,$26,$91,$19,$bc,$7b

    L_a2b7:
        sbc $e0
        rol L_84e7
        and ($a3,x)
        and L_f284,y

        .byte $02,$e0,$2a,$29,$74,$50,$2b,$15,$8c

    L_a2ca:
        asl $78

        .byte $3a,$53,$2d,$6e,$49,$28,$8d,$97,$f6,$eb,$c2,$32,$69,$85,$04,$42
        .byte $49,$24,$99,$40,$2a,$b0,$00

    L_a2e3:
        lsr $34,x
        ldx #$9b
        eor ($9f),y

        .byte $07,$5e,$73,$43,$19,$f0,$04

    L_a2f0:
        tay 
        lda $d0
    L_a2f3:
        asl 
        txa 
        eor $0103,x
        eor $83,x

        .byte $12,$3c,$18,$2d,$19,$f5

    L_a300:
        .byte $50,$2f,$44,$73,$27,$02,$fb

    L_a307:
        sta L_8384,y

        .byte $27,$9b,$f2,$81,$5a,$49,$06,$19,$ca,$c2,$80,$18,$10,$a9,$63,$09
        .byte $e0,$bc,$54,$01,$91,$a5,$06,$91

    L_a322:
        sty $a5
        lsr $01,x
        cli 

        .byte $5c,$00,$1c,$0b,$20,$d2,$23,$71,$62,$12,$77,$c8,$33,$af,$b8,$09
        .byte $4c,$44,$62,$97,$48,$34,$df,$11,$99,$1b,$80,$96,$00

    L_a344:
        .byte $44
        .byte $11,$9a,$0e,$ca,$a9,$8a,$c2,$00,$17,$84,$41

    L_a350:
        .byte $1b
        .byte $0a,$0e,$35,$f2,$4a,$11,$af,$b1,$ef,$99,$2c,$ab,$0b

    L_a35e:
        ldy $03
        sta L_532f + $1,x
        rts 



    L_a364:
         .byte $76,$11,$8a,$0a,$c4,$f2,$5d,$20,$11,$93
        .byte $c8,$77,$1f,$03,$0f,$87,$07,$b1,$cc,$20,$e5,$f9,$00,$30,$16

    L_a37d:
        sbc L_a806,y
        sty $23,x
        and L_430c,x
        sta $e4
        ldx #$d0

        .byte $d4,$2e,$29,$d2,$14,$b1,$19,$3c,$c7,$da

    L_a393:
        ora ($92),y
        tay 
        adc $07,x

        .byte $90,$4b,$00,$8c,$c2,$c2

    L_a39e:
        bvs L_a322
        eor ($88,x)
        cpy L_105b
        sbc $08
        dec L_2464
        inc $18
        asl $ff
        jmp ($6434)

        .byte $8b,$ba,$72,$88,$d3,$d9,$fe,$9a,$4b,$82,$60,$c8,$2d,$0e,$7c,$2d
        .byte $40,$eb,$23,$1d,$95,$21,$c4,$6c,$fe,$31,$88,$8d,$51,$0f,$0c

    L_a3d0:
        lsr $79
        eor L_086e + $269,x
        bvs L_a37d

        .byte $bb,$10,$8e,$21,$19,$72,$b8,$9a,$23,$31,$cb,$b5,$08,$e5,$61,$24
        .byte $a5,$94,$41,$68,$db,$09,$c2,$49,$31,$fd,$c4,$67,$55,$5b,$d6,$fc
        .byte $02,$80,$7d,$cb,$80,$a0,$1e,$15,$60,$0a,$51,$4d,$6c,$6e,$46,$69
        .byte $85,$35,$97,$67,$d3,$d1,$9c,$c9,$c2,$33,$9d,$09,$a6,$1d,$95,$66
        .byte $05,$60,$8d,$4d,$0e,$e5,$2b,$06,$46,$94,$02,$33,$66,$f1,$46,$80
        .byte $29,$ae,$e2,$1d,$a6,$38,$a6,$b6,$a8,$3b,$8a,$a4,$f1,$46,$e5,$cd
        .byte $50,$f1,$6a,$8c,$aa,$63,$63,$5f,$aa,$ac,$88,$29,$bb,$98,$80,$5f
        .byte $56,$14,$53,$5d,$d8,$47,$00,$a6,$f7

    L_a450:
        .byte $63,$c3,$54,$52,$10,$6b
        .byte $b0,$05

    L_a458:
        sta $238c
        ora ($aa,x)
    L_a45d:
        php 
        sty L_5c91

        .byte $52,$be,$e6,$08

    L_a465:
        .byte $c2,$43,$80
        .byte $84,$9c,$50,$0e,$cc,$42,$11,$cc,$9c,$08,$8e,$61,$09,$38,$53,$54
        .byte $b0,$83

    L_a47a:
        pha 
        ldy #$18
        ror $df
        jsr L_3277 + $5b

        .byte $84,$65,$93,$de,$01,$78,$6c,$06,$42

    L_a48b:
        .byte $84,$02,$80,$64
        .byte $e9,$d0,$03,$0c,$bd,$23,$27,$41,$c4,$00,$b4,$20,$d7,$60,$96,$ed
        .byte $60,$c0,$52,$83,$a0,$e2,$00,$05,$d3,$a7,$a0,$e7,$04,$46,$48,$f6
        .byte $00,$0a,$ac,$56,$14,$aa,$ce,$9d,$30,$60,$e9,$d1,$58,$02,$e9,$e9
        .byte $ab,$f3,$02,$14,$04,$80,$08,$90,$04,$6a,$6b,$8c,$45,$e9,$d3,$04
        .byte $1c,$43,$a7,$41,$19,$3e,$87,$67,$34,$f4,$17,$17,$88,$e1,$58,$50
        .byte $2b,$0a,$29,$0a,$65,$14,$6b,$ac,$2c,$60,$0a,$6b,$18,$a2,$df,$29
        .byte $a5,$e8,$ac,$2f,$4d,$3d,$06,$12,$ab,$30,$14,$0a,$c1,$19,$c7,$5c
        .byte $38,$42,$32,$41,$44

    L_a504:
        .byte $70,$08,$d2,$14
        .byte $40,$69,$7a,$74,$2f,$41,$c4,$11,$98,$a5,$dd,$51,$1b,$5a,$ec,$00
        .byte $14,$d7

    L_a51a:
        cmp $e2,x

        .byte $80,$00,$92,$77,$4e,$8d,$2f,$44,$67,$86,$40,$e0,$0b,$43,$9e,$f7
        .byte $86,$04,$b8,$82,$9a,$9f,$85,$33,$90,$70,$ca,$59,$56,$20

    L_a53a:
        cpx SCREEN_BUFFER_2 + $188

        .byte $df,$62,$22,$d1,$68

    L_a542:
        plp 
        cpy $2d4a
        asl $c6,x
        lda ($2d),y
        jmp L_5998 + $cc

    L_a54d:
         .byte $09,$89,$63,$63,$22,$d0,$48
        .byte $b6,$35,$a9,$62,$50,$c0

    L_a55a:
        bvs L_a55a
        ror 

        .byte $63

    L_a55e:
        jsr $22a3

        .byte $e3,$60,$00,$11,$68,$b6,$24

    L_a568:
        .byte $03,$22,$6f
        .byte $01,$04,$82,$45,$80,$61,$40,$7d,$24,$8c,$c4,$a0

    L_a577:
        .byte $b0,$00,$64
        .byte $41,$31,$b1,$90,$40,$63,$5a,$94,$58,$11,$6f,$3c,$56,$25,$04,$06
        .byte $25,$17,$18,$00,$c0,$08,$c0,$45,$80,$70,$16,$df,$a4,$12,$d8,$96
        .byte $a5,$16,$01,$c0,$8c,$8b,$63,$51,$60,$1d,$94,$58,$23,$20,$02,$87

    L_a5aa:
        .byte $48,$f9,$17,$19,$89,$04,$64,$13,$52
        .byte $c4,$82,$32,$2d,$04,$8b,$6a,$51,$63,$d1,$4c,$11,$98,$d4,$5b,$12
        .byte $8b,$8c,$8b,$41,$01,$16,$82,$45,$a0,$94,$b8,$cd,$8d,$03,$52,$8b
        .byte $41,$22,$c0,$d4,$c6,$46,$7f,$07,$01,$62,$40,$8b,$41,$31,$ac,$4c
        .byte $64,$13,$12,$8b,$02,$09,$16,$8b,$00,$e2,$31,$ba,$00,$32,$22,$c4
        .byte $67,$a9,$bd,$b8,$07,$50,$32,$f2,$10,$0c,$88,$b4,$14

    L_a600:
        adc ($19,x)
        tay 
        eor ($5e),y
        eor ($29,x)

        .byte $0c,$8d,$48,$18

    L_a60b:
        sta $f0,x

        .byte $5c,$74,$29,$a6,$6f,$6f,$24,$40,$82,$02,$2e,$30,$18

    L_a61a:
        cmp ($4d,x)

        .byte $12,$8a,$05,$e0,$35,$2c,$4b,$12,$c6,$80,$5d,$89,$86,$28,$52,$44

    L_a62c:
        pla 
        dec $a4,x
        adc $04,x

        .byte $64,$58,$06,$44,$12,$2c,$46,$6e,$9b,$d9,$91,$84,$67,$05,$bd,$da
        .byte $8f,$42,$aa,$6d,$44,$92,$00,$8c,$bd,$60,$f8,$15,$24,$24,$11,$f0
        .byte $64,$0c,$68,$cc,$6a,$09,$a9,$45,$88,$cc,$9a,$8b,$48

    L_a65e:
        iny 
        and #$ab
        dec $f4,x

        .byte $17,$91,$71,$80,$23,$78,$6f,$58,$9e,$34,$56,$3f,$8a,$62,$23,$34
        .byte $2a,$2b,$c0,$11,$9e,$36,$f6,$38,$c2,$de,$81,$5a,$6d,$71,$46,$6a
        .byte $58,$90,$31,$ad,$85,$95

    L_a689:
        cpx #$b8
        cmp $7b5b

        .byte $02,$34,$60

    L_a691:
        .byte $29,$bd,$e8,$a6,$b5,$6d,$e9,$81,$19,$8d,$62,$63,$22
        .byte $c1,$80

    L_a6a0:
        .byte $0c,$4b,$52
        .byte $29,$ae,$ca,$8a,$e5,$d6,$34,$0f,$6c,$40,$8c,$d3,$37,$a6,$11,$91
        .byte $88,$64,$6a

    L_a6b6:
        and $02a9
        php 
        ora ($98),y

        .byte $90,$03,$02,$2d,$01,$df,$90,$45,$83,$00,$04,$66,$91,$2f,$bd,$16
        .byte $c4,$a0,$97,$98,$c0,$c0,$c4,$a4,$d8,$0d,$e4,$b8,$89,$e2,$8f,$56
        .byte $4d,$48,$8d,$f1,$bd,$03,$12,$80,$91,$a1,$71,$98,$0d,$04,$15,$16
        .byte $82,$45,$bb,$bc,$1a,$06,$24,$46,$60,$d4,$55,$5c,$15,$b0,$c9,$55
        .byte $6c,$30,$d5

    L_a6ff:
        .byte $5b
        .byte $0e,$05,$58,$b5,$56,$c3,$c2,$f7,$29,$c0,$32,$20,$c8,$00,$a7,$e0
        .byte $d0,$68,$1f,$69,$af,$15,$80,$1f,$75,$3a,$9c,$1f,$00,$29,$ab,$14
        .byte $bb,$31,$73,$e0,$15,$80,$50,$3c,$6e,$38,$1b,$35,$e0,$b8,$62,$f7
        .byte $00,$64,$56,$01,$58,$a7,$53,$81,$4e,$0c,$80,$6c,$de,$e0,$29,$c0
        .byte $a7,$02,$b0,$0a,$70,$2b,$d6,$08,$8a,$77,$0d,$d5,$70,$dd,$50,$3a
        .byte $aa,$75,$38,$b4,$3c,$49,$70,$43,$9d,$9b,$95,$60,$e3,$c1,$fa,$70
        .byte $3d,$4b,$61,$85

    L_a764:
        cpx $02

        .byte $9c,$03,$80,$e1,$a9,$d4,$e0,$7a,$96,$cb,$67

    L_a771:
        clv 
    L_a772:
        asl 

        .byte $70,$0c,$82,$9a,$9b,$4b,$84,$03,$88,$ac,$00,$63,$ba,$8e,$ab,$86
        .byte $ea,$b8,$6e,$aa,$9c,$53,$5a,$94,$bc,$b0,$22,$16,$c3,$24,$15,$b2
        .byte $da,$ac,$12,$76,$da,$d8,$70,$1d

    L_a79b:
        sbc ($19),y

        .byte $b2,$4b,$c2,$3a,$21,$6c,$b6,$79,$04,$66,$4d,$2e,$27,$05,$60,$9e
        .byte $10,$a7,$56,$7c,$11,$9d,$94,$b9,$92,$47,$88

    L_a7b8:
        ror $00,x
        adc ($53,x)
    L_a7bc:
        lda #$ee
        sty L_7b2a
        ldx L_d22f + $a
        rol L_540c + $2,x

        .byte $e2,$36,$f6,$01,$c9

    L_a7cc:
        ror $40,x
        cpx vColorRam + $181
        ora $1400,y
        bcc L_a7d6
    L_a7d6:
        dec $3d13,x
        dec $cd,x
        cpx $ba

        .byte $a7,$00,$8d,$9d,$2e,$d1,$bc,$80,$17,$39,$cc,$00,$21,$ce,$8d,$5d
        .byte $00,$c4,$ab,$1d,$90,$3b,$20,$00,$ad,$4c,$60,$17,$ec,$ae,$b3,$79
        .byte $f8,$0a,$a9,$37,$c1,$09,$02,$91,$e1

    L_a806:
        sed 
        inc $0396
        adc L_9071,x
        lsr $54
        bmi L_a822
    L_a811:
        ora $a1
        ror $c0,x
        and $35,x
        sbc $08
        cpy $0143
        and $14b3

        .byte $d7,$69,$80

    L_a822:
        ror L_bb34

    L_a825:
         .byte $22,$33,$04
        .byte $c0,$68,$11,$9a,$a6,$02,$30,$8c,$c9,$25,$e6,$5d,$05,$d1,$68,$6c
        .byte $98,$06,$cd,$d0,$ac,$23,$27,$12,$ff,$c5,$36,$e2

    L_a844:
        lsr $911c,x

        .byte $d4,$70,$5d,$06,$41,$48,$74,$58,$0d,$f1,$99,$9a

    L_a853:
        .byte $e2,$33
        .byte $ea

    L_a856:
        .byte $97,$af
        .byte $59,$eb,$5d,$4e,$c6,$08,$cc,$98,$2f,$ff,$21,$c2,$9a,$f3,$a5,$f3
        .byte $d7,$00,$fc,$a9,$de,$a5,$b1,$40,$e2,$41,$5b,$0e,$20,$7f,$06,$50

    L_a878:
        .byte $fc,$bb,$e2,$34
        .byte $e4,$03,$15,$16,$1c,$f8,$b8,$98

    L_a884:
        pha 

    L_a885:
         .byte $67,$54,$c3,$b0,$a9,$82
        .byte $c9,$c3,$7c,$a1,$41,$71,$9b,$f7,$40,$00,$be,$34,$3b

    L_a898:
        eor ($54,x)

        .byte $d0,$85,$48

    L_a89d:
        ora L_63bd + $2
        sbc $334a
        sbc $b88a
        lda ($c7,x)
        sta $48

        .byte $80,$8f,$0d,$6d,$b6,$44,$6c,$ed,$a4

    L_a8b3:
        .byte $14,$fa,$a7,$87
        .byte $ad,$9d,$a8,$76,$cf,$0b,$c0,$28,$42,$cc,$de,$2a,$61,$b9,$2a,$9d
        .byte $cc,$a4,$12,$c3,$c8,$a9,$a8,$56,$9f,$1c,$c8,$e1,$fd,$3d,$81,$87
        .byte $61,$53,$5f,$74,$0c,$af,$52,$a6,$1e,$45,$4f,$e6,$64,$fe,$13,$40
        .byte $77,$c3,$24,$a8,$38,$20,$a1,$da,$0a,$fe,$84,$2d,$f4,$80,$ef,$76
        .byte $67,$e7,$b7,$aa,$38,$4d,$dc,$2b,$8d,$3c,$f6,$06,$93,$e7,$c3,$d3
        .byte $7c,$59,$ed,$ed,$39,$ec,$d3,$f8

    L_a90f:
        rts 



        .byte $14,$d7,$4d,$e1,$32,$01,$83,$a5,$48,$3d,$01,$5e,$08,$28,$21,$ea
        .byte $d0,$ed,$06,$05,$05,$6c,$15,$fd,$08,$43,$ef,$89,$9c,$72,$67,$c0
        .byte $83,$0d,$de,$43,$b3,$f3,$db,$65,$1a,$b5,$47,$0b,$3a,$b5,$0d,$2e
        .byte $7b,$7d,$5e,$04,$06,$81,$7b,$ae,$1a,$0e,$42,$f5,$1a,$96,$d6,$8d
        .byte $86,$8a,$5e,$a3,$61,$da,$41,$a5,$b5,$eb

    L_a95a:
        stx $b3
        dec $8a,x

        .byte $4b,$2d,$21,$a2,$94,$d6,$b5,$a5,$a1,$4e,$07,$2d,$68,$a5,$7e,$b8
        .byte $68,$34,$52,$36,$1a,$eb,$5e,$b5,$ec,$34,$b4,$57,$c1,$b6,$81,$2d
        .byte $ad,$1b,$0e,$d3,$41,$0e,$d2,$0f,$5c,$3c,$c8,$a5,$ea,$35,$69,$0d
        .byte $a0,$53,$42,$96,$05,$d6,$b4,$b6,$61,$4b,$94,$5a,$be,$11,$9c,$16
        .byte $59,$8d,$d7,$cd,$ae,$cd,$0d,$04,$eb,$0a,$43,$4b,$6b,$b5,$21,$2c
        .byte $bd,$d6,$8d,$74,$61,$77,$81,$c9,$2d,$af,$92,$21,$3c

    L_a9bb:
        pha 

        .byte $1c,$46,$c8,$cb,$19,$14,$ca,$6b,$11,$9b,$96,$59,$00,$96,$68,$33
        .byte $6b,$86,$d0,$29,$85,$a1,$c1,$65,$9c,$26,$0d

    L_a9d7:
        .byte $9c,$5a,$5a
        .byte $85,$e4,$0d,$02,$98,$46,$da,$cb,$6d,$69,$12,$da,$d1,$56,$85,$35
        .byte $9a,$69,$69,$4a,$5a,$08,$ce,$1b,$c3,$11,$2c,$d7,$23,$45,$69,$c1
        .byte $65,$80,$39,$cc,$08

    L_a9ff:
        and ($49,x)

        .byte $03,$40,$a6,$87,$bb,$87,$a2,$9a,$24,$52,$f6,$d3,$40,$96,$74,$61
        .byte $27,$65,$22,$92,$da,$e1,$ac,$da,$09,$10

    L_aa1b:
        .byte $d3,$7b
        .byte $41,$48,$d5,$9c,$35,$35,$bc,$5b,$14,$46,$48,$50,$85,$91,$cc,$58
        .byte $8e,$21,$23,$52,$89,$61,$7f,$e5,$66,$6f,$36,$b7,$c4,$91,$5e,$23
        .byte $c9,$5f,$4f,$ba,$e8,$87,$15,$29,$5b,$dc,$34,$8d,$a8,$ce,$93,$67
        .byte $5d,$99,$6c,$eb,$83,$4d,$c2,$81,$14,$fb,$22,$8e,$da,$aa,$9e,$38
        .byte $68,$a6,$dd,$b5,$70,$de,$9d,$a0,$db,$72,$c8,$1a,$36,$55,$18,$da
        .byte $7a,$da,$be,$72,$15,$4d,$1b,$2a,$8c,$6d,$3d

    L_aa78:
        rol $ab,x
        inc $d5
        rol $b6aa,x
        txs 
        adc $297c,x
        jsr L_73b1

    L_aa86:
         .byte $48,$2d,$a6,$b0,$24,$47,$39,$8a,$88,$e9,$43,$d7
        .byte $0d,$7b,$0f,$34,$36,$ba,$1b,$49,$0d,$07,$0e,$d4,$3d,$70,$d7,$b0
        .byte $da,$21,$19,$60

    L_aaa6:
        .byte $d8,$31,$56,$a1,$ba,$50,$d8
        .byte $f8,$c3,$29,$ad,$2c,$8c,$4d,$03,$a5,$c6,$e4,$13,$7f,$1a,$c9,$11
        .byte $91,$8a,$64,$d5,$ed,$07,$25,$9a,$59,$ae,$69,$10,$76,$a1,$c3,$45
        .byte $2f,$51,$a9,$6d,$7e,$e1,$ae,$91,$4d,$76,$6d,$6b,$38

    L_aada:
        .byte $6f
        .byte $2c,$34,$6e,$b5,$ee,$b8,$6a,$f4,$52,$5a,$d6,$b4,$b4,$44,$d0,$10
        .byte $d7,$38

    L_aaed:
        .byte $82,$da
        .byte $69,$8a,$18,$52,$29,$16,$b9,$7a,$b4,$d6,$96

    L_aafa:
        lda $0d,x
        ldx #$45
        and $cb,x
        cld 
        pla 
    L_ab02:
        dec $b9,x
        pla 
        dex 
        php 
        dec L_2dd1 + $2

        .byte $23,$92,$5b,$5a,$d0,$52,$3c,$b2,$db,$d0,$12,$11,$49,$a0,$30,$97
        .byte $18,$a0,$34,$6d,$ab,$d3,$e9,$7d,$b4,$1d,$6e,$31,$c1,$3f

    L_ab28:
        ora #$45
        plp 
        tax 
    L_ab2c:
        sei 
        cmp ($49),y

        .byte $47,$c1,$b7,$1c,$24,$93,$6a,$8c,$c6,$e1,$a3,$36,$81,$e2,$b9,$a0
        .byte $0f

    L_ab40:
        .byte $1c,$34,$53
        .byte $e0,$db,$a3,$1c,$36,$d7,$6e,$d0,$63,$77,$66,$84,$ae,$7f,$b6,$15
        .byte $f1,$ab,$a9,$4a,$66,$63,$03,$50,$05,$36,$5b,$69,$10,$8d,$9b,$00
        .byte $d8,$2e,$9b,$2f,$26,$f8,$69,$28,$da,$8d,$a5,$2d,$e3,$7e,$8f,$06
        .byte $90,$85,$34,$84,$fb,$ba,$b5,$14,$87,$2d,$b0,$90,$64,$03,$ac,$84
        .byte $77,$50,$a2,$cc,$ed,$b6,$15,$d0,$12,$2b,$c8,$62,$2c,$2c,$de,$6e
        .byte $6b,$0b,$5d,$1e,$94,$60

    L_ab99:
        .byte $3f,$bb,$ab,$00
        .byte $31,$3d,$f2,$e5,$05,$bb,$45,$2a,$be,$a2,$92,$8a,$a6,$35,$54,$f1
        .byte $a1,$fc

    L_abaf:
        lsr L_b2cf

        .byte $6b,$5a,$f5,$1b,$79,$34,$e1,$b6,$9b,$76,$81

    L_abbd:
        dec L_7c77

        .byte $02,$da,$29,$28,$d3,$2a,$84,$66,$15,$81,$b6,$da

    L_abcc:
        .byte $b7,$e7
        .byte $4d,$48,$85,$c2,$49,$14,$94,$c6,$aa,$b6,$9a,$86,$9a,$69,$95,$4c
        .byte $6a,$aa,$da,$69,$02,$39,$89,$a6,$98,$08,$87,$75,$52,$07,$6d,$14
        .byte $94,$5f,$7a,$5f,$36,$a0,$6d,$dd,$d6,$7c,$0f,$00,$17,$6e,$eb,$3c
        .byte $07,$39,$bc,$4b,$c4,$0c,$aa,$f9,$34,$b4,$da

    L_ac09:
        tax 
        txs 

        .byte $92,$5d,$63,$42,$a6,$95,$54,$9b,$40

    L_ac14:
        .byte $25,$5d,$d6,$40,$0e,$5a,$49,$95,$6f,$fd,$36,$ad,$a6,$34,$d0,$a6
        .byte $b6,$0c,$0c,$87,$9d,$7d,$e8,$0a,$d7,$75,$8f,$03,$46,$df,$fa,$da
        .byte $be,$6d,$19,$54,$fa,$a9,$a3,$86,$da,$32,$a9,$f5,$f6,$d5,$53,$4a
        .byte $10,$04,$32,$5b,$df,$78,$82,$6d,$6c,$f0,$34,$6d,$ff,$a6

    L_ac52:
        cmp $7d,x
        lda $54,x
        cmp ($b7),y
        inc L_459a + $1,x

        .byte $f3,$69,$b7,$d0,$38,$b5,$af,$88,$1c,$b7,$21,$95,$4f

    L_ac68:
        lda L_402e,x

        .byte $17,$cd,$6b,$e4,$07,$6d,$34,$92,$69,$35,$da,$4f,$e3,$4d,$2f,$bd
        .byte $01,$b4,$6b,$5c,$d2

    L_ac80:
        dec $02
        ora ($ad),y
        rts 



        .byte $c2,$d4,$c3,$49,$34,$8a,$f4,$15,$f8,$70,$fd,$8d,$7c,$92,$5a,$72
        .byte $11,$98,$f6,$59,$c3,$c6,$0f,$6d,$6b,$1f,$65,$a9,$87,$ad,$7a,$8d
        .byte $bc,$be,$da,$04,$2b,$5a,$a7,$54,$46,$05,$36,$b5,$c1,$54,$09,$9a
        .byte $6b,$58,$16,$cf,$a3,$33,$a3,$42,$b9,$00,$64,$93,$44,$8a,$65,$35
        .byte $a3,$31,$a6,$fe,$1f,$c5

    L_accb:
        .byte $53
        .byte $50,$9a,$49,$34,$48,$a6,$53,$5a,$33,$1a,$69,$7d,$e9,$55

    L_acda:
        clc 

        .byte $03,$22,$28

    L_acde:
        .byte $0c
        .byte $6d,$e0,$0c,$88,$a8,$d0,$39,$35,$a0,$06,$60,$35,$20,$18,$57,$c9
        .byte $2e,$49,$66,$81,$a2,$57,$e3,$5f,$24,$91,$ad,$02,$59,$1a,$8d,$c6
        .byte $be

    L_ad00:
        eor #$7b
        eor $66
    L_ad04:
        lsr $a3
        adc ($af),y

        .byte $92,$40,$81,$54,$b8,$8d,$40,$17,$c2,$16,$d6,$c7,$0b,$53,$0d,$24
        .byte $bd,$45,$25,$84,$6b,$91,$d3

    L_ad1f:
        stx $9a,y
        and $a0
        sta L_3c72

        .byte $8b,$4d,$12,$d0,$46,$9f,$1e,$d2,$99,$2d,$6b,$59,$a9,$15,$cf,$89
        .byte $ac,$46,$df,$1f,$52,$49,$14,$b4,$5e,$a3,$51,$b8,$d7,$da,$d7,$a8
        .byte $db,$c0,$02,$e1,$4e,$a8,$8c,$07,$35,$70,$e0,$aa,$04,$cd,$35,$ac
        .byte $0e,$c4,$b3,$73,$cd,$3a,$9c,$d1,$a8,$46,$f5,$1d,$24,$da,$0b,$90
        .byte $23,$ff,$a7,$29,$24,$08,$42,$37,$c6,$d0,$56,$9c,$88,$e8,$bd,$a2
        .byte $33,$ba,$af,$8c,$51,$c2,$5c,$00,$08,$a8,$c5,$ec,$38,$44,$df,$48
        .byte $50,$29,$66,$00,$77,$a1,$0d,$1e,$23,$68,$6d,$99,$0f,$23,$20,$07
        .byte $e9,$e1,$10,$00,$24,$80,$03,$80,$07,$01,$16,$51,$a5,$2b,$29,$4a
        .byte $56,$55,$d5,$22

    L_adaa:
        ldx L_086e + $13b

        .byte $c7,$95,$65,$d3,$1a,$c8

    L_adb3:
        .byte $fa
        .byte $96,$5d,$75,$35,$4c,$1c,$ae,$a7,$e2,$58,$8e,$bc,$2b,$1e,$94,$a3
        .byte $d2,$21,$e9,$10,$f1,$c9,$54,$00,$8e,$01,$90,$59,$ac,$36,$d0,$c4
        .byte $60,$3b,$60,$4d,$08,$cf,$6b,$51,$2f,$26,$a5,$65,$2d,$52,$2a,$f4
        .byte $91,$55,$38,$b2,$e0,$75,$96,$f4,$42,$ca,$ab,$9a,$d1,$d5,$73,$51
        .byte $14,$9e,$54,$45,$29,$47,$af,$28,$f4,$a5,$1e

    L_adff:
        .byte $34,$93
        .byte $c6,$06

    L_ae03:
        tay 
        cpy #$92
        ora ($92,x)

        .byte $90,$01,$e0,$ec,$84,$38,$0a,$78,$c1,$ff,$18

    L_ae13:
        and $2255
    L_ae16:
        lda $40,x
    L_ae18:
        rol L_1780

    L_ae1b:
         .byte $fc,$6f
        .byte $36,$23,$79,$f1,$18,$a9,$ca,$55,$8f,$4a,$52,$4f,$7a,$eb,$c1,$d0
        .byte $b4,$39,$0d,$b0,$01,$0a,$30,$0e,$00,$08,$d8,$db,$68,$c8,$90,$52
        .byte $01,$0e,$02,$1e,$30,$8c

    L_ae43:
        sbc $b6
        cpy #$a4
        asl $aa,x

        .byte $30,$23,$c4,$6f,$36,$c3,$8c,$5f,$f1,$8b,$62,$31,$6c,$46,$2f,$41
        .byte $1a,$33,$6c,$94,$eb,$56,$53,$00,$2d,$09,$b6,$d9,$0d,$18,$17,$cf
        .byte $18,$87,$00,$23,$00,$72,$89,$48,$13,$aa,$82,$75,$50,$44,$38,$3c
        .byte $9e,$33,$14,$7a,$4c,$e1,$c0

    L_ae80:
        .byte $cc,$67,$8c,$cc,$74,$8c,$cc,$1e,$33,$31,$fe,$35,$68,$31,$9a,$f8

    L_ae90:
        .byte $34
        .byte $9a,$fa,$07,$cf,$34,$e5,$5a,$da,$2a,$ca,$3d,$22,$08,$ce,$fb,$56
        .byte $04,$78,$03,$24,$a6,$35,$74,$40,$03,$87,$2f,$20,$d3,$79,$3d,$26
        .byte $28,$f1,$84,$d0,$2a,$1a,$b5,$1d,$e1,$11,$93,$3b,$67,$78,$23,$01
        .byte $90,$11,$92,$8f,$3c,$93,$d7,$92,$7a,$f5,$8f,$5e,$54,$8a,$57,$cf

    L_aed1:
        lsr 
        sbc L_80ea,y
        sbc ($84),y

        .byte $67,$29,$b6,$a5,$54,$05,$3d,$d8,$60,$10,$e0,$9c,$78,$d3,$8f,$1a
        .byte $71,$e3,$13,$fc,$62,$74,$a4,$f4,$e7,$a4,$aa,$e7,$62,$72,$94,$e4
        .byte $e5,$2a,$c0,$23,$c4,$82,$b4,$55,$94,$7a,$a4,$3d,$52,$1e,$a8,$35
        .byte $55,$01,$29,$09,$a2,$6d,$9a,$ba,$22,$32,$9d,$ab,$4d,$33,$29,$58
        .byte $51,$81,$90,$53,$5c,$96,$ac,$46,$80,$78,$c4,$ff,$48,$9d,$29,$03
        .byte $3b,$27,$e4,$f5,$ef,$d8,$a5,$3a,$0d,$2a,$d0,$6a,$ca,$90,$2b,$4d
        .byte $4b,$56,$f6,$b5,$1b,$93,$42,$38,$04,$65,$0a,$64,$d0,$80,$43,$b0
        .byte $ef,$2b,$6c,$07,$6e,$97,$11,$08,$ce,$ab,$6d,$36,$b1,$e3,$4a,$3d
        .byte $3d,$5f,$f7,$e6,$e2,$1d,$49,$c3,$ea,$e8

    L_af61:
        adc $3e47,x

        .byte $a3,$d9,$bc,$56

    L_af68:
        .byte $3a,$b2,$8f
        .byte $56,$51,$e9,$4a,$14,$d7,$61,$b6,$44,$20,$85,$35,$3e,$d5,$d5,$77
        .byte $aa,$83,$10,$05,$cd,$e5,$6d,$84,$66

    L_af84:
        dec vColorRam + $1c1,x

        .byte $97,$cc,$46,$72

    L_af8b:
        .byte $1a,$b0,$57
        .byte $4d,$1e,$96,$38,$35,$4f,$fe,$a9,$fa,$55,$3a,$72,$a9,$cf,$57,$51
        .byte $ea,$ea,$3d,$2d,$42,$33,$2a,$db,$08,$53,$59,$66,$d8,$cd,$44,$a3
        .byte $c6,$20,$8c,$d8,$b6,$ce,$14,$20,$6a,$00,$35,$00,$07,$bc,$03,$de
        .byte $05,$68,$00,$ec,$99,$0e,$c9,$9b,$e2,$e0,$79,$20,$c6,$94,$9c,$8d
        .byte $2b,$43,$b3,$11,$38,$dc,$4a,$e9,$4a,$57,$46,$4e,$57,$4a,$fa,$b3
        .byte $d2,$11,$97,$6b,$94,$d4,$6d,$47,$8d,$aa,$a8,$25,$46,$00,$c8,$24
        .byte $22,$e5,$73,$26,$30,$1e,$98,$c0,$51,$46,$03,$d3,$18,$12,$63,$00
        .byte $31,$84,$69,$42,$32,$b9,$72,$a7,$9d,$a0,$15,$8f,$b6,$54,$16,$6e
        .byte $57,$f8,$da,$bf,$d7,$d5,$20,$5a,$1a,$95,$cb,$56,$74,$a1,$cf,$18

    L_b01e:
        .byte $e7,$00,$c2,$d0,$80,$73,$a7
        .byte $e0,$bc,$96,$a6,$4c,$1a,$99,$30,$1d,$c1,$21,$dc

    L_b031:
        ora L_7947,y
        asl 
        ror $a0,x
        txs 

        .byte $1b,$b2,$27,$1b,$b2,$1d,$bd,$ab,$86,$02,$78,$69,$65,$7f,$70,$25
        .byte $7f,$15,$bb,$de,$68,$42,$76,$44,$67,$bd,$72,$66,$6c,$87,$66,$ca
        .byte $23,$3b,$ed,$8d,$b1,$19,$97,$6c,$5c,$76,$4c,$78,$5e,$4b,$5b,$14
        .byte $93,$82,$41,$34,$4c,$53,$62,$18,$57,$24,$c2,$8e,$99,$84,$a2,$47
        .byte $c2,$43,$a5,$09,$fe,$35,$6c,$f1,$eb,$1e,$3d,$63,$b7,$12,$a4,$52
        .byte $94,$7a,$5a,$8e,$ec,$90,$ec,$ea,$5c,$12,$80,$0d,$5a,$78,$80,$04
        .byte $e2,$e5,$05,$78,$90,$6e,$4a,$70,$ee,$15,$c3,$bc,$4d,$97,$89,$06
        .byte $f1,$2d,$de,$27,$8b,$d2,$ba,$5e,$94,$7a,$f8,$d3,$d4,$b5,$22,$c4
        .byte $64,$3a,$e6,$15,$50,$0b,$43,$36,$db,$76,$41

    L_b0c3:
        .byte $42,$d4
        .byte $01,$19,$a1,$6d,$bb,$4a,$00,$0f

    L_b0cd:
        clc 

        .byte $82,$34,$76,$c6,$14,$a8,$37,$08,$26,$68,$f3,$5c,$47,$7d,$05,$0b
        .byte $b2,$0a,$17,$68,$2e,$09,$2d,$b8,$33,$9e,$04,$9c,$bd,$a9,$11

    L_b0ed:
        .byte $1b,$52,$43,$67

    L_b0f1:
        bcc L_b15a

        .byte $0b,$94,$7c,$24,$38,$8c,$cd,$b6,$c9,$96,$6c,$c0,$30,$f9,$7a,$de
        .byte $b0,$04,$2f,$2d,$09,$01,$89,$9d,$b0,$8b,$b0,$32,$01,$a5,$b1,$61
        .byte $a3,$f1,$7e,$65,$03,$3b,$62,$b8,$c9,$61,$9d,$05,$d6,$e2,$c0,$c8
        .byte $dc,$5d,$02,$2e,$bd,$7b,$b5,$eb,$a2,$c0,$8b,$af,$5e,$ed,$71,$90
        .byte $0c,$ed,$8a,$eb,$6b,$16,$19

    L_b13a:
        .byte $d0,$0e
        .byte $59,$dc,$77,$1c

    L_b140:
        inc L_8e3b

        .byte $73,$a2,$5b,$26,$c9,$86,$3b,$04,$30,$a4,$10,$48,$24,$82,$41,$ac
        .byte $6b,$32,$0e,$73,$58,$74,$4a

    L_b15a:
        bit $e8
        sty $49,x
        dec SCREEN_BUFFER_1 + $100

    L_b161:
         .byte $92,$8f
        .byte $46,$42,$63

    L_b166:
        cpy $66
        and #$35
        ora #$0e

        .byte $c7,$a3,$d1,$ed,$b2,$3d,$9d,$93,$84,$21,$73,$e3,$10,$bc,$50,$f1
        .byte $e3,$dc,$04,$2b,$8c,$7c,$76,$ad,$45,$71,$8f,$ec,$46,$b5,$b4,$50
        .byte $2a

    L_b18d:
        sta $5f,x
        stx $2c,y
        sta $c6
        and L_fa63,x

        .byte $e7,$54,$d3,$1a,$46,$b5,$8d,$63,$48,$79,$2d,$7a,$88,$64,$f4,$d7
        .byte $c9,$8e,$d2,$a6,$46,$4e,$2d,$2c,$75,$c4,$25,$4f,$5e,$dd,$92,$e9
        .byte $2d,$43,$24,$a1,$84,$8d,$0f,$f6,$45,$91,$5b,$36,$4d,$93,$42,$92
        .byte $aa,$71,$92,$ad,$5a,$4d,$eb,$d8,$e9,$b7,$a9,$b6,$85,$bd,$6f,$61
        .byte $24,$18,$08,$50,$92,$0d,$e1,$3d,$47,$15,$05,$08

    L_b1e2:
        .byte $64
        .byte $91,$0a,$10,$70,$ed,$c3,$b6,$e6,$db,$80,$87,$2e,$59,$18,$d2,$13
        .byte $6d,$cd,$ab

    L_b1f6:
        .byte $8b

    L_b1f7:
        cpx L_d5fa + $4
        sty L_12a2

        .byte $52,$6a,$52,$6b,$f6,$d6,$6f,$75,$5e,$f1,$40,$04,$d2,$79,$34,$a0
        .byte $38,$c9,$57,$0f

    L_b211:
        ldx #$35
        lda L_1a69

        .byte $d2,$11,$ad,$27,$e2,$7e,$23,$1a,$7d,$52,$a5,$10,$03,$24,$68,$d4

    L_b226:
        lda #$55
        tax 

        .byte $00,$10,$03,$24,$32,$82

    L_b22f:
        jsr L_1cfe + $8

        .byte $7c,$f5,$a0,$22,$33,$8f,$2a,$99,$9c,$7d,$e2,$24,$60,$af,$21,$b1

    L_b242:
        .byte $30,$e0,$3b,$da
        .byte $d9,$d7,$15,$2c,$ba,$dd,$aa,$50,$1b,$f6,$1f,$9b,$8b,$cf,$44,$8d
        .byte $1c,$d8,$73,$f0,$9c,$0c,$5e,$6d,$53,$0f,$22,$43,$8b,$23,$9b,$55
        .byte $78,$0d,$fb,$05,$22,$43,$09,$ce,$42,$8f,$23,$8b,$cd,$c5,$91,$cf
        .byte $fa,$82,$d7,$3d,$1c,$f4,$58,$e8,$78,$11,$0a,$0d,$33,$f0,$b0,$13
        .byte $a4,$aa,$a6,$a9,$80,$64,$a6,$c9,$d2,$00,$e0,$62,$dd,$bd,$08,$67
        .byte $de,$ad,$20

    L_b299:
        jmp L_c800

        .byte $8a,$af,$18,$32,$51,$e2,$33,$42,$e8,$a8,$84,$6a,$2d,$3c,$98,$43
        .byte $88,$8f,$19,$24,$86,$17,$f3,$6c,$77,$19,$23,$dc,$4a,$38,$50,$3c
        .byte $b3,$cc,$f2,$dd,$9e,$14,$85,$9b,$1d,$0a,$38,$61,$33,$ce,$32,$3d
        .byte $1e,$e3,$23

    L_b2cf:
        .byte $dc
        .byte $65,$6b,$3a,$fb,$ae,$9f,$74,$1a,$bf,$33,$82,$ad,$84,$85,$57,$75
        .byte $68,$5d,$16,$ae,$ba,$eb,$7b,$81,$46,$a9,$d2,$40,$05,$e9,$90,$11
        .byte $ba,$62,$4c,$99,$cb,$94,$cd,$30,$22,$00,$08,$d9,$09,$19,$9c,$b9
        .byte $17,$96,$98,$11,$2d,$01,$01,$ae,$42,$02,$24,$84

    L_b30c:
        .byte $02,$02
        .byte $45,$e0,$44,$d3,$ca,$d4,$40,$44,$81,$a6,$64,$c0,$0c,$88,$04,$06
        .byte $94,$04,$81,$93,$4d,$e9,$1a,$62,$14,$46,$5f,$d9,$b9,$26,$fa,$a8
        .byte $64,$43,$a2,$0e,$30,$a6,$fa,$e1,$69,$ba,$9c,$ed,$0a,$4c,$f7,$19
        .byte $b6,$6d,$d9,$76,$58,$37,$71,$dc,$4b,$f5,$69,$94,$4c,$8b,$23,$d5
        .byte $a6,$3b,$94,$93,$77,$29,$1d,$40,$71,$87,$aa,$4d,$26,$88,$64,$51
        .byte $08,$87,$65,$d9,$6c,$5c,$07

    L_b365:
        .byte $65,$11,$7d,$55,$d7,$ab
        .byte $06,$98,$60,$fa,$d2,$d5,$a9,$8d,$38,$c8,$c6,$a7,$92,$69,$33,$d5
        .byte $4d,$28,$19,$17,$29,$36,$ec,$b6,$29,$b6,$85,$ca,$44,$6a,$d4,$e6
        .byte $b5,$f2,$40,$32,$2f,$69,$b5,$6c,$44,$4f,$86,$a1,$99,$49,$b2,$2d
        .byte $eb,$41,$7b,$97,$2a,$ee,$03,$62,$e0,$36,$31,$c0,$32,$08,$cf,$4b
        .byte $1c,$22,$6a,$d5,$56,$a8,$b4,$3a,$6d,$c9,$92,$cd,$46,$a3,$9d,$11
        .byte $a8,$e3,$b2,$9e,$3d,$5a,$a9,$35,$05

    L_b3c4:
        .byte $53
        .byte $8c,$3a,$a5,$4b,$20,$00,$74,$e7,$8e,$2f,$48,$03,$21,$cf,$56,$ad
        .byte $30,$0e,$24,$3a,$a7

    L_b3da:
        ora L_37ff + $1,y

        .byte $87,$ea,$01,$c4,$39,$c8,$38,$87,$44,$5c,$1c,$0e,$a9,$78,$e0,$1c
        .byte $03,$9c,$1d,$c6,$17,$8d,$10,$e5,$37,$51,$c6,$44,$bf,$68,$43,$20
        .byte $8c,$af,$60,$e8,$c2,$19,$1b,$a6,$e9,$ca,$72,$91,$30,$86,$1b,$83
        .byte $80,$7d,$50,$80,$38,$07,$11,$93,$9c,$55,$a7,$3a,$3f,$68,$c3,$aa
        .byte $54,$98,$40,$18,$4e,$78,$5d,$a5,$0c,$8a,$03,$9d,$2f,$84,$64

    L_b42c:
        sty $23,x
        sec 
        bit SCREEN_BUFFER_0 + $218
        eor #$40
    L_b434:
        cmp $a8,x

        .byte $e7,$ab,$56,$95,$27,$b2,$c3,$d9,$f3,$e0,$1f,$83,$c1,$c4,$0c,$99
        .byte $28,$f4,$7b,$7e,$e3,$42,$9e,$e0,$b4,$ee,$2b,$4e,$cb,$30,$0c,$b3
        .byte $2d,$09,$ac,$85,$0b,$b2,$25,$d1,$60,$32,$30,$6f,$49,$43,$00,$cb
        .byte $3b,$0c,$b6,$a9,$52,$84,$67,$71,$d0,$1a,$5c,$46,$5c,$3d,$de,$31
        .byte $82,$25,$91

    L_b479:
        .byte $93,$da,$0b,$22
        .byte $08,$17,$06,$49,$e8,$76,$95,$0e,$e3,$59,$1c,$4e,$e8,$7b,$81,$78
        .byte $46,$0a,$51,$09,$2a,$50,$06,$48,$d4,$aa,$9c,$f5,$52,$53,$e7,$b5
        .byte $8e,$2f,$29,$ed,$63,$8a,$00,$42,$90,$00,$42,$f7,$e7,$cc,$29,$1e
        .byte $5c,$66,$0a,$44,$f9,$78,$96,$13,$ac,$c1,$5a,$6b,$1c,$5f,$29,$f6
        .byte $b2,$40,$01,$0a,$47,$9f

    L_b4c3:
        rol 
        cmp L_621e,y

        .byte $42,$90,$79,$67,$97,$a8,$92,$88,$78,$c7

    L_b4d1:
        stx $70,y
        asl L_501f + $16,x
        eor $01,x
        sbc ($9c,x)

        .byte $92,$59,$d5,$c2,$31,$18,$c5,$20,$24,$47,$67,$57,$0b,$15,$8b,$c9
        .byte $6a,$40,$c2,$ae,$55,$2a,$a5,$12,$40,$c9,$cd,$3c,$9e,$ab,$4a,$47
        .byte $b5,$6c,$88,$52,$12,$0e,$50,$a4,$2b,$1d,$65,$6a,$1b,$dc,$e6,$01
        .byte $21,$21,$5b,$ed,$80,$48,$48,$56,$3a,$d2,$15,$29,$e4,$f1,$e4,$48
        .byte $85,$20,$e3,$02,$c0,$06,$f1,$48

    L_b522:
        plp 

        .byte $00,$8f,$84,$c1,$32

    L_b528:
        iny 
        inc $fc,x

        .byte $1b,$57,$cb,$b5,$c3,$56,$e3

    L_b532:
        clv 

        .byte $f2,$82,$8f,$4b,$c3,$c2,$c7,$b1,$ac,$dc,$7a,$40,$92,$de,$ee,$04

    L_b543:
        stx $55,y

    L_b545:
         .byte $50,$80
        .byte $88,$30,$de,$9f,$cb,$95,$e1,$85,$8a,$6c,$c6,$49,$0a,$e6,$66,$57
        .byte $2b,$43,$09,$b7,$d2,$7a,$de,$b6,$8d,$ce,$ec,$b6,$59,$b8,$a0,$02
        .byte $01,$01,$20,$64,$6c,$c0,$32,$5e,$bd,$ca,$7c,$f7,$15,$0f

    L_b575:
        beq L_b5e7
    L_b577:
        ora SCREEN_BUFFER_2 + $312,y

    L_b57a:
         .byte $92,$da
        .byte $b5,$22,$47,$33,$57,$8d,$25,$1e,$32,$20,$92,$08,$28,$57,$27,$cf
        .byte $78,$50,$e8,$78,$4d,$60,$43,$21,$f0,$dc,$20,$c9,$84,$39,$c9,$04
        .byte $82,$0a,$10,$c8,$ad,$60,$15,$a0,$8f,$1d,$0e,$87,$8f,$1e,$e2,$41
        .byte $ce,$72,$9c,$3c,$ec,$cb,$33,$5a,$17,$64,$bb,$a7,$a3,$44,$d6,$5e
        .byte $34,$6b,$d4,$aa,$b0,$6a,$25,$12,$22,$c7,$f3,$bc,$b2,$a5,$5e,$4b
        .byte $ff,$80,$ec,$9f,$4f,$f5,$40,$00,$f9,$b2,$99,$6f,$da,$c0,$31,$59
        .byte $1a,$c8,$43,$22,$40,$00,$79,$29,$72,$d4,$3c

    L_b5e7:
        plp 
        pha 
        rol $b1

        .byte $04,$d6,$20,$92,$1e,$da,$c5,$6e,$b0,$e7,$32,$ce,$b3,$ad,$08

    L_b5fa:
        adc ($41,x)

        .byte $22,$5c,$e4,$4b,$a5,$aa,$51,$21,$35,$8a,$1e,$ca,$12

    L_b609:
        and $55
        cpy $2a
        dec L_792d + $1
        cli 

        .byte $2b,$7d,$63,$fa,$bb,$3f,$fd,$5a,$a7,$27,$41,$fc,$e9,$ce,$87,$3c
        .byte $16,$ed,$36,$9e,$65,$d6,$cc,$ba,$d9,$86,$84

    L_b62c:
        ora ($d9,x)

        .byte $43,$b5,$a3,$89,$a8,$01,$47,$ac,$76,$b5,$a9,$28,$c0,$85,$70,$00

    L_b63e:
        sec 
        sta L_ac14 + $5
        eor $ca
        and $10f5,y

        .byte $00,$2e,$b5,$d5,$ee,$5a,$05,$37,$bb,$22,$29,$14,$cf,$29,$35,$2b
        .byte $1a,$f3,$1e,$7c,$e9,$06,$95,$c1,$69,$5c,$16,$95,$a5,$70,$5d,$74
        .byte $35,$6c,$75,$b5

    L_b66b:
        .byte $6a,$94,$d2,$b8,$2f
        .byte $36,$6c,$cf,$32,$d7,$9e,$a9,$47,$d4,$7d,$47,$dc,$00,$04,$28

    L_b67f:
        sed 

        .byte $f7

    L_b681:
        rol $ad33
        lda $c0,x
        pha 
        eor $bd35,y
        rti 

        .byte $08,$d1,$9c,$09,$24,$25,$cd,$48,$c4,$66,$dc,$22,$32,$51,$b6,$72
        .byte $e5,$ee,$05,$c6,$7c,$95,$48,$9a,$63,$69,$8c,$46,$4a

    L_b6a8:
        .byte $a3
        .byte $e0,$84,$94,$d9,$f4,$ba,$a9,$54,$97,$d5,$4a,$94,$68,$c0,$05,$cd
        .byte $b4,$8e,$32,$28,$39,$f8,$65,$35,$2a,$95,$5a,$47,$18,$6a,$b3,$a4
        .byte $97,$a9,$10,$9e

    L_b6cd:
        eor #$a6
        cmp $d1d4,y

        .byte $cf,$d5,$27,$db,$b4,$84

    L_b6d8:
        ora $0c

        .byte $e2,$42,$a2,$0f,$22,$42,$15,$0a,$ac,$60,$18,$07,$16,$d5,$ae,$49
        .byte $64

    L_b6eb:
        .byte $b7,$2b

    L_b6ed:
        lsr $9b,x
        and ($92,x)

        .byte $12,$24,$70,$e1,$92

    L_b6f6:
        and ($0c,x)
        and L_25bb,x

        .byte $fa,$ab,$98,$c2,$f7,$89,$ed,$ec,$57,$72,$5a,$ad,$50,$48,$26,$01
        .byte $c5,$71,$4e,$7d,$43,$81,$8c,$f0,$4f,$6d,$39,$60,$5e,$12,$9f,$63
        .byte $b0,$d9,$ab,$55,$a9,$0f,$7e,$e0,$e7,$d8,$32,$78,$59,$ac,$ec,$41
        .byte $51,$b0,$0d,$98,$c9,$22,$0b,$53,$17,$cb

    L_b735:
        ora $04
        lda ($6f),y

        .byte $b0,$51,$64,$b0,$4b,$ef,$e0,$03

    L_b741:
        .byte $f0,$9c
        .byte $75,$90,$61,$45,$0b,$04,$9e,$2b,$04,$be,$03,$59,$04,$11,$42

    L_b752:
        cmp ($0a,x)

        .byte $6b,$7d,$59,$4a,$7b,$34,$52,$93,$f0,$e6,$79,$6e,$d4,$57,$96,$2b
        .byte $32,$5c,$d5,$ae,$d7,$5f,$e8,$e9,$1f,$a3,$ae,$30,$a2,$00,$a2,$67
        .byte $59,$66,$75,$df,$45,$ac,$5a,$06,$47,$fc,$77,$04,$b0,$2a,$c4,$13
        .byte $6f,$d9,$ce,$62,$58

    L_b789:
        cmp $b2
        sbc ($b0,x)
        lsr $76

    L_b78f:
         .byte $64,$1c
        .byte $66,$ca,$8a,$52,$7e,$05,$f8,$8c,$ed,$c0,$70,$3f,$4f,$56,$ee,$2d
        .byte $7d,$d7,$45,$63,$a3,$ae,$c7,$33

    L_b7a9:
        .byte $b7,$64
        .byte $ae,$04,$64,$9a,$94,$e8,$b1,$4d,$6a,$3e,$9d,$11,$a4,$a0,$98,$5b
        .byte $dc,$80,$cd,$5e,$00,$e4,$de,$bc,$08,$57

    L_b7c5:
        .byte $00
        .byte $3e,$ef,$98

    L_b7c9:
        .byte $03,$70,$1b
        .byte $41,$84,$92,$c9,$2e,$5c,$38,$7b,$80,$a0,$41,$c1,$6a,$62,$c3,$9f
        .byte $04,$aa,$ce,$ac,$c0,$43,$0d,$dc,$51,$a2,$dd,$74,$0a,$b3,$ab,$32
        .byte $99,$72,$5b,$c5,$02

    L_b7f1:
        and L_9ed7
        sbc $d6,x

        .byte $23,$bc,$7d,$2a,$52,$1b,$93,$0d,$1b,$9d
        .fill $41, $20
        .byte $2f,$13,$10,$01,$03

    L_b846:
        ora $21

        .fill $18, $0
        .byte $a2,$00,$78,$86,$01

    L_b865:
        lda $1511,x
        sta.a $00f9,x
        inx 
        bne L_b865
        jmp $0148

        .byte $93,$9f,$00,$08

    L_b875:
        lda L_b8d8
        cmp #$93
        beq L_b89c
        cmp #$9f
        beq L_b8bc
    L_b880:
        sta ($fb),y
        inc $fb
        bne L_b888
        inc $fc
    L_b888:
        dex 
        bne L_b880
    L_b88b:
        inx 
        inc $fe
        bne L_b875
        inc $ff
        bne L_b875
        lda #$37
        sta $01
        cli 
        jmp $582a
    L_b89c:
        inc $fe
        bne L_b8a2
        inc $ff
    L_b8a2:
        lda ($fe),y
        tax 
        beq L_b8ab
        cmp #$03
        bcc L_b8b6
    L_b8ab:
        inc $fe
        bne L_b8b1
        inc $ff
    L_b8b1:
        lda ($fe),y
        jmp $0108
    L_b8b6:
        lda $f8,x
        ldx #$01
        bne L_b880
    L_b8bc:
        ldx #$03
        bne L_b8ab
        ldy #$48
    L_b8c2:
        dex 
        lda L_5ba0,x
        sta L_ff00,x
        txa 
        bne L_b8c2
        dec $014d
        dec $0150
    L_b8d2:
        dey 
        bne L_b8c2
        inx 
        bne L_b875
    L_b8d8:
        sei 
    L_b8d9:
        lda #$37
        sta $01
        lda $ff
        sta $0867
        lda $0330
        sta $085d
        lda $0331
        sta $0862
        jsr L_fd98 + $b
        jsr L_fd15
        jsr L_ff5b
        cli 
        lda #$00
    L_b8fa:
        tay 
    L_b8fb:
        sta.a $0002,y
        sta $0200,y
        sta $023c,y
        iny 
        bne L_b8fb
        ldx #$3c
        ldy #$03
        stx $b2
        sty $b3
        jsr L_fd15
        cli 
        lda #$00
        sta vBorderCol
        sta vBackgCol0
        ldx #$00
    L_b91d:
        lda #$00
        sta vColorRam + $00,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
        sta vColorRam + $300,x
        lda $6000,x
        sta SCREEN_BUFFER_0 + $00,x
        inx 
        bne L_b91d
        lda #$6d
        sta $0330
        lda #$df
        sta $0331
        lda #$00
        sta SCREEN_BUFFER_0 + $100
        jmp L_0400

    L_b946:
         .byte $93,$00,$00,$93,$00,$00,$93,$00,$00,$93,$00,$00,$93,$00,$00,$93

    L_b956:
        .byte $00,$00,$93,$00,$00,$93,$92,$00
        .byte $4c,$79,$10,$4c,$d5,$10,$00,$9f,$0c,$93,$04,$00,$01,$01,$00,$07
        .byte $0e,$9f,$ff,$93,$04,$01,$34,$33,$33,$41,$40,$40,$9f,$00,$9f,$04
        .byte $07,$0e,$0e,$93,$0c,$00,$01,$9f,$14,$93,$04,$01,$03,$01,$00,$00
        .byte $01,$9f,$32,$93,$04,$00,$e0,$00,$00,$9f,$08,$41,$11,$11,$48,$68
        .byte $68,$9f,$ca

    L_b9a1:
        .byte $04,$00,$00
        .byte $01,$00,$00,$9f,$01,$10,$93,$17,$00,$9f,$0a,$8d,$48,$10,$a8,$b9
        .byte $e3,$16,$8d,$bd,$12,$a9,$03,$8d,$db,$10

    L_b9be:
        lda #$08
        sta sFiltControl
        lda #$00
        ldy #$09
    L_b9c7:
        sta L_1006,y
        dey 
        bpl L_b9c7
        ldy #$08
    L_b9cf:
        sta.a $00e6,y
        dey 
        bpl L_b9cf
        ldy #$02
    L_b9d7:
        lda #$fe
        sta $1013,y
        lda #$68
        sta.a $00e6,y
        lda #$08
        ldx L_1010,y
        sta sVoc1Control,x
        lda #$01
        sta.a $00f3,y
        sta L_1016,y
        sta.a $00e3,y
        dey 
        bpl L_b9d7
        sta L_1035
        sta $1019
        ldy #$1f
        lda #$00
    L_ba01:
        sta sVoc1FreqLo,y
        dey 
        bpl L_ba01
    L_ba07:
        rts 


        lda L_1035
        beq L_ba07
        lda #$06
        sta sFiltMode
        ldx #$02
    L_ba14:
        ldy L_1010,x
        lda $f9,x
        sta sVoc1FreqLo,y
        lda $fc,x
        sta sVoc1FreqHi,y
        lda L_104c,x
        sta sVoc1PWidthHi,y
        lda L_1045 + $4,x
        sta sVoc1PWidthLo,y
        lda L_1055,x
        sta sVoc1SusRel,y
        lda $1052,x
        sta sVoc1AttDec,y
        lda L_104f,x
        and $1013,x
        sta sVoc1Control,y
        dex 
        bpl L_ba14
        ldy L_1006
        beq L_ba57
        dec $1019
        bne L_ba57
        sty $1019
        dec $10db
        bmi L_baae
    L_ba57:
        lda #$00
        sta $ff
        dec $ef
        bpl L_ba82
        ldy L_1045 + $3
        lda L_16e2,y
        bpl L_ba7c
        lda $e2
        eor #$ff
        sta $e2
        bpl L_ba79
        lda L_16e2,y
        and #$7f
        sec 
        sbc #$01
        bpl L_ba7c
    L_ba79:
        lda L_16e2,y
    L_ba7c:
        and #$7f
        sta $ef
        dec $ff
    L_ba82:
        ldx #$02
    L_ba84:
        lda $ff
        bpl L_ba9d
        lda L_1006 + $4,x
        bne L_ba99
        lda $f3,x
        cmp L_1020 + $3,x
        bne L_ba99
        lda #$fe
        sta $1013,x
    L_ba99:
        dec $f3,x
        beq L_bac2
    L_ba9d:
        lda $f0,x
        cmp #$ff
        beq L_baa6
        jsr L_134a
    L_baa6:
        lda #$00
        sta $ec,x
        dex 
        bpl L_ba84
        rts 


    L_baae:
        ldx #$02
    L_bab0:
        lda #$00
        ldy L_1010,x
        sta sVoc1FreqHi,y
        sta sVoc1FreqLo,y
        dex 
        bpl L_bab0
    L_babe:
        sta L_1035
        rts 


    L_bac2:
        ldy $e3,x
        lda L_16f3,y
        sta $e0
        lda L_171c,y
        sta $e1
        lda #$00
        sta L_102c + $3,x
        ldy $e6,x
        lda ($e0),y
        cmp #$ff
        beq L_bade
        jmp L_1212
    L_bade:
        dec L_1016,x
        beq L_baec
        ldy #$00
        sty $e6,x
        lda ($e0),y
        jmp L_1212
    L_baec:
        txa 
        asl 
        adc L_1045 + $3
        tay 
        lda L_16db + $1,y
        sta $e0
    L_baf7:
        lda L_16dd,y
        sta $e1
        ldy $e9,x
        lda ($e0),y
        bne L_bb0e
        tay 
        sty $e9
        sty $ea
        sty $eb
        lda ($e0),y
        jmp L_11df
    L_bb0e:
        cmp #$fe
        beq L_baae
        cmp #$80
        bcc L_bb1e
        and #$7f
        sta L_1006 + $1,x
        iny 
        lda ($e0),y
    L_bb1e:
        cmp #$70
        bcc L_bb2a
        and #$0f
        sta L_1006 + $7,x
        iny 
        lda ($e0),y
    L_bb2a:
        cmp #$40
        bcc L_bb36
        and #$1f
        sta L_1016,x
        iny 
    L_bb34:
        lda ($e0),y
    L_bb36:
        sta $e3,x
        lda #$00
        sta $e6,x
        inc L_1016,x
        iny 
    L_bb40:
        sty $e9,x
        jmp L_118f
        cmp #$fa
        bne L_bb52
        iny 
        lda ($e0),y
        sta $10db
        iny 
        lda ($e0),y
    L_bb52:
        cmp #$fd
        bne L_bb79
        iny 
        lda ($e0),y
        sta L_102c + $3,x
        iny 
        lda ($e0),y
        clc 
        adc L_1006 + $1,x
        adc $12bd
        sta $f0,x
        iny 
        lda ($e0),y
        clc 
        adc L_1006 + $1,x
        adc $12bd
        sta L_1032,x
        iny 
        jmp L_12c1
    L_bb79:
        cmp #$e0
        bcc L_bb96
        and #$1f
        sta $f6,x
        lda #$ff
        sta $f0,x
        lda #$00
        sta L_104f,x
        sta $1052,x
        sta L_1055,x
        iny 
        sty $e6,x
        jmp L_1343

    L_bb96:
         .byte $c9,$c0,$90,$1e
        .byte $18,$7d,$0d,$10,$29,$1f,$9d,$26,$10,$9f,$0a,$38,$fd,$26,$10,$9d
        .byte $26,$10,$c8,$b1,$e0

    L_bbaf:
        cmp #$fd

        .byte $f0,$9e,$c9,$c0,$b0,$3c,$c9,$80,$90,$1f,$29,$7f,$18,$75,$f3,$95
        .byte $f3,$95,$f6,$c8,$b1,$e0,$c9,$fd,$f0,$86,$c9,$fa,$d0,$03,$4c,$12
        .byte $12

    L_bbd2:
        .byte $c9,$c0,$b0,$1d,$c9,$80,$b0,$e1,$c9,$60,$90,$0c,$29,$1f,$9d,$64
        .byte $10,$c8,$b1,$e0,$c9,$60,$b0,$09,$18,$7d,$07,$10,$69,$fd,$95,$f0

    L_bbf2:
        .byte $c8,$94,$e6,$f6,$ec,$bd,$0a,$10,$f0,$0a,$a9,$00,$9d,$0a,$10,$9d
        .byte $39,$10,$f0,$5c,$bc,$26,$10,$b9,$69,$18,$9d,$4f,$10,$b9,$6a,$18
        .byte $9d,$52,$10,$b9,$6b,$18,$9d,$55,$10,$a9,$00,$9d,$49,$10,$b9,$6c
        .byte $18,$29,$0f,$9d,$4c,$10,$29,$08,$f0,$04,$a9,$01,$d0,$02

    L_bc30:
        lda #$00
    L_bc32:
        sta L_105d + $1,x
        lda L_186c,y
    L_bc38:
        and #$f0

        .byte $9f,$4a,$d5,$f6,$b0,$05,$9d,$23,$10,$d0,$05

    L_bc45:
        lda $f6,x
        sta L_1020 + $3,x
    L_bc4a:
        lda #$ff
        sta $1013,x
        lda L_1868,y
        sta L_1020,x
        and #$8f
        beq L_bc61
        lda #$00
        sta $fc,x
        sta $f9,x
        beq L_bc66
    L_bc61:
        lda $f0,x
        jsr L_1644
    L_bc66:
        ldy $e6,x
        lda ($e0),y
        cmp #$fb
        bne L_bc74
        inc L_1006 + $4,x
        iny 
        sty $e6,x
    L_bc74:
        lda $f6,x
        sta $f3,x
        jmp L_1177
        lda $ec,x
        bne L_bc82
        jmp L_13d3

    L_bc82:
         .byte $bd,$2f,$10,$f0,$20
        .byte $a8,$93,$04,$4a,$9d,$29,$10,$98,$29,$0f,$9d,$2f,$10,$b5,$f6,$38
        .byte $fd,$29,$10,$9d,$29,$10,$bd,$32,$10,$38,$f5,$f0,$9d,$2c,$10

    L_bca6:
        lda L_1020,x
        bmi L_bcc8
        and #$0f
        beq L_bcc8
        tay 
        lda #$02
        sta L_1062 + $14,x
        lda $1947,y
        sta L_104f,x
        bpl L_bcc3
        lda #$ff
        sta $fc,x
        bne L_bcc8
    L_bcc3:
        lda $f0,x
        jsr L_1644

    L_bcc8:
         .byte $a9,$00,$9d,$70,$10,$9d,$73,$10,$9d,$67,$10,$bc,$26,$10,$b9,$6d

    L_bcd8:
        .byte $18,$9d,$1a,$10,$b9,$6e,$18,$9d,$1d,$10,$93,$04
        .byte $4a,$9d,$36,$10,$b5,$f6,$38,$fd,$36,$10,$b0,$07,$a9,$00,$9d,$1a
        .byte $10,$90,$08

    L_bcf7:
        sta L_1035 + $1,x
        lda #$00
        sta L_1039,x
    L_bcff:
        jmp L_14ca
        ldy L_102c + $3,x
        beq L_bd6f
        lda $1029,x
        cmp $f3,x
        bcc L_bd6c
        lda #$00
        sta $e1
        lda #$07
        dey 
        dey 
        bmi L_bd1e
        asl 
        rol $e1
        jmp L_13e6
    L_bd1e:
        sta $e0
        ldy L_102c,x
        bmi L_bd44
        lda $f9,x
        clc 
        adc $e0
        sta $f9,x
        lda $fc,x
        adc $e1
        sta $fc,x
        lda $f9,x
        ldy L_1032,x
        sec 
    L_bd38:
        sbc L_1644,y
        lda $fc,x
        sbc $168a,y
        bcc L_bd6c
        bcs L_bd61
    L_bd44:
        lda $f9,x
        sec 
        sbc $e0
        sta $f9,x
        lda $fc,x
        sbc $e1
        sta $fc,x
        ldy L_1032,x
        lda $f9,x
        sec 
        sbc L_1644,y
        lda $fc,x
        sbc $168a,y
        bcs L_bd6c
    L_bd61:
        tya 
        sta $f0,x
        jsr L_1644
        lda #$00
        sta L_102c + $3,x
    L_bd6c:
        jmp L_14ca

    L_bd6f:
         .byte $bd,$1a,$10,$f0,$48
        .byte $bd,$36,$10,$d5,$f3,$90,$41,$bd,$39,$10,$d0,$3f,$a9,$00,$9d,$3f
        .byte $10,$bd,$1a,$10,$29,$0f,$4a,$69,$00,$9d,$3c,$10,$fe,$39,$10,$b4
        .byte $f0,$b9,$44,$16,$38,$f9,$43,$16,$9d,$42,$10,$b9,$8a,$16,$f9,$89
        .byte $16,$9d,$45,$10,$bd,$1a,$10,$93,$04,$4a,$a8,$88,$30,$46,$5e,$45
        .byte $10,$7e,$42,$10,$4c,$81,$14,$4c,$ca,$14,$de,$3c,$9f,$10,$bd,$1a
        .byte $10,$29,$0f,$9d,$3c,$10,$bd,$3f,$10,$49,$01,$9d,$3f,$10,$bd,$3f
        .byte $10,$d0,$11,$b5,$f9,$18,$7d,$42,$10,$95,$f9,$b5,$fc,$7d,$45,$10
        .byte $95,$fc,$90,$0f

    L_bde8:
        lda $f9,x
        sec 
        sbc L_1042,x
        sta $f9,x
        lda $fc,x
        sbc L_1045,x
        sta $fc,x
    L_bdf7:
        lda L_101d,x
        and #$0f
        bne L_be01
        jmp L_155c
    L_be01:
        ldy $ec,x
        beq L_be11
        tay 
        lda #$00
        sta L_1058,x
        lda #$01
        sta L_105b,x
        tya 
    L_be11:
        tay 
        lda L_1764,y
        sta $e0
        lda L_1768 + $1,y
        sta $e1
        ldy #$00
        lda ($e0),y
        sta $1556
        iny 
        lda ($e0),y
        sta $153a
        ldy L_1058,x
        bne L_be35
        lda #$02
        sta L_1058,x
        bne L_be89
    L_be35:
        ldy L_1058,x
        lda ($e0),y
        beq L_be4f
        dec L_105b,x
        bne L_be4f
        sta L_105b,x
        iny 
        lda ($e0),y
        sta L_1061,x
        iny 
        tya 
        sta L_1058,x
    L_be4f:
        lda L_105d + $1,x
        bne L_be70
        lda L_1045 + $4,x
        clc 
        adc L_1061,x
        sta L_1045 + $4,x
        lda L_104c,x
        adc #$00
    L_be63:
        sta L_104c,x
        cmp #$0a
        bcc L_be89
    L_be6a:
        inc L_105d + $1,x
        jmp L_155c
    L_be70:
        lda L_1045 + $4,x
        sec 
        sbc L_1061,x
        sta L_1045 + $4,x
        lda L_104c,x
        sbc #$00
    L_be7f:
        sta L_104c,x
        cmp #$08
        bcs L_be89
        dec L_105d + $1,x
    L_be89:
        lda L_1020,x
        bpl L_bed7
        and #$0f
        sta $1587
        tay 
        lda L_1768 + $7,y
        sta $e0
        lda L_1768 + $9,y
        sta $e1
        ldy L_1062 + $e,x
        lda ($e0),y
        bne L_beab
        iny 
        lda ($e0),y
        tay 
        lda ($e0),y
    L_beab:
        sta L_104f,x
        iny 
        tya 
        sta L_1062 + $e,x
        ldy #$ff
        lda L_1768 + $b,y
        sta $e0
        lda L_1768 + $d,y
        sta $e1
        ldy L_1062 + $11,x
        lda ($e0),y
        bne L_becc
    L_bec6:
        iny 
        lda ($e0),y
        tay 
        lda ($e0),y
    L_becc:
        pha 
        iny 
        tya 
        sta L_1062 + $11,x
        pla 
        jsr L_1644
        rts 


    L_bed7:
        lda L_1020,x
        bmi L_bef8
        and #$0f
        beq L_bef8
        dec L_1062 + $14,x
        bne L_bef8
        lda L_104f,x
        bpl L_beef
        lda $f0,x
        jsr L_1644
    L_beef:
        ldy L_1020 + $6,x
        lda $1869,y
        sta L_104f,x
    L_bef8:
        lda L_1020,x
        and #$40
        beq L_bf70
        lda L_1062 + $2,x
        tay 
        lda L_173d + $9,y
        clc 
        adc #$c0
        sta $e0
        lda #$17
        adc #$00
        sta $e1
        ldy L_1062 + $5,x
        bne L_bf1f
        lda ($e0),y
        sta L_1062 + $8,x
        iny 
        jmp L_1607
    L_bf1f:
        lda L_1062 + $8,x
        sec 
        sbc #$10
        sta L_1062 + $8,x
        bpl L_bf68
        ldy #$00
        lda ($e0),y
        sta L_1062 + $8,x
        ldy L_1062 + $5,x
        lda ($e0),y
        cmp #$ff
    L_bf38:
        bne L_bf44
        ldy #$00
        lda ($e0),y
        and #$0f
        tay 
        iny 
        lda ($e0),y
    L_bf44:
        cmp #$fe
        bne L_bf56
        ldy L_1020 + $6,x
        lda L_1020,x
        and #$fb
        sta L_1020,x
        jmp L_1643
    L_bf56:
        sta L_1062 + $b,x
        iny 
        tya 
        sta L_1062 + $5,x
        lda L_104f,x
        bpl L_bf68
        lda L_1062 + $14,x
        bne L_bf70
    L_bf68:
        lda L_1062 + $b,x
        clc 
        adc $f0,x
        bpl L_bf71
    L_bf70:
        rts 


    L_bf71:
        tay 
        lda L_1644,y
        sta $f9,x
        lda $168a,y
        sta $fc,x
        rts 



        .byte $2e,$38,$5a,$7d,$a3,$cc,$f6,$23,$53

    L_bf86:
        stx $bb

        .byte $f4,$30,$70,$b4,$fb,$47,$98,$ed,$47,$a7,$0c,$77,$e9,$61,$e1,$68
        .byte $f7,$8f,$30,$da,$8f,$4e,$18,$ef,$d2,$c3,$c3,$d1,$ef,$1f,$60,$b5
        .byte $1e,$9c,$31,$df,$a5,$87,$86,$a2,$df,$3e,$c1,$6b,$3c,$39,$63,$be
        .byte $4b,$0f,$0c,$45,$bf,$7d,$83,$d6,$79,$73,$c7,$fd,$93,$06,$02,$93
        .byte $05,$03,$93,$04,$04,$9f,$05,$06,$06,$9f,$07,$08,$08,$09,$09,$0a
        .byte $0b,$0b,$0c,$0d,$0e,$0e,$0f,$10,$11,$12,$13

    L_bfe3:
        ora $16,x

        .byte $17,$19,$1a,$1c,$1d,$1f,$21,$23,$25,$27,$2a,$2c,$2f,$32,$35,$38
        .byte $3b,$3f,$43,$47,$4b,$4f,$54,$59,$5e,$64,$6a

    L_c000:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$3f
        .byte $70,$60,$6c,$68,$c0,$c0,$c0,$f0,$18

    L_c012:
        php 

        .byte $00,$00,$00,$c0,$c0,$c3,$c0,$c0,$d5,$c0,$d4,$c0,$d4,$c0,$00,$00
        .byte $54,$00,$54,$c0,$d4,$d4,$d4,$d4,$e8,$d4,$e8,$e8,$c0,$d4,$d4,$d4
        .byte $e8,$d4,$e8,$e8,$c0,$ff,$c0,$c0,$d8,$d0,$c0,$c0,$c0,$e0,$30,$18
        .byte $00,$00,$00,$c0,$c0,$c3,$c0,$c0,$d5,$c0,$d4,$c0,$d4,$c0,$00,$00
        .byte $70,$08,$5c,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$ea,$c0,$d4,$d4,$54
        .byte $a8,$54,$a4,$90

    L_c067:
        .byte $00,$0f
        .byte $38,$60

    L_c06b:
        jmp (L_c0c7 + $1)

        .byte $c0,$c0,$e0,$30,$18,$00,$00,$00,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4
        .byte $c0,$d4,$c0,$c0,$c0,$00,$f8,$d4,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea
        .byte $3a,$0c,$d4,$54,$54,$a8,$54,$a4,$90

    L_c097:
        .byte $00,$ff
        .byte $c0,$cc,$c8,$c0,$c0,$c0,$c0,$e0,$30,$18,$00,$00,$00,$c0,$c0,$c0
        .byte $c0,$c0,$d4

    L_c0ac:
        cpy #$d4
        cpy #$d4
    L_c0b0:
        cpy #$c0
        cpy #$d4
        cpy #$d4
        cpy #$d4

        .byte $d4,$d7,$d5,$ea,$d7

    L_c0bd:
        nop 
    L_c0be:
        nop 
        cpy #$d4

        .byte $d4,$54,$a8,$54,$a4,$90

    L_c0c7:
        .byte $00,$ff
        .byte $c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00,$c0
        .byte $c3,$c0,$d4,$c0,$d4,$c0,$d4

    L_c0e0:
        .byte $00,$f0,$00,$00,$00,$00,$00,$00,$d4,$d7
        .byte $d5,$ea,$d5,$ea,$ea,$c0,$00,$fc,$54,$a8,$54,$a8,$a8

    L_c0f7:
        .byte $00,$ff
        .byte $c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00,$c0
        .byte $c3,$c0,$d4,$c0,$d4,$c0,$d4,$00,$f0,$00,$00,$00,$00,$00,$00,$d4
        .byte $d4,$d4,$e8,$d4

    L_c11d:
        inx 
        inx 
        cpy #$00

        .byte $00,$00,$00,$00,$00,$00,$00,$0f,$38,$60,$6c,$c8,$c0

    L_c12e:
        .byte $c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00
        .byte $c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$00,$00,$00,$00,$f8,$d4,$c0,$d4
        .byte $d4,$d7,$d5,$ea,$d5,$ea

    L_c14e:
        .byte $3a,$0c,$d4,$54,$54
        .byte $a8,$54,$a4,$90,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$c0,$c3,$c0,$c0,$d5,$c0,$d5,$c0,$d4,$c0,$00,$00
        .byte $54,$00,$54,$00,$54,$d4,$d4,$d4,$e8,$d4

    L_c17d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$ff

    L_c189:
        cpy #$d8

        .byte $d0,$c0,$c0,$c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c
        .byte $0d,$0c,$0d,$0c,$0d,$00,$00,$00,$40,$00,$40,$00,$40,$0d,$fd,$d5
        .byte $ea,$d5,$ea,$ea,$c0,$40,$7c,$54,$a8,$54,$a8,$a8,$00,$ff,$c0,$d8
        .byte $d0,$c0,$c0,$c0,$c0,$fc

    L_c1c1:
        .byte $00,$00,$00,$00,$00,$00,$00,$03,$03,$03,$03,$03,$03,$03,$03,$00
        .byte $00,$00,$50,$00

    L_c1d5:
        bvc L_c1d7

    L_c1d7:
         .byte $50,$0d
        .byte $fd,$d5,$ea,$d5,$ea,$ea,$c0,$50,$50,$50,$a0,$50,$40,$00,$00,$fc
        .byte $c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0,$c0,$80,$c3
        .byte $c0,$c0,$d5,$c0,$d5,$c0

    L_c1ff:
        .byte $d4,$00,$00,$00

    L_c203:
        bvs L_c20d

        .byte $5c,$00,$54,$d4,$d4,$d4,$e8,$d4

    L_c20d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$00

    L_c221:
        .byte $00,$00,$00,$00,$00,$00,$00
        .byte $c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d4,$d7,$d5,$ea,$d5,$ea,$ea,$c0,$00,$fc,$54,$a8,$54,$a8,$a8,$00
        .byte $f8,$cc,$c6,$d3,$d1,$c1,$c0,$c0,$3c

    L_c251:
        rts 



        .byte $c0,$80,$00,$00,$00,$00,$c0,$c0,$c0,$d5,$c0,$d4,$c0,$d4

    L_c260:
        .byte $00,$00,$00,$54
        .byte $c0,$d4,$c0,$d4,$d4,$d4,$d4,$e8,$d4,$e8,$e8,$c0,$d4,$d4,$d4,$e8
        .byte $d4,$e8,$e8,$c0,$f0,$d8,$d8,$cc,$cc,$c6,$d6,$c2,$fc,$c0,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$c3,$c0,$c0,$d5,$c0,$d5,$c0,$d4,$c0,$00

    L_c292:
        .byte $00,$54,$00,$54,$00,$54,$d4,$d4,$d4
        .byte $e8,$d4

    L_c29d:
        inx 
        inx 
    L_c29f:
        cpy #$d4

    L_c2a1:
         .byte $d4,$d4
        .byte $e8,$34,$38,$38,$00,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0,$30,$18
        .byte $00,$00,$00,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0,$c0

    L_c2c2:
        cpy #$d4
        cpy #$d4
        cpy #$d4

        .byte $d4,$d7

    L_c2ca:
        cmp $ea,x
        cmp $ea,x

        .byte $3a,$0c,$d4,$54,$54,$a8,$54

    L_c2d5:
        ldy $90

        .byte $00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$e0,$30,$18,$00,$00,$00,$c0
        .byte $c0,$c0,$c3,$c0,$d5,$c0,$d5,$c0,$d4,$c0,$00,$00,$50,$00

    L_c2f5:
        rti 

        .byte $00,$00,$d4,$d4,$d4

    L_c2fb:
        inx 

        .byte $d4

    L_c2fd:
        inx 
        inx 
        cpy #$00

        .byte $00,$00,$00,$00,$00,$00,$00,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0
        .byte $30,$18,$00,$00,$00,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0
        .byte $c0,$c0,$d4,$c0,$d4,$c0,$d4,$d7,$d4,$d4,$e8,$d4,$ea,$3a,$0c,$d4
        .byte $74,$5c,$ac,$1c,$24,$28,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$e0
        .byte $30,$18,$00,$00,$00,$c0,$c0,$c0,$c3,$c0,$d5,$c0,$d5,$c0,$d4,$c0
        .byte $00,$14,$70,$08

    L_c355:
        .byte $5c,$00,$54,$d4,$d4,$d4

    L_c35b:
        inx 

        .byte $d4

    L_c35d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0
        .byte $30,$18,$00,$00,$00,$c0,$c0,$c0,$c0,$c0,$15,$03,$00,$fc,$d4,$00
        .byte $c0,$30,$58,$0c,$54,$c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$3a,$0c,$d4
        .byte $54,$54,$a8,$54,$a4,$90,$00,$ff,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc

    L_c3a1:
        .byte $00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c
        .byte $0d,$0c,$0d,$0c,$0d,$00,$00,$00,$40,$00,$40,$00,$40,$0d,$0d,$0d
        .byte $0e,$0d,$0e,$0e,$0c,$40,$40,$40,$80,$40,$80,$80,$00,$fc,$c0,$d8
        .byte $d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
        .byte $d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$d4,$d7,$d5
        .byte $ea,$d5,$ea

    L_c3ee:
        .byte $3a,$0c,$d4,$54,$54
        .byte $a8,$54,$a4,$90,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$d4,$c0,$d4,$c0,$d4,$c0,$c0,$c0
        .byte $d4,$c0,$d4

    L_c416:
        cpy #$d4

        .byte $d4,$d7,$d5,$2a,$35,$0a,$0e,$00,$d4

    L_c421:
        .byte $54,$54,$90,$50,$80
        .byte $40,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0
        .byte $c0,$c0,$c0,$c0,$c0,$d5,$c0,$d5,$c0,$d5,$c0,$c0,$c0,$d4,$00,$54
        .byte $00,$54,$d5,$d5,$d4,$e8,$d0,$e0,$c0,$c0,$54,$94,$d4,$28,$14,$08
        .byte $08,$00,$fc,$c0,$d8,$d0,$c0,$c0,$c0,$c0,$fc,$c0,$c0,$c0,$c0,$c0
        .byte $c0,$80,$c3,$c0,$00,$15,$30,$d5,$c0

    L_c46f:
        .byte $d4,$00,$00,$00
        .byte $70,$08,$5c,$00,$54,$d4,$d4,$d4,$e8,$d4

    L_c47d:
        inx 
        inx 
        cpy #$d4

        .byte $d4,$d4,$e8,$d4,$e8,$e8,$c0,$f8,$c0,$d8

    L_c48b:
        .byte $d0,$c0
        .byte $c0,$c0,$c1,$fc,$c0,$c0,$c0,$c0,$c0,$c0,$80,$c0,$c0,$30,$0d,$0c
        .byte $0d,$0c,$0d,$00,$00,$00,$40,$00,$40,$00,$40,$0d,$0d,$0d,$0e,$0d
        .byte $0e,$0e,$0c,$40,$40,$40,$80,$40,$80,$80,$00,$ff,$c0,$d8,$d0,$c0
        .byte $c0,$c0,$c0,$fc,$00,$00,$00,$00,$00,$00,$00,$03,$03,$0c,$0d,$0c
        .byte $35,$30,$35,$00,$00,$00,$50,$00

    L_c4d5:
        rti 

        .byte $00,$40,$35,$d5,$d5,$ea,$d5,$ea,$ea,$c0,$40,$7c,$54,$a8,$54,$a8
        .byte $a8,$00,$0f,$18,$30,$6c,$c8,$c0,$c0,$c0,$c0

    L_c4f1:
        .byte $00,$00,$00,$00,$00,$00,$00,$0c,$0c,$0c
        .byte $0d,$0c,$0d,$0c,$0d,$00,$00,$00,$40,$00

    L_c505:
        rti 

        .byte $00,$40,$0d,$fd,$d5,$ea,$d5,$ea,$ea,$c0,$40,$7c,$54,$a8,$54,$a8
        .byte $a8

    L_c517:
        .byte $00,$0f
        .byte $38,$60,$6c,$c8,$c0

    L_c51e:
        .byte $c0,$c0,$e0,$30,$18,$00,$00,$00
        .byte $c0,$c0,$c0,$c0,$c0,$55,$00,$14,$00,$fc,$c0,$c0,$00,$54,$00,$54
        .byte $c0,$d4,$d4,$d7,$d5,$ea,$d5,$ea,$3a,$0c,$d4,$54,$54,$a8,$54,$a4
        .byte $90,$00,$0f,$38,$60,$6c,$c8,$c0,$c0,$c0,$e0,$30,$18,$00,$00,$00
        .byte $c0,$c0

    L_c558:
        cpy #$c0
        cpy #$d4
        cpy #$d4
        cpy #$d4
        cpy #$c0
        cpy #$d4
        cpy #$d4
        cpy #$d4

        .byte $d4,$d7,$d5,$ea,$d5,$ea

    L_c56e:
        .byte $3a,$0c,$d4,$54,$54
        .byte $a8,$54,$a4,$90,$00,$00,$00,$00,$40

    L_c57c:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$10,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$04,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$02,$00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $80,$00,$00,$02,$00,$00,$00,$00,$00,$00,$08

    L_c5c7:
        .fill $61, $0

    L_c628:
        lda #$01
        sta $17
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        jsr L_33df
        lda #$38
        sta vMemControl
        lda #$c0
        ldx #$3b
        jsr L_3c84
    L_c643:
        lda #$ff
        sta L_3935
    L_c648:
        jsr L_3498
        lda #$3b
        sta vScreenControl1
    L_c650:
        jsr L_3399
        bne L_c650
    L_c655:
        jsr L_2407
        jsr L_33b4
        jsr L_337e
        beq L_c675
        lda #$04
        sta L_1006
        ldx #$46
    L_c667:
        jsr L_2407
        dex 
        bne L_c667
        lda L_3935
        sta $ff
        jmp L_0800
    L_c675:
        jsr L_3399
        beq L_c655
        bne L_c648
        beq L_c648
        lda $227b
        sec 
        sbc #$d9
        cmp #$10
        bcs L_c696
        lda L_2277 + $1
        sec 
        sbc #$7c
        cmp #$23
        bcs L_c696
        lda L_22f9 + $1
        rts 


    L_c696:
        lda #$00
        rts 


        lda $227b
        sec 
        sbc #$d9
        cmp #$10
        bcs L_c6b1
        lda L_2277 + $1
        sec 
        sbc #$40
        cmp #$34
        bcs L_c6b1
        lda L_22f9 + $1
        rts 


    L_c6b1:
        lda #$00
        rts 


        lda L_3935
        and #$03
        asl 
        asl 
        asl 
        tax 
        lda L_3457 + $1,x
        sta $16
        lda L_3457 + $2,x
        sta $14
        lda L_3457 + $3,x
        sta $10
    L_c6cc:
        lda L_3457 + $4,x
        sta $11
        lda L_345c,x
        sta $0e
        lda L_345d,x
        sta $0f
        jsr L_33ea
        rts 


        ldx #$08
        ldy #$00
    L_c6e3:
        dey 
        bne L_c6e3
        dex 
        bne L_c6e3
        rts 


        lda $10
        sta $04
        lda $11
        sta $05
        inc L_3457
        lda L_3457
        and #$0f
        clc 
        adc $14
        tax 
        jsr L_3437
        lda $04
        cmp $0e
        beq L_c70c
        inc $04
        jmp L_33fe
    L_c70c:
        jsr L_3437
        lda $05
        cmp $0f
        beq L_c71a
        inc $05
        jmp L_340c
    L_c71a:
        jsr L_3437
        lda $04
        cmp $10
        beq L_c728
        dec $04
        jmp L_341a
    L_c728:
        jsr L_3437
        lda $05
        cmp $11
        beq L_c736
    L_c731:
        dec $05
        jmp L_3428
    L_c736:
        rts 


        ldy $05
        lda L_3fc0,y
        clc 
    L_c73d:
        adc $04
        sta $12
        lda L_3fd7 + $2,y
        adc #$00
        clc 
        adc #$cc
        sta $13
        ldy #$00
        lda ($12),y
        and $16
        ora L_3476 + $2,x
        sta ($12),y
        rts 



        .byte $00,$0f,$00,$00,$00,$0a,$08,$00,$00,$f0,$10,$00,$08

    L_c764:
        asl 

        .byte $10,$00,$00,$0f,$00,$00,$10,$0a,$18

    L_c76e:
        .byte $00,$00,$0f,$00,$00,$00
        .byte $0a,$18,$00,$00,$00,$60,$b0,$40,$e0,$50,$f0,$70,$70,$f0,$50,$e0
        .byte $40,$b0,$60,$00,$00

    L_c789:
        asl $0b

        .byte $04,$0e,$05,$0f,$07,$07,$0f,$05,$0e,$04,$0b,$06,$00,$a0,$77,$a2
        .byte $3a,$ad,$35,$39,$18,$69,$01,$29,$03,$8d,$35,$39,$f0,$08,$c9,$03
        .byte $d0,$0b,$a0,$36,$a2,$39

    L_c7b1:
        tya 
        jsr L_3c84
        jmp L_34bf
    L_c7b8:
        lda #$d0
        ldx #$34
        jsr L_3c84
        jsr L_38d5
        lda L_3935
    L_c7c5:
        asl 
        tay 
        lda L_34fb,y
        ldx $34fc,y
        jmp L_3c84

        .byte $86,$00,$00,$00,$18,$cc,$01,$86,$0a,$00,$0a

    L_c7db:
        clc 
        cpy L_85f9 + $8
        ora ($00,x)
        ora #$00
        cpy L_85f9 + $8
        ora ($08,x)
        ora #$08
        cpy L_85f9 + $8
        ora ($10,x)
        ora #$10
        cpy L_85f9 + $8
        ora ($18,x)
        ora #$18
        cpy $ff01
        ldy $37,x
    L_c7fd:
        ldx $36

        .byte $9e

    L_c800:
        .fill $4e, $0
        .byte $b2

    L_c84f:
        .fill $57, $0
        .byte $0d,$0e,$55,$56,$5b,$5c,$91,$92,$67,$68,$31,$32,$25,$26,$2b,$2c
        .byte $73,$74,$00,$00,$9d,$9e,$a3,$a4,$a3,$a4,$a9,$aa,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$0f,$10,$57,$58,$5d,$5e,$93,$94
        .byte $69,$6a,$33,$34,$27,$28,$2d,$2e,$75,$76,$00,$00,$9f,$a0,$a5,$a6
        .byte $a5,$a6,$ab,$ac,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $11,$12,$59,$5a,$5f,$60,$95,$96,$6b,$6c,$35,$36,$29,$2a,$2f,$30
        .byte $77,$78,$00,$00,$a1,$a2,$a7,$a8,$a7,$a8,$ad,$ae,$00,$00,$00,$00
        .byte $00,$00,$00,$7f,$80,$31,$32,$67,$68,$25,$26,$31,$32,$4f,$50,$00
        .byte $00,$49,$4a,$01,$02,$6d,$6e,$73,$74,$19,$1a,$67,$68,$73,$74,$67
        .byte $68,$55,$56,$4f,$50,$31,$32,$0d,$0e,$00,$00,$81,$82,$33,$34,$69
        .byte $6a,$27,$28,$33,$34,$51,$52,$00,$00,$4b,$4c,$03,$04,$6f,$70,$75
        .byte $76,$1b,$1c,$69,$6a,$75,$76,$69,$6a,$57,$58,$51,$52,$33,$34,$0f
        .byte $10,$00,$00,$83,$84,$35,$36,$6b,$6c,$29,$2a,$35,$36,$53,$54,$00
        .byte $00,$4d,$4e,$05,$06,$71,$72,$77

    L_c97e:
        sei 
        ora $6b1e,x
        jmp ($7877)

        .byte $6b,$6c,$59,$5a,$53,$54,$35,$36,$11,$12,$00,$00,$01,$02,$43,$44
        .byte $43,$44,$00,$00,$67,$68,$31,$32,$25,$26,$2b,$2c,$73,$74,$6d,$6e
        .byte $00,$00,$67,$68,$19,$1a,$6d,$6e,$19,$1a,$67,$68,$7f,$80,$19,$1a
        .byte $13,$14,$00,$00,$03,$04,$45,$46,$45,$46,$00,$00,$69,$6a,$33,$34
        .byte $27,$28,$2d,$2e,$75,$76,$6f,$70,$00,$00,$69,$6a,$1b,$1c,$6f,$70
        .byte $1b,$1c,$69,$6a,$81,$82,$1b,$1c,$15,$16,$00,$00,$05,$06,$47,$48
        .byte $47,$48,$00,$00,$6b,$6c,$35,$36,$29,$2a,$2f,$30,$77,$78,$71,$72
        .byte $00,$00,$6b,$6c,$1d,$1e,$71,$72,$1d,$1e,$6b,$6c,$83,$84,$1d,$1e
        .byte $17,$18,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$b1,$00
        .byte $00,$b5
        .fill $2d, $0
        .byte $b6,$00,$00,$b0
        .fill $a0, $0
        .byte $af
        .fill $1a, $0
        .byte $b3
        .fill $63, $0
        .byte $b4,$00

    L_cb69:
        .fill $8f, $0

    L_cbf8:
        rti 
        rti 
        rti 
        rti 
    L_cbfc:
        rti 
        rti 
        rti 
        rti 
        bpl L_cbfc
        ldy #$00
    L_cc04:
        lda L_2cee + $12,y
        sta L_c000,y
        lda $2e00,y
        sta $c100,y
        lda L_2eff + $1,y
        sta L_c1ff + $1,y
        lda $3000,y
        sta $c300,y
        lda $3100,y
        sta $c400,y
        lda $3200,y
        sta $c500,y
        lda L_3277 + $89,y
        sta L_c5c7 + $39,y
        lda $3400,y
        sta $c700,y
        dey 
        bne L_cc04
        lda #$20
        sta vMemControl
        lda #$18
        sta vScreenControl1
        lda #$c2
        sta $02
        lda #$29
        sta $03
        ldy #$00
        jsr L_2927
        lda L_213a
        and L_213a + $1
        and L_213a + $2
        and L_213a + $3
        and L_213a + $4
        and L_213a + $5
        and L_213a + $6
        and L_213a + $7
        cmp #$ff
        bne L_cc6f
        lda L_22f9 + $1
        beq L_cc72
    L_cc6f:
        jmp L_3328
    L_cc72:
        jsr L_2407
        jmp L_23d8
        lda #$00
        sta $275f
    L_cc7d:
        lda $275f
        beq L_cc7d
        rts 


        sta L_2760
        stx L_2760 + $1
        sty L_2760 + $2
        lda #$01
        sta vIRQFlags
        sta $275f
        jsr L_211d
        jsr $2281
        lda $17
        bne L_cca7
        jsr $2506
        jsr L_2451
        jmp L_2444
    L_cca7:
        jsr L_2142
        lda L_227a
        lsr 
        lda L_2277 + $2
        ror 
        sta L_2277 + $1
        jsr L_1003
        lda L_2760
        ldx L_2760 + $1
        ldy L_2760 + $2
        rti 
        dec L_275e
        beq L_ccc8
        rts 


    L_ccc8:
        lda #$02
        sta L_275e
        ldx #$00
    L_cccf:
        lda L_2675 + $1,x
        beq L_ccde
        txa 
        clc 
        adc #$0b
        tax 
        cpx #$f2
        bne L_cccf
        rts 


    L_ccde:
        lda #$00
        sta L_266c,x
        lda #$c8
        sta L_266d,x
        lda #$6a
        sta L_266e,x
        lda #$26
        sta L_266f,x
        lda #$a0
        sta $2670,x
        lda #$00
        sta L_2671,x
        lda #$08
        jsr L_2c45
        adc #$50
        sta $2674,x
        lda #$ff
        sta L_2675 + $1,x
        lda #$13
        jsr L_2c45
        asl 
        asl 
        tay 
        lda L_24b6,y
        sta L_2672,x
        lda L_24b6 + $1,y
        sta $2673,x
        lda L_24b6 + $2,y
        sta L_2675,x
        rts 


        rts 



        .byte $fc,$ff,$00,$00,$fd,$ff,$01,$00,$fe,$ff,$01,$00,$ff,$ff,$01,$00
        .byte $ff,$ff,$02,$9f,$00,$03,$00,$fd,$9f,$ff,$fe,$93,$09,$ff,$fe,$ff
        .byte $00,$00,$fd,$ff,$03,$00,$01,$00,$02,$00,$01,$00,$01,$00,$01,$00
        .byte $01,$00,$02,$00,$04,$9f,$00,$03,$00,$ff,$ff,$02,$00,$ff,$ff,$01
        .byte $00,$ff,$ff,$01,$00,$fe,$ff,$a9,$af,$8d,$66,$26,$a2,$00

    L_cd75:
        jsr L_2528
        txa 
        clc 
        adc #$0b
        tax 
        cpx #$f2
        bne L_cd75
        ldx #$00
    L_cd83:
        jsr L_2608
        txa 
        clc 
        adc #$0b
    L_cd8a:
        tax 
        cpx #$f2
        bne L_cd83
        rts 


        lda L_2675 + $1,x
        beq L_cd9b
        jsr $25e3
        jsr L_2540
    L_cd9b:
        rts 



        .byte $a9,$00,$9d,$72,$26,$9d,$74,$26,$f0,$f5,$00,$00,$bd,$74,$26,$8d
        .byte $69,$26,$9f,$4a,$a8,$c9,$19,$b0,$72,$bd,$71,$26,$8d,$68,$26,$bd
        .byte $70,$26,$8d,$67,$26,$4e,$68,$26,$6a,$4e,$68,$26,$6a,$4e,$68,$26
        .byte $6a,$c9,$28,$b0,$56,$18,$79,$34,$26,$85,$0a,$9d,$6c,$26,$b9,$4d
        .byte $26,$69,$00,$85,$0b,$9d,$6d,$26,$a0,$00,$b1,$0a,$f0,$06,$c9,$af
        .byte $90,$3f,$b0,$08

    L_cdf0:
        lda L_2666
        inc L_2666
        sta ($0a),y
    L_cdf8:
        sta $0c
        lda #$00
        asl $0c
        rol 
        asl $0c
        rol 
        asl $0c
        rol 
        adc #$c0
        sta $0d
        sta L_266f,x
        lda L_2669
        and #$07
        clc 
        adc $0c
        sta $0c
        sta L_266e,x
        lda $2667
        and #$07
        tay 
        lda L_25db,y
        ldy #$00
        sta ($0c),y
        rts 


    L_ce27:
        lda #$00
        sta L_2675 + $1,x
        rts 


    L_ce2d:
        lda #$00
        sta L_266c,x
        lda #$c8
        sta L_266d,x
        lda #$6a
        sta L_266e,x
        lda #$26
        sta L_266f,x
        rts 



        .byte $80,$40,$20,$10,$08,$04,$02,$01,$bd,$6c,$26,$85,$0a,$bd,$6d,$26
        .byte $85,$0b,$a0,$00,$b1,$0a,$c9,$af,$90,$12,$a9,$00,$91,$0a,$bd,$6e
        .byte $26,$85,$0a,$bd,$6f,$26,$85,$0b,$a9,$00,$91,$0a

    L_ce6e:
        rts 


        lda L_2675 + $1,x
        beq L_ce9a
        lda $2670,x
        clc 
        adc L_2672,x
        sta $2670,x
        sta $2667
        lda L_2671,x
        adc $2673,x
        sta L_2671,x
        sta L_2668
        lda $2674,x
        clc 
        adc L_2675,x
        sta $2674,x
        sta L_2669
    L_ce9a:
        rts 



        .byte $00,$28,$50,$78,$a0,$c8,$f0,$18,$40,$68,$90,$b8

    L_cea7:
        cpx #$08
        bmi L_cf03

        .byte $80,$a8,$d0,$f8,$20,$48,$70,$98,$c0,$93,$07,$c8,$93,$06,$c9,$93
        .byte $07,$ca,$93,$05,$cb,$ba

    L_cec1:
        ldx #$00
        eor $00,x

        .byte $00,$2e,$c9,$7a,$c5,$b8,$00,$01,$00,$39,$ff,$ff,$4e,$c9,$80,$c5
        .byte $74,$00,$fe,$ff,$3f,$ff,$ff,$29,$c9,$8d,$c5,$8c,$00,$ff,$ff,$3c
        .byte $ff,$ff,$51,$c9,$a5,$c5,$8e,$00,$ff,$ff,$44,$ff,$ff,$2d,$c9,$92
        .byte $c5,$b0,$00,$01,$00,$38,$fe,$ff,$50,$c9,$9b,$c5,$84,$00

    L_cf03:
        inc $42ff,x

        .byte $ff,$ff,$1d,$ca,$a2,$c5,$ac,$00,$01,$00,$6c,$02,$ff,$7a,$c9,$aa
        .byte $c5,$96,$00,$ff,$ff,$49,$ff,$ff,$53,$c9,$b4,$c5,$98,$00,$ff,$ff
        .byte $42,$fe,$ff,$7c,$c9,$bd,$c5,$a6,$00,$01,$00,$4c,$ff,$ff,$a4,$c9
        .byte $c5,$c5,$a8,$00,$02,$00,$54,$ff,$ff,$a4,$c9,$ce,$c5,$a2,$00,$01
        .byte $00,$55,$ff,$ff,$00,$c8,$6a,$26,$a0,$00,$03,$00,$58,$ff,$ff,$93
        .byte $4e,$00,$c8,$6a,$26,$a0,$00,$fe,$ff,$46,$01,$00,$00,$c8,$6a,$26
        .byte $a0,$00,$02,$00,$46,$01,$00,$02,$93,$04,$00,$c9,$20,$f0,$67,$aa
        .byte $a4,$05,$b9,$28,$28,$85,$06,$b9,$2e,$28,$85,$07,$b9,$34,$28,$85
        .byte $08,$b9,$3a,$28,$85,$09,$a5,$04,$a8,$18,$69,$28,$8d,$9e,$27,$8d
        .byte $c1,$27,$69,$28,$8d,$ab,$27,$8d,$c8,$27,$bd,$b3,$27,$91,$06,$18
        .byte $69,$01,$c8,$91,$06,$a0,$28,$18,$69,$01,$91,$06,$c8,$18,$69,$01
        .byte $91,$06,$a0,$50,$18,$69,$01,$91,$06,$c8,$18,$69,$01,$91,$06,$a4
        .byte $04,$a9,$00,$91,$08,$c8,$91,$08,$a0,$00,$91,$08,$c8,$91,$08,$a0
        .byte $00,$91,$08,$c8,$91,$08

    L_cfdc:
        inc $04
        inc $04
        rts 



        .byte $93,$10,$00

    L_cfe4:
        lda #$9d

        .byte $93,$07,$00,$a3,$93,$07,$00,$01,$07,$0d,$13,$19,$1f,$25,$2b,$31
        .byte $37,$3d,$43,$49

    L_cffa:
        .byte $4f
        .byte $55,$5b

    L_cffd:
        adc ($67,x)
    L_cfff:
        adc.a $0064

        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18
        .byte $1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00,$f0,$f0
        .byte $f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc

    L_d02f:
        .fill $11, $ff

    L_d040:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00

    L_d055:
        .byte $ff
        .byte $d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00,$f0,$f0,$f6,$fe,$fe,$f1
        .byte $f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc

    L_d06f:
        .fill $11, $ff

    L_d080:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d0c0:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2

    L_d0e9:
        .byte $f3,$f4
        .byte $f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2

    L_d129:
        .byte $f3,$f4
        .byte $f5,$f6,$f7,$fc

    L_d12f:
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d200:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2

    L_d229:
        .byte $f3,$f4
        .byte $f5,$f6,$f7,$fc

    L_d22f:
        .fill $11, $ff

    L_d240:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d280:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6

    L_d2ad:
        .byte $f7,$fc
        .fill $11, $ff

    L_d2c0:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc

    L_d2ef:
        .fill $11, $ff

    L_d300:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00

    L_d31c:
        .byte $00,$00
        .byte $fe,$00,$f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7
        .byte $fc
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4

    L_d3ab:
        sbc $f6,x

        .byte $f7,$fc
        .fill $11, $ff

    L_d3c0:
        .byte $64,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$18,$1f,$d1,$00,$ff,$d8,$00,$21,$7c,$f1,$00,$00,$00,$fe,$00
        .byte $f0,$f0,$f6,$fe,$fe,$f1,$f9,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca,$00,$00,$00,$06,$00

    L_d41a:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca,$00,$00,$00

    L_d458:
        asl $00

        .byte $00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60

    L_d468:
        .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60

    L_d488:
        .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00

    L_d4ba:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca

    L_d4d5:
        .byte $00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60

    L_d508:
        .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60

    L_d548:
        .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca

    L_d555:
        .byte $00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60

    L_d568:
        .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca

    L_d575:
        .byte $00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca

    L_d5b5:
        .byte $00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00

    L_d5fa:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40

    L_d605:
        pha 
        dex 
        rts 



        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40

    L_d625:
        pha 
        dex 
        rts 



        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20

    L_d683:
        ora #$40
        pha 
        dex 
        rts 



        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40,$48,$ca,$60
        .byte $16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca,$00,$00,$00
        .byte $06,$00

    L_d6ba:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca,$00,$00,$00,$06,$00

    L_d6da:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08,$11,$68,$ca,$00,$00,$00

    L_d6f8:
        asl $00

        .byte $00,$00,$00,$00,$00,$00

    L_d700:
        sec 
        asl $20,x
        ora #$40
        pha 
        dex 
        rts 



    L_d708:
         .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68

    L_d714:
        dex 

        .byte $00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00

    L_d720:
        sec 
        asl $20,x
        ora #$40
        pha 
        dex 
        rts 



    L_d728:
         .byte $16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00
        .byte $00,$38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f
        .byte $15,$00,$08,$11,$68,$ca,$00,$00,$00,$06,$00

    L_d77a:
        .byte $00,$00,$00,$00,$00,$00
        .byte $38,$16,$20,$09,$40,$48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15
        .byte $00,$08

    L_d792:
        ora ($68),y
        dex 

        .byte $00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40
        .byte $48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca
        .byte $00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40
        .byte $48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca
        .byte $00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00,$38,$16,$20,$09,$40
        .byte $48,$ca,$60,$16,$00,$08,$11,$68,$ca,$1f,$15,$00,$08,$11,$68,$ca
        .byte $00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00
        .fill $c9, $41
        .fill $3f, $49
        .byte $4b,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49
        .fill $29, $41
        .fill $4f, $49
        .fill $29, $41
        .fill $4f, $49
        .fill $29, $41
        .fill $4f, $49
        .byte $41,$41,$41,$41,$41,$41,$41,$41,$41,$41,$41,$41,$41,$47
        .fill $1b, $41
        .fill $4f, $49
        .fill $29, $41
        .fill $4f, $49
        .fill $20, $41

    L_db90:
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)
        eor ($41,x)

        .byte $7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00
        .byte $7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00
        .byte $7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00
        .byte $7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00
        .byte $7f,$ff,$ff,$00,$fa,$09,$ff

    L_dc47:
        .byte $04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff

    L_dc67:
        .byte $04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa,$09,$ff,$04,$00,$00,$00
        .byte $01,$00

    L_dcbd:
        .byte $10,$00,$00,$7f,$ff,$ff,$00,$fa
        .byte $09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa
        .byte $09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa
        .byte $09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00,$7f,$ff,$ff,$00,$fa
        .byte $09,$ff,$04,$00,$00,$00,$01,$00,$10,$00,$00,$c0,$ff,$3f,$00,$07
        .byte $01,$ff,$ff,$00,$00,$00,$01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07
        .byte $01,$ff,$ff,$00,$00,$00,$01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07
        .byte $01,$ff

    L_dd27:
        .byte $ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00

    L_dd30:
        cpy #$ff

        .byte $3f,$00,$07,$01,$ff

    L_dd37:
        .byte $ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff

    L_dda7:
        .byte $ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff

    L_ddb7:
        .byte $ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$c0,$ff,$3f,$00,$07,$01,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00

    L_dde0:
        cpy #$ff

        .byte $3f,$00,$07,$01,$ff,$ff,$00,$00,$00,$01,$00,$00,$00,$00

    L_ddf0:
        cpy #$ff

    L_ddf2:
         .byte $3f,$00,$07
        .byte $01,$ff

    L_ddf7:
        .byte $ff,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$40,$40,$40

    L_de03:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_de29:
        rti 
        rti 
        rti 
    L_de2c:
        rti 
        rti 
    L_de2e:
        rti 
        rti 
    L_de30:
        rti 
        rti 
        rti 
        rti 
        rti 
    L_de35:
        rti 
        rti 
        rti 
        rti 
        rti 
    L_de3a:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_de5e:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_de87:
        rti 
        rti 
    L_de89:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dec0:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_decc:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_def6:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_df01:
        rti 
        rti 
    L_df03:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_df15:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_df42:
        rti 
        rti 
        rti 
        rti 
    L_df46:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_df59:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dfab:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dfb3:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dfc0:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dfd3:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
    L_dfda:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $07,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$83,$01,$08,$3f,$40,$41
        .byte $42,$43,$44,$45,$46,$47,$83,$01,$09,$85,$44,$52,$00,$01,$02,$03
        .byte $04,$05,$06,$07

    L_e024:
        php 

        .byte $83,$01,$0a,$09,$0a

    L_e02a:
        .byte $0b,$0c
        .byte $0d,$0e,$0f,$10,$11,$83,$01,$0b,$12,$13,$14,$15,$16,$17,$18,$19
        .byte $1a,$83,$01,$0c,$1b,$1c

    L_e042:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$0d,$24,$25,$26,$27,$28,$29,$2a,$2b

    L_e054:
        bit $0183
        asl $2e2d

    L_e05a:
         .byte $2f,$30,$31,$32,$33,$34
        .byte $35,$83,$01,$0f,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$83,$01,$10
        .byte $3f,$40,$41,$42,$43,$44,$45,$46,$47,$83,$01,$11,$85,$14,$55,$00
        .byte $01,$02,$03,$04,$05,$06,$07,$08,$83,$01,$12,$09,$0a,$0b,$0c

    L_e08f:
        ora L_086e + $6a0
        bpl L_e0a5

        .byte $83,$01,$13,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$83,$01,$14,$1b
        .byte $1c

    L_e0a5:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$15,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$16
        .byte $2d,$2e,$2f,$30,$31,$32,$33,$34,$35,$83,$01,$17,$36,$37,$38,$39
        .byte $3a,$3b,$3c,$3d,$3e,$ff

    L_e0d1:
        .byte $83,$00,$00
        .byte $85,$8a

    L_e0d6:
        .byte $57,$00,$82
        .byte $09,$01

    L_e0db:
        .byte $02,$8b,$17,$80,$ff
        .byte $81,$01,$04,$8c,$83,$00,$01,$8b,$17,$03,$80,$ff,$81,$01,$8c,$05
        .byte $82,$09,$06

    L_e0f3:
        .byte $07,$83,$00
        .byte $08,$08,$82,$09,$09,$0a,$8b,$07,$80,$ff,$81,$01,$0c,$8c,$83,$00
        .byte $09,$8b,$07,$0b,$80,$ff,$81,$01,$8c,$0d,$82,$09,$0e,$0f,$83,$01
        .byte $01,$85,$84,$44,$00,$01,$02,$03,$04,$05,$06

    L_e121:
        .byte $07
        .byte $08,$83,$01,$02,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01,$03

    L_e132:
        .byte $12,$13,$14
        .byte $15,$16,$17,$18,$19,$1a,$83,$01,$04,$1b,$1c

    L_e140:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$05,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01,$06
        .byte $2d

    L_e157:
        rol L_302e + $1
        and ($32),y

        .byte $33,$34,$35,$83,$01,$07,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$83
        .byte $01,$09,$85,$fa,$46,$00,$01,$02,$03,$04

    L_e176:
        ora $06

    L_e178:
         .byte $07
        .byte $08,$83,$01,$0a,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01,$0b
        .byte $12,$13,$14,$15,$16,$17,$18,$19,$1a,$83,$01,$0c,$1b,$1c

    L_e197:
        ora L_1f1e,x
        jsr $2221

        .byte $23,$83,$01,$0d,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$83,$01

    L_e1ac:
        asl $2e2d

        .byte $2f,$30,$31,$32,$33,$34,$35,$83,$01,$0f,$36,$37,$38,$39,$3a,$3b
        .byte $3c,$3d,$3e,$83,$01,$11,$85,$70,$49,$00,$01,$02,$03,$04,$05,$06
        .byte $07,$08,$83,$01,$12,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$83,$01
        .byte $13,$12,$13,$14

    L_e1e3:
        ora $16,x

        .byte $17,$18,$19,$1a,$83,$01,$14,$1b,$1c

    L_e1ee:
        ora L_1f1e,x
    L_e1f1:
        jsr $2221

        .byte $23,$83,$01,$15,$24,$25,$26,$27,$28,$29,$2a,$2b

    L_e200:
        bit $0183
        asl $2d,x
        rol L_302e + $1
        and ($32),y

        .byte $33,$34,$35,$83,$01,$17,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$ff
        .byte $83,$0b,$00,$85,$f2,$3f,$00,$82,$1b,$01,$02,$8b,$17,$80,$ff,$81
        .byte $01,$05,$8c,$83,$0b,$01,$8b,$17,$03,$80,$ff,$81,$01,$8c,$06,$82
        .byte $1b,$07,$08,$83,$0c,$14,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$12
        .byte $13,$14,$15,$16,$17,$18,$83,$0c,$15,$19,$1a,$1b,$1c,$1d,$1e,$1f

    L_e25a:
        jsr $2221

        .byte $23,$24,$25,$26,$27,$28

    L_e263:
        .byte $83,$0c
        .byte $16,$29,$2a,$2b,$2c,$2d,$2e,$2f,$30,$31,$32,$33,$34

    L_e272:
        and $36,x

        .byte $37,$38,$83,$0c,$17,$39,$3a,$3b,$3c,$3d,$3e,$3f,$40,$41,$42,$43
        .byte $44,$45,$46,$47,$48,$83,$1c,$14,$49,$4a,$4b,$4c,$4d,$4e

    L_e292:
        .byte $4f,$50,$51,$52,$53,$83,$1c
        .byte $15,$54,$55,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e,$83,$1c,$16,$5f
        .byte $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$83,$1c,$17,$6a,$6b,$6c
        .byte $6d,$6e,$6f,$70,$71,$72,$73,$74,$83,$0c,$08,$82,$1b,$04,$83,$0c
        .byte $0e,$82,$1b,$04,$ff,$a5,$06,$38,$e9,$01,$85,$06,$a5,$07,$e9,$00
        .byte $85,$07,$05,$06,$60,$85,$02,$86,$03,$4c,$8e,$3c,$20,$b5,$29,$a0
        .byte $00,$b1,$02,$30,$06,$20,$dd,$3d,$4c,$8b,$3c

    L_e2f4:
        jsr L_29b5
        cmp #$ff
        bne L_e2fc
        rts 


    L_e2fc:
        cmp #$80
        bne L_e30a
        lda ($02),y
        clc 
    L_e303:
        adc $04
        sta $04
        jmp L_3c8b
    L_e30a:
        cmp #$81
        bne L_e318
        lda ($02),y
    L_e310:
        clc 
        adc $05
        sta $05
        jmp L_3c8b
    L_e318:
        cmp #$82
        bne L_e331
        lda ($02),y
        sta $06
        jsr L_29b5
        lda ($02),y
    L_e325:
        pha 
        jsr L_3ddd
        pla 
        dec $06
        bne L_e325
        jmp L_3c8b
    L_e331:
        cmp #$83
        bne L_e343
        lda ($02),y
        sta $04
        jsr L_29b5
        lda ($02),y
        sta $05
        jmp L_3c8b
    L_e343:
        cmp #$84
        bne L_e34f
        lda ($02),y
        sta L_3dd2 + $2
        jmp L_3c8b
    L_e34f:
        cmp #$85
        bne L_e363
        lda ($02),y
        sta L_3dd2
        jsr L_29b5
        lda ($02),y
        sta L_3dd2 + $1
        jmp L_3c8b
    L_e363:
        cmp #$86
        bne L_e3b0
        lda ($02),y
        sta $04
        jsr L_29b5
        lda ($02),y
        sta $05
        sta $0f
        jsr L_29b5
        lda ($02),y
        sta $10
        jsr L_29b5
        lda ($02),y
        sta $11
        jsr L_29b5
        lda ($02),y
        sta L_3da5 + $1
        jsr L_29b5
        lda ($02),y
        sta L_3da5 + $2
    L_e392:
        jsr L_3da8
        lda $05
        cmp $11
        beq L_e39f
        inc $05
        bne L_e392
    L_e39f:
        lda $04
        cmp $10
        beq L_e3ad
        lda $0f
        sta $05
        inc $04
        bne L_e392
    L_e3ad:
        jmp L_3c8b
    L_e3b0:
        cmp #$87
        bne L_e3bc
        lda #$ff
        sta L_3da5
        jmp L_3c8e
    L_e3bc:
        cmp #$88
        bne L_e3c8
        lda #$00
        sta L_3da5
    L_e3c5:
        jmp L_3c8e
    L_e3c8:
        cmp #$89
        bne L_e3d1
        inc $04
        jmp L_3c8e
    L_e3d1:
        cmp #$8b
        bne L_e3e4
        lda ($02),y
        jsr L_29b5
        pha 
        lda $02
        pha 
        lda $03
        pha 
        jmp L_3c8e
    L_e3e4:
        cmp #$8c
        bne L_e3fe
        pla 
        tay 
        pla 
        tax 
        pla 
        sec 
        sbc #$01
        beq L_e3fb
        pha 
        txa 
        pha 
        tya 
        pha 
        sty $03
        stx $02
    L_e3fb:
        jmp L_3c8e
    L_e3fe:
        rts 



    L_e3ff:
         .byte $ff,$00,$00
        .byte $a4,$05,$b9,$c0,$3f,$18,$65,$04,$85,$12,$85,$18,$b9,$d9,$3f,$69
        .byte $cc,$85,$13,$69,$0c,$85,$19,$a0,$00,$ad,$a6,$3d,$91,$12,$ad,$a7
        .byte $3d

    L_e423:
        sta ($18),y
        rts 


        clc 
        bpl L_e42a
        sec 
    L_e42a:
        rol 
        rts 



        .byte $f2,$3f,$00,$a9,$20,$4c,$dd,$3d,$18,$69,$30,$aa,$bd,$38,$3e,$18
        .byte $6d,$d2,$3d,$85,$12,$bd,$ba,$3e,$6d,$d3,$3d,$85,$13,$a4,$05,$a6
        .byte $04,$bd,$70,$3f,$18,$79,$3c,$3f,$85,$10,$bd,$98,$3f,$79,$56,$3f
        .byte $85,$11,$a0,$07

    L_e460:
        lda ($12),y
        sta ($10),y
        dey 
        bpl L_e460
        ldx $05
        lda L_3fc0,x
        clc 
        adc $04
        sta $3e2d
        sta $3e33
        lda L_3fd7 + $2,x
        adc #$cc
        sta $3e2e
        adc #$0c
        sta $3e34
        ldy #$08
        lda ($12),y
        sta $ffff
        iny 
        lda ($12),y
        sta $ffff
        inc $04
        rts 



        .byte $00,$0a,$14,$1e,$28,$32,$3c,$46,$50,$5a,$64,$6e,$78,$82,$8c,$96
        .byte $a0,$aa,$b4,$be,$c8,$d2,$dc,$e6,$f0,$fa,$04,$0e,$18,$22,$2c,$36
        .byte $40,$4a,$54,$5e,$68,$72,$7c,$86,$90,$9a,$a4,$ae,$b8,$c2,$cc,$d6
        .byte $e0,$ea,$f4,$fe,$08,$12,$1c,$26,$30,$3a,$44,$4e,$58,$62,$6c,$76
        .byte $80,$8a,$94,$9e,$a8,$b2,$bc,$c6,$d0,$da,$e4,$ee,$f8,$02,$0c,$16
        .byte $20,$2a,$34,$3e,$48,$52,$5c,$66,$70,$7a,$84,$8e,$98,$a2,$ac,$b6
        .byte $c0,$ca,$d4,$de,$e8,$f2,$fc,$06,$10,$1a,$24,$2e,$38,$42,$4c,$56
        .byte $60,$6a,$74

    L_e505:
        ror L_9288,x

        .byte $9c,$a6,$b0,$ba,$c4,$ce,$d8,$e2

    L_e510:
        cpx.a $00f6
        asl 

        .byte $93,$1a,$00,$93,$1a,$01,$93,$19,$02,$93,$1a,$03,$93,$19,$04,$05
        .byte $05,$00,$40,$80,$c0,$00,$40,$80,$c0,$00,$40,$80,$c0,$00,$40,$80
        .byte $c0,$00,$40,$80,$c0,$00,$40,$80,$c0,$00,$40

    L_e53f:
        .byte $e0,$e1,$e2,$e3
        .byte $e5,$e6,$e7,$e8,$ea,$eb,$ec,$ed,$ef,$f0,$f1,$f2,$f4,$f5,$f6,$f7
        .byte $f9,$fa,$fb,$fc,$fe,$ff,$00,$08,$10,$18,$20,$28,$30,$38,$40,$48
        .byte $50,$58,$60,$68,$70,$78,$80,$88,$90,$98,$a0,$a8,$b0,$b8

    L_e571:
        cpy #$c8

        .byte $d0,$d8

    L_e575:
        cpx #$e8
        beq L_e571

        .byte $00,$08,$10,$18,$20,$28,$30

    L_e580:
        .byte $38,$93
        .byte $20,$00,$93,$08,$01,$00,$28,$50,$78,$a0,$c8,$f0,$18,$40,$68,$90
        .byte $b8

    L_e593:
        cpx #$08

    L_e595:
         .byte $30,$58,$80

    L_e598:
        tay 
        bne L_e593
        jsr L_7048

        .byte $98,$c0,$93,$07,$00,$93,$06,$01,$93,$07,$02,$93,$05,$03,$6a,$9a
        .byte $da,$e6,$f6,$f9,$fa,$fb,$1f,$0c,$93,$05,$55

    L_e5b9:
        tax 
        eor $ff,x
        sbc ($0c),y
        lsr $56,x
        eor L_675b,y

        .byte $af,$5f,$df,$f1,$0c,$93,$08,$59,$cf,$93,$04,$00,$55,$93,$04,$00
        .byte $b0,$00,$93,$08,$65,$cf,$00,$59,$5a,$55,$5f,$5f,$7f,$7f,$ff,$cf
        .byte $0b,$55,$aa,$55,$93,$05,$ff,$cf,$0b,$65,$a5,$65,$d5,$f5,$f5,$fd
        .byte $fd,$cf,$0b,$15,$93,$05,$2a,$28,$28,$fb,$00,$55,$93,$05,$aa,$00
        .byte $00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$00
        .byte $00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$00
        .byte $00,$fb,$00,$55,$93,$05,$aa

    L_e62a:
        .byte $00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa

    L_e65a:
        .byte $00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$2a,$2a,$fb,$00
        .byte $55,$93,$05,$aa,$a8,$a8,$fb,$00,$93,$08,$14,$b0,$00

    L_e67b:
        eor $6a,x
        adc $65

        .byte $93,$04,$64,$87,$00,$55,$aa,$55,$55,$93,$04,$44,$87,$00,$55,$aa
        .byte $55,$55,$41,$9f,$45,$87,$00,$55,$aa,$55,$55,$15,$9f,$11,$87,$00
        .byte $55,$aa,$55,$55,$93,$04,$15,$87,$00,$55,$aa,$55,$55,$01,$9f,$11
        .byte $87

    L_e6b0:
        .byte $00
        .byte $55,$aa,$55,$55,$01,$11,$01,$01,$87,$00,$55,$aa,$55,$55,$01,$11
        .byte $01,$01,$87,$00,$55,$aa,$55,$55,$01,$9f,$11,$87,$00,$55,$aa,$55
        .byte $55,$05,$9f,$11,$87,$00,$55,$aa,$55,$55,$04,$9f,$14,$87,$00,$55
        .byte $aa,$55,$55,$14,$9f,$45,$87,$00,$55,$ab

    L_e6eb:
        .byte $57,$57,$07,$9f,$17,$87
        .byte $09,$93,$08,$15,$b0,$00,$93,$08,$54,$b0,$00,$93,$08,$14,$b0,$00
        .byte $93,$04,$64,$54,$65,$ff,$ff,$87,$09,$04,$93,$04,$14,$55,$aa,$aa

    L_e711:
        .byte $89,$00
        .byte $41,$45,$45,$41,$41,$55,$aa,$aa,$89,$00,$9f,$11,$00,$11,$55

    L_e722:
        tax 
        tax 

        .byte $89,$00,$93,$05,$15,$55,$aa,$aa,$89,$00,$9f,$11,$01,$01,$55,$aa

    L_e734:
        tax 

        .byte $89,$00,$93,$05,$15

    L_e73a:
        eor $aa,x
        tax 

        .byte $89,$00,$93

    L_e740:
        ora $15
        eor $aa,x
        tax 

    L_e745:
         .byte $89,$00,$9f
        .byte $11,$01,$01,$55

    L_e74c:
        tax 
        tax 

        .byte $89,$00,$93,$05,$11,$55,$aa,$aa,$89,$00,$04,$14,$14,$04,$04,$55
        .byte $aa,$aa,$89,$00,$93,$05,$45,$55,$aa,$aa,$89,$00,$93,$05,$16,$56
        .byte $aa,$aa,$89,$00,$93,$08,$15,$b0,$00,$93,$08,$54,$b0,$00,$14,$14
        .byte $93,$06,$15,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0
        .byte $9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55

    L_e799:
        bcs L_e73a

        .byte $00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55
        .byte $b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93
        .byte $06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f
        .byte $00,$93,$06,$55,$b0,$00

    L_e7d1:
        ora $15,x

        .byte $93,$06,$55,$b0,$00,$54,$54,$93,$06,$55,$b0,$00

    L_e7df:
        eor $93,x
        ora $aa

        .byte $00,$00,$fb,$00,$55,$93

    L_e7e9:
        ora $aa

        .byte $00,$00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa
        .byte $00,$00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa
        .byte $00,$00,$fb,$00,$55,$93,$05,$aa

    L_e813:
        .byte $00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$00,$00,$fb,$00,$55,$93,$05,$aa,$00,$00,$fb,$00
        .byte $55,$93,$05,$aa,$2a,$2a,$fb,$00,$55,$93,$07,$aa,$fb,$00,$55,$6a
        .byte $65,$65,$93,$04,$64,$87,$00,$55,$aa,$55,$55,$11,$51,$51,$50,$87
        .byte $00,$55,$aa,$55,$55,$10,$11,$11,$10,$87,$00,$55,$aa,$55,$55,$51
        .byte $9f,$11,$87,$00,$55,$aa,$55,$55,$93,$04,$45,$87,$00,$55,$aa,$55
        .byte $55

    L_e868:
        .byte $04,$14,$14,$04,$87,$00
        .byte $55,$aa,$55,$55,$14,$9f,$44,$87,$00,$55,$aa,$55,$55

    L_e87b:
        .byte $04,$9f,$54,$87,$00
        .byte $55,$a9,$57,$57,$17,$57,$57,$17,$87,$09,$93,$08,$15,$b0,$00,$93
        .byte $08,$55,$b0,$00,$93,$04,$64,$54,$65,$ff,$ff,$87,$09,$50,$51,$51

    L_e8a0:
        ora ($11),y
        eor $aa,x
        tax 

        .byte $89,$00,$10,$93,$04,$11,$55

    L_e8ac:
        tax 
        tax 

        .byte $89,$00,$9f,$11,$10,$10,$55,$aa,$aa,$89,$00,$9f,$45,$41,$41,$55

    L_e8be:
        tax 
        tax 

        .byte $89,$00,$9f,$14,$04,$04,$55,$aa,$aa,$89,$00,$93,$05,$44,$55,$aa
        .byte $aa,$89,$00,$9f,$44,$04,$04,$55,$aa,$aa,$89,$00,$9f,$56,$16,$16
        .byte $56,$aa,$aa,$89,$00,$93,$08,$15,$b0,$00,$93,$08,$55,$b0,$9f,$00
        .byte $93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55

    L_e8ff:
        bcs L_e8a0

        .byte $00,$93,$06,$55

    L_e905:
        .byte $b0,$9f,$00,$93
        .byte $06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$9f
        .byte $00,$93,$06,$55,$b0,$9f,$00,$93,$06,$55,$b0,$00

    L_e925:
        ora $15,x

        .byte $93,$06,$55,$b0,$00,$93,$08,$55,$b0,$00,$55,$55,$aa,$93,$04,$55
        .byte $aa,$5c,$00,$55,$55,$aa,$55,$55,$57,$57,$ab,$5c,$0b,$55,$55,$5a
        .byte $aa,$96,$79,$75,$7d

    L_e94c:
        .byte $5b
        .byte $01,$55,$55,$00,$aa,$6a,$99,$56,$56,$5b,$00,$55,$55,$2a,$c5,$71
        .byte $fc,$df,$ff,$5c,$0b,$55,$55,$aa,$55,$55,$9f,$00,$5c,$00,$55,$55
        .byte $aa,$55,$55

    L_e970:
        ora $05,x

        .byte $02,$5c,$00,$55,$55

    L_e977:
        tax 

        .byte $93,$04,$55,$aa

    L_e97c:
        .byte $5c,$00
        .byte $55,$55,$aa,$93,$04,$55,$aa,$5c,$00,$9f,$55,$aa,$55,$55,$aa,$55
        .byte $5c,$00,$56,$5e,$59,$f9,$59,$59,$fa,$59,$5b,$0c,$69,$93,$04,$ea
        .byte $5a,$de,$57,$b1,$0c,$56,$d9,$d5,$e6,$e9,$e5,$65,$95,$5b,$0c,$5a
        .byte $55,$55,$aa,$5a,$56,$56,$55,$5b,$00,$40,$50,$54,$19,$56,$45,$51
        .byte $51,$b5,$00,$01,$93,$04,$00,$80,$60,$90,$5b,$00,$55,$55,$15,$0a
        .byte $05,$01,$02,$01,$5c,$00,$9f,$55,$aa,$55,$55,$aa,$55,$5c,$00,$55
        .byte $aa,$55,$55,$ff,$55,$55,$ff,$5c,$0b,$59,$fb,$7a,$6b,$af,$6f,$4e
        .byte $a2,$5b,$0c,$65,$95,$a5,$e9,$fa,$fb,$af,$0e,$5c,$07,$56,$6a,$aa
        .byte $af,$ff,$ff,$f4,$e0,$cb,$07,$5a,$aa,$6a,$ea,$fa,$fe,$3e,$0a,$b5
        .byte $07,$54,$94,$55,$55,$99,$a6,$99,$a6,$b5,$00,$54,$18,$24,$14,$9f
        .byte $58,$48,$b5,$00,$01,$93,$07,$00,$50,$00

    L_ea28:
        eor $aa,x
        eor $55,x

        .byte $ff,$55,$15,$3f,$5c,$0b,$55,$aa,$55,$9f,$aa,$55,$aa,$5b,$00

    L_ea3b:
        rts 



        .byte $f3,$50,$fc,$fe,$fe,$5e,$fa,$5c,$0b,$01,$82,$c6,$3e,$6a,$82,$8e
        .byte $be,$87,$0c,$40,$09,$30,$3f,$ba,$26,$1a,$1a,$c7,$08,$4a,$cb,$3a
        .byte $fa,$fa,$7e,$7e,$5f,$75,$0c,$66,$a0,$aa,$6a,$59,$56,$59,$56,$5b
        .byte $00,$10,$40,$12,$55,$51

    L_ea72:
        eor ($60),y

        .byte $90,$b5,$93,$05,$00,$40,$9f,$80,$5b,$00,$15,$2a,$15,$9f,$0a,$05
        .byte $0a,$5b,$00,$93,$08,$55,$b0,$00,$93,$04,$5b,$6f,$6b,$6f,$6b,$bc
        .byte $07,$5a,$9a,$9e,$ae,$9f,$fe,$fd,$c7,$01,$9f,$6a,$93,$05,$aa,$c7
        .byte $00,$6a,$5a,$66,$5a,$56,$59,$56,$59,$7c,$00

    L_eaaf:
        eor $56,x
        sta $d6,x
        cmp $9f,x
        sbc $5b

        .byte $0c,$66,$99,$65,$99,$65,$95,$51,$95,$b5,$00,$93,$06,$40

    L_eac5:
        .byte $00,$10,$b0,$00,$93
        .byte $08,$05,$b0,$00,$93,$04,$55,$00,$55,$00

    L_ead4:
        .byte $00,$b0,$00,$5a
        .byte $66,$7a,$76,$72,$71,$3c,$0d,$b7,$01,$59,$bb,$55,$b7,$77,$ff,$00
        .byte $a9,$71,$0c,$55,$55,$5b,$58,$7b,$ca,$0a,$58,$71,$0c,$56,$5a,$5a
        .byte $62,$81,$16,$a0,$aa,$7c,$00,$5a,$5b,$5a,$5b,$1b,$2c,$bf,$cf,$c5
        .byte $0b,$50,$91,$46,$41,$15,$56,$48,$56,$b5,$00,$68,$94,$64,$91,$42
        .byte $15,$69,$55,$b5,$00,$9f,$05,$45,$40,$45,$00,$10,$b0,$93,$05,$00
        .byte $01,$15,$55,$55,$50,$00

    L_eb2e:
        ora $05
        ora ($b1,x)
        lda L_abaf

        .byte $ab,$75,$0b,$55,$aa,$aa,$6a,$6a,$6b,$2c,$c3,$7c,$0b,$55,$a6,$a5
        .byte $a6,$b9,$bd,$01,$f0,$7c,$0b,$56,$59,$57,$6c,$73,$8f,$ce,$0a,$c5
        .byte $0b,$55,$19,$15,$56,$5a,$9f,$aa,$b5,$00,$66,$99,$66,$99

    L_eb63:
        lsr $5a,x
        lsr $5a,x

        .byte $5b,$00,$68,$a2,$6a,$aa,$6a,$9f,$aa,$5b,$00,$44,$11,$40,$11,$44
        .byte $41,$54,$55,$b0,$00,$55,$55,$aa,$93,$04,$55,$aa,$8f,$00,$55,$55
        .byte $aa,$93,$04

    L_eb8a:
        eor $aa,x

        .byte $8f,$00,$55,$55,$aa,$93,$04,$55,$aa,$8f,$00,$55,$55,$aa,$93,$04
        .byte $55,$aa,$8f,$00,$55,$55,$aa,$55,$55,$5b,$6f,$be,$8f,$01,$55,$55
        .byte $aa,$55,$bf,$ff,$ea,$bf,$8f,$01,$55,$55,$aa,$55,$9f,$ff,$fe,$8f
        .byte $01,$55,$55,$aa,$55,$95

    L_ebc2:
        sbc $f8
        lda #$8f
        ora ($55,x)
        eor $aa,x

    L_ebca:
         .byte $93,$04
        .byte $55,$2a,$8f,$00,$93,$04,$55,$aa,$9f,$55,$8f,$00,$93,$04,$55,$aa
        .byte $9f,$55,$8f,$00,$93,$04,$55,$aa,$55,$55,$56,$8f,$00,$56,$57,$5b
        .byte $5e,$ae,$ba,$fb,$eb,$8f,$01,$5a

    L_ebf4:
        adc #$a5
        sta $93,x

        .byte $04,$55,$1f,$00,$93,$08,$55,$10,$00,$93,$08,$55,$10

    L_ec05:
        .byte $00
        .byte $6a,$59,$5e,$56,$56,$5e,$5e,$5a,$1c,$0f,$45,$81,$90,$e0,$e4,$a0
        .byte $b8,$f8,$8f,$01,$55,$55,$aa,$55,$55,$aa,$aa,$55,$89,$00,$55,$55
        .byte $aa,$55,$55,$aa,$a9,$55,$89,$00,$56,$5e,$5a,$7b,$6b,$ef,$bf,$bf
        .byte $81,$0f,$65,$a5,$95,$95

    L_ec3c:
        .byte $93,$04
        .byte $55,$1f,$00,$93,$07,$55,$59,$1c,$00,$93,$05,$55,$56,$6f,$55,$1f
        .byte $0c,$9f,$55,$56,$6f,$fe,$ab,$55,$1f,$0c,$5b,$6e,$bd,$f9,$e5,$96
        .byte $5b,$5c,$1c,$0b,$68,$6c,$44,$84,$9f,$34,$7c,$1f,$0b,$93,$08,$55
        .byte $90,$00,$56,$57,$5b,$5b,$93,$04,$5e,$9b,$01

    L_ec79:
        .byte $5a,$5a,$da,$da
        .byte $dd,$6e,$75,$55,$1c,$0b,$55,$55,$56,$5b,$5d,$7d,$fd,$54,$1c,$0b
        .byte $65,$98,$50,$43,$49,$0d,$0d,$4b,$1c,$05,$55,$00,$aa,$aa,$ee,$7f
        .byte $ff,$fc,$1b,$05,$55,$2e,$cd,$c5,$85,$b6

    L_eca7:
        .byte $14,$1f,$1b,$0c
        .byte $6d,$2d,$b9,$35,$26,$d6,$db,$9d,$1c,$0b

    L_ecb5:
        jmp (L_f8ec)

        .byte $b0,$a0,$40,$c0,$80,$1b,$0c,$93,$08,$55,$90,$00,$5a,$7a,$69,$69
        .byte $6b,$6d,$ed,$e5,$91,$0c,$69,$96,$aa,$aa,$e5,$ff,$fa,$fe,$b1,$09
        .byte $58,$f9,$9f,$75,$e4,$96,$96,$1c,$0b,$6b,$5a,$55,$95

    L_ece5:
        sta $69,x
        eor $65,x

        .byte $1b,$05,$50,$56,$ab,$af,$ba,$aa,$aa,$a9,$b1,$0c,$5a,$69,$a5,$57
        .byte $5d,$76,$db,$ac,$1c,$0b,$5a,$77,$d8,$6c,$b0,$c0

    L_ed05:
        .byte $00,$00,$1c,$0b,$00,$00
        .byte $01,$01,$05,$05,$15,$15,$90,$93,$04,$00,$55,$93,$04,$00,$90,$00

    L_ed1b:
        .byte $50,$60
        .byte $60,$7f,$93,$04,$40,$1c,$09,$9f,$00,$55,$00,$02,$03,$03,$9b,$0c
        .byte $69,$67,$a7,$a2,$a1,$90,$b1,$82,$c1,$0b,$6f,$6a,$7a,$5f,$5d,$57
        .byte $56,$5e,$1b,$0c,$56,$5b,$be,$ed,$74,$9f,$70,$bc,$01,$60,$c0,$80
        .byte $93,$05,$00,$1b,$0c,$93,$04,$00,$01,$9f,$00,$90,$00

    L_ed5a:
        eor $9f,x

        .byte $00,$55,$9f,$00,$90,$00

    L_ed62:
        eor $93,x

        .byte $07,$00,$90,$00

    L_ed68:
        eor $93,x

        .byte $07,$00,$90,$00

    L_ed6e:
        lsr $0a,x

        .byte $2b,$93,$05,$00,$91,$0c,$6b,$43,$07,$0f,$0f,$1c,$3c,$7f,$c9,$01
        .byte $6a,$55,$55,$56,$51,$59,$05,$a5,$1b,$00,$50,$90,$93,$04,$80,$90
        .byte $a9,$c1,$93,$0c,$00,$55,$93,$06,$00,$90,$00,$00,$55,$93,$06,$00
        .byte $90,$00

    L_eda2:
        eor $aa,x
        eor $aa,x
        eor $aa,x
        eor $55,x

        .byte $6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00,$55,$aa,$55,$aa
        .byte $55,$aa,$55,$55,$6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00
        .byte $55,$aa,$55,$aa,$55,$aa,$55,$55,$6b,$00,$55,$aa,$55,$aa,$55,$aa
        .byte $55,$af,$6b,$0c,$55,$aa,$55,$aa,$55,$aa,$55,$fa,$6b,$0c,$55,$aa
        .byte $55,$aa,$55,$aa,$55,$55,$6b,$00,$55,$aa,$55,$aa,$55,$aa,$55,$55
        .byte $6b,$00,$55,$aa,$93,$06,$55,$6b,$00,$55,$aa,$93,$06,$55,$6b,$00
        .byte $55,$aa,$93,$06,$55,$6b,$00,$55,$aa,$93,$05,$55,$56,$6b,$00,$56
        .byte $ab,$5f,$6b,$6f,$bf,$bf,$ff,$6b,$0c,$55,$55,$56,$5b,$6d,$b9,$e5
        .byte $95,$cf,$01,$56,$55,$e5,$59,$66,$5a,$6a,$69,$cb,$0f,$6a

    L_ee38:
        eor $da,x
        inc $f6,x
        ror L_5d6f + $f,x
        ldx $0c,y
        eor $aa,x

        .byte $93,$05,$55,$aa,$6b,$00,$55,$6a,$93,$06,$aa,$b6,$00,$55,$93,$07
        .byte $aa,$b6,$00,$55,$93,$04,$aa,$a9,$ab,$a7,$b6,$0c,$56,$f9,$d9,$65
        .byte $a6,$95,$96,$5a,$bc,$06,$6b,$af,$be,$b9,$f9,$ea,$da,$56,$bc,$0f
        .byte $59,$5a,$56,$96,$a9,$ab,$6e,$ba,$cb,$0f,$56,$6d,$b5,$d4,$d0,$50
        .byte $41,$01,$bc,$0f,$59,$5d,$1e,$1e,$6e,$5d,$6e,$a9,$bc,$0f,$55,$9f
        .byte $95,$9f,$a5,$a6,$6b,$00,$55,$93,$07,$aa,$b6,$00,$55,$93,$05,$aa
        .byte $e9,$e9,$b6,$01,$5a,$fa,$d9,$e9,$66,$a6,$9a,$9a,$bc,$06,$6f,$6f
        .byte $be,$75,$e5,$e9,$ea,$aa,$bc,$0f,$69,$5b,$57,$5e,$ba,$ba,$e8,$e0
        .byte $cb,$0f,$6c,$bc,$f1,$c1,$00,$0f,$3d,$f9,$fc,$0b,$61,$a1,$93,$01
        .byte $57,$1d,$f7,$fd,$f5,$ba,$0c,$65,$99,$a5,$95,$99,$6a,$af,$7e,$bc
        .byte $0f,$93,$04,$56,$d6,$54,$d4,$54,$b6,$0c,$55,$55,$00,$93,$04,$55
        .byte $00,$60,$00,$6a,$9f,$4b,$6f,$ad,$b6,$be,$fb,$0c,$59,$5b,$5f,$5f
        .byte $77,$75,$7d

    L_ef06:
        adc L_086e + $451,x

        .byte $5b,$57,$95,$a5,$95,$75,$71,$77,$bc,$0f,$51,$46,$4a,$6b,$ab

    L_ef18:
        ldx $e5,y
        cpx $bc

        .byte $0f,$5b,$6f,$7f,$ff,$f0,$c0,$00,$00,$cf,$0b,$6a,$a8,$a8,$80,$0a

    L_ef2c:
        asl 
        plp 
        ldy #$cb

        .byte $00,$15,$a5,$aa,$00,$80,$9f,$00,$cb,$00,$60,$a0,$80,$93,$05,$00
        .byte $cb,$00,$56,$56,$02,$57,$57,$0f,$0e,$2c,$6b

    L_ef4b:
        ora ($15,x)
        eor $a0

        .byte $9e,$99,$49,$28,$cf,$b1,$0c,$46,$14,$61,$11,$c1,$d4,$dc,$dc,$bc
        .byte $01,$1b,$1b,$1a,$00,$02,$8a,$a8,$a0,$1b,$0f,$60,$80,$00,$22,$88
        .byte $28,$00,$00,$cb,$00,$01,$15,$55,$54,$93,$04,$00,$b0,$00

    L_ef7d:
        .byte $50,$40,$93
        .byte $06,$00,$b0,$93,$08,$00,$15,$60,$00,$00,$01,$00,$05,$15,$00,$00
        .byte $55,$60,$00,$52,$4a,$7a,$73,$72,$14,$05,$01,$b2,$01,$52,$54,$95
        .byte $56,$58,$0b,$fb,$f3,$21,$0b,$6c,$e3,$bf,$bc,$fc,$f0,$c0,$00,$21
        .byte $0b,$50,$40,$93,$06,$00,$b0,$93,$17,$00,$55,$93,$05,$00,$60,$9f
        .byte $00,$55,$93,$05,$00,$60,$9f,$00,$55,$93,$05,$00,$60,$00,$93,$08
        .byte $ff,$1c,$00,$93,$04,$df,$cf,$df,$cf,$ff,$1c,$00,$77,$77,$33,$93
        .byte $05,$ff

    L_efe2:
        .byte $1c,$00,$77,$67,$47,$67,$47,$33,$ff,$ff,$1c,$00,$f7,$db,$63,$1f

    L_eff2:
        .byte $db,$63,$8f,$3f,$1c,$00,$77,$37,$d3,$df,$4f,$77,$33,$ff,$1c,$00

    L_f002:
        .byte $ff,$df,$df,$57,$13,$df,$cf,$ff,$1c,$00,$df,$df,$cf,$93
        .byte $05,$ff,$1c,$00,$57,$43,$9f,$7f,$57,$03,$ff,$1c,$00,$57,$07,$9f
        .byte $f7,$57

    L_f022:
        .byte $03,$ff,$1c,$00,$ff,$ff,$77,$13,$47,$33,$ff,$ff,$1c,$00,$ff,$df

    L_f032:
        .byte $df,$57,$13,$df,$cf,$ff,$1c,$00,$93,$04,$ff,$df,$4f,$3f,$ff,$1c
        .byte $00,$ff,$ff,$57,$03,$93,$04,$ff,$1c,$00,$93,$04,$ff,$df,$cf,$ff

    L_f052:
        .byte $ff,$1c,$00,$f7,$e7,$d3,$93,$02,$4f,$7f,$3f,$ff,$1c,$00,$ff,$9b

    L_f062:
        .byte $47,$77,$77,$9b,$03,$ff,$1c,$00,$ff,$df,$5f,$1f,$df,$57,$03,$ff

    L_f072:
        .byte $1c,$00,$ff,$5b,$07,$db,$63,$57,$03,$ff,$1c,$00,$ff,$5b,$0b,$d7

    L_f082:
        .byte $c7,$5b,$03,$ff,$1c,$00,$ff,$7f,$7f,$77,$57,$07,$f3,$ff,$1c,$00
        .byte $ff,$57,$43,$5b,$07,$5b,$03,$ff,$1c,$00,$ff,$97,$43,$5b,$47,$9b

    L_f0a2:
        .byte $03,$ff,$1c,$00,$ff,$57,$07,$e7,$d3,$df,$cf,$ff,$1c,$00,$ff,$9b
        .byte $47,$9b,$47,$9b,$03,$ff,$1c,$00,$ff,$9b,$47,$97,$07,$5b,$03,$ff
        .byte $1c,$00,$ff,$ff,$df,$cf,$df,$cf,$ff,$ff,$1c,$00,$ff,$ff,$df,$cf
        .byte $df,$4f,$3f,$ff,$1c,$00,$ff,$f7,$d3,$4f,$1f,$c7,$f3,$ff,$1c,$00

    L_f0e2:
        .byte $ff,$ff,$57,$03,$57,$03,$ff,$ff,$1c,$00,$ff,$7f,$1f,$c7,$d3,$4f
        .byte $3f,$ff,$1c,$00,$57,$47,$37,$d7,$d3,$cf,$df,$cf,$1c,$00,$fb,$fb
        .byte $e7,$e7,$97,$97,$03,$ff,$1c,$00,$9b,$47,$57,$47,$77,$77,$33,$ff

    L_f112:
        .byte $1c,$00,$5b,$47,$57,$47,$77,$5b,$0f,$ff,$1c,$00,$9b,$47,$73,$7f
        .byte $77,$9b,$03,$ff,$1c,$00,$5b,$47,$9f,$77,$5b,$0f,$ff,$1c,$00,$57

    L_f132:
        .byte $43,$5f,$4f,$7f,$57,$03,$ff,$1c,$00,$57,$43,$5f,$4f,$7f,$7f,$3f

    L_f142:
        .byte $ff,$1c,$00,$9b,$47,$73,$77,$77,$9b,$03,$ff,$1c,$00,$77,$77,$57

    L_f152:
        .byte $47,$77,$77,$33,$ff,$1c,$00,$57,$13,$9f,$df,$57,$03,$ff,$1c,$00
        .byte $57,$07,$f7,$f7,$77,$9b,$03,$ff,$1c,$00,$77,$77,$53,$5f,$47,$77
        .byte $33,$ff,$1c,$00,$93,$05,$7f

    L_f179:
        .byte $57,$03,$ff,$1c,$00,$77,$57,$67,$47,$77,$77,$33,$ff,$1c,$00,$5f
        .byte $47,$93,$04,$77,$33,$ff,$1c,$00,$9b,$47,$9f,$77,$9b,$03,$ff,$1c
        .byte $00,$5b,$47,$5b,$43,$7f,$7f,$3f,$ff,$1c,$00,$5b,$47,$77,$57,$53
        .byte $0b,$f3,$ff,$1c,$00,$5b,$47,$5b,$47,$77,$77,$33,$ff,$1c,$00,$97

    L_f1b9:
        .byte $43,$9b,$07,$77,$9b,$03,$ff,$1c,$00,$57,$13,$93,$04,$df,$cf,$ff
        .byte $1c,$00,$93,$05,$77

    L_f1ce:
        .byte $9b,$03,$ff,$1c,$00,$9f,$77,$67,$9b,$df,$cf,$ff,$1c,$00,$9f,$77
        .byte $67,$57,$47,$33,$ff,$1c,$00,$77,$67,$9b,$13,$57,$47,$33,$ff,$1c
        .byte $00,$77,$67,$9b,$9f,$df,$cf,$ff,$1c,$00,$57,$07,$d7,$53,$4f,$57

    L_f1fe:
        .byte $03,$ff,$1c,$00,$93
        .byte $06,$7f

    L_f205:
        .byte $3f,$ff,$1c,$00,$5f,$4f,$5f,$4f,$7f,$5f,$0f,$ff,$1c,$00,$5f,$4f
        .byte $5f,$4f,$7f,$7f,$3f,$ff,$1c,$93,$05,$00,$9f,$40,$60,$1c,$00,$60
        .byte $50,$5c,$58,$57,$9f,$55,$1f,$0c,$93,$06,$00,$40,$80,$cf,$00,$9f

    L_f235:
        ror 
        nop 

        .byte $93,$04,$2a,$f1,$0c,$60,$78,$5e,$57,$93,$04,$55,$1c,$0f,$93,$04
        .byte $00,$40,$90,$e4,$f8,$cf,$01,$1a,$3a,$0a,$06,$0e,$02,$02,$03,$f1
        .byte $0c,$93,$07,$55,$5b,$1f,$0c,$9f,$54,$58,$5c,$60,$b0,$00,$1f,$0c
        .byte $05,$93,$07,$06,$c1,$00,$50,$93,$07,$90,$c1,$00,$9f,$06,$16,$0a
        .byte $16,$0a,$56,$c1,$93,$05,$00,$40,$00,$40,$00,$c0,$93

    L_f284:
        ora $00
        ora ($00,x)
        ora ($00,x)
        cpy #$00

        .byte $9f,$60,$68,$50,$68,$50,$6a,$1c,$00,$05,$29,$05,$a9,$05,$29,$09
        .byte $29,$1c,$00,$40,$00,$50,$00

    L_f2a3:
        rti 

        .byte $00,$00,$50,$c0,$00,$01,$00,$05,$00

    L_f2ad:
        ora ($00,x)

        .byte $00,$05,$c0,$00,$50,$68,$50,$6a,$50,$68,$60,$68,$1c,$00,$12,$01
        .byte $05,$04,$00,$9f,$01,$c1,$00,$40,$48,$60,$50,$98,$94,$24,$00,$1c
        .byte $00,$01,$21,$09,$05,$26,$16,$18,$00,$1c,$00,$48,$80,$a0,$20

    L_f2de:
        .byte $00,$9f,$80,$1c,$93
        .byte $05,$00,$06,$07

    L_f2e7:
        .byte $47,$6f,$1f,$0c,$00
        .byte $60,$50,$58,$94,$a6

    L_f2f1:
        lda $65

        .byte $1c,$93,$04,$00,$6c,$eb,$1a,$3a,$06,$f1,$0b,$04,$06,$07,$1f,$ae
        .byte $9f,$55,$1f,$0c,$6a,$ae,$af,$af,$bf,$fc,$f4,$40,$fc,$01,$55,$54
        .byte $50,$40,$93,$04,$00,$10,$93,$0b,$00,$01,$01,$02,$02,$93,$04,$03
        .byte $78,$06,$58,$9f,$55,$c5,$9f,$c0,$87,$06,$10

    L_f32e:
        txs 

        .byte $9f,$7a,$78,$72,$7f,$18,$0b,$01,$93,$05,$55,$04,$aa,$8b,$00

    L_f33e:
        lsr $55,x

        .byte $93,$05,$5e,$0e,$8b,$01,$66,$59,$66,$5a,$56,$59,$56,$56,$87,$00
        .byte $93,$06,$55,$56,$5a

    L_f355:
        ror $1593,x

        .byte $00,$93,$07,$01,$00,$60,$00,$40,$40,$93,$04,$42,$4a,$40

    L_f366:
        .byte $6b,$00
        .byte $55,$56,$46,$46,$06,$06,$15,$14,$bc,$00,$6a,$ea,$ea,$6a,$6a,$aa
        .byte $02,$02,$cb,$01,$42,$02,$42,$12,$42,$52,$42,$52,$b1,$00,$40,$40
        .byte $6a,$9f,$43,$53,$53,$b8,$06,$5b,$5e,$fa,$5a,$6a,$5a,$6a,$5a,$6e
        .byte $07,$93,$1e,$00,$93,$06,$4b,$4a,$4a,$6b,$07,$93,$04,$12,$13,$10
        .byte $11,$37,$b7,$0c,$56,$5e,$7a,$ea

    L_f3b0:
        tax 
        tsx 

        .byte $fa,$fa,$7b,$0c,$52,$43,$46,$17

    L_f3ba:
        lsr $9f,x

        .byte $1a,$bc,$01,$93,$04,$63,$9f,$53,$50,$cb,$06,$6a,$69,$59,$69,$69

    L_f3cc:
        eor L_6869,y
        ror $1f93

        .byte $00,$4a,$93,$06,$48,$4b,$6b,$0f,$15,$11,$00,$a8,$a9,$a9,$ff,$00
        .byte $cb,$0f,$9f,$6f,$af,$6f,$af,$5f,$07,$1c,$0b,$1a,$1a,$1e,$0e,$06
        .byte $03,$43,$11,$bc,$01,$50,$93,$05,$58,$54,$d4,$cb,$0f,$68

    L_f400:
        .byte $9f,$64
        .byte $60,$20,$a1,$a6

    L_f406:
        .byte $6e,$93,$06,$00,$54
        .byte $a8,$59,$6e,$93,$0c,$00,$10,$54,$64,$65,$59,$55,$51,$6e,$00,$48
        .byte $08

    L_f41c:
        .byte $02,$02,$00
        .byte $40,$40,$50,$6f,$00,$00,$55,$55,$2a

    L_f428:
        ora SCREEN_BUFFER_0 + $109,y
        ora #$2a

        .byte $00,$00,$40,$50,$59,$5a,$5e,$97,$95,$2a,$01,$40,$10,$04,$00,$80
        .byte $e0,$f8

    L_f43f:
        inc L_086e + $244,x
        pla 
        cld 
        cld 
        sec 
        sec 
        php 

        .byte $0c,$00,$fc,$0b,$59,$66,$56,$5a,$58,$60,$a2,$40,$e6,$00,$56,$56
        .byte $06,$12,$11,$01,$11,$11,$6e,$00,$93,$07,$01,$00,$60,$00,$41,$93
        .byte $04,$40,$02,$0b,$2e,$62,$0a,$9f,$50,$15,$1a,$af,$8f,$ff,$62,$09
        .byte $05,$25,$95,$55,$5a,$da,$ff,$83,$2a,$09,$5a,$6b,$5a,$99,$95,$97
        .byte $ff,$73,$a2,$09,$69,$5a,$5a,$a6,$f7,$ff,$ff,$fb,$2a,$09,$54,$52
        .byte $52,$f0,$ff,$7f,$ff,$fa,$a2,$09,$48,$4a,$2a,$fa,$8a,$aa,$ba,$ab
        .byte $e2,$0a,$01,$01,$81,$a1,$e8,$f8,$fe,$bf,$69,$02,$93,$0a,$00,$1b
        .byte $27,$2f,$67,$5f,$9e,$9d,$b6,$2a,$09,$55,$65,$57,$ff,$f7,$fb,$bf
        .byte $bf,$9a,$02,$55,$56,$aa,$98,$bb,$9f,$aa,$92,$0a,$55,$59,$d7,$9f
        .byte $ff,$fb,$eb,$9a,$02,$6a,$9a,$59,$5d,$9f,$55,$d6,$29,$0a,$6a,$aa
        .byte $aa,$8a,$ba,$9f,$aa,$92,$0a,$56,$66,$56,$9f,$66,$a6,$a6,$2a,$00
        .byte $66,$e6,$ea

    L_f4fb:
        .byte $fa,$7a
        .byte $7e,$5e,$de,$12,$0a,$01,$01,$9f,$05,$19,$19,$1a,$2a,$00,$56,$66
        .byte $65,$57,$5f,$6f,$6f,$63,$2a,$09,$6e,$6e,$6a,$6a

    L_f519:
        stx $aa,y
        nop 

        .byte $eb,$1a,$02,$56,$5a,$6a,$ba,$aa,$95,$57,$43,$2a,$09,$55,$55,$69
        .byte $5e,$f5,$ff,$0f,$03,$a1,$02,$6b,$aa,$aa,$ff,$ff,$a9,$55,$05,$2a
        .byte $01,$65,$55,$f5,$d5,$5a,$6a,$aa,$00,$a2,$01,$59,$e9,$6a,$9f,$8a
        .byte $03,$33,$a2,$09,$66,$66,$56,$55,$55,$d5,$f5,$ff,$a2,$09,$93,$04
        .byte $6a,$ae,$be,$ba,$b9,$2a,$01,$63,$63,$6c,$7c,$bc,$fc,$f8,$a8,$a2
        .byte $09,$55,$54,$01,$15,$16,$5a,$6d,$65,$2a,$01,$06,$5f,$77

    L_f57a:
        sbc L_75dd,x
        lsr $da,x
        and #$0a

        .byte $5a,$bd,$af,$fe,$ff,$5f,$1f,$57,$9a,$02,$56,$f5,$ae,$5a,$f6,$a9
        .byte $6a,$96,$a2,$09,$58,$d8,$da,$7a,$7a,$58

    L_f59b:
        .byte $da,$5a
        .byte $29,$0a,$10,$10,$16,$9f,$36,$76,$f4,$29,$0a,$55,$99,$aa,$ea,$ea
        .byte $fa,$fe,$ff,$92

    L_f5b1:
        asl 
        lsr $56,x

        .byte $9f,$55,$56,$5a,$aa,$a2,$00,$64,$a7,$a4,$94,$50,$40,$40,$00,$2a
        .byte $09,$15,$16,$2d,$25,$16,$2d,$29,$15,$2a,$01,$55,$55,$96,$97,$5b
        .byte $5a,$56,$95,$2a,$01,$51,$64,$65,$79,$69,$69,$65,$55,$2a,$01,$6f
        .byte $d9,$f5,$7d,$ad,$af,$97,$b7,$29,$0a,$69,$eb,$e7,$6d,$6d,$94,$b4
        .byte $b4,$29,$0a,$60,$80,$93,$04,$00,$03,$0f,$a2,$06,$65,$59,$d5,$d5
        .byte $35,$3d,$0f,$03,$a1,$02,$54,$52,$93,$06,$02,$26,$00,$93,$08,$40
        .byte $60,$00,$06,$0b,$09,$06,$19,$14,$13,$0f,$2a,$0b,$6a,$aa,$a9,$65
        .byte $67,$a5,$a5,$25,$a2,$01,$15,$15,$69,$6a,$6e,$6c,$68,$68,$2a,$01
        .byte $6f,$7b,$7e,$ff,$ff,$3f,$0f,$a0,$9a,$02,$50,$60,$60,$70,$70,$9f
        .byte $b0,$a2,$0b,$01,$41,$41,$45,$40,$45,$41,$41,$60,$00,$42,$9f,$40
        .byte $44,$45,$45,$41,$62,$00

    L_f65a:
        ora ($01,x)

        .byte $93,$06,$05,$60,$00,$40,$40,$00,$00,$02,$02,$00,$00,$6b,$00,$19
        .byte $59,$53,$4c,$01,$00,$14,$3f,$b1,$0c,$1b,$87,$c6,$e1,$31,$80,$0f
        .byte $0f,$2b,$0a,$64,$61,$61,$47,$47,$1c,$50,$51,$ba,$0f,$5a,$da,$d6
        .byte $aa,$00,$2a,$b6,$e0,$fb,$01,$18,$88,$a8

    L_f696:
        tax 

    L_f697:
         .byte $02,$80
        .byte $a8,$02,$2b,$00,$45,$01,$05,$00,$85,$00,$01,$85,$6b,$00,$45,$41
        .byte $9f,$45,$9f,$41,$60,$00,$93,$05,$05,$04,$04,$14,$60,$9f,$00,$01
        .byte $06,$0a,$1a,$1a,$2a,$bc,$00,$01,$50,$59,$93,$04,$aa,$ae,$bc,$0f
        .byte $4b,$80,$3e,$ab,$82,$a8,$a4,$a6,$cb,$01,$16,$19,$55,$14,$44

    L_f6d8:
        rti 

        .byte $10,$14,$bc,$00,$40,$02,$1f,$1b,$6b,$6f,$af,$af,$bc,$0f,$00,$54
        .byte $a5,$a9,$86,$e6,$de,$da,$bc,$9f,$01,$80,$b1,$a8,$ac,$ab,$eb,$6b
        .byte $0c,$45,$93,$04,$41,$9f,$45,$60,$00,$10,$10,$14,$14,$16,$12,$12
        .byte $02,$6b,$00,$9f,$6a,$aa,$af,$bb,$a7,$92,$bc,$0f,$69,$93,$04,$6b
        .byte $a7,$a5,$a5,$cf,$0b,$59,$1b,$1b,$7b,$7a,$ef,$7f,$c0,$b1,$0c,$44
        .byte $44,$94,$90,$91,$92,$42,$02,$bc,$00,$5b,$5b,$93,$05,$5a,$55,$cf
        .byte $01,$9f,$6b,$df,$bc,$b0,$f3,$c3,$1f,$0c,$6a,$5a,$a5,$02,$00,$00
        .byte $a8,$6a,$cb,$00,$42,$4a,$6a,$52,$da,$2a,$2a,$0a,$c6,$0b,$06,$06
        .byte $16,$9f,$10,$42,$4a,$6b,$00,$41,$00,$14,$55,$56,$6a,$6b,$ab,$bc
        .byte $0f,$5a,$96,$da,$3a,$0e,$c3,$b0,$6c,$fc,$0b,$68,$62,$58,$55,$56
        .byte $6a,$0a,$00,$cb,$00,$46,$06,$46,$06,$46,$46,$01,$00,$bc,$00,$69
        .byte $e5,$a5,$94,$a4,$91,$49,$1a,$bc,$0f,$06,$1a,$1b,$93,$05,$5b,$cf
        .byte $01,$56,$a5,$85,$b5,$a4

    L_f79f:
        ldx $a5
        lda $cf
        ora ($05,x)
        ora $85
        sta $c5
        sbc $e5
        sbc ($6b,x)

        .byte $0c,$05,$05,$04,$04,$93,$04,$00,$b0,$00,$5a,$db,$1a,$3a,$0a,$0e
        .byte $d3,$5c

    L_f7bf:
        .byte $cf,$0b,$6f,$6b,$53,$57,$af,$bf,$bf,$ff,$fc,$0b
        .byte $40,$41,$45,$44,$45,$15,$05,$11,$b0,$00,$93,$05,$40

    L_f7d8:
        .byte $9f,$00
        .byte $b0,$00

    L_f7dc:
        lsr $57,x
        eor $55,x

        .byte $50,$0a,$2a,$15,$cb,$0f,$5a,$5a,$5f,$70,$03,$f5,$55,$55,$cf,$0b
        .byte $6a

    L_f7f1:
        .byte $82,$00,$00,$f0,$6c,$6f,$6b,$fc,$0b,$9f,$52,$12,$12,$9f,$02
        .byte $c6,$00

    L_f802:
        .byte $12,$43,$43,$4b,$4b,$0b

    L_f808:
        php 
        plp 

        .byte $6b,$0c,$67,$6b,$69,$aa,$ac,$c0,$00,$00,$cf,$0b,$14,$40,$55,$54
        .byte $00,$00,$20,$aa,$b2,$00,$50,$51,$05,$04,$44,$44,$10,$10,$b0,$93
        .byte $0b,$00,$1a,$06,$00,$28,$03,$33,$03,$03,$bc,$02,$45,$65,$55,$15
        .byte $00,$f0,$ff,$ff,$cf,$02,$6a,$aa,$6a,$9a,$0a

    L_f845:
        .byte $00,$f0,$7c,$1c
        .byte $09,$42,$42,$4a

    L_f84d:
        .byte $9f
        .byte $ca,$c2,$42,$b6,$0c,$10,$10,$9f,$02,$0f,$0a,$0a,$b2,$09,$15,$55
        .byte $56,$da,$6a,$a0,$56,$76,$29

    L_f865:
        asl 

        .byte $5a,$6a,$aa,$81,$09,$25,$25,$a5,$29,$00,$60,$63,$60

    L_f873:
        rti 

    L_f874:
         .byte $93,$04,$43,$2b
        .byte $06,$00,$00,$93,$04,$01,$00,$00,$60,$00,$12,$1a,$1a,$0a,$0a,$9f
        .byte $02,$b2,$00,$55,$b5,$65,$6a,$60,$69,$59,$69,$a2,$01,$60,$48,$c2
        .byte $2b,$2a,$fa,$fb,$eb,$a9,$02,$01,$85,$01,$05,$01,$81,$c1,$e1,$69
        .byte $02,$93,$08,$05,$20,$00,$6b,$9b,$5b,$6b,$5b,$6b,$6b,$5b,$a2,$09
        .byte $6e,$6a,$be,$ee,$be,$be,$ee,$ba,$92,$0a,$93,$04,$42,$0a,$02,$0a
        .byte $02,$26,$00,$01,$11,$01,$11,$01,$11,$01,$11,$60,$00,$01,$81,$00
        .byte $80,$00,$00,$88,$88,$26,$00,$59,$69,$59,$b5,$b6,$96,$96,$9e,$a2
        .byte $01

    L_f8e9:
        adc #$59

        .byte $93

    L_f8ec:
        asl $d9
        and #$0a

        .byte $93,$08,$52,$26,$00,$06,$05,$06,$05,$06,$05,$06,$05,$2a,$00,$67
        .byte $a7,$67,$a5,$55,$95,$55,$96,$2a

    L_f908:
        ora #$5a
        cli 
        cli 
        sei 
        sei 
        rts 



        .byte $68,$68,$a2,$01,$05,$11,$05,$15,$93,$04

    L_f919:
        ora $60

        .byte $00,$01,$05,$05,$11,$05,$11,$05,$11,$60,$00,$44,$45,$41,$45,$41
        .byte $45,$45,$41,$60,$00,$59,$1d,$1d,$0d,$0f,$0d,$0f,$07,$21,$0a,$6a
        .byte $69,$99,$9f,$9b,$99,$9a,$a2

    L_f942:
        ora ($93,x)

    L_f944:
         .byte $04,$52,$93,$04,$d2
        .byte $26,$0a,$93,$07,$06,$0a,$2a,$00,$6a,$69,$69,$aa,$69,$a9,$b9,$b5
        .byte $a2

    L_f95a:
        ora #$9f
        rts 



        .byte $93,$05,$80,$a2,$00,$01,$93,$04,$05,$15,$05,$05,$60,$00,$05,$11
        .byte $05,$11,$05,$11,$05,$11,$60,$00,$45,$41,$45,$45,$41,$9f,$45,$60
        .byte $00,$06,$02,$c2,$01,$01,$c1,$01,$cf,$2a,$06,$55,$65,$59,$93,$04
        .byte $99,$ff,$2a,$01,$93,$06,$63,$a3,$a3,$a2,$06,$1a,$19,$1a,$19,$1a
        .byte $15,$55,$5f,$2a,$09,$6f,$67,$67,$6b,$6b,$69,$ab,$ab,$29,$0a,$42
        .byte $93,$06,$40,$c0,$26,$0a,$45,$05,$05,$93,$05,$00

    L_f9b9:
        rts 



        .byte $00,$05,$05

    L_f9bd:
        ora ($93,x)
        ora $00
        rts 



        .byte $00,$45,$05,$01,$93,$05,$00,$60,$00,$9f,$4b,$93,$04,$0b,$0a,$6b
        .byte $0c,$5a,$5a,$5b,$5b,$59,$7a,$6a,$ff,$fc,$0b,$9f,$58,$98,$d8,$58
        .byte $68,$a0,$cb

    L_f9e5:
        .byte $0f
        .byte $65,$9d,$7f,$7d,$ff,$ff,$fd,$55,$29,$0a,$6b,$9f,$67,$57,$9f,$55
        .byte $29,$0a,$93,$04,$40,$93,$04,$80,$a2,$93

    L_fa00:
        .byte $1a,$00
        .byte $06,$37,$35,$a1,$02,$01,$05,$16,$5a,$59,$d5,$57,$54,$2a,$01,$56
        .byte $56,$55,$99,$a9,$aa,$ca,$2b,$a2,$01

    L_fa1b:
        .byte $50,$50,$90,$54
        .byte $95,$95,$55,$d7,$2a,$01,$93,$04,$00,$15,$1f,$1c,$1c

    L_fa2c:
        cpy L_9300 + $1

        .byte $04,$00,$55,$ff,$00,$00,$cc,$01,$93,$04,$00,$54,$f4,$34,$34,$cc
        .byte $01,$93,$08,$1c,$cc,$01,$93,$08,$34,$cc,$01,$9f,$1c,$1f,$15,$9f
        .byte $00,$cc,$01,$9f,$00,$ff,$55,$9f,$00,$cc,$01,$9f,$34,$f4,$54,$9f
        .byte $00,$cc,$01,$1c

    L_fa63:
        .byte $1c,$1f
        .byte $15,$2a,$2f,$2c,$2c,$cc,$01,$00,$00,$ff,$55,$aa,$ff,$00,$00,$cc
        .byte $01,$34

    L_fa77:
        .byte $34,$f4,$54
        .byte $a8,$f8,$38,$38,$cc,$01,$93,$08,$2c,$cc,$01,$93,$08,$38,$cc,$01
        .byte $2c,$2c,$2f,$2a,$15,$1f,$1c,$1c,$cc,$01,$00,$00,$ff,$aa,$55,$ff
        .byte $00,$00,$cc,$01,$38,$38,$f8,$a8,$54,$f4,$34,$34,$cc,$01,$78

    L_faa9:
        lda #$35
        sta $01
        lda #$00
    L_faaf:
        sta cCia1PortA
    L_fab2:
        jsr L_2c45
        lda cCia1PortB
        cmp #$ff
        bne L_fab2
    L_fabc:
        lda cCia1PortB
        cmp #$ff
        bne L_fabc
        sei 
        lda #$35
        sta $01
        lda #$00
        sta sFiltMode
        sta vBorderCol
        lda cCia2DDRA
        ora #$03
        sta cCia2DDRA
        lda #$08
        sta vScreenControl1
        lda #$ff
        sta vSprEnable
        lda #$17
        sta vScreenControl2
        ldy #$00
        lda #$00
    L_faeb:
        sta vColorRam + $00,y
        sta vColorRam + $100,y
        sta vColorRam + $200,y
        sta vColorRam + $300,y
        dey 
        bne L_faeb
        lda #$fe
        sta vIRQMasks
        lda #$01
        sta vIRQMasks
        lda #$01
        sta vBackgCol0
        lda #$0c
        sta vBackgCol1
        lda #$0b
        sta vBackgCol2
        sta vBackgCol3
        lda #$00
        sta vSprExpandY
        sta vIRQFlags
        sta vSprPriority
        sta vSprExpandX
        sta cCia1TimerAControl
        sta cCia1TimerbControl
        sta cCia2TimerAControl
        sta cCia2TimerbControl
        lda #$7f
        sta cCia1IntControl
        lda cCia1IntControl
        lda #$ff
        sta cCia1DDRA
        lda #$00
        sta cCia1DDRB
        lda #$01
        sta vSprMCMCol0
        lda #$09
        sta vSprMCMCol1
        lda #$00
        sta cCia2PortA
        lda #$64
        sta vSprite0X
        sta vSprite0Y
        lda #$ff
        sta vSprEnable
        lda #$00
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        sta vSprite6Y
        sta vSprite7Y
        sei 
        lda #$35
        sta $01
        lda #$c6
        sta vRaster
        lda #$81
        sta vIRQMasks
        lda #$08
        sta vScreenControl1
        lda #$18
        sta vScreenControl2
        lda #$38
        sta vMemControl
        lda #$00
        sta vBackgCol0
        sta vBorderCol
        lda #$34
        sta $01
        ldy #$c0
    L_fba4:
        lda L_5998 + $188,y
        sta L_cfff,y
        dey 
        bne L_fba4
        lda #$35
        sta $01
        jmp L_235c
        sei 
        lda #$37
        sta $01
        lda $ff
        sta SCREEN_BUFFER_2 + $58
        lda $0330
        sta SCREEN_BUFFER_2 + $30
        lda $0331
        sta SCREEN_BUFFER_2 + $35
        jsr L_fd98 + $b
        jsr L_ff5b
        jsr L_fd15
        lda #$08
        tax 
        tay 
        jsr $ffba
        lda #$03
        ldx #$5f
        ldy #$cc
        jsr L_ffbd
        lda #$00
        sta $0330
        lda #$00
        sta $0331
        ldx #$00
    L_fbef:
        lda #$00
        sta vColorRam + $00,x
        sta vColorRam + $100,x
        sta vColorRam + $200,x
    L_fbfa:
        sta vColorRam + $300,x
        sta vBorderCol
        sta vBackgCol0
        inx 
        bne L_fbef
        lda #$00
        jsr $ffd5
        lda #$00
        sta SCREEN_BUFFER_0 + $100
        jmp $080b

        .byte $30,$31,$2a,$93,$00,$00,$93,$cc,$00,$40,$00,$00,$60,$00,$00,$38
        .byte $00,$00,$1d,$b0,$00,$0f,$f8,$00,$07,$fc,$00,$0b,$fc,$00,$0d,$fc
        .byte $00,$05,$fc,$00,$71,$fc,$00,$3f,$fc,$00,$07,$be,$00,$00,$7c,$00
        .byte $00,$38,$93,$13,$00,$a0,$40,$00,$00,$e0,$00,$00,$f0,$00,$00,$7d
        .byte $b0,$00,$3f,$f8,$00,$1f,$fc,$00,$0f,$fe,$00,$1f,$fe,$00,$1f,$fe
        .byte $00,$7f,$fe,$00,$ff,$fe,$00,$7f,$fe,$00,$3f,$ff,$00,$07,$fe,$00
        .byte $00,$7c,$00,$00,$38

    L_fc78:
        .byte $93,$14,$00,$03
        .byte $c0,$00,$02,$b0,$00

    L_fc81:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$ef,$00,$03,$97,$c0
        .byte $32,$b9,$c0,$de,$62,$c0,$ef,$62,$c0,$3b,$a2,$c0,$0c,$a2,$c0,$03
        .byte $fd,$c0,$0d,$ae,$c0,$36,$a0,$00,$1a,$ac,$00,$2b,$02,$00,$36,$0a

    L_fcb3:
        cpy #$0d
        dec $e480

        .byte $02,$b3

    L_fcba:
        bcs L_fcbc
    L_fcbc:
        rts 



        .byte $a8,$03,$60,$f8,$02,$b0,$08,$00,$00,$08,$00,$00,$0c,$93,$2d,$00
        .byte $e4,$9f,$00,$03,$c0,$00,$02,$b0,$00

    L_fcd6:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$ec,$00,$03,$9b,$00
        .byte $03,$b6,$c0,$32,$be,$c0,$df,$62,$c0,$eb,$ae,$00,$3c,$a2,$00,$03
        .byte $f6,$00,$03,$8b,$00,$0e,$b0,$00,$39,$ac,$00,$36,$b3,$00,$36,$ca
        .byte $00

    L_fd09:
        asl 
        dec L_e3ff + $1
        ora $c0ce

        .byte $02,$b3,$b0,$00,$63

    L_fd15:
        ldy #$03
        bcc L_fd09

        .byte $02,$b0,$f0,$00,$00,$30,$93,$2d,$00,$e4,$93,$06,$00,$03,$c0,$00
        .byte $02,$b0,$00

    L_fd2c:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$9c,$00,$03,$98,$00
        .byte $03,$e7,$00,$0f,$b7,$00,$37,$ba,$00,$38,$8a,$00,$00,$37,$00,$00
        .byte $db,$00,$03,$e8,$00,$03,$70,$00

    L_fd56:
        asl.a $00ac
        ora.a $00ac
        asl.a $00bb
        cpx $03

        .byte $7a,$00,$00,$ae,$c0,$00,$a2,$c0,$00,$df,$80,$00,$eb,$80,$00,$df
        .byte $00,$00,$b0,$93,$2b,$00,$e4,$93,$06,$00

    L_fd7b:
        .byte $03
        .byte $c0,$00,$02,$b0,$00

    L_fd81:
        ora ($b0,x)

    L_fd83:
         .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$b0,$00,$03,$9c,$00
        .byte $03,$d8,$00,$03,$e8

    L_fd98:
        .byte $00,$0f,$b7,$00,$0f,$b7,$00,$0c,$fb,$00,$00,$5b,$00,$03
        .byte $ac,$00,$03,$fc,$00,$03,$ac,$00,$03,$6c,$00,$03,$60,$00,$e4,$03

    L_fdb6:
        .byte $70,$00,$00,$6c,$00,$00,$93,$02,$00,$00,$df,$00,$00,$2b,$00,$00
        .byte $34,$00,$00,$e8

    L_fdca:
        .byte $93,$2b,$00
        .byte $e4,$93,$06,$00,$03,$c0,$00,$02,$b0,$00

    L_fdd7:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$f0,$00,$00,$ac,$00,$03,$9c,$00
        .byte $03,$dc,$00,$03,$dc,$00,$03,$dc,$00,$03,$e8,$00,$0d,$f8,$00,$0d
        .byte $68,$00,$02,$fc,$00,$03,$0c,$00,$03,$e8,$00,$0e,$db,$00,$0e,$ba
        .byte $00,$e4,$03

    L_fe0c:
        ror $c0,x

        .byte $00,$be,$c0,$00,$e1,$80,$00,$2c,$b0,$00,$ec,$a0,$00,$e3,$70,$00
        .byte $b2,$c0,$93,$2a,$00,$e4,$9f,$00,$03,$c0,$00,$02,$b0,$00

    L_fe2c:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$f0,$00,$00,$9c,$00
        .byte $03,$df,$00,$3b

    L_fe42:
        dec $3700,x

        .byte $df,$00,$39,$ec,$00,$0e,$6c,$00,$03,$a0,$00,$00,$0c,$00,$03

    L_fe54:
        inx 

        .byte $00,$0e,$eb,$00,$09,$e7,$00,$0e,$b7,$00,$02,$4a,$00,$e4,$03,$bd
        .byte $c0,$03,$a2,$b0,$00,$e3,$60,$00,$ec,$e0,$03,$ac,$d0,$03,$f0,$20
        .byte $00,$00,$30,$93,$2a,$00,$e4,$9f,$00,$03,$c0,$00,$02,$b0,$00

    L_fe84:
        ora ($b0,x)

        .byte $00,$02,$b0,$00,$03,$f0,$00,$00,$30,$00,$00,$fc,$00,$00,$93,$02
        .byte $00,$00,$9e,$c0,$18,$6c,$c0,$27,$6c,$c0,$39,$bf,$00,$0e,$ba,$00
        .byte $03,$f8,$00,$00,$e8,$00,$0e,$eb,$00

    L_feaf:
        rol $27,x

        .byte $00,$37,$3a,$00,$0a,$c9,$c0,$0d,$ce,$80,$e4,$03,$b3,$70,$03

    L_fec0:
        .byte $b0,$a8,$0f,$b0,$e4
        .byte $0e,$80,$38,$00,$00,$08,$00,$00,$0c,$93,$2d,$00,$e4,$03,$e0,$00
        .byte $00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03
        .byte $e0,$00,$00,$e0,$00,$03,$e0,$00,$00,$e0,$00,$03,$e0,$00,$00

    L_fef4:
        cpx #$00

        .byte $03,$e0,$00,$00,$e0,$00,$03,$e0,$00

    L_feff:
        .byte $00

    L_ff00:
        cpx #$00

    L_ff02:
         .byte $03
        .byte $e0,$00,$00,$e0,$00

    L_ff08:
        .byte $03
        .byte $e0,$00,$00,$e0,$00,$03,$e0,$00,$c4,$02,$08,$00,$02,$08,$00,$02
        .byte $08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$aa,$0a,$a0,$93,$09
        .byte $00,$aa

    L_ff2b:
        asl 
        ldy #$02
    L_ff2e:
        php 

        .byte $00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08,$00,$02,$08

    L_ff3e:
        .byte $93
        .byte $0d,$00,$14,$93,$1e,$00,$bd,$20,$42,$04,$20,$a3,$fd,$20,$15,$fd
        .byte $4c,$0b,$08

    L_ff52:
        jsr L_0403 + $28
        rol $bd
        lda $bd
        cmp #$02
    L_ff5b:
        bne L_ff52
        ldy #$09
    L_ff5f:
        jsr L_04ad
        cmp #$02
        beq L_ff5f
    L_ff66:
        cpy $bd
        bne L_ff52
        jsr L_04ad
        dey 
        bne L_ff66
        rts 


        lda #$10
    L_ff73:
        bit cCia1IntControl
        beq L_ff73
        lda cCia2IntControl
        sta vBorderCol
        sta sFiltMode
        lsr 
        lda #$19
        sta cCia2TimerAControl
        rts 


    L_ff88:
        jsr L_0478 + $1d
        jsr L_0403 + $9
    L_ff8e:
        jsr L_04ad
        sta.a $00ae,y
        iny 
        cpy #$05
        bne L_ff8e
        jsr L_04ad
        cmp #$30
        bne L_ff88
        jsr L_04ad
        cmp #$31
    L_ffa5:
        bne L_ff88
    L_ffa7:
        jsr L_04ad
        iny 
        cpy #$13
        bne L_ffa7
        jsr L_0478 + $13
        jsr L_0478 + $1d
        jsr L_0403 + $9
    L_ffb8:
        jsr L_04ad
        ror $01
    L_ffbd:
        sta ($ae),y
        rol $01
        inc $ae
        bne L_ffc7
        inc $af
    L_ffc7:
        lda $ae
        cmp $b0
        lda $af
        sbc $b1
        bcc L_ffb8
        dec $c0
        clc 
        lda $01
        ora #$20
        sta $01
        rts 


        sei 
        ldy #$00
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        lda #$07
        sta $01
        sta cCia2TimerALo
        lda #$01
        sta cCia2TimerAHi
        rts 


        ldx #$08
    L_fff5:
        jsr L_0403 + $28
        rol $bd
        dex 
        bne $1000f
    L_fffd:
        bit $12
