BADDR	.req	R0
MAXVAL	.req 	R1
MINVAL	.req	R2
NXTVAL	.req	R3
COUNT	.req	R4
MEMMAX	.req	R5
MEMMIN	.req	R6

.equ	ADDMAX,	0xA0
.equ	ADDMIN,	0xA4

.section .data
list: .word 13, 25, 2, 7, -11, 33, 0


.section .text
.global _start
_start:
	
	LDR		MEMMAX, =ADDMAX
	LDR		MEMMIN, =ADDMIN
	LDR		BADDR, =list
	
	MOV 	MAXVAL, #0x00
	MOV 	MINVAL, #0xFF
	MOV 	NXTVAL, #0x00
	MOV 	COUNT, 	#0x00
	
next:

	LDR		NXTVAL, [BADDR, COUNT, LSL #2]
	CMP 	MAXVAL, NXTVAL
	MOVLT 	MAXVAL, NXTVAL
	
	CMP 	MINVAL, NXTVAL
	MOVGT 	MINVAL, NXTVAL
	
	ADD		COUNT, #1
	CMP		COUNT, #7
	BLT		next
	
end:

	STR MINVAL, [MEMMIN]
	STR MAXVAL, [MEMMAX]
	
	MOV R7, #1                          @ syscall: exit
    SWI 0                               @ make syscall
