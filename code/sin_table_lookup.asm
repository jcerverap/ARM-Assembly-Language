

.section .data

lookup_angle: .word 1383  @ Angle in degrees to look up sine value: 33 + 180 + 90 + 360 * 3

circle_degrees: .word 360
half_circle_degrees: .word 180
quarter_circle_degrees: .word 90

sin_table:

    .word   0x00000000, 0x3C8EF77F, 0x3D0EF240, 0x3D565E46, 0x3D8EDC3B, 0x3DB27ED8, 0x3DD612C6, 0x3DF99674, 0x3E0E835D
    .word   0x3E20303C, 0x3E31D0C8, 0x3E43636F, 0x3E54E6E2, 0x3E66598E, 0x3E77BA66, 0x3E8483EC, 0x3E8D204A, 0x3E95B1C8
    .word   0x3E9E3779, 0x3EA6B0D9, 0x3EAF1D3E, 0x3EB77C02, 0x3EBFCC7D, 0x3EC80DE4, 0x3ED03FD5, 0x3ED86162, 0x3EE07229
    .word   0x3EE87160, 0x3EF05EA2, 0x3EF83904, 0x3F000000, 0x3F03D987, 0x3F07A8C5, 0x3F0B6D76, 0x3F0F2745, 0x3F12D5E0
    .word   0x3F167913, 0x3F1A108C, 0x3F1D9C06, 0x3F211B1D, 0x3F248DC1, 0x3F27F37B, 0x3F2B4C2B, 0x3F2E976B, 0x3F31D51B
    .word   0x3F3504F6, 0x3F3826AA, 0x3F3B3A04, 0x3F3E3EC0, 0x3F4134AC, 0x3F441B75, 0x3F46F30A, 0x3F49BB16, 0x3F4C7357
    .word   0x3F4F1BBC, 0x3F51B3F2, 0x3F543BD5, 0x3F56B324, 0x3F5919AC, 0x3F5B6F4B, 0x3F5DB3D0, 0x3F5FE718, 0x3F6208E1
    .word   0x3F641908, 0x3F66175D, 0x3F6803CD, 0x3F69DE15, 0x3F6BA637, 0x3F6D5BEE, 0x3F6EFF19, 0x3F708FB8, 0x3F720D88
    .word   0x3F737878, 0x3F74D067, 0x3F761544, 0x3F7746ED, 0x3F786551, 0x3F79704F, 0x3F7A67E8, 0x3F7B4BE8, 0x3F7C1C60
    .word   0x3F7D8234, 0x3F7E177E, 0x3F7E98FE, 0x3F7F06A2, 0x3F7F605A, 0x3F7FA637, 0x3F7FD816, 0x3F800000, 0xFFFFFFFF

.section .text
    .globl _start

_start:

    LDR     R0, =lookup_angle           @ Load address of lookup_angle
    LDR     R0, [R0]                    @ Load angle value into R0

    LDR     R1, =circle_degrees         @ Load address of circle_degrees
    LDR     R1, [R1]                    @ Load circle degrees value into R1

    MOV     R3, #0                      @ Flag to indicate sine sign change, R1 = 0 --> No chage
	MOV		R12, R0						@ Backup the original angle value
	
check_circles:

    CMP     R0, R1                      @ Compare angle with 360
    SUBGE   R0, R0, R1              	@ R0 = angle - 360
    BGE     check_circles           	@ If angle >= 360, repeat

check_half_circle:

    LDR     R1, =half_circle_degrees    @ Load address of half_circle_degrees
    LDR     R1, [R1]                    @ Load half circle degrees value into R1

    CMP     R0, R1                      @ Compare angle with 180
    SUBGE   R0, R0, R1                  @ angle = angle - 180
    MOVGE   R3, #1                      @ Flag to indicate sine sign change: R1 = 1 --> Chage

check_quarter_circle:

    LDR     R1, =quarter_circle_degrees @ Load address of quarter_circle_degrees
    LDR     R1, [R1]                    @ Load quarter circle degrees value into R1
    CMP     R0, R1                      @ Compare angle with 90: sin (x) = sin(x - 90) when x > 90 and x < 180
    SUBGE   R0, R0, R1                  @ If angle < 90, no change; else angle = 90 - angle

lookup_sine:

    LDR     R1, =sin_table @ Load address of sin_table
    LDR     R9, [R1, R0, LSL #2]        @ Load address of sin_table[R0] into R9

	CMP		R3, #1
	NEGEQ	R9, R9
	
end_program:

	MOV		R0, R12
    MOV		R7, #1        @ syscall: exit
    SWI		0
