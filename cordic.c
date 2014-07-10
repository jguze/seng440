#include <stdio.h>
#include <stdlib.h>

typedef struct vector3 {
	int x;
	int y;
	double z;
} vector3;

typedef enum {ROTATION, VECTOR} cordic_mode_t;

double elem_angle[] = {
	45.00, 26.56, 14.04,
	7.13, 3.58, 1.79,
	0.89, 0.45, 0.22,
	0.11, 0.06, 0.03
};
int elem_size = 12;

void iter_shift(int *x, int *y, int iteration)
{
	int i;
	for (i = iteration; i != 0; i--)
	{
		*x = *x >> 1;
		*y = *y >> 1;
	}
}

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
 *
 *
 */ 
vector3 cordic_rotation(int x, int y, double z)
{
	int i;
	int x_shift;
	int y_shift;

	x = x << 8;
	y = y << 8;
	
	for (i = 0; i < elem_size; i++)
	{
		x_shift = x;
		y_shift = y;
		iter_shift(&x_shift, &y_shift, i);
		if (z < 0)
		{
			x = x + y_shift;
			y = y - x_shift;
			z = z + elem_angle[i]; 
		} else {
			x = x - y_shift;
			y = y + x_shift;
			z = z - elem_angle[i];
		}
	}

	x = x >> 8;
	y = y >> 8;

	vector3 result;
	result.x = x;
	result.y = y;
	result.z = z;
	return result;
}

// y should somehow go to 0
vector3 cordic_vector(int x, int y, double z)
{
	int i;
	int x_shift;
	int y_shift;
	
	x = x << 8;
	y = y << 8;

	for (i = 0; i < elem_size; i++)
	{
		x_shift = x;
		y_shift = y;
		iter_shift(&x_shift, &y_shift, i);
		if (y < 0)
		{
			x = x - y_shift;
			y = y + x_shift;
			z = z - elem_angle[i]; 
		} else {
			x = x + y_shift;
			y = y - x_shift;
			z = z + elem_angle[i];
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