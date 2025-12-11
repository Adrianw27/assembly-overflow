.section .data
unsignedCheckStr:       .asciz "Unsigned check:\n"
unsignedFmtAB:          .asciz "a = %llu\nb = %llu\n"
overflowUnsignedMsg:    .asciz "Overflow detected: unsigned\n"
noOverflowUnsignedMsg:  .asciz "No overflow detected. Operation Successful\n"

.section .text
.global check_unsigned
.extern printf

check_unsigned:
    // Save FP and LR, allocate space
    SUB SP, SP, #32
    STR X29, [SP, #0]
    STR X30, [SP, #8]
    STR X19, [SP, #16]
    STR X20, [SP, #24]
    MOV X29, SP

    // Save a and b
    MOV X19, X0
    MOV X20, X1

    // Print "Unsigned check:\n"
    LDR X0, =unsignedCheckStr
    BL printf
    
    // Print "a = %llu\nb = %llu\n"
    LDR X0, =unsignedFmtAB
    MOV X1, X19
    MOV X2, X20
    BL printf

    // Perform the addition to set flags for unsigned overflow
    ADDS X8, X19, X20

    // Check for carry flag
    BCS unsigned_overflow

    // If no carry, print success message
    LDR X0, =noOverflowUnsignedMsg
    BL printf
    B exit

unsigned_overflow:
    // Print overflow message
    LDR X0, =overflowUnsignedMsg
    BL printf

exit:
    // Restore registers and return
    LDR X19, [SP, #16]
    LDR X20, [SP, #24]
    LDR X29, [SP]
    LDR X30, [SP, #8]
    ADD SP, SP, #32
    RET
