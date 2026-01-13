
.section .data
list: .word -13, 25, 2, -7, -11, 33, 0 @ total = 29


.section .text
.global _start
_start:
	
	LDR		R0, =list
	MOV		R1, #0
	
next_number:

	LDR		R2, [R0, R1, LSL #2]
	ADD 	R3, R2
	
	ADD		R1, #1
	CMP		R1, #7
	BLT		next_number
	
end:
	
	MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall

