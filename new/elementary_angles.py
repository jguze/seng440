

import math

FIXED_SHIFT = 30



def GenAngles():
	elems = []
	for x in range(31):
		elems += [int(round(math.atan2(1,2**x) * math.pow(2, 30)))]
		print "atan(2^-", x, ")= ", round(math.atan2(1, 2**x) * math.pow(2, 30)), " (", math.atan2(1, 2**x) * 180 / math.pi, ",", math.atan2(1, 2**x), ")"

	print "VHDL Lookup Table"
	print "constant ARC_TABLE : ARC_INFO := ("
	for f in elems:
		print "TO_SIGNED(", f, "),"	
	print ");"
	print ""
	print "C Array"
	print "int elem_angles[] = {"
	for e in elems:
		print e, ","

	print "};"





def main():
	GenAngles()




if __name__ == '__main__':
	main()