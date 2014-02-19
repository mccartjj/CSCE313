/*
 * VideoFunctions.c
 *
 *  Created on: Feb 10, 2014
 *      Author: John McCarthy and Silas Rubinson, I suppose.
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

	alt_up_pixel_buffer_dma_draw(myPixelBuffer, (myImage[(col * rowSize * dimension) + row * 3 + 2]) + (myImage[(col * rowSize * dimension) + row * 3 + 1] << 8) + (myImage[(col * rowSize * dimension) + row * 3 + 0] << 16), row, col);
}

int getPixelFromArray(int col, int row) {
	return (myImage[(col * rowSize * dimension) + row * 3 + red]) + (myImage[(col * rowSize * dimension) + row * 3 + green] << 8) + (myImage[(col * rowSize * dimension) + row * 3 + blue] << 16);
}

int getPixelFromDestArray(int col, int row) {
	return (destImage[(col * rowSize * dimension) + row * 3 + red]) + (destImage[(col * rowSize * dimension) + row * 3 + green] << 8) + (destImage[(col * rowSize * dimension) + row * 3 + blue] << 16);
}

int getColorFromArray(int col, int row, int color) {
	return myImage[(col * rowSize * dimension) + row * 3 + color];
}

void drawPixel(int col, int row, int color) {
	//this prints an individual pixel to the specified row and column
	alt_up_pixel_buffer_dma_draw(myPixelBuffer, color, row, col);
}

void clearScreen(void) {
	//clears the part of the screen controlled by the pixel buffer
	alt_up_pixel_buffer_dma_clear_screen(myPixelBuffer, 0);
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

	float col = 0;
	float row = 0;
	float rotatedCol = 0;
	float rotatedRow = 0;

	int interPixel = 0;
	int interPRed = 0;
	int interPBlue = 0;
	int interPGreen = 0;

	//converting the angle to rad
	angle = angle * (PI / 180);

	//calculating the value of the sin and cos
	const float cosine = cosf(angle);
	const float sine = sinf(angle);

	//correction for the position
	const float centerRow = rowSize / 2;
	const float centerCol = colSize / 2;

	clearScreen();

	//the loop where we recompute where we place the pixels for rotation
	for (col = 0; col < colSize; col++) {
		for (row = 0; row < rowSize; row++) {

			//correcting the position to center
			row = row - centerRow;
			col = col - centerCol;

			//calculating the new position of the row and col
			rotatedRow = (row * cosine) - (col * sine);
			rotatedCol = (row * sine) + (col * cosine);

			//correcting the position to center
			rotatedRow = rotatedRow + centerRow;
			rotatedCol = rotatedCol + centerCol;

			row = row + centerRow;
			col = col + centerCol;
			int roundedCol = (int) roundf(rotatedCol);
			int roundedRow = (int) roundf(rotatedRow);
			int intCol = (int) roundf(col);
			int intRow = (int) roundf(row);

			drawPixel((int) roundf(rotatedCol), (int) roundf(rotatedRow), getPixelFromArray(intCol, intRow));
			//putting the source pixel in its new destination
			destImage[(roundedCol * rowSize * dimension) + (roundedRow * dimension) + red] = myImage[(intCol * rowSize * dimension) + intRow * dimension + red];
			destImage[(roundedCol * rowSize * dimension) + (roundedRow * dimension) + green] = myImage[(intCol * rowSize * dimension) + intRow * dimension + green];
			destImage[(roundedCol * rowSize * dimension) + (roundedRow * dimension) + blue] = myImage[(intCol * rowSize * dimension) + intRow * dimension + blue];

		}
	}

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

			//			drawPixel((int) roundf(rotatedCol), (int) roundf(rotatedRow), getPixelFromDestArray((int) roundf(col),(int) roundf(row)));
		}
	}
}

void bilinearInterpolation(void) {

	//	float floorCol = floorf(col);
	//	float floorRow = floorf(row);

	/*Method 1*/
	//			interPixel = (1-(col-floorCol))*(1-(row-floorRow))*getPixelFromArray(floorCol, floorRow)
	//						+((col-floorCol))*(1-(row-floorRow))*getPixelFromArray((floorCol+1), floorRow)
	//						+(1-(col-floorCol))*((row-floorRow))*getPixelFromArray((floorCol), (floorRow+1))
	//						+((col-floorCol))*((row-floorRow))*getPixelFromArray((floorCol+1), (floorRow+1));


	/*Method 2*/

	//
	//			float weightrow = rotatedRow-floorf(rotatedRow);
	//			float weightcol = rotatedCol-floorf(rotatedCol);
	////
	//			interPixel =   ((1.0-weightrow)*(1.0-weightcol)*getPixelFromArray(floorCol, floorRow))
	//			             + ((1.0-weightrow)*(weightcol)*getPixelFromArray((floorCol+1), floorRow))
	//			             + ((weightrow)*(1.0-weightcol)*getPixelFromArray((floorCol), (floorRow+1)))
	//			             + ((weightrow)*(weightcol)*getPixelFromArray((floorCol+1), (floorRow+1)));

	//				/*Method 3*/
	//			float x = col;
	//			float y = row;
	//			float x1 = col - 1;
	//			float x2 = col + 1;
	//			float y1 = row - 1;
	//			float y2 = row + 1;
	//
	//			interPixel = ((((x2-x)*(y2-y))/((x2-x1)*(y2-y1)))*getPixelFromArray(x1,y1))
	//					+ ((((x-x1)*(y2-y))/((x2-x1)*(y2-y1)))*getPixelFromArray(x2,y1))
	//					+ ((((x2-x)*(y-y1))/((x2-x1)*(y2-y1)))*getPixelFromArray(x1,y2))
	//					+ ((((x-x1)*(y-y1))/((x2-x1)*(y2-y1)))*getPixelFromArray(x2,y2));

	/*Method 4*/
	//			interPRed = (1-(col-floorCol))*(1-(row-floorRow))*getColorFromArray(floorCol, floorRow, red)
	//						+((col-floorCol))*(1-(row-floorRow))*getColorFromArray((floorCol+1), floorRow, red)
	//						+(1-(col-floorCol))*((row-floorRow))*getColorFromArray((floorCol), (floorRow+1), red)
	//						+((col-floorCol))*((row-floorRow))*getColorFromArray((floorCol+1), (floorRow+1), red);
	//
	//			interPGreen = (1-(col-floorCol))*(1-(row-floorRow))*getColorFromArray(floorCol, floorRow, green)
	//						+((col-floorCol))*(1-(row-floorRow))*getColorFromArray((floorCol+1), floorRow, green)
	//						+(1-(col-floorCol))*((row-floorRow))*getColorFromArray((floorCol), (floorRow+1), green)
	//						+((col-floorCol))*((row-floorRow))*getColorFromArray((floorCol+1), (floorRow+1), green);
	//
	//			interPBlue = (1-(col-floorCol))*(1-(row-floorRow))*getColorFromArray(floorCol, floorRow, blue)
	//						+((col-floorCol))*(1-(row-floorRow))*getColorFromArray((floorCol+1), floorRow, blue)
	//						+(1-(col-floorCol))*((row-floorRow))*getColorFromArray((floorCol), (floorRow+1), blue)
	//						+((col-floorCol))*((row-floorRow))*getColorFromArray((floorCol+1), (floorRow+1), blue);
	//
	//			interPixel = ((int) roundf(interPRed) << 16) + ((int) roundf(interPGreen) << 8) + interPBlue;

	/*Method 5*/
	//			float weightrow = rotatedRow-floorf(rotatedRow);
	//			float weightcol = rotatedCol-floorf(rotatedCol);
	//
	//			interPRed = (1-weightcol)*(1-weightrow)*getColorFromArray(floorCol, floorRow, red)
	//						+(weightcol)*(1-weightrow)*getColorFromArray((floorCol+1), floorRow, red)
	//						+(1-weightcol)*(weightrow)*getColorFromArray((floorCol), (floorRow+1), red)
	//						+(weightcol)*(weightrow)*getColorFromArray((floorCol+1), (floorRow+1), red);
	//
	//			interPGreen = (1-weightcol)*(1-weightrow)*getColorFromArray(floorCol, floorRow, green)
	//			     		+(weightcol)*(1-weightrow)*getColorFromArray((floorCol+1), floorRow, green)
	//						+(1-weightcol)*(weightrow)*getColorFromArray((floorCol), (floorRow+1), green)
	//						+(weightcol)*(weightrow)*getColorFromArray((floorCol+1), (floorRow+1), green);
	//
	//			interPBlue = (1-weightcol)*(1-weightrow)*getColorFromArray(floorCol, floorRow, blue)
	//						+(weightcol)*(1-weightrow)*getColorFromArray((floorCol+1), floorRow, blue)
	//						+(1-weightcol)*(weightrow)*getColorFromArray((floorCol), (floorRow+1), blue)
	//						+(weightcol)*(weightrow)*getColorFromArray((floorCol+1), (floorRow+1), blue);
	//
	//			interPixel = (interPRed << 16) + (interPGreen << 8) + interPBlue;

	//	drawPixel((int) roundf(rotatedCol), (int) roundf(rotatedRow), interPixel);
}

void constantRotation(void) {
	//Rotates in increments of 10 degrees for a full circle
	printCharToScreen(0, 59, "Rotation");
	int degree = 0;
	for (degree = 10; degree < 360; degree += 10) {
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
			drawPixel((int) roundf(scaledCol), (int) roundf(scaledRow), getPixelFromArray(col, row));

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

