/*
 * hello_world.c
 *
 * Authors: John McCarthy and Silas Rubinson
 * Date: 16 January, 2014
 *
 * Description: TODO fix description
 */

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include <time.h>
#include <stdlib.h>
#include "VideoFunctions.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

int main() {

	//	alt_u32 current_value = 1;
	//	alt_u32 current_state = 3;
	//	alt_u8 current_direction = 0;
	//	alt_u32 keys = 0;
	setUpImage();

	printf("Program running (UART)...\n");
	fprintf(stderr, "Program running (LCD)...\n");

	//the main program loop
	while (1) {
		printCharToScreen(0, 59, "Test 11: Apparently Silas is an old person.");
		displayImage();
		usleep(125000);
		clearScreen();
		constantRotation();
		shrinkAndResize();
	}
	return 0;
}
