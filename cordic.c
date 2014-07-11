#include <stdio.h>
#include <stdlib.h>

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
	double z;
} vector3;

typedef enum {ROTATION, VECTOR} cordic_mode_t;

/*
 * This was supposed to return the appropriate true or false
 * value depending on the mode, but I couldn't get
 * this working.
 */
int rot_decision(cordic_mode_t mode, void * val)
{
	int result;
	int value = *((int*) val);
	printf("VALUE %d\n", value);
	if (value < 0)
	{
		result = 1;
	} else {
		result = 0;
	}

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
 */ 
vector3 cordic_rotation(int x, int y, double z)
{
	int i;
	int x_temp;
	
	for (i = 0; i < ELEM_SIZE; i++)
	{
		x_temp = x;
		if (z < 0)
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
	return result;
}

/* Much like cordic_rotation mode. The only difference
 * is the condiition in the middle of the for loop. Need
 * to make everything in fixed point arithmetic.
 * x: The x coordinate of the vector.
 * y: The y coordinate of the vector. Reaches 0 after n iterations.
 * z: The angle accumulator. Reaches z[0] + arctan(y[0]/x[0]) after n iterations.
 */
vector3 cordic_vector(int x, int y, double z)
{
	int i;
	int x_temp;
	
	x = x << 16;
	y = y << 16;

	for (i = 0; i < ELEM_SIZE; i++)
	{
		x_temp = x;
		if (y >= 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + elem_angle[i]; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - elem_angle[i];
		}
		printf("i: %d z: %f\n", i,z);
	}
	vector3 result;
	result.x = x;
	result.y = y;
	result.z = z;
	return result;
}

vector3 cordic(int x, int y, double z, cordic_mode_t mode)
{
	vector3 result;
	if (mode == ROTATION)
	{
		result = cordic_rotation(x,y,z);
	} else if (mode == VECTOR)
	{
		result = cordic_vector(x,y,z);
	}

	return result;
}

int cos_cordic(double theta)
{
	return cordic(1,0,theta, ROTATION).x;
}

int sin_cordic(double theta)
{
	return cordic(1,0,theta, ROTATION).y;
}

double arctan_div_cordic(int x, int y)
{
	return cordic(x,y,0, VECTOR).z;
}

double arctan_cordic(int x)
{
	return cordic(1,x,0, VECTOR).z;
}

int main()
{
	printf("Cos(45): %d\n", cos_cordic(45));
	printf("Sin(90): %d\n", sin_cordic(90));
	printf("Arctan(5/4): %f\n", arctan_div_cordic(4,5));
	printf("Arctan(2): %f\n", arctan_cordic(2));
	return 0;
}