#!/bin/ash

awk -f sigconv.awk /usr/include/asm-generic/signal.h > sigdesc.h

