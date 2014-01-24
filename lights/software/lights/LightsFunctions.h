/*
 * LightsFunctions.h
 *
 *  Created on: Jan 23, 2014
 *      Author: Silas Rubinson, who decided this was necessary
 *      		and John McCarthy, who reluctantly agreed.
 */

#ifndef LIGHTSFUNCTIONS_H_
#define LIGHTSFUNCTIONS_H_

	//if you can't figure out what this does, stop talking to me.
	void setUp(void);
	//accepts location from 0 to 7, accepts value from 0 to 127, displays value at loc
	void hexOutputGeneric(int location, int value);
	//accepts from 0 to 7 for location and 0 to 9 for value, displays value at loc
	void hexOutputNumber(int location, int value);
	//accepts 0 to 7, displays location as blank
	void hexOutputBlank(int location);
	//clears all sevenSegDisplays
	void hexBlankAll(void);
	//sets each sevenSegDisplay to a random number
	void printRandom(void);
	//TODO
	void segmentCircle(void);
	//TODO
	void segmentCounter(void);

#define blank 127
#define key3 3
#define key2 5
#define key1 6
#define key0 7

//Individual Locations on sevenSegDisplay
#define segTop  126
#define segTopL 95
#define segTopR 125
#define segMid  63
#define segLow  119
#define segLowL 111
#define segLowR 123

#endif /* LIGHTSANDOTHERFUNCTION_H_ */
