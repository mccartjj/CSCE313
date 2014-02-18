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

#define key3 3
#define key2 5
#define key1 6
#define key0 7

int main() {

	alt_u32 current_value = 1;
	alt_u32 current_state = 0;
	alt_u8 current_direction = 0;
	alt_u32 keys = 0;
	setUpImage();

	printf("Program running (UART)...\n");
	fprintf(stderr, "Program running (LCD)...\n");

	//the main program loop
	while (1) {
		keys = IORD_ALTERA_AVALON_PIO_DATA(KEYS_BASE);

		//switching speeds if necessary
		if ((keys != key0) && (keys != current_state)) {
			current_state = keys;
		}

		if (current_state == key3) {
			printCharToScreen(0, 59, "Original Image");
			displayImage();
		}
		else if (current_state == key2) {
			constantRotation();
		}
		else if (current_state == key1){
			shrinkAndResize();
		}
		else {
			clearScreen();
			printCharToScreen(5, 0, "John McCarthy and Silas Rubinson, Lab 2. Testing AA. Attempt 1.");
		}
	}
	return 0;
}
