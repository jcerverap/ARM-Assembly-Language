.global _start
_start:
	
	MOV	R1, #0xFF, 28	@ R0=4080 (28 = 32 -4)
	
	@ ----------------------------------------------------------------
	@ NOTE!! ONLY one of the two below instructions is correct,
	@ depending on the compiler user. It needs to be checked first!!!

	MOV	R2, #0xFE, 30	@ R0=508  (30 = 32 - 2)
	MOV R3, #0x7F, 30	@ R0=508  (30 = 32 - 2)

	@ ----------------------------------------------------------------
	
    MOVW R0, #12523      @ move wide (16-bits) No available in all assemblers
    LDR R5, =0x25AF150A

	MOVW	R6,	#0xFACE
	MOVT	R6, #0xBABE

	ADR		R8, my_label
	BX		R8
	MOV		R8, #0			@should never execute

my_label:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall

	