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
#include <stdio.h>
#include "alt_types.h"
#include "system.h"
#include <altera_avalon_mailbox.h>

long targetArrayXYMaster[2] = { -52679047, -13416037 };
volatile long *targetArrayXY = targetArrayXYMaster;

extern alt_up_pixel_buffer_dma_dev *myPixelBuffer;

void setup(void) {

	volatile void **buffaddr = (volatile void**) 0x31FD;

	//moving the frame buffer to work with the high resolution
#ifdef MASTER
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	volatile alt_u8 pixel_buffer_memory[2359296];
	alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	alt_up_pixel_buffer_dma_swap_buffers(myPixelBuffer);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(myPixelBuffer)) {
		alt_up_pixel_buffer_dma_change_back_buffer_address(myPixelBuffer, (unsigned int) pixel_buffer_memory);
	}
	*buffaddr = pixel_buffer_memory;
#endif

	barrier(0);

#ifndef MASTER
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");

	myPixelBuffer->back_buffer_start_address = (unsigned int) *buffaddr;
#endif

	PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
}

//makes the color for display
int genColor(int iter) {
	int color = 0;
	if (iter == maxIter) {
		color = grey;
	}
	else {
		int red = iter;
		int green = iter * 6;
		int blue = iter;

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

//this calculates the math to find if a location is in the Mandelbrot set
int mandelbrot(long x0, long y0, long *xOut, long *yOut) {
	int iter = 0;
	//	int cpu = __builtin_rdctl(5);

	long x = 0.0;
	long y = 0.0;
	long xtemp = 0.0;

	long FP2 = 134217728; // 2 in fixed point

	while (((fixedPointMultiply64(x, x) + fixedPointMultiply64(y, y)) <= 268435456) && (iter < maxIter)) {

		/*if (cpu == 3) {
		 startTimer();
		 }//*/

		xtemp = fixedPointMultiply64(x, x) - fixedPointMultiply64(y, y) + x0;
		y = fixedPointMultiply64(fixedPointMultiply64(FP2, x), y) + y0;

		/*
		 if (cpu == 3) {
		 endTimeAndPrint();
		 }//*/

		x = xtemp;
		iter++;

	}
	*xOut = x;
	*yOut = y;

	return iter;
}

void drawFrame(int zoom) {
	int i;
	int j;
	int result = 0;
	int color = 0;
	int cpu = __builtin_rdctl(5);
	int recalculateTargetFlag = 1;

	long x = 0;
	long y = 0;
	long y0 = 0;
	long x0 = 0;

	long minX = 0;
	long maxX = 0;
	long minY = 0;
	long maxY = 0;

	long oneOverRowSize = 87381;
	long oneOverColSize = 65536;
	long rowOverRowSize = 0;
	long colOverColSize = 0;

	if (zoom == 0) {
		minX = FloatToFixed(-2.5);
		maxX = FloatToFixed(1.0);
		minY = FloatToFixed(-1.0);
		maxY = FloatToFixed(1.0);
	}

	else {
		minX = targetArrayXY[0] - FloatToFixed(1.0 / powf(1.5, zoom));
		maxX = targetArrayXY[0] + FloatToFixed(1.0 / powf(1.5, zoom));
		minY = targetArrayXY[1] - FloatToFixed(0.75 / powf(1.5, zoom));
		maxY = targetArrayXY[1] + FloatToFixed(0.75 / powf(1.5, zoom));
	}

	//the loop that goes over the rows
	for (i = cpu; i < rowSize; i = i + NUM_CPUS) {

		//calculating the y0
		rowOverRowSize = fixedPointMultiply32(((rowSize - 1) - i), oneOverRowSize);
		y0 = fixedPointMultiply64(rowOverRowSize, (maxY - minY)) + minY;

		//the loop that goes over the columns
		for (j = 0; j < colSize; j++) {

			//calculating the x0
			colOverColSize = fixedPointMultiply32(j, oneOverColSize);
			x0 = fixedPointMultiply64(colOverColSize, (maxX - minX)) + minX;

			//getting the number of iterations it takes a location to go out of the set
			result = mandelbrot(x0, y0, &x, &y);

			//recalculates the x and y
			if (zoom > 6) {
				if (cpu == 3) {
					printf("iter: %d\n", result);
					if (recalculateTargetFlag) {
						if (result > (maxIter - 5) && (result < maxIter)) {
							if (result < maxIter) {
								targetArrayXYMaster[0] = x;
								targetArrayXYMaster[1] = y;
								recalculateTargetFlag = recalculateTargetFlag - 1;
								printf("zoom level: %d \n", zoom);
								printf("X, Y: %d, %d\n", x, y);
							}
						}
					}
				}
			}

			color = genColor(result);
			alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, j, i);
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
			targetArrayXY = (long *) msg;
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

//starts the performance counter
void startTimer(void) {
	PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
	PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
}

//stops the timer and prints out the number of cycles
void endTimeAndPrint(void) {
	unsigned long long cycles = 0;

	PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
	PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);
	cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);

	printf("Cycles : %llu \n\n", (cycles));
}

long FloatToFixed(float fixMe) {
	return (long) (fixMe * ((float) 134217728));
}

long fixedPointMultiply32(long a, long b) {
	return (long long) a * (long long) b;
}

long fixedPointMultiply64(long a, long b) {

	long long c = (long long) a * (long long) b;

	return c >> 26;
}
