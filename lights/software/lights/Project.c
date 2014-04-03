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

	alt_u32 current_value = 1;
	alt_u32 current_state = 0;
	alt_u8 current_direction = 0;
	alt_u32 keys = 0;

	setup();
	printf("Program running (UART)...\n");

	//the main program loop
	while (1) {
		printf("Beginning Frame \n");
		int zoom;
		for (zoom = 1; zoom < 100; zoom++) {
			PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
//			barrier(0);
			drawFrame(zoom);
//			clearScreen();
			PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
			PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			unsigned long cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);
			printf("Cycles: %lu \n", cycles);
		}
	}
	return 0;
}
