@ List of multiplication commands
@
@ This file contains the assembly code for multiplication operations.
@
@ MUL r1, r1, r2  ; Multiply r1 by r2 and store the result in r1
@ MULS r1, r1, r2  ; Multiply r1 by r2, store the result in r1, and update condition flags
@ MLA r1, r1, r2, r3  ; Multiply r1 by r2, add r3, and store the result in r1
@ SMULL r4, r5, r1, r2  ; Signed multiply r1 by r2, store lower 32 bits in r4 and upper 32 bits in r5
@ SMULAL r4, r5, r1, r2, r3  ; Signed multiply r1 by r2, add r3, store lower 32 bits in r4 and upper 32 bits in r5
@ USMULL r4, r5, r1, r2  ; Unsigned multiply r1 by r2, store lower 32 bits in r4 and upper 32 bits in r5
@ UMULAL r4, r5, r1, r2, r3  ; Unsigned multiply r1 by r2, add r3, store lower 32 bits in r4 and upper 32 bits in r5
@ LSL r1, r1, #2  ; Logical shift left r1 by 2 bits = multiplying by 4
@ ADD r0, r1, r1 LSL #1  ; r0 = r1 * 3 (r1 shifted left by 1 is r1 * 2, plus r1)
@ RSB r0, r1, #0  ; r0 = -r1 (negation, equivalent to multiplying by -1)
@ RSB r0, r2, r2, LSL #3  ; r0 = r2*7 (r2 shifted left by 3 is r2 * 8, minus r2)

@ End of multiplication commands list

@ Divitions commands
@ UDIV r0, r1, r2  ; Unsigned divide r1 by r2, store result in r0
@ SDIV r0, r1, r2  ; Signed divide r1 by r2, store result in r0
@
@ End of division commands list