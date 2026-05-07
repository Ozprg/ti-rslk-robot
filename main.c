#include <code/motor_init.h>
#include <code/motor_control.h>
#include <code/timer_init.h>

#include <code/reflectance.h>
#include <code/systick.h>

#include "code/button_init.h"
#include "code/check_button.h"

#include "code/reflectance_init.h"
#include "code/line_follow.h"

#include "code/bumper_init.h"

#include "code/system_state.h"

#include <stdint.h>
#include "msp.h"
#include "inc/clock.h"

volatile RobotState state = WAIT_FOR_BUTTON;
volatile uint8_t searchSteps = 0;

void main(void)
{
    /* DO NOT CHANGE THIS */
    Clock_Init48MHz();
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;
    /* ----- */
    motor_init();
    timer_init();
    bumper_init();
    reflectance_init();
    button_init();
    __asm("  cpsie i");

    while(1) {
        switch(state) {
        case WAIT_FOR_BUTTON:
            if(buttonPressed()) state = FOLLOW_LINE;
            break;

        case FOLLOW_LINE:
            followLine();
            break;

        case COLLISION_REVERSE:
            searchSteps++;
            driveBackward();
            SysTick_wait(16000000);
            driveStop();
            SysTick_wait(1600000);
            state = COLLISION_TURN;
            break;

        case COLLISION_TURN:
            turnRight();
            SysTick_wait(16000000);
            driveStop();
            SysTick_wait(1600000);
            state = COLLISION_FORWARD;
            break;

        case COLLISION_FORWARD:
            driveForward();
            driveStop();
            SysTick_wait(1600000);
            state = COLLISION_SEARCH;
            break;

        case COLLISION_SEARCH:
            driveLeft();
            SysTick_wait(1600000);
            if(searchSteps > 5 && anyLineDetected()) {
                driveStop();
                SysTick_wait(800000);
                state = COLLISION_ADJUST;
            }
            break;

        case COLLISION_ADJUST:
            driveBackward();
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            turnRight();
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            driveForward();
            SysTick_wait(16000000);
            SysTick_wait(16000000);
            if(anyLineDetected()) {
                driveStop();
                searchSteps = 0;
                state = FOLLOW_LINE;
            }
            break;
        }
    }
}
