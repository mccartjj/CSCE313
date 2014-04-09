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

	setup();
	printf("Program running (UART)...\n");
	int cpu = __builtin_rdctl(5);
	printf("cpu %d\n", cpu);
	unsigned long long cycles = 0;
	clearScreen();
//	drawFullSet();
	//the main program loop
	while (1) {
		int zoom;
		for (zoom = 1; zoom <= 10; zoom++) {
			PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
			clearScreen();
			drawFrame(zoom);
			barrier(0);
			PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
			PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);
			printf("Zoom level: %i\n", zoom);
			printf("Cycles on frame: %llu \n\n", cycles);
		}
	}
	return 0;
}
