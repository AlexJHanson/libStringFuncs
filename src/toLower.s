# toLower.s
# Converts uppercase chars in src array to lowercase and stores them in dest array
# Input:
#   rdi <- (char *) address to src
#   rsi <- (char *) address to dest
# Return:
#   int number of uppercase alphabetic chars processed
        .intel_syntax   noprefix
# Constants
        .equ    MASK,  0x20           # 0x20 = 0010 0000 used with OR to set bit 5 (0 offset)
        .equ    NULL,  0x00
        .equ    A,     0x41           # ASCII A
        .equ    Z,     0x5A           # ASCII Z    
# Code
        .text
        .globl  toLower
        .type   toLower, @function
toLower:
        push    rbp                   # Prologue
        mov     rbp, rsp              # Save caller's frame pointer and establish new one

        mov     eax, 0                # Initialize return value- count
        mov     edx, 0                # Zero data reg
while:
        mov     dl, [rdi]             # Get character from source

        cmp     dl, NULL              # While not NULL 
        je      end

        cmp     dl, A                 # Skip if char is < A code point
        jl      continue

        cmp     dl, Z                 # Skip if char is > Z code point
        jg      continue

        or      dl, MASK              # Or with 0x20 to turn bit 5 on 
        add     eax, 1
continue:
        mov     [rsi], dl             # Store all chars, processed or not, in dest array.
        add     rdi, 1                # Increment pointers
        add     rsi, 1

        jmp     while
end:
        mov     [rsi], dl             # NULL terminate destination string
        pop     rbp                   # Epilogue 
        ret

