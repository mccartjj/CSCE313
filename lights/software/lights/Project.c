/*
 * Project.c
 *
 * Authors: John McCarthy and Silas Rubinson
 * Date: 6 February, 2014
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
			clearCharBuffer();
			printLineToScreen(0, 0, "John McCarthy and Silas Rubinson, Lab 2.");
			printLineToScreen(0, 1, "Key 3: View Original Image.");
			printLineToScreen(0, 2, "Key 2: Rotate 360.");
			printLineToScreen(0, 3, "Key 1: Shrink and Expand.");
			printLineToScreen(0, 4, "Key 0: Reset.");
			printLineToScreen(0, 5, "Due to the nature of the board, the keys will be ignored until after");
			printLineToScreen(0, 6, "each process is completed. Please be patient.");

			printLineToScreen(0, 10, "                           _______________________________");
			printLineToScreen(0, 11, "                           |                             |");
			printLineToScreen(0, 12, "                           |_____________________________|");
			printLineToScreen(0, 13, "                           \\                             /");
			printLineToScreen(0, 14, "                            \\                           /");
			printLineToScreen(0, 15, "                             \\                         /");
			printLineToScreen(0, 16, "                              \\                       /");
			printLineToScreen(0, 17, "                               \\                     /");
			printLineToScreen(0, 18, "                                \\                   /");
			printLineToScreen(0, 19, "                                 \\                 /");
			printLineToScreen(0, 20, "                                  \\               /");
			printLineToScreen(0, 21, "                                   \\             /");
			printLineToScreen(0, 22, "                                    \\           /");

		}
	}
	return 0;
}
