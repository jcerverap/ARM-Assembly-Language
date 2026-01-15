@ this program enables a data bus, a port and switches the leds on an stm32f4xx
@ 1st .- Enables the port (D)
@ 2nd .- Sets the port pins as output
@ 3rd .- Switches the leds on (pin 12, 13, 14, 15)
 
    .equ    ONESEC, 5333333     @ Number of loops for 1 second delay (approx)
    .equ    HALFSEC, 2666666     @ Number of loops for 0.5 second delay (approx)
    .equ    FIFTSEC, 1066666     @ Number of loops for 0.2 second delay (approx)

@    .equ    AHB1PERIPH_BASE, PERIPH_BASE + 0x000
    .equ    RCC_AHB1ENR, 0x40023830                     @ RCC AHB1 peripheral clock enable register
    .equ    GPIOD_BASE, 0x40020C00                      @ GPIOD mode register base address
    .equ    GPIOD_MODER, GPIOD_BASE                     @ GPIOD mode register (same as base)
    .equ    GPIOD_ODR, GPIOD_BASE + 0x14                @ GPIOD output data register offset

    .equ    GPIOD_EN, (1 << 3)      @ GPIOD enable bit

    .equ    GPIOD_MODER_PIN12_OUTPUT, (0x01 << 12 * 2)  @ Set pin 12 to output mode
    .equ    GPIOD_MODER_PIN13_OUTPUT, (0x01 << 13 * 2)  @ Set pin 13 to output mode
    .equ    GPIOD_MODER_PIN14_OUTPUT, (0x01 << 14 * 2)  @ Set pin 14 to output mode
    .equ    GPIOD_MODER_PIN15_OUTPUT, (0x01 << 15 * 2)  @ Set pin 15 to output mode   

    .equ    LED_PIN_12, (1 << 12)                         @ Pin number where the LED is connected
    .equ    LED_PIN_13, (1 << 13)                         @ Pin number where the LED is connected
    .equ    LED_PIN_14, (1 << 14)                         @ Pin number where the LED is connected
    .equ    LED_PIN_15, (1 << 15)                         @ Pin number where the LED is connected

    .section .data

 .section .text
 .global _start

_start:

@ 1st Step: Enable the GPIOD port clock

    LDR R0, =RCC_AHB1ENR                                @ Load address of AHB1 peripheral clock enable register
    LDR R1, [R0]                                        @ Read current value of the register
    ORR R1, R1, #GPIOD_EN                               @ Set GPIOD enable bit
    STR R1, [R0]                                        @ Write back to the register to enable GPIOD clock

@ 2nd Step: Set GPIOD pins 12, 13, 14, 15 as output

    LDR R0, =GPIOD_MODER                                @ Load address of GPIOD mode register
    LDR R1, [R0]                                        @ Read current mode register value
    ORR R1, R1, #GPIOD_MODER_PIN12_OUTPUT              @ Set LED pin 12 to output mode
    ORR R1, R1, #GPIOD_MODER_PIN13_OUTPUT              @ Set LED pin 13 to output mode
    ORR R1, R1, #GPIOD_MODER_PIN14_OUTPUT              @ Set LED pin 14 to output mode
    ORR R1, R1, #GPIOD_MODER_PIN15_OUTPUT              @ Set LED pin 15 to output mode
    STR R1, [R0]                                        @ Write back to mode register

@ 3rd Step: Switch the LEDs on

blink:

    LDR R0, =GPIOD_ODR                                 @ Load base address of GPIOD
    LDR R1, [R0]                                        @ Read current output data register
    MOV R2, R1                                          @ Copy current value to R2

loop:

@ Switches on each LED with delay of 0.2 seconds between them, then delays 0.5 seconds

    ORR R1, R1, #(LED_PIN_12) @ Load LED pin 12
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    ORR R1, R1, #(LED_PIN_13) @ Load LED pin 13
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    ORR R1, R1, #(LED_PIN_14) @ Load LED pin 14
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    ORR R1, R1, #(LED_PIN_15) @ Load LED pin 15
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =HALFSEC                                    @ Load delay count
    BL delay                                            @ Call delay


@ Switches off each LED with delay of 0.2 seconds between them, then delays 1 second

    BIC R1, R1, #(LED_PIN_12) @ Load LED pin 12
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    BIC R1, R1, #(LED_PIN_13) @ Load LED pin 13
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    BIC R1, R1, #(LED_PIN_14) @ Load LED pin 14
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =FIFTSEC                                    @ Load delay count
    BL delay                                            @ Call delay

    BIC R1, R1, #(LED_PIN_15) @ Load LED pin 15
    STR R1, [R0]                                 @ Set the pins high to turn on LEDs
    LDR R4, =ONESEC                                    @ Load delay count
    BL delay                                            @ Call delay

@ Starts loop again
    B   loop                                               @ Repeat the loop

delay:
    SUB R4, R4, #1                                     @ Decrement delay count
    CMP R4, #0                                         @ Compare with zero
    BNE delay                                     @ Branch if not equal to zero
    BX LR                                              @ Return from function
