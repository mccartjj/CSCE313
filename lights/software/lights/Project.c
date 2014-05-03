/*
 * Project.c
 *
 * Authors: John McCarthy and Silas Rubinson
 * Date: 6 February, 2014
 *
 * Description: TODO fix description
 */

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include <time.h>
#include <stdlib.h>
#include "Fractal.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include <altera_avalon_performance_counter.h>
#include <altera_avalon_mailbox.h>

#define key3 3
#define key2 5
#define key1 6
#define key0 7

#define FIXED_POINT

int main() {

	barrier(0);
	setup();

	printf("Program running (UART)...\n");

	//how to reset the interrupt vector
	//the following will show you the number to put in SOPC video DMA controller
	//reset address: 0090FFE4
	//default buffer start address: 0x01880000
	printf("ADDRESS: %08X \n", myPixelBuffer->back_buffer_start_address);
	int cpu = __builtin_rdctl(5);
	printf("cpu %d \n", cpu);

	//unsigned long long cycles = 0;
	//the main program loop
	while (1) {

		int zoom;
		for (zoom = 0; zoom <= 100; zoom++) {

			printf("zoom: %d\n", zoom);

			//startTimer();
			clearScreen();

			drawFrame(zoom);

			//printf("before barrier %d \n", zoom);
			barrier(0);
			//printf("after barrier %d \n", zoom);

			//endTimeAndPrint();
		}
	}
	return 0;
}
