	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"cordic.c"
	.global	elem_angle
	.data
	.align	2
	.type	elem_angle, %object
	.size	elem_angle, 92
elem_angle:
	.word	2949120
	.word	1740967
	.word	919789
	.word	466945
	.word	234379
	.word	117304
	.word	58666
	.word	29335
	.word	14668
	.word	7334
	.word	3667
	.word	1833
	.word	917
	.word	458
	.word	229
	.word	115
	.word	57
	.word	29
	.word	14
	.word	7
	.word	4
	.word	2
	.word	1
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.text
	.align	2
	.global	fixed_to_float
	.type	fixed_to_float, %function
fixed_to_float:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #12
	str	r0, [fp, #-24]
	ldr	r0, [fp, #-24]
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r5, #0
	mov	r6, #1073741824
	add	r6, r6, #15728640
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
	.size	fixed_to_float, .-fixed_to_float
	.global	__aeabi_dmul
	.global	__aeabi_d2iz
	.align	2
	.global	float_to_fixed
	.type	float_to_fixed, %function
float_to_fixed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #12
	str	r0, [fp, #-28]
	str	r1, [fp, #-24]
	sub	r4, fp, #28
	ldmia	r4, {r3-r4}
	mov	r5, #0
	mov	r6, #1073741824
	add	r6, r6, #15728640
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_dmul
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2iz
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
	.size	float_to_fixed, .-float_to_fixed
	.align	2
	.global	rot_decision
	.type	rot_decision, %function
rot_decision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bge	.L6
	mov	r3, #1
	str	r3, [fp, #-8]
	b	.L7
.L6:
	mov	r3, #0
	str	r3, [fp, #-8]
.L7:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L8
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-24]
	b	.L9
.L8:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	movne	r3, #0
	moveq	r3, #1
	str	r3, [fp, #-24]
.L9:
	ldr	r3, [fp, #-24]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	rot_decision, .-rot_decision
	.align	2
	.global	cordic
	.type	cordic, %function
cordic:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40
	str	r0, [fp, #-44]
	str	r1, [fp, #-32]
	str	r2, [fp, #-36]
	str	r3, [fp, #-40]
	ldr	r3, [fp, #4]
	cmp	r3, #0
	bne	.L12
	sub	r3, fp, #40
	str	r3, [fp, #-8]
	b	.L13
.L12:
	sub	r3, fp, #36
	str	r3, [fp, #-8]
.L13:
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #16
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-36]
	mov	r3, r3, asl #16
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #16
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L14
.L17:
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	ldr	r0, [fp, #4]
	mov	r1, r3
	bl	rot_decision
	mov	r3, r0
	cmp	r3, #0
	beq	.L15
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-16]
	mov	r2, r2, asr r3
	ldr	r3, [fp, #-32]
	add	r3, r3, r2
	str	r3, [fp, #-32]
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	mov	r3, r2, asr r3
	rsb	r3, r3, r1
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-16]
	ldr	r3, .L19
	ldr	r2, [r3, r2, asl #2]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-40]
	b	.L16
.L15:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-16]
	mov	r2, r2, asr r3
	ldr	r3, [fp, #-32]
	rsb	r3, r2, r3
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	mov	r2, r2, asr r3
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r1, [fp, #-40]
	ldr	r2, [fp, #-16]
	ldr	r3, .L19
	ldr	r3, [r3, r2, asl #2]
	rsb	r3, r3, r1
	str	r3, [fp, #-40]
.L16:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L14:
	ldr	r3, [fp, #-16]
	cmp	r3, #22
	ble	.L17
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-20]
	ldr	ip, [fp, #-44]
	sub	r3, fp, #28
	ldmia	r3, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldr	r0, [fp, #-44]
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L20:
	.align	2
.L19:
	.word	elem_angle
	.size	cordic, .-cordic
	.align	2
	.global	cos_cordic
	.type	cos_cordic, %function
cos_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	sub	r2, fp, #32
	mov	r3, #0
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r1, #1
	mov	r2, #0
	ldr	r3, [fp, #-40]
	bl	cordic
	ldr	r3, [fp, #-32]
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	adr	r6, .L23
	ldmia	r6, {r5-r6}
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L24:
	.align	3
.L23:
	.word	59098750
	.word	1073371425
	.size	cos_cordic, .-cos_cordic
	.align	2
	.global	sin_cordic
	.type	sin_cordic, %function
sin_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	sub	r2, fp, #32
	mov	r3, #0
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r1, #1
	mov	r2, #0
	ldr	r3, [fp, #-40]
	bl	cordic
	ldr	r3, [fp, #-28]
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	adr	r6, .L27
	ldmia	r6, {r5-r6}
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L28:
	.align	3
.L27:
	.word	59098750
	.word	1073371425
	.size	sin_cordic, .-sin_cordic
	.align	2
	.global	arctan_div_cordic
	.type	arctan_div_cordic, %function
arctan_div_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #36
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	sub	r2, fp, #24
	mov	r3, #1
	str	r3, [sp, #0]
	mov	r0, r2
	ldr	r1, [fp, #-32]
	ldr	r2, [fp, #-36]
	mov	r3, #0
	bl	cordic
	ldr	r3, [fp, #-16]
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	arctan_div_cordic, .-arctan_div_cordic
	.align	2
	.global	arctan_cordic
	.type	arctan_cordic, %function
arctan_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #36
	str	r0, [fp, #-32]
	sub	r2, fp, #24
	mov	r3, #1
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r1, #1
	ldr	r2, [fp, #-32]
	mov	r3, #0
	bl	cordic
	ldr	r3, [fp, #-16]
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	arctan_cordic, .-arctan_cordic
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Cos(45): %.15lf\012\000"
	.align	2
.LC1:
	.ascii	"Cos(30): %.15lf\012\000"
	.align	2
.LC2:
	.ascii	"Sin(90): %.15lf\012\000"
	.align	2
.LC3:
	.ascii	"Arctan(5/4): %.15lf\012\000"
	.align	2
.LC4:
	.ascii	"Arctan(2): %.15lf\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, fp, lr}
	add	fp, sp, #12
	mov	r0, #45
	bl	cos_cordic
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L35
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r0, #30
	bl	cos_cordic
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L35+4
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r0, #90
	bl	sin_cordic
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L35+8
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r0, #4
	mov	r1, #5
	bl	arctan_div_cordic
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L35+12
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r0, #2
	bl	arctan_cordic
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L35+16
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp!, {r4, r5, fp, lr}
	bx	lr
.L36:
	.align	2
.L35:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
