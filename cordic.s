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
@ GNU C (Sourcery G++ Lite 2008q3-72) version 4.3.2 (arm-none-linux-gnueabi)
@	compiled by GNU C version 3.4.4, GMP version 4.2.2, MPFR version 2.3.1.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib armv4t -iprefix
@ /opt/arm/4.3.2/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/ -isysroot
@ /opt/arm/4.3.2/bin/../arm-none-linux-gnueabi/libc cordic.c -march=armv4t
@ -fverbose-asm
@ options enabled:  -falign-loops -fargument-alias -fauto-inc-dec
@ -fbranch-count-reg -fcommon -fearly-inlining
@ -feliminate-unused-debug-types -ffunction-cse -fgcse-lm -fident -fivopts
@ -fkeep-static-consts -fleading-underscore -fmath-errno
@ -fmerge-debug-strings -fmove-loop-invariants -fpeephole
@ -freg-struct-return -fsched-interblock -fsched-spec
@ -fsched-stalled-insns-dep -fsigned-zeros -fsplit-ivs-in-unroller
@ -ftoplevel-reorder -ftrapping-math -ftree-cselim -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
@ -ftree-reassoc -ftree-scev-cprop -ftree-vect-loop-version -fverbose-asm
@ -fzero-initialized-in-bss -mglibc -mlittle-endian -msched-prolog
@ -mthumb-interwork

@ Compiler executable checksum: d3429b3d44dc83ee8ef5b80b6a06f8ca

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
	stmfd	sp!, {r4, r5, r6, fp, lr}	@,
	add	fp, sp, #16	@,,
	sub	sp, sp, #12	@,,
	str	r0, [fp, #-24]	@ fixed, fixed
	ldr	r0, [fp, #-24]	@, fixed
	bl	__aeabi_i2d	@
	mov	r3, r0	@ D.2105,
	mov	r4, r1	@ D.2105,
	mov	r5, #0	@ tmp136,
	mov	r6, #1073741824	@,
	add	r6, r6, #15728640	@,,
	mov	r0, r3	@, D.2105
	mov	r1, r4	@, D.2105
	mov	r2, r5	@, tmp136
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp137,
	mov	r4, r1	@,
	mov	r0, r3	@, <result>
	mov	r1, r4	@, <result>
	sub	sp, fp, #16	@,,
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
	stmfd	sp!, {r4, r5, r6, fp, lr}	@,
	add	fp, sp, #16	@,,
	sub	sp, sp, #12	@,,
	str	r0, [fp, #-28]	@ flt, flt
	str	r1, [fp, #-24]	@, flt
	sub	r4, fp, #28	@,,
	ldmia	r4, {r3-r4}	@, tmp136
	mov	r5, #0	@ tmp137,
	mov	r6, #1073741824	@,
	add	r6, r6, #15728640	@,,
	mov	r0, r3	@, tmp136
	mov	r1, r4	@,
	mov	r2, r5	@, tmp137
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp138,
	mov	r4, r1	@,
	mov	r0, r3	@, D.2111
	mov	r1, r4	@, D.2111
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ D.2110,
	mov	r0, r3	@, <result>
	sub	sp, fp, #16	@,,
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
	str	fp, [sp, #-4]!	@,
	add	fp, sp, #0	@,,
	sub	sp, sp, #28	@,,
	str	r0, [fp, #-16]	@ mode, mode
	str	r1, [fp, #-20]	@ val, val
	ldr	r3, [fp, #-20]	@ tmp135, val
	cmp	r3, #0	@ tmp135,
	bge	.L6	@,
	mov	r3, #1	@ tmp136,
	str	r3, [fp, #-8]	@ tmp136, result
	b	.L7	@
.L6:
	mov	r3, #0	@ tmp137,
	str	r3, [fp, #-8]	@ tmp137, result
.L7:
	ldr	r3, [fp, #-16]	@ tmp138, mode
	cmp	r3, #0	@ tmp138,
	bne	.L8	@,
	ldr	r3, [fp, #-8]	@, result
	str	r3, [fp, #-24]	@, D.2118
	b	.L9	@
.L8:
	ldr	r3, [fp, #-8]	@ tmp139, result
	cmp	r3, #0	@ tmp139,
	movne	r3, #0	@,
	moveq	r3, #1	@,
	str	r3, [fp, #-24]	@, D.2118
.L9:
	ldr	r3, [fp, #-24]	@ <result>, D.2118
	mov	r0, r3	@, <result>
	add	sp, fp, #0	@,,
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
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #40	@,,
	str	r0, [fp, #-44]	@ D.2172, D.2172
	str	r1, [fp, #-32]	@ x, x
	str	r2, [fp, #-36]	@ y, y
	str	r3, [fp, #-40]	@ z, z
	ldr	r3, [fp, #4]	@ tmp160, mode
	cmp	r3, #0	@ tmp160,
	bne	.L12	@,
	sub	r3, fp, #40	@ tmp161,,
	str	r3, [fp, #-8]	@ tmp161, val
	b	.L13	@
.L12:
	sub	r3, fp, #36	@ tmp162,,
	str	r3, [fp, #-8]	@ tmp162, val
.L13:
	ldr	r3, [fp, #-32]	@ tmp163, x
	mov	r3, r3, asl #16	@ tmp164, tmp163,
	str	r3, [fp, #-32]	@ tmp164, x
	ldr	r3, [fp, #-36]	@ y.0, y
	mov	r3, r3, asl #16	@ y.1, y.0,
	str	r3, [fp, #-36]	@ y.1, y
	ldr	r3, [fp, #-40]	@ z.2, z
	mov	r3, r3, asl #16	@ z.3, z.2,
	str	r3, [fp, #-40]	@ z.3, z
	mov	r3, #0	@ tmp165,
	str	r3, [fp, #-16]	@ tmp165, i
	b	.L14	@
.L17:
	ldr	r3, [fp, #-32]	@ tmp166, x
	str	r3, [fp, #-12]	@ tmp166, x_temp
	ldr	r3, [fp, #-8]	@ tmp167, val
	ldr	r3, [r3, #0]	@ D.2143,
	ldr	r0, [fp, #4]	@, mode
	mov	r1, r3	@, D.2143
	bl	rot_decision	@
	mov	r3, r0	@ D.2144,
	cmp	r3, #0	@ D.2144,
	beq	.L15	@,
	ldr	r2, [fp, #-36]	@ y.4, y
	ldr	r3, [fp, #-16]	@ tmp168, i
	mov	r2, r2, asr r3	@ D.2146, y.4,
	ldr	r3, [fp, #-32]	@ tmp169, x
	add	r3, r3, r2	@ tmp170, tmp169, D.2146
	str	r3, [fp, #-32]	@ tmp170, x
	ldr	r1, [fp, #-36]	@ y.5, y
	ldr	r2, [fp, #-12]	@ tmp171, x_temp
	ldr	r3, [fp, #-16]	@ tmp172, i
	mov	r3, r2, asr r3	@ D.2148, tmp171,
	rsb	r3, r3, r1	@ y.6, D.2148, y.5
	str	r3, [fp, #-36]	@ y.6, y
	ldr	r2, [fp, #-16]	@ i.7, i
	ldr	r3, .L19	@ tmp173,
	ldr	r2, [r3, r2, asl #2]	@ D.2151, elem_angle
	ldr	r3, [fp, #-40]	@ z.8, z
	add	r3, r2, r3	@ z.9, D.2151, z.8
	str	r3, [fp, #-40]	@ z.9, z
	b	.L16	@
.L15:
	ldr	r2, [fp, #-36]	@ y.10, y
	ldr	r3, [fp, #-16]	@ tmp174, i
	mov	r2, r2, asr r3	@ D.2155, y.10,
	ldr	r3, [fp, #-32]	@ tmp175, x
	rsb	r3, r2, r3	@ tmp176, D.2155, tmp175
	str	r3, [fp, #-32]	@ tmp176, x
	ldr	r2, [fp, #-12]	@ tmp177, x_temp
	ldr	r3, [fp, #-16]	@ tmp178, i
	mov	r2, r2, asr r3	@ D.2156, tmp177,
	ldr	r3, [fp, #-36]	@ y.11, y
	add	r3, r2, r3	@ y.12, D.2156, y.11
	str	r3, [fp, #-36]	@ y.12, y
	ldr	r1, [fp, #-40]	@ z.13, z
	ldr	r2, [fp, #-16]	@ i.14, i
	ldr	r3, .L19	@ tmp179,
	ldr	r3, [r3, r2, asl #2]	@ D.2161, elem_angle
	rsb	r3, r3, r1	@ z.15, D.2161, z.13
	str	r3, [fp, #-40]	@ z.15, z
.L16:
	ldr	r3, [fp, #-16]	@ tmp180, i
	add	r3, r3, #1	@ tmp181, tmp180,
	str	r3, [fp, #-16]	@ tmp181, i
.L14:
	ldr	r3, [fp, #-16]	@ tmp182, i
	cmp	r3, #22	@ tmp182,
	ble	.L17	@,
	ldr	r3, [fp, #-32]	@ tmp183, x
	str	r3, [fp, #-28]	@ tmp183, result.x
	ldr	r3, [fp, #-36]	@ y.16, y
	str	r3, [fp, #-24]	@ y.16, result.y
	ldr	r3, [fp, #-40]	@ z.17, z
	str	r3, [fp, #-20]	@ z.17, result.z
	ldr	ip, [fp, #-44]	@ tmp184, D.2172
	sub	r3, fp, #28	@ tmp185,,
	ldmia	r3, {r0, r1, r2}	@ tmp185,,,
	stmia	ip, {r0, r1, r2}	@ tmp184,,,
	ldr	r0, [fp, #-44]	@, D.2172
	sub	sp, fp, #4	@,,
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
	stmfd	sp!, {r4, r5, r6, fp, lr}	@,
	add	fp, sp, #16	@,,
	sub	sp, sp, #36	@,,
	str	r0, [fp, #-40]	@ theta, theta
	sub	r2, fp, #32	@ tmp137,,
	mov	r3, #0	@ tmp138,
	str	r3, [sp, #0]	@ tmp138,
	mov	r0, r2	@, tmp137
	mov	r1, #1	@,
	mov	r2, #0	@,
	ldr	r3, [fp, #-40]	@, theta
	bl	cordic	@
	ldr	r3, [fp, #-32]	@ D.2178, D.2177.x
	mov	r0, r3	@, D.2178
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2179,
	mov	r4, r1	@ D.2179,
	adr	r6, .L23	@,
	ldmia	r6, {r5-r6}	@, tmp139
	mov	r0, r3	@, D.2179
	mov	r1, r4	@, D.2179
	mov	r2, r5	@, tmp139
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp140,
	mov	r4, r1	@,
	mov	r0, r3	@, <result>
	mov	r1, r4	@, <result>
	sub	sp, fp, #16	@,,
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
	stmfd	sp!, {r4, r5, r6, fp, lr}	@,
	add	fp, sp, #16	@,,
	sub	sp, sp, #36	@,,
	str	r0, [fp, #-40]	@ theta, theta
	sub	r2, fp, #32	@ tmp137,,
	mov	r3, #0	@ tmp138,
	str	r3, [sp, #0]	@ tmp138,
	mov	r0, r2	@, tmp137
	mov	r1, #1	@,
	mov	r2, #0	@,
	ldr	r3, [fp, #-40]	@, theta
	bl	cordic	@
	ldr	r3, [fp, #-28]	@ D.2187, D.2186.y
	mov	r0, r3	@, D.2187
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2188,
	mov	r4, r1	@ D.2188,
	adr	r6, .L27	@,
	ldmia	r6, {r5-r6}	@, tmp139
	mov	r0, r3	@, D.2188
	mov	r1, r4	@, D.2188
	mov	r2, r5	@, tmp139
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp140,
	mov	r4, r1	@,
	mov	r0, r3	@, <result>
	mov	r1, r4	@, <result>
	sub	sp, fp, #16	@,,
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
	stmfd	sp!, {r4, fp, lr}	@,
	add	fp, sp, #8	@,,
	sub	sp, sp, #36	@,,
	str	r0, [fp, #-32]	@ x, x
	str	r1, [fp, #-36]	@ y, y
	sub	r2, fp, #24	@ tmp137,,
	mov	r3, #1	@ tmp138,
	str	r3, [sp, #0]	@ tmp138,
	mov	r0, r2	@, tmp137
	ldr	r1, [fp, #-32]	@, x
	ldr	r2, [fp, #-36]	@, y
	mov	r3, #0	@,
	bl	cordic	@
	ldr	r3, [fp, #-16]	@ D.2197, D.2196.z
	mov	r0, r3	@, D.2197
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2198,
	mov	r4, r1	@ D.2198,
	mov	r0, r3	@, <result>
	mov	r1, r4	@, <result>
	sub	sp, fp, #8	@,,
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
	stmfd	sp!, {r4, fp, lr}	@,
	add	fp, sp, #8	@,,
	sub	sp, sp, #36	@,,
	str	r0, [fp, #-32]	@ x, x
	sub	r2, fp, #24	@ tmp137,,
	mov	r3, #1	@ tmp138,
	str	r3, [sp, #0]	@ tmp138,
	mov	r0, r2	@, tmp137
	mov	r1, #1	@,
	ldr	r2, [fp, #-32]	@, x
	mov	r3, #0	@,
	bl	cordic	@
	ldr	r3, [fp, #-16]	@ D.2206, D.2205.z
	mov	r0, r3	@, D.2206
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2207,
	mov	r4, r1	@ D.2207,
	mov	r0, r3	@, <result>
	mov	r1, r4	@, <result>
	sub	sp, fp, #8	@,,
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
	stmfd	sp!, {r4, r5, fp, lr}	@,
	add	fp, sp, #12	@,,
	mov	r0, #45	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2212,
	mov	r4, r1	@ D.2212,
	ldr	r0, .L35	@,
	mov	r2, r3	@, D.2212
	mov	r3, r4	@, D.2212
	bl	printf	@
	mov	r0, #30	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2213,
	mov	r4, r1	@ D.2213,
	ldr	r0, .L35+4	@,
	mov	r2, r3	@, D.2213
	mov	r3, r4	@, D.2213
	bl	printf	@
	mov	r0, #90	@,
	bl	sin_cordic	@
	mov	r3, r0	@ D.2214,
	mov	r4, r1	@ D.2214,
	ldr	r0, .L35+8	@,
	mov	r2, r3	@, D.2214
	mov	r3, r4	@, D.2214
	bl	printf	@
	mov	r0, #4	@,
	mov	r1, #5	@,
	bl	arctan_div_cordic	@
	mov	r3, r0	@ D.2215,
	mov	r4, r1	@ D.2215,
	ldr	r0, .L35+12	@,
	mov	r2, r3	@, D.2215
	mov	r3, r4	@, D.2215
	bl	printf	@
	mov	r0, #2	@,
	bl	arctan_cordic	@
	mov	r3, r0	@ D.2216,
	mov	r4, r1	@ D.2216,
	ldr	r0, .L35+16	@,
	mov	r2, r3	@, D.2216
	mov	r3, r4	@, D.2216
	bl	printf	@
	mov	r3, #0	@ D.2217,
	mov	r0, r3	@, <result>
	sub	sp, fp, #12	@,,
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
