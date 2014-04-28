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
#ifdef MASTER
	//	volatile alt_u8 pixel_buffer_memory[2359296];
	//	alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	//	alt_up_pixel_buffer_dma_swap_buffers(myPixelBuffer);
	//	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(myPixelBuffer)) {
	//		alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	//	}
#endif
	//	barrier(0);


	printf("Program running (UART)...\n");
	//reset address: 0090FFE4
	//default buffer start address: 0x01880000
	printf("ADDRESS: %08X \n", myPixelBuffer->back_buffer_start_address);
	int cpu = __builtin_rdctl(5);
	printf("cpu %d \n", cpu);

	//	unsigned long long cycles = 0;
	//the main program loop
	while (1) {

		printf("entering the main loop \n");

		int zoom;
		for (zoom = 0; zoom <= 100; zoom++) {

			/*
			 PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
			 PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			 PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
			 //*/
			clearScreen();

			if (zoom == 0) {
				drawFullSet();
			}

			else {
				drawFrame(zoom);
			}

			printf("before barrier %d \n", zoom);
			barrier(0);
			printf("after barrier %d \n", zoom);
			/*
			 PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
			 PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
			 cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);
			 printf("Zoom level: %i\n", zoom);
			 printf("Cycles on frame: %llu \n\n", cycles);
			 //*/
		}
	}
	return 0;
}
