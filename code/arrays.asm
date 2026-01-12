.equ SIZE, 8

.section .data

arry_data: .word 123, 7657, 94579, 90813, 436546, 1243, 3555656, 67654

.section .bss

array_buffer:	.space	32		@32 bytes allocated

.section .text

.global _start
_start:
	
	LDR 	R0, =array_buffer
	LDR 	R1, =arry_data
	MOV		R3, #0
	
_loop:

	LDR		R4, [R1, R3, LSL #2] 
	STR		R4, [R0, R3, LSL #2]
	ADD		R3, #1
	
	CMP		R3, #SIZE
	BLT		_loop
	
end_program:

	@MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall

