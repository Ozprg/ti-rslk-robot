	.text
    .thumb
    .align 2
    .global bumper_init

bumper_init: .asmfunc
    PUSH {LR}

    LDR R0, gpio_base

    ; P4DIR = 0 (input) for bump pins
    LDRB R1, [R0, #0x025]
    BIC R1, R1, #0xED
    STRB R1, [R0, #0x025]

    ; P4REN = 1 (enable pull resistor)
    LDRB R1, [R0, #0x027]
    ORR R1, R1, #0xED
    STRB R1, [R0, #0x027]

    ; P4OUT = 1 (pull-up)
    LDRB R1, [R0, #0x023]
    ORR R1, R1, #0xED
    STRB R1, [R0, #0x023]

    ; P4IES = 1 (falling edge trigger)
    LDRB R1, [R0, #0x039]
    ORR R1, R1, #0xED
    STRB R1, [R0, #0x039]

    ; P4IFG = 0 (clear flags)
    LDRB R1, [R0, #0x03D]
    BIC R1, R1, #0xED
    STRB R1, [R0, #0x03D]

    ; P4IE = 1 (enable interrupt)
    LDRB R1, [R0, #0x03B]
    ORR R1, R1, #0xED
    STRB R1, [R0, #0x03B]

    LDR R0, iser_base
	LDR R1, [R0, #4]
	ORR R1, R1, #0x40
	STR R1, [R0, #4]

    POP {LR}
    BX LR

gpio_base: .word 0x40004C00
iser_base: .word 0xE000E100

    .endasmfunc



