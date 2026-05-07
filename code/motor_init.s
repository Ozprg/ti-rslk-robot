	.text
	.thumb
	.align 2
	.global motor_init

motor_init: .asmfunc
    PUSH {LR}

    LDR R0, gpio_base_adress

    ; P2DIR = 1
    LDRB R1, [R0, #0x005]
    ORR R1, R1, #0xC0
    STRB R1, [R0, #0x005]

    ; P2SEL0 = 1
    LDRB R1, [R0, #0x00B]
    ORR R1, R1, #0xC0
    STRB R1, [R0, #0x00B]

    ; P2SEL1 = 0
    LDRB R1, [R0, #0x00D]
    BIC R1, R1, #0xC0
    STRB R1, [R0, #0x00D]

    ; P3DIR = 1
    LDRB R1, [R0, #0x024]
    ORR R1, R1, #0xC0
    STRB R1, [R0, #0x024]

    ; P3OUT = 0
    LDRB R1, [R0, #0x022]
    BIC R1, R1, #0xC0
    STRB R1, [R0, #0x022]

    ; P5DIR = 1
    LDRB R1, [R0, #0x044]
    ORR R1, R1, #0x30
    STRB R1, [R0, #0x044]

    POP {LR}


    BX LR

gpio_base_adress: .word 0x40004C00

	.endasmfunc



