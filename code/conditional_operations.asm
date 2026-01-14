@ This program counts the occurrences of the characters 'W' and 'Z' in a predefined array of characters.

.section .text

.global _start
_start:
	
	LDR R4, =chars
	MOV R0, #0
	
search:

	LDR		R1, [R4], #4
	TEQ		R1, #'\0'
	BEQ		end_program
	
	TEQ 	R1, #'W'
	TEQNE	R1, #'Z'
	ADDEQ	R0, #1
	B		search
	
end_program:

    @ R0 contains the count of 'W' and 'Z' characters, the characters after the end flag '\0' are ignored.

    MOV R7, #1
    SWI 0  

.section .data

chars: .word 'z', 'w', 'Z', 'W', 'a', 'Z', '\0', 'W'
