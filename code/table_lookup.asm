@ This program is a search for a given value in a lookup table stored in memory and storeg the index if found.
@ The end of table flag is 0xFFFFFFFF.
@ Otherwise, it exits indicating not found (-1).

.section .data
table: .word 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0xFFFFFFFF
value_to_find: .word 17
end_flag: .word 0xFFFFFFFF
omem: .word 0x90

.section .text

    .globl _start
_start:

    LDR R0, =table            	@ Load address of the table into R0
    LDR R1, =value_to_find    	@ Load address of the value to find into R1
    LDR R2, [R1]              	@ Load the value to find into R2

    LDR R3, =end_flag          	@ Load address of end_flag into R3
    LDR R4, [R3]               	@ Load end_flag into R4

    MOV R5, #0                 	@ Initialize index i = 0
    MOV R6, #-1                	@ Indicate not found by setting R6 to -1

loop:

    LDR R7, [R0, R5, LSL #2]   	@ Load table[i] into R7
	CMP R7, #0xFFFFFFFF        	@ Compare end_flag with 0xFFFFFFFF
    BEQ end_program             @ If end_flag is reached, value not found

    CMP R2, R7                 	@ Compare table[i] with value_to_find
    BEQ found                  	@ If equal, value found

    ADD R5, R5, #1             	@ Increment index i
    B loop						@ Repeat the loop

found:
    @ Value found, handle accordingly (e.g., store index in R6)
    MOV R6, R5                 @ Store index of found value in R6

end_program:

    LDR R8, =omem          @ Load address of omem into R8
    STR R6, [R8]           @ Store the result (index or -1) into omem
    
    MOV R7, #1        @ syscall: exit
    SWI 0