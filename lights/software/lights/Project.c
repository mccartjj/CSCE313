/*
 * hello_world.c
 *
 * Authors: John McCarthy and Silas Rubinson
 * Date: 16 January, 2014
 *
 * Description: Despite the title of the program, this class takes input from buttons
 * ("keys") and uses that to determine the speed which lights cross an array of LED lights.
 * :)
 */

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include <time.h>
#include <stdlib.h>
#include "LightsFunctions.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

int main() {

	alt_u32 current_value = 1;
	alt_u32 current_state = 3;
	alt_u8 current_direction = 0;
	alt_u32 keys = 0;

	printf("Program running (UART)...\n");
	fprintf(stderr, "Program running (LCD)...\n");
	setUp();
	while (1) {
		//reading the current state of the keys
		keys = IORD_ALTERA_AVALON_PIO_DATA(KEYS_BASE);

		//switching speeds if necessary
		if ((keys != key0) && (keys != current_state)) {

			//switches speed to 250 ms and displays a random number
			if (keys == key3) {
				printf("speed set to 250 ms\n");
				fprintf(stderr, "Speed set 250 ms\n");

			}
			else if (keys == key2) {
				printf("speed set to 150 ms\n");
				fprintf(stderr, "Speed set 150 ms\n");

			}
			else if (keys == key1) {
				printf("speed set to 50 ms\n");
				fprintf(stderr, "Speed set 50 ms\n");

			}
			else
				printf("keys != 3, 5, or 6. Stop hitting multiple buttons.");
			current_state = keys;
		}

		//switches current direction if necessary
		//For current_direction 0 denotes RIGHT, 1 denotes LEFT
		if ((current_direction == 0) && (current_value == (1 << 25)))
			current_direction = 1;
		else if ((current_direction == 1) && (current_value == 1))
			current_direction = 0;
		//moving the light
		else if (current_direction == 0)
			current_value = current_value << 1;
		else
			current_value = current_value >> 1;
		//updating the lights
		IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, current_value);

		//sleep
		if (current_state == key3) {
			printRandom();
			usleep(250000);
		}
		else if (current_state == key2) {
			segmentCircle();
			usleep(125000);
		}
		else {
			segmentCounter();
			usleep(50000);
		}
	}
	return 0;
}
