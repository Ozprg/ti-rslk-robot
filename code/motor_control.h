/*
 * motor_control.h
 *
 *  Created on: 08.03.2026
 *      Author: ozank
 */

#ifndef CODE_EXC_H_
#define CODE_EXC_H_
#include "msp.h"
#include <stdint.h>

void driveForward(void);
void driveBackward(void);
void driveLeft(void);
void driveRight(void);
void driveStop(void);
void turnRight(void);
void turnLeft(void);

#endif /* CODE_EXC_H_ */
