.global _start
_start:
	
	MOV R0, #0xEF000000
	MOV R1, #0xF0000000
	MOV R2, #0xFF000000
	MOV R3, #0x01000000
	MOV	R4, #0x10000000

	ADDS 	R5, R0, R3 
	MRS 	R9, CPSR		@ Carry flag off

	ADDS 	R5, R1, R3
	MRS 	R9, CPSR		@ Carry flag off

	ADDS 	R5, R2, R3
	MRS 	R9, CPSR		@ Carry flag ON
	
	SUBS 	R5, R2, R0
	MRS 	R9, CPSR		@ Zero flag off
	
	SUBS 	R5, R5, R4
	MRS 	R9, CPSR		@ Zero flag ON
	
	SUBS 	R5, R0, R2
	MRS 	R9, CPSR		@ Negative flag ON

	ADDS	R4, R0, R3		@ Overflow flag ON
	MRS 	R9, CPSR		@ Negative flag ON

	MRS 	R9, CPSR
	MSR 	SPSR, R9    	@ Back up CPSR into SPSR
	
end_program:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall
    
