	.text
    .thumb
    .align 2
    .global button_init

button_init: .asmfunc
    LDR R0, gpio_base

    ; P1DIR = 0 (input)
    LDRB R1, [R0, #0x004]
    BIC R1, R1, #0x10
    STRB R1, [R0, #0x004]

    ; P1REN = 1 (pull resistor)
    LDRB R1, [R0, #0x006]
    ORR R1, R1, #0x10
    STRB R1, [R0, #0x006]

    ; P1OUT = 1 (pull-up)
    LDRB R1, [R0, #0x002]
    ORR R1, R1, #0x10
    STRB R1, [R0, #0x002]

    BX LR

gpio_base: .word 0x40004C00
    .endasmfunc





