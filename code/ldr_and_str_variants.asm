.section .data

byte_one: 		.byte 	0x12
byte_two: 		.byte 	0x34
byte_three: 	.byte 	0x56
byte_four: 		.byte 	0x78

.align 2

str_1:			.word	0
str_2:			.word	0
str_3:			.word	0

.section .text
.global _start
_start:

	MOV		R0, #0
	MOV		R1, #0
	MOV		R2, #0
	MOV		R3, #0
	MOV		R4, #0

	LDR		R0, =byte_one
	LDR		R1, =str_1
	LDR		R2, =str_2
	LDR		R3, =str_3
	
	LDR		R4, [R0]
	REV		R4, R4
	
	STR		R4, [R1]
	STRB	R4, [R2]
	STRH	R4, [R3]
	
	
end_program:

	MOV R0, #0                          @ exit code 0
    MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall
    
	.end
