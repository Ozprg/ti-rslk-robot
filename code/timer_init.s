	.text
	.thumb
	.align 2
	.global timer_init

timer_init: .asmfunc

	; Timer_A0 Base adress
    LDR R0, timer_a0_base_adress

    ; TACTL - offset 0x00 - SMCLK, /8, Up-Down, TACLR
    MOV R1, #0x02F0
    STRH R1, [R0, #0x00]

    ; TA0EX0 - offset 0x20 - /1
    MOV R1, #0x0000
    STRH R1, [R0, #0x20]

    ; TA0CCTL3 - offset 0x08 - OUTMOD_2
    MOV R1, #0x0040
    STRH R1, [R0, #0x08]

    ; TA0CCR3 - offset 0x18 - duty cycle 0
    MOV R1, #0x0000
    STRH R1, [R0, #0x18]

    ; TA0CCTL4 - offset 0x0A - OUTMOD_2
    MOV R1, #0x0040
    STRH R1, [R0, #0x0A]

    ; TA0CCR4 - offset 0x1A - duty cycle 0
    MOV R1, #0x0000
    STRH R1, [R0, #0x1A]

    ; TA0CCR0 - offset 0x12
    LDR R1, ccr0_val
    STRH R1, [R0, #0x12]

	bx lr
ccr0_val: .word 15000
timer_a0_base_adress:  .word 0x40000000
	.endasmfunc



