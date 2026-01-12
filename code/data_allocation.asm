.section .data

my_word:  .word  0xAABBCCDD                 @ Allocates 4 bytes with value
my_array: .skip  40                         @ Allocates 40 bytes (uninitialized/zero)
source_str: .asciz "Hello from assembly"    @ Source text (in Flash/ROM)

.section .bss
my_bss:   .space  16                        @ Allocates 16 bytes (uninitialized/zero)

.section .text
.global _start
_start:
    LDR R0, =my_word                        @ Load address of my_word
    MOV R2, #15 
    STR R2, [R0]                            @ Store value into my_word

    LDR R0, =my_array                       @ Load address of my_array
    MOV R2, #1                              @ Initialize index to 0
	
fill_array:

    CMP R2, #10                             @ Check if we have filled 10 words (40 bytes)
    BGT end_fill_array                      @ If yes, exit loop

    STR R2, [R0], #4 		                @ Store index value into array
    ADD R2, #1                              @ Increment index	
	
    B fill_array                            @ Repeat

end_fill_array:

copy_text_init:
    ldr r0, =source_str                     @ R0 = Address of source
    ldr r1, =my_bss    		                @ R1 = Address of reserved .space

copy_text_loop:
    ldrb r2, [r0], #1                       @ Load byte from source, increment pointer
    strb r2, [r1], #1                       @ Store byte in .space, increment pointer
    cmp  r2, #0                             @ Check if we reached the null terminator
    bne  copy_text_loop                     @ If not zero, keep copying
	
copy_text_loop_end:

    MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall

    .end
    