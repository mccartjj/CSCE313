/*
 * VideoFunctions.h
 *
 *  Created on: Feb 6, 2014
 *      Author: John McCarthy and Silas Rubinson, if he feels like it.
 */

#ifndef VIDEOFUNCTIONS_H_
#define VIDEOFUNCTIONS_H_

#include "system.h"
#include "alt_types.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include <stdio.h>
#include <altera_avalon_performance_counter.h>

	void drawPixelFromArray(int col, int row);
	int getPixelFromArray(int col, int row);
	void drawPixel(int col, int row, int color);
	void setUpImage(void);
	void rotateImage(float direction, float angle);
	void rotateImageFixedPoint(int direction, float angle);
	void constantRotation(void);
	void scaleImage(float scalingFactor);
	void shrinkAndResize(void);
	//clears the character buffer before replacing it. also leads to flashy lights.
	void printCharToScreen(int row, int col, char *input);
	void clearScreen(void);

	//displays the image in myImage array
	void displayImage(void);
	int bilinearInterpolation(float col, float row, float changedCol, float changedRow);

	//changes a (32,4) fixed point number to a (32,0) fixed point number
	int toInt(int fixedPoint);

	//240
#define colSize 240

	//320
#define rowSize 320

	//3
#define dimension 3

#define rsizexdim 960
	//0
#define red 2

	//1
#define green 1

	//2
#define blue 0
#define PI 3.14159265

	FILE *myFile;

	//the array holding the image in the flash
	alt_u8 *myImage;

	alt_u8 *destImage;

	//the pixel buffer
	alt_up_pixel_buffer_dma_dev *myPixelBuffer;


#endif /* VIDEOFUNCTIONS_H_ */
