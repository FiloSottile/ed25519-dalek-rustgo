TEXT ·ScalarBaseMult(SB), 0, $2048-16
	MOVQ dst+0(FP), DI
	MOVQ in+8(FP), SI

	MOVQ SP, BX
	ADDQ $2048, SP
	ANDQ $~15, SP

	CALL scalar_base_mult(SB)

	MOVQ BX, SP
	RET

