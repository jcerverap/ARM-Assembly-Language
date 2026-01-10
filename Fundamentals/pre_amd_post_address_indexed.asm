.equ ZERO, 0x00
.equ OFFSET, 0x04
.equ DATA, 0x12345678

.section .data

data_addr:          .word 0x00
data_addr_offset:   .word 0x00

.section .text
.global _start
_start:

	LDR R0, =ZERO
	MOV R1, R0
	MOV R2, R0
	MOV R3, R0
	
    /* Load base address into r0 */
    LDR R0, =data_addr
    LDR R1, =data_addr_offset

    LDR R2, =DATA
    STR R2, [R0], #OFFSET		@first store R2 in R0 and then R0+=4

    LDR R3, =data_addr
    STR R2, [R3, #OFFSET]!		@first R0+=4 and then store R2 in R0

end:

    /* Exit program (for simulation purposes) */
    MOV r7, #1          /* syscall: exit */
    SWI 0
    .end
    