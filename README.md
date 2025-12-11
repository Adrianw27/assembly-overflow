# Computer Architecture Assignment — ARM64 Overflow Checker

This assignment explores how **overflow flags** work in ARM64 assembly.  
You will write a C program (`overflow.c`) that calls two external assembly functions to detect **signed** and **unsigned** overflow during addition.

---

## Overview

In ARM64, arithmetic operations update condition flags that can be used to detect overflow.  
You will write two ARM64 functions to check:

- **Unsigned overflow** using the `BCS` (Carry Set) flag  
- **Signed overflow** using the `BVS` (Overflow Set) flag

These functions are implemented in **separate assembly files** and called from C.

---

## Required Function Signatures

Declare these functions in `overflow.c`:

\`\`\`c
void check_unsigned(uint64_t a, uint64_t b);
void check_signed(int64_t a, int64_t b);
\`\`\`

Each assembly function must be implemented in its **own `.S` file**.

---

## C Program Requirements (`overflow.c`)

1. Read two command-line arguments: `a` and `b`
2. Convert them using:
   - `strtoull()` → convert to `uint64_t`, pass to `check_unsigned`
   - `strtoll()` → convert to `int64_t`, pass to `check_signed`
3. Call both assembly functions
4. Each assembly function prints:
   - The arguments `a` and `b`
   - The result of `a + b`
   - Whether overflow occurred

> Note: `strtoull` will reinterpret negative inputs as very large unsigned numbers.

---

## Assembly Function Requirements

### `check_unsigned(a, b)`

- Print values `a` and `b`
- Perform `ADD x0, x0, x1`
- Check **unsigned overflow** using:
  - `BCS overflow_label`
- Print messages matching the sample output
- Must save and restore **LR** on the stack

### `check_signed(a, b)`

- Print values `a` and `b`
- Perform `ADD x0, x0, x1`
- Check **signed overflow** using:
  - `BVS overflow_label`
- Print messages matching the sample output
- Must save and restore **LR** on the stack
