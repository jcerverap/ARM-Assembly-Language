SUM1 .req R1
SUM2 .req R2
TOTAL .req R0

.section .text
.global _start
_start:
	
	MOV		SUM1, #7
	MOV		SUM2, #5
	
	ADD		TOTAL, SUM1, SUM2
	
end_program:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall
    
	.end
