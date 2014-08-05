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
//#define SCALE_CONSTANT 1.64676
#define SCALE_CONSTANT 0.60725303

#define ELEM_SIZE 30

/* Cordic vector containing the result vector
	and angle accumulator resulting from the 
	operation */
typedef struct vector2 {
	int x;
	int y;
} vector2;

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
	// 751619277 = SHIFT_BASE * 0.7
	return (int)(flt * (912680550));
}

vector2 cordic_rotation(register int x, register int y, register int z)
{
	register int i;
	register int x_temp;

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
	result.x = x * SCALE_CONSTANT;
	result.y = y * SCALE_CONSTANT;
	return result;
}

int cordic_vector(register int x, register int y, register int z)
{
	register int i;
	register int x_temp;
	register int z_temp = z;

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

	for (i = 0; i < ELEM_SIZE;)
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
		i++;
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

	return z - z_temp;

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
	return fixed_to_float(cordic_rotation(SHIFT_BASE,0,thetai).x);
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
	return fixed_to_float(cordic_rotation(SHIFT_BASE,0,thetai).y);
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
	return fixed_to_float(cordic_vector(xi,yi,0));
}

//R may be any double value. we will normalize it.
double atan_cordic(double r)
{
	/* In order to get the correect result we need to convert
	the value coming in to our ownbase. To save time we simply
	use r as the base vector length, rather than additional pi/2
	use in conversion.
	*/
	int yi = normalize(1.0);
	int xi = normalize(1.0/r);
	return fixed_to_float(cordic_vector(xi,yi,0));
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
