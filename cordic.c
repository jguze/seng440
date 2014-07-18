#include <stdio.h>
#include <stdlib.h>

#define SHIFT 16
#define SHIFT_FLOAT 65536.0
#define SHIFT_BASE 65536

#define SCALE_CONSTANT 1.64676

#define ELEM_SIZE 23
/*
 * The elementary angles for the lookup table. They correspond to
 * arctan(2^-i) and then shifted left by 8 bits in an integer format
 */
int elem_angle[] = {
	2949120,
	1740967,
	919789,
	466945,

	234379,
	117304,
	58666,
	29335,
	
	14668,
	7334,
	3667,
	1833,
	
	917,
	458,
	229,
	115,
	
	57,
	29,
	14,
	7,
	
	4, 
	2,
	1
};

typedef struct vector3 {
	int x;
	int y;
	int z;
} vector3;

typedef enum {ROTATION, VECTOR} cordic_mode_t;

// This does work
double fixed_to_float(int fixed)
{
	return fixed / SHIFT_FLOAT;
}

int float_to_fixed(double flt)
{
	return (int)(flt * SHIFT_BASE);
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
v

r
q
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
		//	printf("Z < 0 TOTALLY TRUE\t\t");
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + elem_angle[i]; 
		} else {
		//	printf("Z < 0 FANTASTICALLY FALSE\t\t");
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - elem_angle[i];
		}
		//printf("X: %f, Y: %f, Z: %f\n", fixed_to_float(x), fixed_to_float(y), fixed_to_float(z));
	}

	 // x = x >> SHIFT;
	 // y = y >> SHIFT;
	 // z = z >> SHIFT;

	//x /= SCALE_CONSTANT;
	//y /= SCALE_CONSTANT;
	//z /= SCALE_CONSTANT;
	//printf("X: %f, Y: %f, Z: %f\n", fixed_to_float(x), fixed_to_float(y), fixed_to_float(z));
	vector3 result;
	result.x = x;
	result.y = y;
	result.z = z;
	return result;
}

//This is returning the incorrect result
double cos_cordic(int theta)
{
	return fixed_to_float(cordic(1,0,theta, ROTATION).x) / SCALE_CONSTANT;
}

double sin_cordic(int theta)
{
	return fixed_to_float(cordic(1,0,theta, ROTATION).y) / SCALE_CONSTANT;
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
	printf("%d bytes to a int\n", sizeof(int));
	printf("%d bytes to a long\n", sizeof(long));
	printf("%d bytes to a long int\n", sizeof(long int));
	printf("%d bytes to a long long\n", sizeof(long long));
	int i;
	for (i = 0; i < ELEM_SIZE; i++)
	{
		printf("i: %d rep %lf\n",i, fixed_to_float(elem_angle[i]));
	}
}

int main()
{
	testing();
	printf("Cos(45): %.15lf\n", cos_cordic(45));
	printf("Cos(30): %.15lf\n", cos_cordic(30));
	printf("Sin(90): %.15lf\n", sin_cordic(90));
	printf("Arctan(5/4): %.15lf\n", arctan_div_cordic(4,5));
	printf("Arctan(2): %.15lf\n", arctan_cordic(2));
	return 0;
}
