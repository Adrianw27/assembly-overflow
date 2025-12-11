#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Declare external assembly functions
extern void check_unsigned(uint64_t a, uint64_t b);
extern void check_signed(int64_t a, int64_t b);

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <num1> <num2>\n", argv[0]);
        return 1;
    }

    // Convert to unsigned 64-bit
    uint64_t ua = strtoull(argv[1], NULL, 10);
    uint64_t ub = strtoull(argv[2], NULL, 10);
    check_unsigned(ua, ub);

    // Convert to signed 64-bit
    int64_t sa = strtoll(argv[1], NULL, 10);
    int64_t sb = strtoll(argv[2], NULL, 10);
    check_signed(sa, sb);

    return 0;
}
