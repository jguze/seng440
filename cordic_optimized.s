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
@ GNU C (Sourcery G++ Lite 2008q3-72) version 4.3.2 (arm-none-linux-gnueabi)
@	compiled by GNU C version 3.4.4, GMP version 4.2.2, MPFR version 2.3.1.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib armv4t -iprefix
@ /opt/arm/4.3.2/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/ -isysroot
@ /opt/arm/4.3.2/bin/../arm-none-linux-gnueabi/libc cordic_optimized.c
@ -march=armv4t -fverbose-asm
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
	mov	r3, r0	@ D.2099,
	mov	r4, r1	@ D.2099,
	mov	r5, #0	@ tmp136,
	mov	r6, #1073741824	@,
	add	r6, r6, #15728640	@,,
	mov	r0, r3	@, D.2099
	mov	r1, r4	@, D.2099
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
	.section	.rodata
	.align	2
	.type	C.0.2114, %object
	.size	C.0.2114, 92
C.0.2114:
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
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #128	@,,
	str	r0, [fp, #-120]	@ D.2149, D.2149
	str	r1, [fp, #-124]	@ x, x
	str	r2, [fp, #-128]	@ y, y
	str	r3, [fp, #-132]	@ z, z
	ldr	r3, .L13	@ tmp163,
	sub	r2, fp, #96	@ tmp164,,
	mov	ip, #92	@ tmp166,
	mov	r0, r2	@, tmp164
	mov	r1, r3	@, tmp165
	mov	r2, ip	@, tmp166
	bl	memcpy	@
	ldr	r1, [fp, #-124]	@, x
	mov	r1, r1, asl #16	@,,
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-128]	@, y
	mov	r2, r2, asl #16	@,,
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-132]	@, z
	mov	r3, r3, asl #16	@,,
	str	r3, [fp, #-132]	@, z
	mov	r1, #0	@,
	str	r1, [fp, #-116]	@, i
	b	.L4	@
.L9:
	ldr	r2, [fp, #-124]	@, x
	str	r2, [fp, #-112]	@, x_temp
	ldr	r3, [fp, #-132]	@, z
	cmp	r3, #0	@,
	bge	.L5	@,
	ldr	r1, [fp, #-128]	@, y
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2115,,
	ldr	r1, [fp, #-124]	@, x
	add	r1, r1, r3	@,, D.2115
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2116,,
	ldr	r2, [fp, #-128]	@, y
	rsb	r2, r3, r2	@, D.2116,
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.1, i
	mvn	r2, #91	@ tmp168,
	mov	r3, r3, asl #2	@ tmp169, i.1,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp170,, tmp169
	add	r3, r3, r2	@ tmp171, tmp170, tmp168
	ldr	r3, [r3, #0]	@ D.2118, elem_angle
	ldr	r2, [fp, #-132]	@, z
	add	r2, r2, r3	@,, D.2118
	str	r2, [fp, #-132]	@, z
	b	.L6	@
.L5:
	ldr	r1, [fp, #-128]	@, y
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2119,,
	ldr	r1, [fp, #-124]	@, x
	rsb	r1, r3, r1	@, D.2119,
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2120,,
	ldr	r2, [fp, #-128]	@, y
	add	r2, r2, r3	@,, D.2120
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.2, i
	mvn	r2, #91	@ tmp172,
	mov	r3, r3, asl #2	@ tmp173, i.2,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp174,, tmp173
	add	r3, r3, r2	@ tmp175, tmp174, tmp172
	ldr	r3, [r3, #0]	@ D.2122, elem_angle
	ldr	r2, [fp, #-132]	@, z
	rsb	r2, r3, r2	@, D.2122,
	str	r2, [fp, #-132]	@, z
.L6:
	ldr	r3, [fp, #-116]	@, i
	add	r3, r3, #1	@,,
	str	r3, [fp, #-116]	@, i
	ldr	r1, [fp, #-124]	@, x
	str	r1, [fp, #-112]	@, x_temp
	ldr	r2, [fp, #-132]	@, z
	cmp	r2, #0	@,
	bge	.L7	@,
	ldr	r1, [fp, #-128]	@, y
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2123,,
	ldr	r1, [fp, #-124]	@, x
	add	r1, r1, r3	@,, D.2123
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2124,,
	ldr	r2, [fp, #-128]	@, y
	rsb	r2, r3, r2	@, D.2124,
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.3, i
	mvn	r2, #91	@ tmp176,
	mov	r3, r3, asl #2	@ tmp177, i.3,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp178,, tmp177
	add	r3, r3, r2	@ tmp179, tmp178, tmp176
	ldr	r3, [r3, #0]	@ D.2126, elem_angle
	ldr	r2, [fp, #-132]	@, z
	add	r2, r2, r3	@,, D.2126
	str	r2, [fp, #-132]	@, z
	b	.L8	@
.L7:
	ldr	r1, [fp, #-128]	@, y
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2127,,
	ldr	r1, [fp, #-124]	@, x
	rsb	r1, r3, r1	@, D.2127,
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2128,,
	ldr	r2, [fp, #-128]	@, y
	add	r2, r2, r3	@,, D.2128
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.4, i
	mvn	r2, #91	@ tmp180,
	mov	r3, r3, asl #2	@ tmp181, i.4,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp182,, tmp181
	add	r3, r3, r2	@ tmp183, tmp182, tmp180
	ldr	r3, [r3, #0]	@ D.2130, elem_angle
	ldr	r2, [fp, #-132]	@, z
	rsb	r2, r3, r2	@, D.2130,
	str	r2, [fp, #-132]	@, z
.L8:
	ldr	r3, [fp, #-116]	@, i
	add	r3, r3, #1	@,,
	str	r3, [fp, #-116]	@, i
.L4:
	ldr	r1, [fp, #-116]	@, i
	cmp	r1, #22	@,
	bne	.L9	@,
	ldr	r2, [fp, #-116]	@, i
	add	r2, r2, #1	@,,
	str	r2, [fp, #-116]	@, i
	ldr	r3, [fp, #-124]	@, x
	str	r3, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-132]	@, z
	cmp	r1, #0	@,
	bge	.L10	@,
	ldr	r2, [fp, #-128]	@, y
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2131,,
	ldr	r2, [fp, #-124]	@, x
	add	r2, r2, r3	@,, D.2131
	str	r2, [fp, #-124]	@, x
	ldr	r1, [fp, #-112]	@, x_temp
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2132,,
	ldr	r1, [fp, #-128]	@, y
	rsb	r1, r3, r1	@, D.2132,
	str	r1, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.5, i
	mvn	r2, #91	@ tmp184,
	mov	r3, r3, asl #2	@ tmp185, i.5,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp186,, tmp185
	add	r3, r3, r2	@ tmp187, tmp186, tmp184
	ldr	r3, [r3, #0]	@ D.2134, elem_angle
	ldr	r2, [fp, #-132]	@, z
	add	r2, r2, r3	@,, D.2134
	b	.L11	@
.L10:
	ldr	r1, [fp, #-128]	@, y
	ldr	r2, [fp, #-116]	@, i
	mov	r3, r1, asr r2	@ D.2135,,
	ldr	r1, [fp, #-124]	@, x
	rsb	r1, r3, r1	@, D.2135,
	str	r1, [fp, #-124]	@, x
	ldr	r2, [fp, #-112]	@, x_temp
	ldr	r1, [fp, #-116]	@, i
	mov	r3, r2, asr r1	@ D.2136,,
	ldr	r2, [fp, #-128]	@, y
	add	r2, r2, r3	@,, D.2136
	str	r2, [fp, #-128]	@, y
	ldr	r3, [fp, #-116]	@ i.6, i
	mvn	r2, #91	@ tmp188,
	mov	r3, r3, asl #2	@ tmp189, i.6,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp190,, tmp189
	add	r3, r3, r2	@ tmp191, tmp190, tmp188
	ldr	r3, [r3, #0]	@ D.2138, elem_angle
	ldr	r2, [fp, #-132]	@, z
	rsb	r2, r3, r2	@, D.2138,
.L11:
	ldr	r3, [fp, #-124]	@, x
	str	r3, [fp, #-104]	@, result.x
	ldr	r1, [fp, #-128]	@, y
	str	r1, [fp, #-100]	@, result.y
	ldr	r2, [fp, #-120]	@ tmp192, D.2149
	sub	r3, fp, #104	@ tmp193,,
	ldmia	r3, {r0, r1}	@ tmp193,,
	stmia	r2, {r0, r1}	@ tmp192,,
	ldr	r0, [fp, #-120]	@, D.2149
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	C.0.2114
	.size	cordic_rotation, .-cordic_rotation
	.section	.rodata
	.align	2
	.type	C.7.2165, %object
	.size	C.7.2165, 92
C.7.2165:
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
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #120	@,,
	str	r0, [fp, #-112]	@ x, x
	str	r1, [fp, #-116]	@ y, y
	str	r2, [fp, #-120]	@ z, z
	ldr	r3, .L25	@ tmp164,
	sub	r2, fp, #96	@ tmp165,,
	mov	ip, #92	@ tmp167,
	mov	r0, r2	@, tmp165
	mov	r1, r3	@, tmp166
	mov	r2, ip	@, tmp167
	bl	memcpy	@
	ldr	r1, [fp, #-112]	@, x
	mov	r1, r1, asl #16	@,,
	str	r1, [fp, #-112]	@, x
	ldr	r2, [fp, #-116]	@, y
	mov	r2, r2, asl #16	@,,
	str	r2, [fp, #-116]	@, y
	ldr	r3, [fp, #-120]	@, z
	mov	r3, r3, asl #16	@,,
	str	r3, [fp, #-120]	@, z
	mov	r1, #0	@,
	str	r1, [fp, #-108]	@, i
	b	.L16	@
.L21:
	ldr	r2, [fp, #-112]	@, x
	str	r2, [fp, #-104]	@, x_temp
	ldr	r3, [fp, #-116]	@, y
	cmp	r3, #0	@,
	blt	.L17	@,
	ldr	r1, [fp, #-116]	@, y
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2166,,
	ldr	r1, [fp, #-112]	@, x
	add	r1, r1, r3	@,, D.2166
	str	r1, [fp, #-112]	@, x
	ldr	r2, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2167,,
	ldr	r2, [fp, #-116]	@, y
	rsb	r2, r3, r2	@, D.2167,
	str	r2, [fp, #-116]	@, y
	ldr	r3, [fp, #-108]	@ i.8, i
	mvn	r2, #91	@ tmp169,
	mov	r3, r3, asl #2	@ tmp170, i.8,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp171,, tmp170
	add	r3, r3, r2	@ tmp172, tmp171, tmp169
	ldr	r3, [r3, #0]	@ D.2169, elem_angle
	ldr	r2, [fp, #-120]	@, z
	add	r2, r2, r3	@,, D.2169
	str	r2, [fp, #-120]	@, z
	b	.L18	@
.L17:
	ldr	r1, [fp, #-116]	@, y
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2170,,
	ldr	r1, [fp, #-112]	@, x
	rsb	r1, r3, r1	@, D.2170,
	str	r1, [fp, #-112]	@, x
	ldr	r2, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2171,,
	ldr	r2, [fp, #-116]	@, y
	add	r2, r2, r3	@,, D.2171
	str	r2, [fp, #-116]	@, y
	ldr	r3, [fp, #-108]	@ i.9, i
	mvn	r2, #91	@ tmp173,
	mov	r3, r3, asl #2	@ tmp174, i.9,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp175,, tmp174
	add	r3, r3, r2	@ tmp176, tmp175, tmp173
	ldr	r3, [r3, #0]	@ D.2173, elem_angle
	ldr	r2, [fp, #-120]	@, z
	rsb	r2, r3, r2	@, D.2173,
	str	r2, [fp, #-120]	@, z
.L18:
	ldr	r3, [fp, #-108]	@, i
	add	r3, r3, #1	@,,
	str	r3, [fp, #-108]	@, i
	ldr	r1, [fp, #-112]	@, x
	str	r1, [fp, #-104]	@, x_temp
	ldr	r2, [fp, #-116]	@, y
	cmp	r2, #0	@,
	blt	.L19	@,
	ldr	r1, [fp, #-116]	@, y
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2174,,
	ldr	r1, [fp, #-112]	@, x
	add	r1, r1, r3	@,, D.2174
	str	r1, [fp, #-112]	@, x
	ldr	r2, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2175,,
	ldr	r2, [fp, #-116]	@, y
	rsb	r2, r3, r2	@, D.2175,
	str	r2, [fp, #-116]	@, y
	ldr	r3, [fp, #-108]	@ i.10, i
	mvn	r2, #91	@ tmp177,
	mov	r3, r3, asl #2	@ tmp178, i.10,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp179,, tmp178
	add	r3, r3, r2	@ tmp180, tmp179, tmp177
	ldr	r3, [r3, #0]	@ D.2177, elem_angle
	ldr	r2, [fp, #-120]	@, z
	add	r2, r2, r3	@,, D.2177
	str	r2, [fp, #-120]	@, z
	b	.L20	@
.L19:
	ldr	r1, [fp, #-116]	@, y
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2178,,
	ldr	r1, [fp, #-112]	@, x
	rsb	r1, r3, r1	@, D.2178,
	str	r1, [fp, #-112]	@, x
	ldr	r2, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2179,,
	ldr	r2, [fp, #-116]	@, y
	add	r2, r2, r3	@,, D.2179
	str	r2, [fp, #-116]	@, y
	ldr	r3, [fp, #-108]	@ i.11, i
	mvn	r2, #91	@ tmp181,
	mov	r3, r3, asl #2	@ tmp182, i.11,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp183,, tmp182
	add	r3, r3, r2	@ tmp184, tmp183, tmp181
	ldr	r3, [r3, #0]	@ D.2181, elem_angle
	ldr	r2, [fp, #-120]	@, z
	rsb	r2, r3, r2	@, D.2181,
	str	r2, [fp, #-120]	@, z
.L20:
	ldr	r3, [fp, #-108]	@, i
	add	r3, r3, #1	@,,
	str	r3, [fp, #-108]	@, i
.L16:
	ldr	r1, [fp, #-108]	@, i
	cmp	r1, #22	@,
	bne	.L21	@,
	ldr	r2, [fp, #-108]	@, i
	add	r2, r2, #1	@,,
	str	r2, [fp, #-108]	@, i
	ldr	r3, [fp, #-112]	@, x
	str	r3, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-116]	@, y
	cmp	r1, #0	@,
	blt	.L22	@,
	ldr	r2, [fp, #-116]	@, y
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2182,,
	ldr	r2, [fp, #-112]	@, x
	add	r2, r2, r3	@,, D.2182
	ldr	r1, [fp, #-104]	@, x_temp
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2183,,
	ldr	r1, [fp, #-116]	@, y
	rsb	r1, r3, r1	@, D.2183,
	ldr	r3, [fp, #-108]	@ i.12, i
	mvn	r2, #91	@ tmp185,
	mov	r3, r3, asl #2	@ tmp186, i.12,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp187,, tmp186
	add	r3, r3, r2	@ tmp188, tmp187, tmp185
	ldr	r3, [r3, #0]	@ D.2185, elem_angle
	ldr	r2, [fp, #-120]	@, z
	add	r2, r2, r3	@,, D.2185
	str	r2, [fp, #-120]	@, z
	b	.L23	@
.L22:
	ldr	r1, [fp, #-116]	@, y
	ldr	r2, [fp, #-108]	@, i
	mov	r3, r1, asr r2	@ D.2186,,
	ldr	r1, [fp, #-112]	@, x
	rsb	r1, r3, r1	@, D.2186,
	ldr	r2, [fp, #-104]	@, x_temp
	ldr	r1, [fp, #-108]	@, i
	mov	r3, r2, asr r1	@ D.2187,,
	ldr	r2, [fp, #-116]	@, y
	add	r2, r2, r3	@,, D.2187
	ldr	r3, [fp, #-108]	@ i.13, i
	mvn	r2, #91	@ tmp189,
	mov	r3, r3, asl #2	@ tmp190, i.13,
	sub	r1, fp, #4	@,,
	add	r3, r1, r3	@ tmp191,, tmp190
	add	r3, r3, r2	@ tmp192, tmp191, tmp189
	ldr	r3, [r3, #0]	@ D.2189, elem_angle
	ldr	r2, [fp, #-120]	@, z
	rsb	r2, r3, r2	@, D.2189,
	str	r2, [fp, #-120]	@, z
.L23:
	ldr	r3, [fp, #-120]	@ D.2190, z
	mov	r0, r3	@, <result>
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
.L26:
	.align	2
.L25:
	.word	C.7.2165
	.size	cordic_vector, .-cordic_vector
	.align	2
	.global	cos_cordic
	.type	cos_cordic, %function
cos_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #16	@,,
	str	r0, [fp, #-16]	@ theta, theta
	sub	r3, fp, #12	@ tmp137,,
	mov	r0, r3	@, tmp137
	mov	r1, #1	@,
	mov	r2, #0	@,
	ldr	r3, [fp, #-16]	@, theta
	bl	cordic_rotation	@
	ldr	r1, [fp, #-12]	@ D.2209, D.2208.x
	mov	r3, r1	@ tmp138, D.2209
	mov	r3, r3, asl #3	@ tmp139, tmp138,
	mov	r2, r3, asl #2	@ tmp140, tmp139,
	add	r3, r3, r2	@ tmp139, tmp139, tmp140
	rsb	r3, r1, r3	@ tmp139, D.2209, tmp139
	mov	r3, r3, asl #3	@ tmp141, tmp139,
	rsb	r3, r1, r3	@ tmp141, D.2209, tmp141
	mov	r3, r3, asl #3	@ tmp142, tmp141,
	rsb	r3, r1, r3	@ tmp142, D.2209, tmp142
	mov	r3, r3, asl #2	@ tmp143, tmp142,
	add	r3, r3, r1	@ tmp143, tmp143, D.2209
	mov	r3, r3, asl #1	@ tmp144, tmp143,
	mov	r3, r3, asr #15	@ D.2207, D.2210,
	mov	r0, r3	@, <result>
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
	.size	cos_cordic, .-cos_cordic
	.align	2
	.global	sin_cordic
	.type	sin_cordic, %function
sin_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #16	@,,
	str	r0, [fp, #-16]	@ theta, theta
	sub	r3, fp, #12	@ tmp137,,
	mov	r0, r3	@, tmp137
	mov	r1, #1	@,
	mov	r2, #0	@,
	ldr	r3, [fp, #-16]	@, theta
	bl	cordic_rotation	@
	ldr	r1, [fp, #-8]	@ D.2218, D.2217.y
	mov	r3, r1	@ tmp138, D.2218
	mov	r3, r3, asl #3	@ tmp139, tmp138,
	mov	r2, r3, asl #2	@ tmp140, tmp139,
	add	r3, r3, r2	@ tmp139, tmp139, tmp140
	rsb	r3, r1, r3	@ tmp139, D.2218, tmp139
	mov	r3, r3, asl #3	@ tmp141, tmp139,
	rsb	r3, r1, r3	@ tmp141, D.2218, tmp141
	mov	r3, r3, asl #3	@ tmp142, tmp141,
	rsb	r3, r1, r3	@ tmp142, D.2218, tmp142
	mov	r3, r3, asl #2	@ tmp143, tmp142,
	add	r3, r3, r1	@ tmp143, tmp143, D.2218
	mov	r3, r3, asl #1	@ tmp144, tmp143,
	mov	r3, r3, asr #15	@ D.2216, D.2219,
	mov	r0, r3	@, <result>
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
	.size	sin_cordic, .-sin_cordic
	.align	2
	.global	arctan_div_cordic
	.type	arctan_div_cordic, %function
arctan_div_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #8	@,,
	str	r0, [fp, #-8]	@ x, x
	str	r1, [fp, #-12]	@ y, y
	ldr	r0, [fp, #-8]	@, x
	ldr	r1, [fp, #-12]	@, y
	mov	r2, #0	@,
	bl	cordic_vector	@
	mov	r3, r0	@ D.2227,
	mov	r0, r3	@, <result>
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
	.size	arctan_div_cordic, .-arctan_div_cordic
	.align	2
	.global	arctan_cordic
	.type	arctan_cordic, %function
arctan_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #8	@,,
	str	r0, [fp, #-8]	@ x, x
	mov	r0, #1	@,
	ldr	r1, [fp, #-8]	@, x
	mov	r2, #0	@,
	bl	cordic_vector	@
	mov	r3, r0	@ D.2233,
	mov	r0, r3	@, <result>
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
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
	stmfd	sp!, {r4, r5, fp, lr}	@,
	add	fp, sp, #12	@,,
	mov	r0, #1	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2237,
	mov	r0, r3	@, D.2237
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2238,
	mov	r4, r1	@ D.2238,
	ldr	r0, .L37	@,
	mov	r2, r3	@, D.2238
	mov	r3, r4	@, D.2238
	bl	printf	@
	mov	r0, #20	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2239,
	mov	r0, r3	@, D.2239
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2240,
	mov	r4, r1	@ D.2240,
	ldr	r0, .L37+4	@,
	mov	r2, r3	@, D.2240
	mov	r3, r4	@, D.2240
	bl	printf	@
	mov	r0, #45	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2241,
	mov	r0, r3	@, D.2241
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2242,
	mov	r4, r1	@ D.2242,
	ldr	r0, .L37+8	@,
	mov	r2, r3	@, D.2242
	mov	r3, r4	@, D.2242
	bl	printf	@
	mov	r0, #30	@,
	bl	cos_cordic	@
	mov	r3, r0	@ D.2243,
	mov	r0, r3	@, D.2243
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2244,
	mov	r4, r1	@ D.2244,
	ldr	r0, .L37+12	@,
	mov	r2, r3	@, D.2244
	mov	r3, r4	@, D.2244
	bl	printf	@
	mov	r0, #90	@,
	bl	sin_cordic	@
	mov	r3, r0	@ D.2245,
	mov	r0, r3	@, D.2245
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2246,
	mov	r4, r1	@ D.2246,
	ldr	r0, .L37+16	@,
	mov	r2, r3	@, D.2246
	mov	r3, r4	@, D.2246
	bl	printf	@
	mov	r0, #4	@,
	mov	r1, #5	@,
	bl	arctan_div_cordic	@
	mov	r3, r0	@ D.2247,
	mov	r0, r3	@, D.2247
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2248,
	mov	r4, r1	@ D.2248,
	ldr	r0, .L37+20	@,
	mov	r2, r3	@, D.2248
	mov	r3, r4	@, D.2248
	bl	printf	@
	mov	r0, #2	@,
	bl	arctan_cordic	@
	mov	r3, r0	@ D.2249,
	mov	r0, r3	@, D.2249
	bl	fixed_to_float	@
	mov	r3, r0	@ D.2250,
	mov	r4, r1	@ D.2250,
	ldr	r0, .L37+24	@,
	mov	r2, r3	@, D.2250
	mov	r3, r4	@, D.2250
	bl	printf	@
	mov	r3, #0	@ D.2251,
	mov	r0, r3	@, <result>
	sub	sp, fp, #12	@,,
	ldmfd	sp!, {r4, r5, fp, lr}
	bx	lr
.L38:
	.align	2
.L37:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
