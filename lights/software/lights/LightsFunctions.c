/*
 * LightsFunctions.c
 *
 *  Created on: Jan 23, 2014
 *      Author: John McCarthy and Silas Rubinson
 */

#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include "LightsFunctions.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

//array of digits on a seven segment display from 0 to 9
alt_u8 sevenSegmentDisplay[11] = { 64, 121, 36, 48, 25, 18, 2, 120, 0, 16, blank };
alt_u32 currentSegCount = 0;
alt_u8 circleCounter = 0;

void setUp(void) {
	//setting up the seed for the random number generator
	srand(time(NULL));
}

void hexOutputGeneric(int location, int value) {
	switch (location) {
		case 0:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX0_BASE, value);
			break;
		case 1:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX1_BASE, value);
			break;
		case 2:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX2_BASE, value);
			break;
		case 3:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX3_BASE, value);
			break;
		case 4:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX4_BASE, value);
			break;
		case 5:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX5_BASE, value);
			break;
		case 6:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX6_BASE, value);
			break;
		case 7:
			IOWR_ALTERA_AVALON_PIO_DATA(HEX7_BASE, value);
			break;
	}
}

void hexOutputNumber(int location, int value) {
	hexOutputGeneric(location, sevenSegmentDisplay[value]);
}

void hexOutputBlank(int location) {
	hexOutputNumber(location, 10);
}

void hexBlankAll(void){
	int i = 0;
	while(i < 8){
		hexOutputBlank(i);
		i++;
	}
}

void printRandom(void) {
	int rngNum = 0;
	int i = 0;
	while (i < 8) {
		rngNum = rand() % 10;
		hexOutputNumber(i, rngNum);
		i++;
	}
}

void segmentCircle(void) {
	alt_u8 location[20] = { 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 6, 5, 4,
			3, 2, 1 };
	alt_u8 value[20] = { segTop, segTopR, segLowR, segLow, segLow, segLow,
			segLow, segLow, segLow, segLow, segLow, segLowL, segTopL, segTop,
			segTop, segTop, segTop, segTop, segTop, segTop };
	hexBlankAll();
	hexOutputGeneric(location[circleCounter], value[circleCounter]);
	circleCounter++;
	if(circleCounter > 19){
		circleCounter = 0;
	}

}

void segmentCounter(void) {
	//resets counter when it reaches 99,999,999
	if (currentSegCount >= 100000000) {
		currentSegCount = 0;
	}
	//displaying the current count.
	int i = 0;
	int displayNumber = 0;
	int temp = currentSegCount;
	while (i < 8) {
		//grabs the last digit
		displayNumber = temp % 10;
		//displays the digit on the appropriate seven segment display
		hexOutputNumber(i, displayNumber);
		//shifts to the next digit.
		temp = temp / 10;
		i++;
	}
	currentSegCount++;
}
