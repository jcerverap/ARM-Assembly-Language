
.equ		RAM_ADDR1, 0x20000000
.equ		RAM_ADDR2, 0x20000100
.equ		TEXT, 0xBABEFACE
.equ		REPETITIONS, 10

.global _start
_start:

	BL		fill_buffer
	BL		copy_buffer
	B		end_program
	
fill_buffer:

	LDR		R0, =RAM_ADDR1
	LDR		R1, =TEXT
	LDR		R2, =REPETITIONS
	
loop_fill_buffer:

	STR		R1, [R0], #4
	SUBS	R2, #1
	BGT		loop_fill_buffer
	
	BX		LR

copy_buffer:

	LDR		R0, =RAM_ADDR1
	LDR		R1, =RAM_ADDR2
	LDR		R2, =REPETITIONS

loop_copy_buffer:

	LDR		R3, [R0], #4
	STR		R3, [R1], #4

	SUBS	R2, #1
	BGT		loop_copy_buffer
	
	BX		LR

end_program:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall

