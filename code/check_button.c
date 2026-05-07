#include "msp.h"

uint8_t buttonPressed(void) {
    return !(P1->IN & 0x10);
}
