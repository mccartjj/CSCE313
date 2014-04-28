/*
 * Fractal.c
 *
 *  Created on: Mar 31, 2014
 *      Author: Silas Rubinson
 */

#include "Fractal.h"
#include <altera_up_avalon_video_pixel_buffer_dma.h> //to swap front and back buffer
#include <altera_avalon_performance_counter.h>
#include <math.h>
#include <stdlib.h>
#include "alt_types.h"
#include "system.h"
#include <altera_avalon_mailbox.h>

float targetArrayXYMaster[2] = { 0.0, 0.0 };
volatile float *targetArrayXY = targetArrayXYMaster;

extern alt_up_pixel_buffer_dma_dev *myPixelBuffer;

void setup(void) {
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
#ifdef MASTER
	volatile alt_u8 pixel_buffer_memory[2359296];
	alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	alt_up_pixel_buffer_dma_swap_buffers(myPixelBuffer);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(myPixelBuffer)) {
		alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	}
#endif

}

int genColor(int iter) {
	int color = 0;
	if (iter == maxIter) {
		color = black;
	}
	else {
		int red = iter;
		int green = iter * 8;
		int blue = iter * 2;

		//saturating the colors
		if (red > 31)
			red = 31;
		if (green > 63)
			green = 63;
		if (blue > 31)
			blue = 31;

		//making the final color
		color = ((red << 11) & 0xF800) | ((green << 5) & 0x07E0) | (blue & 0x00FF);
	}
	return color;
}

int mandelbrot(float x0, float y0, float *xOut, float *yOut) {
	int iter = 0;
	//	int cpu = __builtin_rdctl(5);
	//	unsigned long long cycles = 0;

	float x = 0.0;
	float y = 0.0;
	float xtemp = 0.0;

	while (((x * x + y * y) <= 4.0) && (iter < maxIter)) {

		/*
		 if (cpu == 3) {
		 PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
		 PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
		 PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
		 }//*/

		xtemp = x * x - y * y + x0;
		y = 2 * x * y + y0;

		/*
		 if (cpu == 3) {
		 PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
		 PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
		 cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);

		 printf("iter number: %i\n", iter);
		 printf("Cycles on frame: %llu \n\n", (cycles));
		 }//*/

		x = xtemp;
		iter++;

	}
	*xOut = x;
	*yOut = y;

	return iter;
}

int mandelbrotNoZoom(int cRow, int cCol, int *recalculateTargetFlag) {
	int iter = 0;
	float minX = -2.5;
	float maxX = 1;
	float minY = -1;
	float maxY = 1;

	float x0 = (((float) cCol / (float) colSize) * (maxX - minX)) + minX;
	float y0 = ((((float) 767 - (float) cRow) / (float) rowSize) * (maxY - minY)) + minY;
	float x = 0.0;
	float y = 0.0;
	float xtemp = 0.0;

	while (((x * x + y * y) <= 4.0) && (iter < maxIter)) {
		xtemp = x * x - y * y + x0;
		y = 2 * x * y + y0;
		x = xtemp;
		iter++;
	}
	int cpu = __builtin_rdctl(5);
	if (cpu == 3) {
		if (*recalculateTargetFlag) {
			if (iter >= (maxIter - 2)) {
				targetArrayXYMaster[0] = x;
				targetArrayXYMaster[1] = y;
				*recalculateTargetFlag = *recalculateTargetFlag - 1;
			}
		}
	}
	return iter;
}//*/


void drawFullSet(void) {
	int i;
	int j;
	int result = 0;
	int color = 0;
	int cpu = __builtin_rdctl(5);

	int recalculateTargetFlag = 10;

	for (i = cpu; i < colSize; i = i + NUM_CPUS) {
		for (j = 0; j < rowSize; j++) {
			result = mandelbrotNoZoom(j, i, &recalculateTargetFlag);
			color = genColor(result);
			alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, i, j);
		}
	}
}//*/

void drawFrame(int zoom) {
	int i;
	int j;
	int result = 0;
	int color = 0;
	int cpu = __builtin_rdctl(5);
	int recalculateTargetFlag = 20;
	float x = 0.0;
	float y = 0.0;

	float minX = targetArrayXY[0] - (1 / powf(1.5, zoom));
	float maxX = targetArrayXY[0] + (1 / powf(1.5, zoom));
	float minY = targetArrayXY[1] - (0.75 / powf(1.5, zoom));
	float maxY = targetArrayXY[1] + (0.75 / powf(1.5, zoom));

	for (i = cpu; i < colSize; i = i + NUM_CPUS) {
		float y0 = ((((float) 767 - (float) i) / (float) 768) * (maxY - minY)) + minY;
		for (j = 0; j < rowSize; j++) {
			float x0 = (((float) j / (float) 1024) * (maxX - minX)) + minX;

			result = mandelbrot(x0, y0, &x, &y);

			//recalculates the x and y
			if (cpu == 3) {
				if (recalculateTargetFlag) {
					if (result > (maxIter - 2)) {
						targetArrayXYMaster[0] = x;
						targetArrayXYMaster[1] = y;
						recalculateTargetFlag = recalculateTargetFlag - 1;
					}
				}
			}

			color = genColor(result);
			alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, i, j);
		}
	}

}

void barrier(alt_u8 barrierNum) {
	alt_u32 msg;
	alt_mailbox_dev *mb[NUM_CPUS];
	char mb_name[80];
	int cpu = __builtin_rdctl(5);
	int i = 0;

	for (i = 0; i < NUM_CPUS; i++) {
		sprintf(mb_name, "/dev/mailbox_%d", i);
		mb[i] = altera_avalon_mailbox_open(mb_name);
	}
	//sending the messages to the other CPU's
	for (i = 0; i < NUM_CPUS; i++) {
		if (i != cpu) {

			if (cpu == 3) {
				altera_avalon_mailbox_post(mb[i], (int) targetArrayXYMaster);
			}
			else {
				altera_avalon_mailbox_post(mb[i], 0);
			}
		}
	}

	//gets the messages from the other CPU's
	for (i = 0; i < NUM_CPUS - 1; i++) {

		msg = altera_avalon_mailbox_pend(mb[cpu]);

		if (msg != 0) {
			targetArrayXY = (float *) msg;
		}
	}
	for (i = 0; i < NUM_CPUS; i++) {
		altera_avalon_mailbox_close(mb[i]);
	}
}

void clearScreen(void) {
	//clears the part of the screen controlled by the pixel buffer
	alt_up_pixel_buffer_dma_clear_screen(myPixelBuffer, 0);
}
