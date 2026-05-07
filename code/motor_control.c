/*
 * motor_control.h
 *
 *  Created on: 08.03.2026
 *      Author: ozank
 */

#include "motor_control.h"

void driveForward(void){
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    TIMER_A0->CCR[3] = 3000;
    TIMER_A0->CCR[4] = 3000;
}
void driveBackward(void){
    P3->OUT |= 0xC0;
    P5->OUT |= 0x30;
    TIMER_A0->CCR[3] = 3000;
    TIMER_A0->CCR[4] = 3000;
}
void driveLeft(void){
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    TIMER_A0->CCR[3] = 5000;
    TIMER_A0->CCR[4] = 2000;
}
void driveRight(void){
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    TIMER_A0->CCR[3] = 3000;
    TIMER_A0->CCR[4] = 5000;
}
void driveStop(void){
    P3->OUT &= ~0xC0;
    TIMER_A0->CCR[3] = 0;
    TIMER_A0->CCR[4] = 0;
}
void turnRight(void){
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    TIMER_A0->CCR[3] = 0;
    TIMER_A0->CCR[4] = 3000;
}
void turnLeft(void){
    P3->OUT |= 0xC0;
    P5->OUT &= ~0x30;
    TIMER_A0->CCR[3] = 3000;
    TIMER_A0->CCR[4] = 0;
}
