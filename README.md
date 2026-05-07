# TI-RSLK Line-Following Robot

## Overview

An autonomous line-following robot built on the **TI-RSLK (Texas Instruments Robotics System Learning Kit)** platform using the **MSP432P401R** microcontroller. The robot follows a black line on a white surface using reflectance sensors and is capable of detecting and navigating around obstacles using bumper sensors.

## Hardware

| Pin | Function |
|-----|----------|
| P2.6 | PWM Right Motor (TA0CCP3) |
| P2.7 | PWM Left Motor (TA0CCP4) |
| P3.6 | Right Motor Enable (nSLPR) |
| P3.7 | Left Motor Enable (nSLPL) |
| P5.4 | Left Motor Direction (DIR_L) |
| P5.5 | Right Motor Direction (DIR_R) |
| P1.4 | Start Button S2 |
| P4.0/2/3/5/6/7 | Bumper Sensors (mask 0xED) |
| P7.0–P7.7 | Reflectance Sensors 1–8 |
| P5.3 | Reflectance Even LED |
| P9.2 | Reflectance Odd LED |

## Software Architecture

### Peripheral Initialization (ARM Thumb2 Assembly)
All peripheral initialization is implemented in Assembly as required:

- `motor_init.s` — GPIO init for motor direction and enable pins (P2, P3, P5)
- `timer_init.s` — Timer_A0 PWM configuration (SMCLK/8, Up-Down mode, CCR0=15000)
- `bumper_init.s` — Bumper GPIO init with falling-edge interrupts and NVIC configuration
- `button_init.s` — Button S2 input with pull-up resistor
- `reflectance_init.s` — Reflectance sensor and LED GPIO init
- `systick.s` — SysTick-based blocking delay function

### Application Logic (C)
- `motor_control.c` — Drive functions (forward, backward, left, right, stop, turn)
- `reflectance.c` — RC discharge-based reflectance sensor reading
- `line_follow.c` — Proportional error-based line following and line detection
- `bumper.c` — Bumper interrupt handler (`PORT4_IRQHandler`)
- `check_button.c` — Button S2 polling
- `main.c` — State machine main loop

## State Machine

```
WAIT_FOR_BUTTON
      │ (S2 pressed)
      ▼
FOLLOW_LINE ◄────────────────────────────────────────┐
      │ (bumper triggered)                            │
      ▼                                               │
COLLISION_REVERSE → COLLISION_TURN → COLLISION_FORWARD → COLLISION_SEARCH → COLLISION_ADJUST
                                                                                     │
                                                                         (line detected)
```

| State | Behavior |
|-------|----------|
| `WAIT_FOR_BUTTON` | Wait for S2 press to start |
| `FOLLOW_LINE` | Proportional line following using 8 reflectance sensors |
| `COLLISION_REVERSE` | Drive backward ~1s, increment bump counter |
| `COLLISION_TURN` | Turn right to navigate around obstacle |
| `COLLISION_FORWARD` | Drive forward to clear the obstacle |
| `COLLISION_SEARCH` | Arc left, search for line after sufficient bumps (>5) |
| `COLLISION_ADJUST` | Drive backward, turn right to re-align with line |

## Timer_A0 Configuration

| Parameter | Value |
|-----------|-------|
| Clock | SMCLK = 12MHz |
| Prescaler | /8 |
| Mode | Up-Down |
| CCR0 (Period) | 15000 |
| PWM Frequency | ~50Hz |
| CCR3 | Right motor duty cycle |
| CCR4 | Left motor duty cycle |

**Duty cycle formula:** `CCR / CCR0`  
**Forward speed:** CCR = 3000 (~20%)

## Line Following Algorithm

Proportional controller using weighted sensor error:

```c
if (data & 0x80) error -= 4;  // Sensor 1 (rightmost)
if (data & 0x40) error -= 3;
if (data & 0x20) error -= 2;
if (data & 0x10) error -= 1;
if (data & 0x08) error += 1;
if (data & 0x04) error += 2;
if (data & 0x02) error += 3;
if (data & 0x01) error += 4;  // Sensor 8 (leftmost)

CCR[3] = 3000 - (error * 350);  // Right motor
CCR[4] = 3000 + (error * 350);  // Left motor
```

## Build & Flash

Project is developed in **Code Composer Studio (CCS)** targeting the MSP432P401R.

1. Clone/open the project in CCS
2. Build the project (`Project → Build All`)
3. Connect the TI-RSLK via USB
4. Flash (`Run → Debug`)
5. Place robot on the track, press **S2** to start

## Dependencies

- TI MSP432 DriverLib
- `inc/clock.h` — `Clock_Init48MHz()` from TI-RSLK library

