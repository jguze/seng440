#include <stdio.h>
#include <stdlib.h>

#define SHIFT 16
#define SHIFT_MASK ((1 << SHIFT ) - 1)

#define ELEM_SIZE 12
/*
 * The elementary angles for the lookup table. They correspond to
 * arctan(2^-i)
 */
double elem_angle[] = {
	45.00, 26.56, 14.04,
	7.13, 3.58, 1.79,
	0.89, 0.45, 0.22,
	0.11, 0.06, 0.03
};

typedef struct vector3 {
	int x;
	int y;
	int z;
} vector3;

typedef enum {ROTATION, VECTOR} cordic_mode_t;

double fixed_to_float(int fixed)
{
	return ( (double) (fixed & SHIFT_MASK) / (1 << SHIFT) );
}

int float_to_fixed(double flt)
{
	return (int)(flt * 65536);
}

/*
 * This is to reduce our amount of code for one more if statement per
 * loop. It checks if (z < 0) and if (y >= 0). Depending on the mode, it
 * will return
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
 * Cordic in rotation mode. The only difference between this and cordic
 * vector mode is the if condition in the for loop. Look at the slides
 * to better understand the formula. x and y are shifted to the left by
 * 8 to give it better precision, but proper fixed point arithmetic hasn'table
 * been implemented
 * x: The x coordinate in the vector.
 * y: The y coordinate in the vector.
 * z: The angle accumulator. Reaches 0 after n iterations
 * 
 * Cordic in vector mode. The only difference
 * is the condiition in the middle of the for loop. Need
 * to make everything in fixed point arithmetic.
 * x: The x coordinate of the vector.
 * y: The y coordinate of the vector. Reaches 0 after n iterations.
 * z: The angle accumulator. Reaches z[0] + arctan(y[0]/x[0]) after n iterations.
 */ 
vector3 cordic(int x, int y, int z, cordic_mode_t mode)
{
	int i;
	int x_temp;
	int * val;

	// If the mode is rotation, our check for rotation direction is on the z value, but
	// if it is in vector, it is on the y value.
	if (mode == ROTATION)
	{
		val = &z;
	} else {
		val = &y;
	}
	
	x = x << SHIFT;
	y = y << SHIFT;
	z = z << SHIFT;
	
	for (i = 0; i < ELEM_SIZE; i++)
	{
		x_temp = x;
		if (rot_decision(mode, *val))
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + float_to_fixed(elem_angle[i]); // note that the elem_angle lookup table should be in integers rather than converting every time.
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - float_to_fixed(elem_angle[i]);
		}
	}

	vector3 result;
	result.x = x;
	result.y = y;
	result.z = z;
	return result;
}

double cos_cordic(int theta)
{
	return fixed_to_float(cordic(1,0,theta, ROTATION).x);
}

double sin_cordic(int theta)
{
	return fixed_to_float(cordic(1,0,theta, ROTATION).y);
}

double arctan_div_cordic(int x, int y)
{
	return fixed_to_float(cordic(x,y,0, VECTOR).z);
}

double arctan_cordic(int x)
{
	return fixed_to_float(cordic(1,x,0, VECTOR).z);
}

void testing()
{
	int i;
	for (i = 0; i < ELEM_SIZE; i++)
	{
		printf("i: %d rep %d",i, float_to_fixed(elem_angle[i]));
	}
}

int main()
{
	//testing();
	printf("Cos(45): %f\n", cos_cordic(45));
	printf("Sin(90): %f\n", sin_cordic(90));
	printf("Arctan(5/4): %f\n", arctan_div_cordic(4,5));
	printf("Arctan(2): %f\n", arctan_cordic(2));
	return 0;
}