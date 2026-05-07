#include "msp.h"
#include "code/system_state.h"

extern volatile RobotState state;

void PORT4_IRQHandler(void) {
    P4->IFG &= ~0xED;
    state = COLLISION_REVERSE;
}
