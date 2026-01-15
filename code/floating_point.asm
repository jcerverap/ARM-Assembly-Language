
.equ 	CTLREG, 0xE000ED88		@Register for the Coprocessor Access Control (stm32)
.equ	FLTMASK, (0x0F<<20)		@ Enablig floting point code
.equ	SUM1, 0x3E800000
.equ	SUM2, 0x3F700000

.global _start
_start:
	
	LDR	R0, =CTLREG
	LDR	R1, [R0]
	ORR	R1, R1, #FLTMASK
	STR	R1, [R0]				@ Enables floating point
	
	VMOV.F	S1, #SUM1
	VMOV.F	S2, #SUM2
	VADD.F	S0, S1, S2
	
	VMOV.F	R0, S0				@ Move result to R0 for exit code

end_program:

    MOV R7, #1          		@ syscall: exit
    SVC 0
