@ This program looks up an operation in a jump table and jumps to the corresponding code.
@ The operation code is loaded from memory. Supported operations are:
@ 0: Addition
@ 1: Subtraction
@ 2: Multiplication
@ If the operation code is invalid, it exits the program.

.section .data

jump_table:
    .word add_operation
    .word sub_operation
    .word mul_operation

op_code: .word 2          @ Operation code to look up (0:Add, 1:Sub, 2:Mul) 

.section .text
.globl _start  
_start: 

    MOV R4, #10             @ First operand
    MOV R5, #5              @ Second operand

    LDR R0, =op_code                @ Load address of op_code into R0
    LDR R0, [R0]                    @ Load operation code into R0

    LDR R1, =jump_table             @ Load address of jump table into R1
    LDR PC, [R1, R0, LSL #2]        @ Load the address from the jump table into PC (jump_table BASE + op_code * 4)

@ Addition operation
add_operation:

    ADD R6, R4, R5          @ R6 = R4 + R5
    B end_program           @ Branch to end

@ Subtraction operation
sub_operation:

    SUB R6, R4, R5          @ R6 = R4 - R5
    B end_program           @ Branch to end

@ Multiplication operation
mul_operation:

    MUL R6, R4, R5          @ R6 = R4 * R5
    B end_program           @ Branch to end

end_program:
    MOV R7, #1        @ syscall: exit
    SWI 0


