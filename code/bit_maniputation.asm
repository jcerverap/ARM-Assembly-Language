@ Bit Manipulation in ARM Assembly
@
@ BFI - Bit Field Insert
@ BFXIL - Bit Field Extract and Insert Low
@ UBFX - Unsigned Bit Field Extract
@ SBFX - Signed Bit Field Extract
@ AND - Bitwise AND
@ ORR - Bitwise OR
@ EOR - Bitwise Exclusive OR
@ BIC - Bitwise Bit Clear
@ MVN - Move Not (Bitwise NOT)
@ LSL - Logical Shift Left
@ LSR - Logical Shift Right
@ ASR - Arithmetic Shift Right
@ ROR - Rotate Right
@ RRX - Rotate Right with Extend
@ ANDS - Bitwise AND and update flags
@ ORRS - Bitwise OR and update flags
@ EORS - Bitwise Exclusive OR and update flags
@ BICS - Bitwise Bit Clear and update flags
@ Example usage of some bit manipulation instructions


.section .data
    value: .word 0b10101010      @ Example value for bit manipulation
    result: .word 0               @ To store results
	
.section .text
.global _start
_start:

clear_regs:

	MOV	R0, #0
	MOV	R1, #0
	MOV	R2, #0
	MOV	R3, #0
	MOV	R4, #0
	MOV	R5, #0
	MOV	R6, #0
	MOV	R7, #0
	MOV	R8, #0
	MOV	R9, #0
	MOV	R10, #0
	MOV	R11, #0
	MOV	R12, #0

init_values:

    LDR R0, =value               @ Load address of value
    LDR R1, [R0]                 @ Load value into R1

    AND R2, R1, #0b11110000      @ Bitwise AND with mask to clear lower 4 bits
    ORR R3, R1, #0b00001111      @ Bitwise OR with mask to set lower 4 bits
    EOR R4, R1, #0b11111111      @ Bitwise XOR with all bits set (bitwise NOT)

basic_bit_field_operations:

    LSL R5, R1, #2               @ Logical shift left by 2
    LSR R6, R1, #2               @ Logical shift right by 2
    ASR R7, R1, #2               @ Arithmetic shift right by 2

    LDR R8, =result              @ Load address of result
    STR R2, [R8]                 @ Store AND result
    STR R3, [R8], #4             @ Store ORR result
    STR R4, [R8], #4             @ Store EOR result
    STR R5, [R8], #4            @ Store LSL result
    STR R6, [R8], #4            @ Store LSR result
    STR R7, [R8], #4            @ Store ASR result

advance_bit_field_operations:

    BFI R2, R1, #4, #4          @ Bit Field Insert: insert bits 4-7 of R1 into R2
    @ Not valid for CORTEX-M4 --> BFXIL R3, R1, #0, #4       @ Bit Field Extract and Insert Low: extract bits 0-3 of R1 and insert into R3
    UBFX R4, R1, #4, #4        @ Unsigned Bit Field Extract: extract bits 4-7 of R1 into R4
    SBFX R5, R1, #4, #4        @ Signed Bit Field Extract: extract bits 4-7 of R1 into R5
    BIC R6, R1, #0b00001111      @ Bitwise Bit Clear: clear lower 4 bits of R1 and store in R6
    MVN R7, R1                  @ Move Not: bitwise NOT of R1 and store in R7
    ASR R9, R1, #2              @ Arithmetic Shift Right by 2

	STR R2, [R8], #4
	MOV R3, #0
	STR R3, [R8], #4
	STR R4, [R8], #4
	STR R5, [R8], #4
	STR R6, [R8], #4
	STR R7, [R8], #4
	STR R9, [R8], #4

end_program:

    MOV R7, #1
    SWI 0  
