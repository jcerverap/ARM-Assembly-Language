@ This program calculates the factorial of a number and exits.

.section .text

    .globl _start
_start:

	MOV		R0, #12
	MOV		R1, R0

loop:
	SUB		R1, #1
	CMP		R1, #1
	BLE		end_program
	
	MUL		R0, R0, R1
	
	B		loop

end_program:

    MOV R7, #1        @ syscall: exit
    SWI 0
	