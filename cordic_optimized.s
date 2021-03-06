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
	.file	"cordic_optimized.c"
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
	.global	ftfixed
	.type	ftfixed, %function
ftfixed:
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
	.size	ftfixed, .-ftfixed
	.section	.rodata
	.align	2
	.type	C.0.2120, %object
	.size	C.0.2120, 92
C.0.2120:
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
	.text
	.align	2
	.global	cordic_rotation
	.type	cordic_rotation, %function
cordic_rotation:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #128
	str	r0, [fp, #-120]
	str	r1, [fp, #-124]
	str	r2, [fp, #-128]
	str	r3, [fp, #-132]
	ldr	r3, .L15
	sub	r2, fp, #96
	mov	ip, #92
	mov	r0, r2
	mov	r1, r3
	mov	r2, ip
	bl	memcpy
	mov	r1, #0
	str	r1, [fp, #-116]
	b	.L6
.L11:
	ldr	r2, [fp, #-124]
	str	r2, [fp, #-112]
	ldr	r3, [fp, #-132]
	cmp	r3, #0
	bge	.L7
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	add	r1, r1, r3
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	rsb	r2, r3, r2
	str	r2, [fp, #-128]
	ldr	r3, [fp, #-116]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-132]
	add	r2, r2, r3
	str	r2, [fp, #-132]
	b	.L8
.L7:
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	rsb	r1, r3, r1
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	add	r2, r2, r3
	str	r2, [fp, #-128]
	ldr	r3, [fp, #-116]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-132]
	rsb	r2, r3, r2
	str	r2, [fp, #-132]
.L8:
	ldr	r3, [fp, #-116]
	add	r3, r3, #1
	str	r3, [fp, #-116]
	ldr	r1, [fp, #-124]
	str	r1, [fp, #-112]
	ldr	r2, [fp, #-132]
	cmp	r2, #0
	bge	.L9
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	add	r1, r1, r3
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	rsb	r2, r3, r2
	str	r2, [fp, #-128]
	ldr	r3, [fp, #-116]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-132]
	add	r2, r2, r3
	str	r2, [fp, #-132]
	b	.L10
.L9:
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	rsb	r1, r3, r1
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	add	r2, r2, r3
	str	r2, [fp, #-128]
	ldr	r3, [fp, #-116]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-132]
	rsb	r2, r3, r2
	str	r2, [fp, #-132]
.L10:
	ldr	r1, [fp, #-116]
	add	r1, r1, #1
	str	r1, [fp, #-116]
.L6:
	cmp	r1, #22
	bne	.L11
	ldr	r2, [fp, #-124]
	str	r2, [fp, #-112]
	ldr	r3, [fp, #-132]
	cmp	r3, #0
	bge	.L12
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	add	r1, r1, r3
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	rsb	r2, r3, r2
	str	r2, [fp, #-128]
	b	.L13
.L12:
	ldr	r1, [fp, #-128]
	ldr	r2, [fp, #-116]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-124]
	rsb	r1, r3, r1
	str	r1, [fp, #-124]
	ldr	r2, [fp, #-112]
	ldr	r1, [fp, #-116]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-128]
	add	r2, r2, r3
	str	r2, [fp, #-128]
.L13:
	ldr	r3, [fp, #-124]
	str	r3, [fp, #-104]
	ldr	r1, [fp, #-128]
	str	r1, [fp, #-100]
	ldr	r2, [fp, #-120]
	sub	r3, fp, #104
	ldmia	r3, {r0, r1}
	stmia	r2, {r0, r1}
	ldr	r0, [fp, #-120]
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L16:
	.align	2
.L15:
	.word	C.0.2120
	.size	cordic_rotation, .-cordic_rotation
	.section	.rodata
	.align	2
	.type	C.7.2171, %object
	.size	C.7.2171, 92
C.7.2171:
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
	.text
	.align	2
	.global	cordic_vector
	.type	cordic_vector, %function
cordic_vector:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #120
	str	r0, [fp, #-112]
	str	r1, [fp, #-116]
	str	r2, [fp, #-120]
	ldr	r3, .L27
	sub	r2, fp, #96
	mov	ip, #92
	mov	r0, r2
	mov	r1, r3
	mov	r2, ip
	bl	memcpy
	mov	r1, #0
	str	r1, [fp, #-108]
	b	.L18
.L23:
	ldr	r2, [fp, #-112]
	str	r2, [fp, #-104]
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	blt	.L19
	ldr	r1, [fp, #-116]
	ldr	r2, [fp, #-108]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-112]
	add	r1, r1, r3
	str	r1, [fp, #-112]
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	rsb	r2, r3, r2
	str	r2, [fp, #-116]
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	add	r2, r2, r3
	str	r2, [fp, #-120]
	b	.L20
.L19:
	ldr	r1, [fp, #-116]
	ldr	r2, [fp, #-108]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-112]
	rsb	r1, r3, r1
	str	r1, [fp, #-112]
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	add	r2, r2, r3
	str	r2, [fp, #-116]
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	rsb	r2, r3, r2
	str	r2, [fp, #-120]
.L20:
	ldr	r3, [fp, #-108]
	add	r3, r3, #1
	str	r3, [fp, #-108]
	ldr	r1, [fp, #-112]
	str	r1, [fp, #-104]
	ldr	r2, [fp, #-116]
	cmp	r2, #0
	blt	.L21
	ldr	r1, [fp, #-116]
	ldr	r2, [fp, #-108]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-112]
	add	r1, r1, r3
	str	r1, [fp, #-112]
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	rsb	r2, r3, r2
	str	r2, [fp, #-116]
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	add	r2, r2, r3
	str	r2, [fp, #-120]
	b	.L22
.L21:
	ldr	r1, [fp, #-116]
	ldr	r2, [fp, #-108]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-112]
	rsb	r1, r3, r1
	str	r1, [fp, #-112]
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	add	r2, r2, r3
	str	r2, [fp, #-116]
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	rsb	r2, r3, r2
	str	r2, [fp, #-120]
.L22:
	ldr	r1, [fp, #-108]
	add	r1, r1, #1
	str	r1, [fp, #-108]
.L18:
	cmp	r1, #22
	bne	.L23
	ldr	r2, [fp, #-112]
	str	r2, [fp, #-104]
	ldr	r3, [fp, #-116]
	cmp	r3, #0
	blt	.L24
	ldr	r1, [fp, #-116]
	ldr	r2, [fp, #-108]
	mov	r3, r1, asr r2
	ldr	r1, [fp, #-112]
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	add	r2, r2, r3
	str	r2, [fp, #-120]
	b	.L25
.L24:
	ldr	r2, [fp, #-104]
	ldr	r1, [fp, #-108]
	mov	r3, r2, asr r1
	ldr	r2, [fp, #-116]
	add	r2, r2, r3
	ldr	r3, [fp, #-108]
	mvn	r2, #91
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r2, [fp, #-120]
	rsb	r2, r3, r2
	str	r2, [fp, #-120]
.L25:
	ldr	r3, [fp, #-120]
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L28:
	.align	2
.L27:
	.word	C.7.2171
	.size	cordic_vector, .-cordic_vector
	.global	__aeabi_f2d
	.global	__aeabi_d2f
	.align	2
	.global	cos_cordic
	.type	cos_cordic, %function
cos_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #28
	str	r0, [fp, #-32]	@ float
	ldr	r0, [fp, #-32]	@ float
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	ftfixed
	mov	r3, r0
	str	r3, [fp, #-16]
	sub	r3, fp, #24
	mov	r0, r3
	mov	r1, #65536
	mov	r2, #0
	ldr	r3, [fp, #-16]
	bl	cordic_rotation
	ldr	r1, [fp, #-24]
	mov	r3, r1
	mov	r3, r3, asl #3
	mov	r2, r3, asl #2
	add	r3, r3, r2
	rsb	r3, r1, r3
	mov	r3, r3, asl #3
	rsb	r3, r1, r3
	mov	r3, r3, asl #3
	rsb	r3, r1, r3
	mov	r3, r3, asl #2
	add	r3, r3, r1
	mov	r3, r3, asl #1
	mov	r3, r3, asr #15
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2f
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	cos_cordic, .-cos_cordic
	.align	2
	.global	sin_cordic
	.type	sin_cordic, %function
sin_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #28
	str	r0, [fp, #-32]	@ float
	ldr	r0, [fp, #-32]	@ float
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	ftfixed
	mov	r3, r0
	str	r3, [fp, #-16]
	sub	r3, fp, #24
	mov	r0, r3
	mov	r1, #65536
	mov	r2, #0
	ldr	r3, [fp, #-16]
	bl	cordic_rotation
	ldr	r1, [fp, #-20]
	mov	r3, r1
	mov	r3, r3, asl #3
	mov	r2, r3, asl #2
	add	r3, r3, r2
	rsb	r3, r1, r3
	mov	r3, r3, asl #3
	rsb	r3, r1, r3
	mov	r3, r3, asl #3
	rsb	r3, r1, r3
	mov	r3, r3, asl #2
	add	r3, r3, r1
	mov	r3, r3, asl #1
	mov	r3, r3, asr #15
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2f
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	sin_cordic, .-sin_cordic
	.align	2
	.global	arctan_div_cordic
	.type	arctan_div_cordic, %function
arctan_div_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]	@ float
	str	r1, [fp, #-28]	@ float
	ldr	r0, [fp, #-24]	@ float
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	ftfixed
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-28]	@ float
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	ftfixed
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r0, [fp, #-20]
	ldr	r1, [fp, #-16]
	mov	r2, #0
	bl	cordic_vector
	mov	r3, r0
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2f
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	arctan_div_cordic, .-arctan_div_cordic
	.align	2
	.global	arctan_cordic
	.type	arctan_cordic, %function
arctan_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]	@ float
	ldr	r0, [fp, #-24]	@ float
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	ftfixed
	mov	r3, r0
	str	r3, [fp, #-16]
	mov	r0, #65536
	ldr	r1, [fp, #-16]
	mov	r2, #0
	bl	cordic_vector
	mov	r3, r0
	mov	r0, r3
	bl	fixed_to_float
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2f
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	arctan_cordic, .-arctan_cordic
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Cos(1): %.15lf\012\000"
	.align	2
.LC1:
	.ascii	"Cos(20): %.15lf\012\000"
	.align	2
.LC2:
	.ascii	"Cos(45): %.15lf\012\000"
	.align	2
.LC3:
	.ascii	"Cos(30): %.15lf\012\000"
	.align	2
.LC4:
	.ascii	"Sin(90): %.15lf\012\000"
	.align	2
.LC5:
	.ascii	"Arctan(5/4): %.15lf\012\000"
	.align	2
.LC6:
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
	ldr	r0, .L39	@ float
	bl	cos_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+4
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+8	@ float
	bl	cos_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+12
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+16	@ float
	bl	cos_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+20
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+24	@ float
	bl	cos_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+28
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+32	@ float
	bl	sin_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+36
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+40	@ float
	ldr	r1, .L39+44	@ float
	bl	arctan_div_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+48
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r0, .L39+52	@ float
	bl	arctan_cordic
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L39+56
	mov	r2, r3
	mov	r3, r4
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #12
	ldmfd	sp!, {r4, r5, fp, lr}
	bx	lr
.L40:
	.align	2
.L39:
	.word	1065353216
	.word	.LC0
	.word	1101004800
	.word	.LC1
	.word	1110704128
	.word	.LC2
	.word	1106247680
	.word	.LC3
	.word	1119092736
	.word	.LC4
	.word	1082130432
	.word	1084227584
	.word	.LC5
	.word	1073741824
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
