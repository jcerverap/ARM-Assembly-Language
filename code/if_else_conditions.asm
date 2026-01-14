@ This program load 4 numbers from memmory and compares the first two. If N1 > N2, then R9 is N3 + N4
@ Otherwise, R9 = N3 - N4.

NADRR .req R0
N1 .req R1
N2 .req R2
N3 .req R3
N4 .req R4
RLT .req R9

.section .data

nums: .word 0, 1, 10, 15

.section .text

    .globl _start
_start:

    LDR NADRR, =nums       @ Load address of nums into R0
    LDR N1, [NADRR]        @ Load first value (10) into N1
    LDR N2, [NADRR, #4]    @ Load second value (5) into N2
    LDR N3, [NADRR, #8]    @ Load third value (15) into N3
    LDR N4, [NADRR, #12]   @ Load fourth value (10) into N4

    CMP N1, N2          @ Compare N1 and N2

    ITTE GT          @ If-Then-Else structure for Greater Than
    ADDGT RLT, N3, N4  @ If N1 > N2, RESULT = N3 + N4
    SUBLE RLT, N3, N4  @ Else, RESULT = N3 - N4

end_program:

    MOV R7, #1        @ syscall: exit
    SWI 0
	