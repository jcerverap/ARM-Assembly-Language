.global _start
_start:
	
	MOV R0, #0
	MOV R1, #0
	MOV R2, #0
	MOV R3, #0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV R7, #0
	
	
	LDR R0, =list
	LDR R1, [R0]
	LDR R2, [R0, #4]!
	LDR R3, [R0, #4]!
	LDR R4, [R0, #4]!
	LDR R5, [R0, #4]!
	
	@MOV R0, #0x1E
	@MOV R1, R0
	
	MOV R7, #1
	SWI 0
	
.data
list:
	.word 4, 5, -12, 2, 3