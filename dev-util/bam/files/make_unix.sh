#!/bin/sh
TXT2C=src/tools/txt2c

echo gcc ${CFLAGS} src/tools/txt2c.c -o ${TXT2C}
gcc ${CFLAGS} src/tools/txt2c.c -o ${TXT2C} || exit 1

echo ${TXT2C} src/base.bam src/driver_gcc.bam src/driver_cl.bam \> src/internal_base.h
${TXT2C} src/base.bam src/driver_gcc.bam src/driver_cl.bam > src/internal_base.h || exit 1

echo gcc ${CFLAGS} src/*.c -o src/bam -lm -lpthread -llua
gcc ${CFLAGS} src/*.c -o src/bam -lm -lpthread -llua || exit 1
