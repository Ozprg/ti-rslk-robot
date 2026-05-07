	.text
	.thumb
	.align 2
	.global reflectance_init

reflectance_init: .asmfunc

	LDR R0, gpio_base

	; P5DIR = 1
	LDRB R1, [R0, #0x044]
    ORR R1, R1, #0x08
    STRB R1, [R0, #0x044]

	; P5OUT = 1
	LDRB R1, [R0, #0x042]
	ORR R1, R1, #0x08
	STRB R1, [R0, #0x042]

	; P7DIR = 1
	LDRB R1, [R0, #0x064]
    ORR R1, R1, #0x0FF
    STRB R1, [R0, #0x064]

    ; P9DIR = 1
	LDRB R1, [R0, #0x084]
    ORR R1, R1, #0x04
    STRB R1, [R0, #0x084]

	; P9OUT = 1
	LDRB R1, [R0, #0x082]
	ORR R1, R1, #0x04
	STRB R1, [R0, #0x082]

    BX LR

gpio_base: .word 0x40004C00

	.endasmfunc
