TEXT ·ScalarBaseMult(SB), 0, $16384-16
	MOVQ dst+0(FP), DI
	MOVQ in+8(FP), SI

	MOVQ SP, BX
	ADDQ $16384, SP
	ANDQ $~15, SP

	MOVQ scalar_base_mult(SB), AX
	CALL AX

	MOVQ BX, SP
	RET
