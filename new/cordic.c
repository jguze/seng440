/*
SENG 440 - CORDIC Calculator Project
Justin Guze,
Paul Hunter

2014-AUG-01

This code is a portion of a project completed for the
SENG 440 course at the University of Victoria. It is open
source and may be used by any one without license or permission.

The documentation for this code is present in a technical report
created during the project. It is available by email by contacting
the authors.
*/


#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* Our scale factor power */
#define SHIFT 30
/* Our scale Factor  2^ 30 */
#define SHIFT_FLOAT 1073741824.0
#define SHIFT_BASE 1073741824

/* Scale constant that results in rotation mode */
#define SCALE_CONSTANT 1.64676

#define ELEM_SIZE 31
/*
 * The elementary angles for the lookup table. They correspond to
 * arctan(2^-i) and then shifted left by our basein an integer format
 */
int elem_angle[] = {
	843314857 ,
	497837829 ,
	263043837 ,
	133525159 ,

	67021687 ,
	33543516 ,
	16775851 ,
	8388437 ,

	4194283 ,
	2097149 ,
	1048576 ,
	524288 ,

	262144 ,
	131072 ,
	65536 ,
	32768 ,

	16384 ,
	8192 ,
	4096 ,
	2048 ,

	1024 ,
	512 ,
	256 ,
	128 ,

	64 ,
	32 ,
	16 ,
	8 ,

	4 ,
	2 ,
	1 ,
};

/* Cordic vector containing the result vector
	and angle accumulator resulting from the 
	operation */
typedef struct vector3 {
	int x;
	int y;
	int z;
} vector3;

/* Modes of operation of the CORDIC calculator */
typedef enum {ROTATION, VECTOR} cordic_mode_t;

/*
Convert a CORDIC base number to a double
*/
double fixed_to_float(int fixed)
{
	return fixed / SHIFT_FLOAT;
}

/*
Convert a double to a CORDIC base number
*/
int float_to_fixed(double flt)
{
	return (int)(flt * SHIFT_BASE);
}

/*
Normalize a unit vector to our CORDIC base
*/
int normalize(double flt)
{
	//Given the limit of our base choice, we need to normalize 
	//our x and y values for Vectoring mode to be no larger than 
	//the squareroot of 2. 
	//More info available in techincal report.
	return (int)(flt * (SHIFT_BASE * 0.7));
}

/*
 * This is to reduce our amount of code for one more if statement per
 * loop. It checks if (z < 0) and if (y >= 0).
 */
int rot_decision(cordic_mode_t mode, int val)
{

	int result;
	if (val < 0)
	{
		result = 1;
	} else {
		result = 0;
	}

	/* The function will return the result if we are in rotation mode,
	 * and the opposite if we are in vector mode. This is because rotation
	 * mode runs if( z < 0) whereas vector mode runs if (y >= 0)
	 */
	if (mode == ROTATION)
	{
		return result;
	} else {
		return !result;
	}
}


/**
 * Cordic in rotation mode. 
 * x: The x coordinate in the vector.
 * y: The y coordinate in the vector.
 * z: The angle accumulator. Reaches 0 after n iterations
 * 
 * Cordic in vector mode.
 * x: The x coordinate of the vector.
 * y: The y coordinate of the vector. Reaches 0 after n iterations.
 * z: The angle accumulator. Reaches z[0] + arctan(y[0]/x[0]) after n iterations.

 All values should be in CORDIC base and answers will be provided in CORDIC base.
 */ 
vector3 cordic(int x, int y, int z, cordic_mode_t mode)
{
	printf("\n\n");
	int i;
	int x_temp;
	int z_temp = z;
	int * val;

	//DEBUG
	int x_orig = x;
	int y_orig = y;
	int z_orig = z;


	// If the mode is rotation, our check for rotation direction is on the z value, but
	// if it is in vector, it is on the y value.
	if (mode == ROTATION)
	{
		val = &z;
	} else {
		val = &y;
	}
		
	for (i = 0; i < ELEM_SIZE; i++)
	{
		x_temp = x;
		printf("y : %10d\nx : %10d\n\n", y, x);
		if (rot_decision(mode, *val))
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + elem_angle[i]; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - elem_angle[i];
		}
	}
	vector3 result;
	result.x = x;
	result.y = y;
	result.z = z;	

	//DEBUG Check
	if(mode == ROTATION)
	{
		printf("CORDIC Rotation Mode Results:\n");
		printf("  x : %d ?= E%d\n", x, 0);
		printf("  y : %d ?= E%d\n", y, 0);
		printf("  z : %d ?= %d\n", z, 0);	
	}
	else
	{
		printf("CORDIC Rotation Mode Results:\n");
		printf("  x : %d ?= E%d\n", x, 0);
		printf("  y : %d ?= %d\n", y, 0);
		printf("  z : %d ?= E%d\n", z, 0);
	}


	/* 	Before returning the answer we me ensure we scale x and y
		if we used the calcuator in rotation mode. */
	if(mode == ROTATION)
	{
		result.x = (int)(result.x / SCALE_CONSTANT);
		result.y = (int)(result.y / SCALE_CONSTANT);
	}
	return result;
}

//Friendly Method
/*
Calculate cosine of theta and return the value.
Theta should be in the range [-pi/2, pi/2].
*/
double cos_cordic(double theta)
{
	/*
	To calculate cosine we use the calculator in 
	rotation mode using a unit vector on the x axis and
	taking the x component of the result.
	*/
	//Convert input to CORDIC base
	int thetai = float_to_fixed(theta);
	return fixed_to_float(cordic(SHIFT_BASE,0,thetai, ROTATION).x);
}


//Friendly Method
/*
Calculate sine of theta and return the value.
Theta should be in the range [-pi/2, pi/2].
*/
double sin_cordic(double theta)
{
	/*
	To calculate sine we use the calculator in rotation mode
	using a unit vector on the x axis and taking the y component
	of the result.
	*/
	int thetai = float_to_fixed(theta);
	return fixed_to_float(cordic(SHIFT_BASE,0,thetai, ROTATION).y);
}


//Use unit vectors in base 2^0, ie, max -1 to 1
//Do not allow an error of about 0.1, or the result may suck
// ie we can handle 1.0001 , but not 1.01
double atan2_cordic(double y, double x)
{
	//We need to normalize x and y into our base. 
	//given the chose of our base, X and Y cannot exceed 
	//the squareroot of 2 (1.41), so we use the normalize 
	//function
	int xi = normalize(x);
	//printf("atan - x Value: %d\n", xi);
	int yi = normalize(y);
	//printf("atan - y Value: %d\n", yi);
	return fixed_to_float(cordic(xi,yi,0, VECTOR).z);
}

//R may be any double value. we will normalize it.
double atan_cordic(double r)
{
	/* In order to get the correect result we need to convert
	the value coming in to our ownbase. To save time we simply
	use r as the base vector length, rather than additional pi/2
	use in conversion.
	*/
	int yi = normalize(1);
	int xi = normalize(1.0/r);
	return fixed_to_float(cordic(xi,yi,0, VECTOR).z);
}

int main()
{
	//Smoke Test
	double r45 = 45.0*M_PI/180.0;
	double r30 = 30.0*M_PI/180.0;
	double r90 = 90.0*M_PI/180.0;
	printf("Cos(45d): %.15lf ?= %.15lf\n", cos_cordic(r45), cos(r45));
	printf("Cos(30d): %.15lf ?= %.15lf\n", cos_cordic(r30), cos(r30));
	printf("Sin(90d): %.15lf ?= %.15lf\n", sin_cordic(r90), sin(r90));
	printf("Atan2(5,4): %.15lf ?= %.15lf\n", atan2_cordic(1.0, 0.8), atan2(1.0, 0.8));
	printf("Atan(2): %.15lf ?= %.15lf\n", atan_cordic(2.0), atan2(2.0, 1.0));
	return 0;
}
