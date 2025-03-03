#include <cups/cups.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <cstdint>
#include <cstddef>

extern "C" {
#include "cups-browsed.h"  // Header declares invalidate_default_printer(int)
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
    if (Size < 1) return 0;

    // Convert first byte to 0 or 1
    int local = Data[0] % 2;

    // Call the function (C linkage ensured via header)
    invalidate_default_printer(local);

    return 0;
}