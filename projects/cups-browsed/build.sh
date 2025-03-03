#!/bin/bash -eu
export CC=${CC:-clang}
export CXX=${CXX:-clang++}
export CFLAGS="-fPIE -O0 -g -fno-omit-frame-pointer -fsanitize=address -I$SRC/cups-browsed/fuzzer/include"
export CXXFLAGS="-fPIE -O0 -g -fno-omit-frame-pointer -stdlib=libc++ -fsanitize=address -I$SRC/cups-browsed/fuzzer/include"
export LDFLAGS="-fsanitize=address"

# Build cups-browsed
./autogen.sh
./configure --enable-static --disable-shared
make -j$(nproc)

# Build fuzzer
cd fuzzer/
$CXX $CXXFLAGS -I../daemon fuzz_cups_browsed.cc -o $OUT/fuzz_cups_browsed \
    ../daemon/libcupsbrowsed.a -lcups -lcupsfilters -lppd -lglib-2.0 -lgobject-2.0

# Copy corpus (if present)
if [ -d "corpus_dir" ]; then
    cp corpus_dir/* $OUT/
fi

