@ this program calculates the greatest common divisor (GCD) of two numbers and writes the result to a specific memory address

.section .text

.global _start
_start:
	
	LDR R4, =numbers
	LDR	R5, =oaddr
	
	LDR R0, [R4], #4
	LDR	R1, [R4]
	
check_gcd:

	CMP		R0, R1
	BEQ		end_program
	
	SUBLT	R1, R0 @ if R2 > R1 -> R2 -= R1
	SUBGT	R0, R1 @ if R1 > R2 -> R1 -= R2
	
	B check_gcd
	
end_program:

	STR		R0, [R5]

    MOV R7, #1
    SWI 0  

.section .data

numbers: .word 300, 75


.equ oaddr,	0x0200
