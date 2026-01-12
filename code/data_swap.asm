.section .data

word1: .word 0xBABEFACE
word2: .word 0xDEADBEEF

.section .text
.global _start
_start:
	
	MOV		R0, #0
	MOV		R1, #0
	MOV		R2, #0
	
	LDR		R0, =word1
	LDR		R1, [R0]
	LDR 	R0, =word2
	LDR		R2, [R0]

	EOR		R1, R1, R2
	EOR		R2, R1, R2
	EOR		R1, R1, R2
	
	LDR		R0, =word1
	STR		R1, [R0]
	
	LDR 	R0, =word2
	STR		R2, [R0]
	
end_program:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall
    
	.end
