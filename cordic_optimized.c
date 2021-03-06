#include <stdio.h>
#include <stdlib.h>

#define SHIFT 16
#define SHIFT_FLOAT 65536.0
#define SHIFT_BASE 65536

#define SCALE_CONSTANT 19898 //Inverse of the Scale Constant in fixed point (2^16)
#define SCALE_BASE 15


#define ELEM_SIZE 22 //23 Its actually 23 but we use 22 for the loop condition.


typedef struct vector2 {
	int x;
	int y;
} vector2;

// This does work
double fixed_to_float(int fixed)
{
	return fixed / SHIFT_FLOAT;
}

//FLoat to Fix
int ftfixed(double flt)
{
	return (int)(flt * SHIFT_BASE);
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
vector2 cordic_rotation(register int x, register int y, register int z)
{
	register int i;
	register int x_temp;

	/*
	 * The elementary angles for the lookup table. They correspond to
	 * arctan(2^-i) and then shifted left by 8 bits in an integer format
	 * This is now a local variable lookup table
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
	
	// Loop unrolling x2
	for (i = 0; i != ELEM_SIZE; i++)
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

		i++;
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

	vector2 result;
	result.x = x;
	result.y = y;
	return result;
}

/**
 * Cordic in vector mode. The only difference
 * is the condiition in the middle of the for loop. Need
 * to make everything in fixed point arithmetic.
 * x: The x coordinate of the vector.
 * y: The y coordinate of the vector. Reaches 0 after n iterations.
 * z: The angle accumulator. Reaches z[0] + arctan(y[0]/x[0]) after n iterations.
 */ 
int cordic_vector(register int x, register int y, register int z)
{
	register int i;
	register int x_temp;

	/*
	 * The elementary angles for the lookup table. They correspond to
	 * arctan(2^-i) and then shifted left by 8 bits in an integer format
	 * This is now a local variable lookup table
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

	// Loop unrolling x2
	for (i = 0; i != ELEM_SIZE; i++)
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

		i++;
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
	}

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

	return z;
}

float cos_cordic(float theta)
{
	int i_theta = ftfixed(theta);
	return fixed_to_float((cordic_rotation(SHIFT_BASE,0, i_theta).x * SCALE_CONSTANT) >> SCALE_BASE);
}

float sin_cordic(float theta)
{
	int i_theta = ftfixed(theta);
	return fixed_to_float((cordic_rotation(SHIFT_BASE,0, i_theta).y * SCALE_CONSTANT) >> SCALE_BASE);
}

float arctan_div_cordic(float x, float y)
{
	int i_x = ftfixed(x);
	int i_y = ftfixed(y);
	return fixed_to_float(cordic_vector(i_x,i_y,0));
}

float arctan_cordic(float y)
{
	int i_y = ftfixed(y);
	return fixed_to_float(cordic_vector(SHIFT_BASE,i_y,0));
}

int main()
{
	printf("Cos(1): %.15lf\n", cos_cordic(1.0));
	printf("Cos(20): %.15lf\n", cos_cordic(20.0));
	printf("Cos(45): %.15lf\n", cos_cordic(45.0));
	printf("Cos(30): %.15lf\n", cos_cordic(30.0));
	printf("Sin(90): %.15lf\n", sin_cordic(90.0));
	printf("Arctan(5/4): %.15lf\n", arctan_div_cordic(4.0,5.0));
	printf("Arctan(2): %.15lf\n", arctan_cordic(2.0));
	return 0;
}
