@ This program implements a fifo buffer

FIFO_MAX_IND       .req R8
FIFO_INIT       .req R9
FIFO_HEAD       .req R11
FIFO_TAIL       .req R10
FIFO_COUNT      .req R1
FIFO_ADDR       .req R12
FIFO_DATA       .req R2
FIFO_DATA_ADDR  .req R3
REGS_BACKUP     .req R5
TEST_MODE       .req R6

    .equ    FIFO_SIZE, 16          @ Size of the FIFO buffer (number of 32-bits registers)
    .equ    FIFO_INIT, 1          @ Size of the FIFO buffer (number of 32-bits registers)
	
    .section .data

BABEFACE: .word	0xBABEFACE


fifo_buffer:
    .space  FIFO_SIZE * 4            @ Allocate space for the FIFO buffer

fifo_head:
    .word   0                         @ Head index

fifo_tail:
    .word   0                         @ Tail index

fifo_count:
    .word   0                         @ Number of elements in the FIFO

fifo_data:
	.word	0
	
reg_backup:
    .space  12 * 4                    @ Space to backup R1-R12 and LR

    .section .text
    .global _start
    .global _init_fifo
    .global _put
    .global _get

_start:

    MOV TEST_MODE, #1               @ Enable test mode

_init_fifo:

    LDR FIFO_ADDR, =fifo_buffer           @ Load address of FIFO buffer
	SUB	FIFO_ADDR, #4	
    LDR FIFO_HEAD, =fifo_head             @ Load address of head index
    LDR FIFO_TAIL, =fifo_tail             @ Load address of tail index
    MOV FIFO_MAX_IND, #FIFO_SIZE              @ Load address of count
	SUB	FIFO_MAX_IND, #1
    LDR	FIFO_DATA_ADDR, =fifo_data
	LDR REGS_BACKUP , =reg_backup         @ Load address for register backup

    CMP FIFO_INIT, #FIFO_INIT              @ Check if FIFO is already initialized
    MOVNE LR, #end_program                  @ If not initialized, initialize and exit

    MOV FIFO_COUNT, #0                     @ Initialize count to 0
    MOV FIFO_INIT, #FIFO_INIT              @ FIFO initialized
    STM REGS_BACKUP, {R1-R12}               @ Save registers and link register
    
    CMP 	TEST_MODE, #1                     @ Check if test mode is enabled
	BLEQ	do_test
    BXNE  LR                          

_put:

    LDM REGS_BACKUP, {R1-R12}                           @ Restore registers
    CMP FIFO_INIT, #FIFO_INIT               @ Check if FIFO is initialized
    BLNE _init_fifo                         @ If not, initialize it

    CMP FIFO_COUNT, FIFO_MAX_IND              @ Check if FIFO is full
    BEQ end_put                             @ If full, exit rutine

    LDR FIFO_DATA, [FIFO_DATA_ADDR]
    STR FIFO_DATA, [FIFO_ADDR, #4]!                     @ Store value in FIFO
    ADD FIFO_COUNT, #1                      @ Update count

    STM REGS_BACKUP, {R1-R12}           @ Save registers and link register

end_put:
    BX  LR                                  @ Return from put

_get:

    LDM REGS_BACKUP, {R1-R12}                           @ Restore registers
    CMP FIFO_INIT, #FIFO_INIT               @ Check if FIFO is initialized
    BLNE _init_fifo                         @ If not, initialize it

    CMP FIFO_COUNT, #0                      @ Check if FIFO is empty
    MOVEQ FIFO_DATA, #0                     @ If empty, return 0
    BEQ end_get                             @ If empty, exit routine


    LDR FIFO_DATA, [FIFO_ADDR]                     @ Load value from FIFO
    SUB FIFO_ADDR, #4                       @ Update address
    SUB FIFO_COUNT, #1                      @ Update count
    STM REGS_BACKUP, {R1-R12}        @ Save registers and link register

end_get:
    BX  LR                                  @ Return from get
	
do_test:

    MOV FIFO_DATA, #10                           @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #20                           @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #30                           @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #40                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #50                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #60                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #70                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #80                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #90                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #100                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #110                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #120                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #130                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #140                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO

    MOV FIFO_DATA, #150                            @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put                              @ Call put to store value in FIFO
    
    LDR FIFO_DATA, =BABEFACE                   @ Test value to put in FIFO
	LDR FIFO_DATA, [FIFO_DATA]                   @ Test value to put in FIFO
    STR FIFO_DATA, [FIFO_DATA_ADDR]
    BL  _put 
    
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO
    BL  _get                              @ Call get to retrieve value from FIFO

end_program:

    MOV R7, #1          		@ syscall: exit
    SVC 0

	B end_program