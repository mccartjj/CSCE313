/*
 * VideoFunctions.c
 *
 *  Created on: Feb 10, 2014
 *      Author: John McCarthy and Silas Rubinson.
 *
 */

#include <altera_up_avalon_video_character_buffer_with_dma.h> //to write chars to video
#include <altera_up_avalon_video_pixel_buffer_dma.h> //to swap front and back buffer
#include <math.h>
#include <stdlib.h>
#include "VideoFunctions.h"
#include "alt_types.h"
#include "system.h"

extern FILE *myFile;
extern alt_u8 *myImage;
extern alt_u8 *destImage;
extern alt_up_pixel_buffer_dma_dev *myPixelBuffer;

void setUpImage(void) {
	//all the set up to use this file

	myFile = fopen("myFileSystem/myfile.dat", "rb");
	if (myFile == NULL) {
		perror("error opening dataFile");
	}
	myImage = (alt_u8 *) malloc(rowSize * colSize * dimension);
	destImage = (alt_u8 *) malloc(rowSize * colSize * dimension);
	fread(myImage, sizeof(alt_u8), rowSize * colSize * dimension, myFile);
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
}

void drawPixelFromArray(int col, int row) {
	//draws the pixel to the screen from the array where we have the image

	alt_up_pixel_buffer_dma_draw(myPixelBuffer, (myImage[(col * rsizexdim) + row * 3 + 2]) + (myImage[(col * rsizexdim) + row * 3 + 1] << 8) + (myImage[(col * rsizexdim) + row * 3 + 0] << 16), row,
			col);
}

int getPixelFromArray(int col, int row) {
	return (myImage[(col * rsizexdim) + row * 3 + red]) + (myImage[(col * rsizexdim) + row * 3 + green] << 8) + (myImage[(col * rsizexdim) + row * 3 + blue] << 16);
}

int getPixelFromDestArray(int col, int row) {
	return (destImage[(col * rsizexdim) + row * 3 + red]) + (destImage[(col * rsizexdim) + row * 3 + green] << 8) + (destImage[(col * rsizexdim) + row * 3 + blue] << 16);
}

int getColorFromArray(int col, int row, int color) {
	return myImage[(col * rsizexdim) + row * 3 + color];
}

void drawPixel(int col, int row, int color) {
	//this prints an individual pixel to the specified row and column
	alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, row, col);
}

void clearScreen(void) {
	//clears the part of the screen controlled by the pixel buffer
	alt_up_pixel_buffer_dma_clear_screen(myPixelBuffer, 0);
}

void clearCharBuffer(void){
	alt_up_char_buffer_dev *myCharBuffer;
	myCharBuffer = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
	alt_up_char_buffer_clear(myCharBuffer);
}

void printCharToScreen(int row, int col, char *input) {
	//clears the character buffer before replacing it. also leads to flashy lights.

	alt_up_char_buffer_dev *myCharBuffer;
	myCharBuffer = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
	if (!myCharBuffer) {
		printf("error opening character buffer \n");
	}
	alt_up_char_buffer_clear(myCharBuffer);
	alt_up_char_buffer_string(myCharBuffer, input, row, col);
}

void printLineToScreen(int row, int col, char *input){
		alt_up_char_buffer_dev *myCharBuffer;
		myCharBuffer = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
		if (!myCharBuffer) {
			printf("error opening character buffer \n");
		}
		alt_up_char_buffer_string(myCharBuffer, input, row, col);
}

void displayImage(void) {
	//	displays the image loaded into the array myImage

	clearScreen();
	int i = 0;
	int j = 0;

	//the loop that goes gets all the indexes of the array where we have the image
	for (i = 0; i < colSize; i++) {
		for (j = 0; j < rowSize; j++) {
			drawPixelFromArray(i, j);
		}
	}
}

void rotateImage(float direction, float angle) {
	//rotates the image in increments of degrees

	float col = 0.0;
	float row = 0.0;
	float rotatedCol = 0.0;
	float rotatedRow = 0.0;


	//converting the angle to rad
	angle = angle * (PI / 180);

	//calculating the value of the sin and cos
	const float cosine = cosf(angle);
	const float sine = sinf(angle);

	//correction for the position
	const float centerRow = rowSize / 2;
	const float centerCol = colSize / 2;

	clearScreen();
	memset(destImage, 0x0, 320 * 240 * 3);

	//the loop where we recompute where we place the pixels for rotation
	for (col = 0; col < colSize; col++) {
		for (row = 0; row < rowSize; row++) {

			//correcting the position to center
			row = row - centerRow;
			col = col - centerCol;

			//calculating the new position of the row and col
			rotatedRow = (row * cosine) + (col * sine);
			rotatedCol = -(row * sine) + (col * cosine);

			//correcting the position to center
			rotatedRow = rotatedRow + centerRow;
			rotatedCol = rotatedCol + centerCol;

			row = row + centerRow;
			col = col + centerCol;

			int roundedCol = (int) roundf(rotatedCol);
			int roundedRow = (int) roundf(rotatedRow);
			int intCol = (int) roundf(col);
			int intRow = (int) roundf(row);

			if (rotatedCol > colSize || rotatedCol < 0 || rotatedRow > rowSize || rotatedRow < 0) {
				drawPixel((int) roundf(col), (int) roundf(row), 0);
			}
			else {
				int destCalc = (intCol * rsizexdim) + intRow * dimension;
				int myImageCalc = (roundedCol * rsizexdim) + (roundedRow * dimension);

				destImage[destCalc + red] = myImage[myImageCalc + red];
				destImage[destCalc + green] = myImage[myImageCalc + green];
				destImage[destCalc + blue] = myImage[myImageCalc + blue];

//				drawPixel((int) roundf(col), (int) roundf(row), getPixelFromDestArray(col, row));
				drawPixel((int) roundf(col), (int) roundf(row), bilinearInterpolation(rotatedCol, rotatedRow, col, row));
			}
		}
	}
}

void constantRotation(void) {
	//Rotates in increments of 10 degrees for a full circle
	printCharToScreen(0, 59, "Rotation");
	int degree = 0;
	for (degree = 0; degree < 360; degree += 10) {
		rotateImage(1, degree);
	}
}

void scaleImage(float scalingFactor) {
	//scales the image by the percentage given
	int col = 0;
	int row = 0;
	float scaledCol = 0;
	float scaledRow = 0;

	//correction for the position
	const float centerRow = rowSize / 2;
	const float centerCol = colSize / 2;

	clearScreen();

	//the loop where we recompute where we place the pixels for scaling
	for (col = 0; col < colSize; col++) {
		for (row = 0; row < rowSize; row++) {

			row = row - centerRow;
			col = col - centerCol;

			//calculating the new position of the row and col
			scaledRow = row * scalingFactor;
			scaledCol = col * scalingFactor;

			scaledRow = scaledRow + centerRow;
			scaledCol = scaledCol + centerCol;

			row = row + centerRow;
			col = col + centerCol;

			//displaying the scaled image
			drawPixel((int) roundf(scaledCol), (int) roundf(scaledRow), bilinearInterpolation(col, row, scaledCol, scaledRow));
		}
	}
}

void shrinkAndResize(void) {
	//This shrinks and expands images by increments of 10%
	float i = 0;
	printCharToScreen(0, 59, "Shrink/Expand");
	for (i = 1; i > 0.1; i = i - 0.1) {
		scaleImage(i);
	}
	for (i = 0.1; i <= 1; i = i + 0.1) {
		scaleImage(i);
	}
}

int bilinearInterpolation(float col, float row, float changedCol, float changedRow) {
	//For scale, use col, row, scaledC, scaledR
	//For rotate, the opposite, rotatedC, rotatedR, col, row
	//returns an integer holding the data for the pixel value averaged from the corners of the original

	float weightrow = 0.0;
	float weightcol = 0.0;
	int interPRed = 0;
	int interPGreen = 0;
	int interPBlue = 0;

	weightrow = changedRow - floorf(changedRow);
	weightcol = changedCol - floorf(changedCol);

	interPRed = ((1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, red))
			+ ((1 - weightcol) * (weightrow) * getColorFromArray((col), (row + 1), red))
			+ ((weightcol) * (1	- weightrow) * getColorFromArray((col + 1), row, red))
			+ ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), red));

	interPGreen = ((1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, green))
			+ ((weightcol) * (1 - weightrow) * getColorFromArray((col + 1), row, green))
			+ ((1 - weightcol) * (weightrow) * getColorFromArray((col), (row + 1), green))
			+ ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), green));

	interPBlue = (1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, blue)
			+ ((weightcol) * (1 - weightrow) * getColorFromArray((col + 1), row, blue))
			+ ((1 - weightcol) * (weightrow) * getColorFromArray((col), (row + 1), blue))
			+ ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), blue));

	return ((interPRed) + (interPGreen << 8) + (interPBlue << 16));
}
