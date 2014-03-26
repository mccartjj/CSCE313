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
#include <altera_avalon_mailbox.h>

extern FILE *myFile;
extern alt_u8 *myImage;
extern alt_up_pixel_buffer_dma_dev *myPixelBuffer;

void setUpImage(void) {
	//all the set up to use this file

	myFile = fopen("myFileSystem/myfile.dat", "rb");
	if (myFile == NULL) {
		perror("error opening dataFile");
	}
	myImage = (alt_u8 *) malloc(rowSize * colSize * dimension);
	fread(myImage, sizeof(alt_u8), rowSize * colSize * dimension, myFile);
	myPixelBuffer = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	PERF_RESET(PERFORMANCE_COUNTER_0_BASE);

}

void drawPixelFromArray(int col, int row) {
	//draws the pixel to the screen from the array where we have the image

	alt_up_pixel_buffer_dma_draw(myPixelBuffer, (myImage[(col * rsizexdim) + row * 3 + 2]) + (myImage[(col * rsizexdim) + row * 3 + 1] << 8) + (myImage[(col * rsizexdim) + row * 3 + 0] << 16), row,
			col);
}

int getPixelFromArray(int col, int row) {
	return (myImage[(col * rsizexdim) + row * 3 + red]) + (myImage[(col * rsizexdim) + row * 3 + green] << 8) + (myImage[(col * rsizexdim) + row * 3 + blue] << 16);
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

void clearCharBuffer(void) {
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

void printLineToScreen(int row, int col, char *input) {
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

			int intCol = (int) roundf(col);
			int intRow = (int) roundf(row);

			if (rotatedCol > colSize || rotatedCol < 0 || rotatedRow > rowSize || rotatedRow < 0) {
				drawPixel(intCol, intRow, 0);
			}
			else {

				drawPixel(intCol, intRow, bilinearInterpolation(rotatedCol, rotatedRow, col, row));
			}
		}
	}
}

void rotateImageFixedPoint(int direction, float angle) {
	//rotates the image in increments of degrees

	//these are (32,4) fixed point numbers
	alt_32 col = 0;
	alt_32 row = 0;
	alt_32 rotatedCol = 0;
	alt_32 rotatedRow = 0;

	int cpuid = (int) __builtin_rdctl(5);

	//converting the angle to rad
	angle = angle * (PI / 180);

	//calculating the value of the sin and cos
	const float cosineFloat = cosf(angle);
	const float sineFloat = sinf(angle);

	//changing the cos and sin to (32,4) fixed point numbers
	alt_32 cosine = (alt_32) ((cosineFloat) * 16);
	alt_32 sine = (alt_32) ((sineFloat) * 16);

	//correction for the position and making it a (32,4) fixed point number
	const alt_32 centerRow = (rowSize / 2);
	const alt_32 centerCol = (colSize / 2);

	clearScreen();

	//the loop where we recompute where we place the pixels for rotation
	for (col = cpuid; col < (colSize); col += 2) {
		for (row = 0; row < (rowSize); row += 1) {


			//correcting the position to center
			row = row - centerRow;
			col = col - centerCol;

			//calculating the new position of the row and col
			rotatedRow = (row * cosine) + (col * sine);
			rotatedCol = -(row * sine) + (col * cosine);

			//correcting the position to center
			rotatedRow = rotatedRow + (centerRow * 16);
			rotatedCol = rotatedCol + (centerCol * 16);

			row = row + centerRow;
			col = col + centerCol;

			rotatedCol = toInt(rotatedCol);
			rotatedRow = toInt(rotatedRow);

			if (rotatedCol > colSize || rotatedCol < 0 || rotatedRow > rowSize || rotatedRow < 0) {
				drawPixel(col, row, 0);
			}
			else {
				drawPixel(col, row, bilinearInterpolationFP(rotatedCol, rotatedRow, (col * 16), (row * 16)));
			}
		}
	}
}

void constantRotation(void) {
	//Rotates in increments of 10 degrees for a full circle

	printf("Rotation Beginning\n");
	fprintf(stderr, "Rotation Begin. \n");

	printCharToScreen(0, 59, "Rotation");

	int degree = 0;
	double averageCycles = 0.0;
	unsigned long totalCycles = 0;

	for (degree = 0; degree < 360; degree += 10) {

		//begin timing the rotation
		PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
		PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);

		rotateImage(1, degree);

		//end timing the rotation
		PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
		PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);

		//getting the average pixel render time
		unsigned long cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);

		//getting cycles per pixel
		cycles = cycles / (colSize * rowSize);
		totalCycles = totalCycles + cycles;

		//printing average time for pixel render and average time in seconds
		printf("------------------------------------------\n");
		printf("Degrees: %d.\nCycles: %lu \n", degree, cycles);
		fprintf(stderr, "Deg %d Cyc %lu \n", degree, cycles);
		PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
	}
	averageCycles = totalCycles / 36;
	printf("------------------------------------------\n");
	printf("Total Cycles: %lu.\nAverage Cycles: %g\n", totalCycles, averageCycles);
	printf("------------------------------------------\n");
}

void constantRotationFP(void) {
	//Rotates in increments of 10 degrees for a full circle

	int cpuid = (int) __builtin_rdctl(5);

	printf("Rotation Beginning\n");
	fprintf(stderr, "Rotation Begin. \n");

	printCharToScreen(0, 59, "Rotation");

	int degree = 0;
	double averageCycles = 0.0;
	unsigned long totalCycles = 0;

	for (degree = 0; degree < 360; degree += 10) {


		if (cpuid == 1) {
		//begin timing the rotation
		PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
		PERF_BEGIN(PERFORMANCE_COUNTER_0_BASE, 1);
		}

		rotateImageFixedPoint(1, degree);
		barrier(0);


		if (cpuid == 1) {
		//end timing the rotation
		PERF_END(PERFORMANCE_COUNTER_0_BASE, 1);
		PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE);

		//this "synchronizes" the two cpus after computing the image transformation

		//getting the average pixel render time
		unsigned long cycles = perf_get_section_time((void*) PERFORMANCE_COUNTER_0_BASE, 1);

		//turning this time into seconds for John's sanity.
		//double timeSecs = (double)cycles/(double)ALT_CPU_FREQ;
		//totalTime = totalTime + timeSecs;

		//slowed down the rotation for some reason, commented out until we need it
		totalCycles = totalCycles + cycles;

		//printing average time for pixel render and average time in seconds
		printf("------------------------------------------\n");
		printf("Degrees: %d.\nCycles: %lu \n", degree, cycles);
//		fprintf(stderr, "Deg %d Cyc %lu \n", degree, cycles);
		PERF_RESET(PERFORMANCE_COUNTER_0_BASE);
		}
	}
	averageCycles = totalCycles / 36;
	printf("------------------------------------------\n");
	printf("Total Cycles: %lu.\nAverage Cycles: %g\n", totalCycles, averageCycles);
	printf("------------------------------------------\n");
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

alt_32 bilinearInterpolationFP(alt_32 col, alt_32 row, alt_32 changedCol, alt_32 changedRow) {
	//For scale, use col, row, scaledC, scaledR
	//For rotate, the opposite, rotatedC, rotatedR, col, row
	//returns an integer holding the data for the pixel value averaged from the corners of the original

	alt_32 weightrow = 0;
	alt_32 weightcol = 0;
	alt_32 interPRed = 0;
	alt_32 interPGreen = 0;
	alt_32 interPBlue = 0;

	weightrow = changedRow & 0x0000000F;
	weightcol = changedCol & 0x0000000F;

	//	this is a (32,8)
	interPRed = ((16 - weightcol) * (16 - weightrow) * getColorFromArray(col, row, red)) + ((16 - weightcol) * (weightrow) * getColorFromArray((col), (row + 1), red)) + ((weightcol)
			* (16 - weightrow) * getColorFromArray((col + 1), row, red)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), red));

	//	this is a (32,8)
	interPGreen = ((16 - weightcol) * (16 - weightrow) * getColorFromArray(col, row, green)) + ((weightcol) * (16 - weightrow) * getColorFromArray((col + 1), row, green)) + ((16 - weightcol)
			* (weightrow) * getColorFromArray((col), (row + 1), green)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), green));

	//	this is a (32,8)
	interPBlue = (16 - weightcol) * (16 - weightrow) * getColorFromArray(col, row, blue) + ((weightcol) * (16 - weightrow) * getColorFromArray((col + 1), row, blue)) + ((16 - weightcol) * (weightrow)
			* getColorFromArray((col), (row + 1), blue)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), blue));

	return ((toInt8(interPRed)) + (toInt8(interPGreen) << 8) + (toInt8(interPBlue) << 16));
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

	interPRed = ((1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, red)) + ((1 - weightcol) * (weightrow) * getColorFromArray((col), (row + 1), red)) + ((weightcol) * (1 - weightrow)
			* getColorFromArray((col + 1), row, red)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), red));

	interPGreen = ((1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, green)) + ((weightcol) * (1 - weightrow) * getColorFromArray((col + 1), row, green)) + ((1 - weightcol)
			* (weightrow) * getColorFromArray((col), (row + 1), green)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), green));

	interPBlue = (1 - weightcol) * (1 - weightrow) * getColorFromArray(col, row, blue) + ((weightcol) * (1 - weightrow) * getColorFromArray((col + 1), row, blue)) + ((1 - weightcol) * (weightrow)
			* getColorFromArray((col), (row + 1), blue)) + ((weightcol) * (weightrow) * getColorFromArray((col + 1), (row + 1), blue));

	return ((interPRed) + (interPGreen << 8) + (interPBlue << 16));
}

//changes a (32,4) fixed point number to a (32,0) fixed point number
alt_32 toInt(alt_32 fixedPoint) {
	//checking if bit 3 is 1
	if (fixedPoint & 8) {
		//since bit 3 was a 1 we need to round up after shifting right by 4
		fixedPoint = fixedPoint / 16;
		return fixedPoint + 1;
	}

	else {
		//since bit 3 was 0 we only need to shift the number right by 4 to change it to a (32, 0) fixed point
		return fixedPoint / 16;
	}
}

//changes a (32,8) fixed point number to a (32,0) fixed point number
alt_32 toInt8(alt_32 fixedPoint) {
	//checking if bit 8 is 1
	if (fixedPoint & 128) {
		//since bit 8 was a 1 we need to round up after shifting right by 4
		fixedPoint = fixedPoint / 256;
		return fixedPoint + 1;
	}

	else {
		//since bit 8 was 0 we only need to shift the number right by 4 to change it to a (32, 0) fixed point
		return fixedPoint / 256;
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

