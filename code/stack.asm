.section .data

zero:   .word 0
one:    .word 1
two:    .word 2
three:  .word 3
four:   .word 4

all_zeros:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

backup: .space 20         @ Reserve space for 5 words (4 bytes each)

.section .text
.globl _start
_start:

    LDR		R0, =zero       	@ Load address of zero into R0
    LDR		R1, =all_zeros     	@ Load address of all_zeros into R1
    LDR		R2, =backup     	@ Load address of backup into R2

    LDM		R0, {R3-R6, R9}     	@ Load the value at address in R0 into R3 to R6 and R9
    PUSH	{R3-R6, R9}        		@ Push registers R3 to R6 and R9 onto the stack	
    LDM		R1, {R3-R6, R9}     	@ Load the value at address in R1 (all zeroes) R3 to R6 and R9
    POP		{R0, R1, R10-R12}         	@ Pop values from the stack back into the listed registers
    STM		R2, {R0, R1, R10-R12}     	@ Store values from the registers load from the stack

	STMDB	SP!, {R0-R12, LR}
    LDR		R1, =all_zeros
	LDM		R1, {R0-R12}
	LDM		SP!, {R0-R12, PC}
	
end_program:

    MOV R7, #1          @ syscall: exit
    SVC 0
