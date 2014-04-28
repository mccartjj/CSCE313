/*
 * Fractal.h
 *
 *  Created on: Mar 31, 2014
 *      Author: mccartjj
 */

#include <altera_up_avalon_video_pixel_buffer_dma.h> //to swap front and back buffer
#include <altera_avalon_performance_counter.h>
#include <math.h>
#include <stdlib.h>
#include "alt_types.h"
#include "system.h"
#include <altera_avalon_mailbox.h>

#ifndef FRACTAL_H_
#define FRACTAL_H_

//generation functions
void setup(void);

//fractal generation
int genColor(int iter);
int mandelbrot(float x0,float y0,float *xOut,float *yOut);
int mandelbrotNoZoom(int cRow, int cCol, int *recalculateTargetFlag);

//drawing functions
void drawFrame(int zoom);
void drawFullSet(void);
void drawPixel(int color, int row, int col);
void barrier(alt_u8 barrierNum);
void clearScreen(void);

//universal stuff
alt_up_pixel_buffer_dma_dev *myPixelBuffer;

//useful
#define rowSize 768
#define colSize 1024
#define maxIter 100
#define NUM_CPUS 4

//colors
#define white 0xFFFFFF
#define black 0x000000

#endif /* FRACTAL_H_ */
