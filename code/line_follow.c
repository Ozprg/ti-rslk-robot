#include "msp.h"
#include "reflectance.h"
#include "line_follow.h"

void followLine(void) {
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    uint8_t data = reflectanceRead();
    int8_t error = 0;
    if (data & 0x80) error -= 4;
    if (data & 0x40) error -= 3;
    if (data & 0x20) error -= 2;
    if (data & 0x10) error -= 1;
    if (data & 0x08) error += 1;
    if (data & 0x04) error += 2;
    if (data & 0x02) error += 3;
    if (data & 0x01) error += 4;
    TIMER_A0->CCR[3] = 3000 - (error * 350);
    TIMER_A0->CCR[4] = 3000 + (error * 350);
}

uint8_t lineDetectedRight(void) {
    uint8_t data = reflectanceRead();
    return (data & 0x80) != 0;
}

uint8_t anyLineDetected(void) {
    uint8_t data = reflectanceRead();
    return data != 0;
}
/*uint8_t lineCentered(void) {
    uint8_t data = reflectanceRead();
    return (data & 0x3C) != 0;
}*/
