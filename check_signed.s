.section .data
signedCheckStr:       .asciz "Signed check:\n"
signedFmtAB:          .asciz "a = %lld\nb = %lld\n"
overflowSignedMsg:    .asciz "Overflow detected: signed\n"
noOverflowSignedMsg:  .asciz "No overflow detected. Operation Successful\n"

.section .text
.global check_signed
.extern printf

check_signed:
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

    // Print "Signed check:\n"
    LDR X0, =signedCheckStr
    BL printf

    // Print "a = %lld\nb = %lld\n"
    LDR X0, =signedFmtAB
    MOV X1, X19
    MOV X2, X20
    BL printf

    // Perform addition to set flags for signed overflow
    ADDS X8, X19, X20

    // Check for overflow
    BVS signed_overflow

    // If no overflow, print success message
    LDR X0, =noOverflowSignedMsg
    BL printf
    B exit

signed_overflow:
    // Print overflow message
    LDR X0, =overflowSignedMsg
    BL printf

exit:
    // Restore registers and return
    LDR X19, [SP, #16]
    LDR X20, [SP, #24]
    LDR X29, [SP]       
    LDR X30, [SP, #8]
    ADD SP, SP, #32          
    RET
