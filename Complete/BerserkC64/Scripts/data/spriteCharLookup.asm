* = $fd00 "SpriteCharLookup"

.label remove = 24

ColumnSpriteX:	.fill 40, 24 + (i * 8)
RowSpriteY:		.fill 25, 50 + (i * 8)
ColumnSpriteMSB:	.fill 28, 0
					.fill 12, 1