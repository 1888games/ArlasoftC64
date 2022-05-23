.segment Code [outBin="lynx.o"]

.cpu _65c02

* = $200-10 "Header"

.byte $80,$08,$02,$00,$40,$0A,$42,$53,$39,$33

* = $200 "Code"

stz $FD94
lda #$C0
sta $DF95

stz $fda0
lda #%00000000
sta $fdb0

lda #%00000111
sta $fdaf
sta $fdbf





ldx #0
lda #92


Loop:
	
	lda Stoufer
	sta $d400, x
	inc Stoufer
	inx
	cpx #255
	bne Loop


Horse:
	
	ldx #0
	inc Stoufer
	lda Stoufer
	jmp Loop

	jmp Horse


Stoufer:

	.byte 20