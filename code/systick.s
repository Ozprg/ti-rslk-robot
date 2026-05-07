	.text
	.thumb
	.align 2
	.global SysTick_wait

SysTick_wait: .asmfunc
	ldr r1, core_peripherals ; Load Base

	str r0, [r1, #0x14] ; Store Reload Value

	mov r0, #0
	str r0, [r1, #0x18] ; Reset Current Value

	mov r0, #5
	str r0, [r1, #0x10] ; Enable SysTick
wait_var:
	ldr r0, [r1, #0x10] ; Read count flag
	lsr r0, #16
	cmp r0, #1
	bne wait_var ; wait if count flag != 1

	mov r0, #4 ; disable SysTick again
	str r0, [r1, #0x10]
	bx lr

core_peripherals: .int 0xE000E000

	.endasmfunc



