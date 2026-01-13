
.section .data
    dividend: .word 53        @ The number to be divided
    divisor:  .word 6         @ The number to divide by
    quotient: .word 0         @ To store the result of the division
    remainder: .word 0        @ To store the remainder

.section .text
.global _start
_start:

    LDR R0, =dividend        @ Load address of dividend
    LDR R1, [R0]             @ Load dividend value into R1
    LDR R2, =divisor         @ Load address of divisor
    LDR R3, [R2]             @ Load divisor value into R3

    MOV R4, #0               @ Initialize quotient (R4) to 0
    MOV R5, R1               @ Initialize remainder (R5) to dividend

division_loop:

    CMP R5, R3               @ Compare remainder with divisor
    BLT end_division         @ If remainder < divisor, exit loop

    SUB R5, R5, R3           @ Subtract divisor from remainder
    ADD R4, R4, #1           @ Increment quotient
    B division_loop          @ Repeat the loop

end_division:

    LDR R6, =quotient        @ Load address of quotient
    STR R4, [R6]             @ Store quotient
    LDR R6, =remainder       @ Load address of remainder
    STR R5, [R6]             @ Store remainder

end_program:

    MOV R7, #1               @ syscall: exit
    SWI 0                    @ make syscall
