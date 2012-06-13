#!/bin/sh
type="prod"

cmake ../ -DCMAKE_C_FLAGS="-m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -march=native -O3 -pipe -msse3 -fno-strength-reduce -fno-delete-null-pointer-checks -fno-strict-aliasing -frename-registers -mfpmath=sse -fomit-frame-pointer -funroll-loops -ffast-math -floop-interchange -floop-strip-mine -ftree-loop-distribution -ftree-vectorize" -DCMAKE_CXX_FLAGS="${CMAKE_C_FLAGS}" -DMAKEOPTS="-j8" -DLARGE_CELL=0 -DPREFIX=/home/trinity/core/$type
