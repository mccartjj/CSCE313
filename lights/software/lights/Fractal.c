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

float targetX = 0.037500;
float targetY = -0.156250;
float zoomFactor = 1;

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
		//		iter = iter + 12 / 2;
		int red = iter * 2;//(int)round(overIter*iter*0.3);
		int green = iter * 8;//(int)round(overIter*iter*0.5);
		int blue = iter * 3;//(int)round(overIter*iter);
		color = (red << 16) + (green << 8) + (blue);
	}
	return color;
}

int mandelbrot(int cRow, int cCol) {
	int iter = 0;

	float minX = targetX - (1 / powf(1.5, zoomFactor));
	float maxX = targetX + (1 / powf(1.5, zoomFactor));
	float minY = targetY - (0.75 / powf(1.5, zoomFactor));
	float maxY = targetY + (0.75 / powf(1.5, zoomFactor));

	float y0 = (((float) cCol / (float) 320) * (maxY - minY)) + minY;//*/ -2.5+0.008333333*col;
	float x0 = ((((float) 239 - (float) cRow) / (float) 240) * (maxX - minX)) + minX;//*/-1+0.0109375*row;
	float x = 0.0;
	float y = 0.0;
	float xtemp = 0.0;

	while (((x * x + y * y) <= 4.0) && (iter < maxIter)) {
		xtemp = x * x - y * y + x0;
		y = 2 * x * y + y0;
		x = xtemp;
		iter++;
		//		printf("%i ", iter);
	}
	return iter;
}

void drawFrame(int zoom) {
	int i;
	int j;
	int result = 0;
	int color = 0;
	int cpu = __builtin_rdctl(5);
	zoomFactor = zoom;
	for (i = cpu; i < rowSize; i = i + NUM_CPUS) {
		for (j = 0; j < colSize; j++) {
			result = mandelbrot(i, j);
			color = genColor(result);
			drawPixel(color, i, j);
		}
	}
}

void drawPixel(int color, int row, int col) {
	alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, row, col);
}

void barrier(alt_u8 barrierNum) {
	alt_u32 msg;
	alt_mailbox_dev *mb[NUM_CPUS];
	char mb_name[80];
	int cpu = __builtin_rdctl(5);
	int i = 0;

	for (i = 0; i < NUM_CPUS; i++) {
		//		sprintf(mb_name, "/dev/mailbox_%d", i);
		mb[i] = altera_avalon_mailbox_open(mb_name);
	}

	for (i = 0; i < NUM_CPUS; i++) {
		if (i != cpu) {
			altera_avalon_mailbox_post(mb[i], barrierNum);
			//			printf("cpu %0d post msg \n", cpu);
		}
	}

	for (i = 0; i < NUM_CPUS - 1; i++) {
		do {
			msg = altera_avalon_mailbox_pend(mb[cpu]);
		}
		while (msg != barrierNum);
		//		printf("cpu %0d recv msg \n", cpu);
	}

	for (i = 0; i < NUM_CPUS; i++) {
		altera_avalon_mailbox_close(mb[i]);
	}
}

void clearScreen(void) {
	//clears the part of the screen controlled by the pixel buffer
	alt_up_pixel_buffer_dma_clear_screen(myPixelBuffer, 0);
}
