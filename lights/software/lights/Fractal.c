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

float targetX = -0.227;
float targetY = 0.700;

extern alt_up_pixel_buffer_dma_dev *myPixelBuffer;

void setup(void) {
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
}

int genColor(int iter) {
	int color = 0;
	if (iter == maxIter) {
		color = black;
	}
	else {
		int red = iter * 2;
		int green = iter * 8;
		int blue = iter * 3;
		if (red > 255)
			red = 255;
		if (green > 255)
			green = 255;
		if (blue > 255)
			blue = 255;
		color = (red << 16) + (green << 8) + (blue);
	}
	return color;
}

int mandelbrot(int cRow, int cCol, float x0, float y0) {
	int iter = 0;
	int cpu = __builtin_rdctl(5);

	float x = 0.0;
	float y = 0.0;
	float xtemp = 0.0;

	unsigned long long cycles = 0;

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

	return iter;
}

/*
int mandelbrotNoZoom(int cRow, int cCol) {
	int iter = 0;
	float minX = -2.5;
	float maxX = 1;
	float minY = -1;
	float maxY = 1;

	float x0 = (((float) cCol / (float) 320) * (maxX - minX)) + minX;
	float y0 = ((((float) 239 - (float) cRow) / (float) 240) * (maxY - minY)) + minY;
	float x = 0.0;
	float y = 0.0;
	float xtemp = 0.0;

	while (((x * x + y * y) <= 4.0) && (iter < maxIter)) {
		xtemp = x * x - y * y + x0;
		y = 2 * x * y + y0;
		x = xtemp;
		iter++;
	}
	return iter;
}//*/

/*
void drawFullSet(void) {
	int i;
	int j;
	int result = 0;
	int color = 0;
	int cpu = __builtin_rdctl(5);

	for (i = cpu; i < rowSize; i = i + NUM_CPUS) {
		for (j = 0; j < colSize; j++) {
			result = mandelbrotNoZoom(j, i);
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

	float minX = /*-2.5;//*/targetX - (1 / powf(1.5, zoom));
	float maxX = /*1;//*/targetX + (1 / powf(1.5, zoom));
	float minY = /*-1;//*/targetY - (0.75 / powf(1.5, zoom));
	float maxY = /*1;//*/targetY + (0.75 / powf(1.5, zoom));

	for (i = cpu; i < colSize; i = i + NUM_CPUS) {
		float y0 = ((((float) 239 - (float) i) / (float) 240) * (maxY - minY)) + minY;
		for (j = 0; j < rowSize; j++) {
			float x0 = (((float) j / (float) 320) * (maxX - minX)) + minX;

			result = mandelbrot(j, i, x0, y0);
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

	for (i = 0; i < NUM_CPUS; i++) {
		if (i != cpu) {
			altera_avalon_mailbox_post(mb[i], barrierNum);
		}
	}

	for (i = 0; i < NUM_CPUS - 1; i++) {
		do {
			msg = altera_avalon_mailbox_pend(mb[cpu]);
		}
		while (msg != barrierNum);
	}

	for (i = 0; i < NUM_CPUS; i++) {
		altera_avalon_mailbox_close(mb[i]);
	}
}

void clearScreen(void) {
	//clears the part of the screen controlled by the pixel buffer
	alt_up_pixel_buffer_dma_clear_screen(myPixelBuffer, 0);
}
