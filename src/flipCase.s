# flipCase.s
# Flips each char in src array to opposite case and stores result in dest array
# Input:
#   rdi <- (char*) src char array
#   rsi <- (char*) dest char array
# Returns:
#   int number of alphabetic chars processed
        .intel_syntax   noprefix
# Constants
        .equ    MASK, 0x20      # 0xff = 0010 0000 use with XOR to flip bit 5
        .equ    A,    0x41      # ASCII A
        .equ    Z,    0x5A      # ASCII Z
        .equ    a,    0x61      # ASCII a
        .equ    z,    0x7A      # ASCII z
        .equ    NULL, 0x00     
# Code
        .text
        .globl flipCase
        .type  flipCase, @function
flipCase:
        push    rbp             # Prologue
        mov     rbp, rsp

        mov     eax, 0          # Initialize return value- num alpha chars processed
        mov     edx, 0          # zero out data reg
while:
        mov     dl, [rdi]       # Load next character 

        cmp     dl, NULL        # While not NULL
        je      end

        cmp     dl, A           # Skip processing if code point < lowest char code point
        jl      continue

        cmp     dl, z           # Skip processing if code pont > highest char code point
        jg      continue

        cmp     dl, Z           # Char is uppercase, process it
        jle      process

        cmp     dl, a           # Char is lowercase, process it
        jge      process

        jmp     continue        # Not an alpha char, skip processing
process:
        xor     dl, MASK        # If char is alpha, flip its case
        add     eax, 1          # Increment num chars processed 
continue:
        mov     [rsi], dl       # Store in dest
        add     rdi, 1          # Increment pointers
        add     rsi, 1          # Loop back to top of while
        jmp     while
end:
        mov     [rsi], dl       # NULL terminate dest array
        pop     rbp             # Epilogue 
        ret 

