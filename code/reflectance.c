#include <code/reflectance.h>
#include "code/systick.h"

uint8_t reflectanceRead(void){

    P7->DIR = 0xFF;
    P7->OUT = 0xFF;
    SysTick_wait(480);
    P7->DIR = 0x00;
    SysTick_wait(48000);

    uint8_t value = P7->IN;

    return value;
}
