# toUpper.s
# Converts lowercase ASCII alpabetic characters to uppercase
# Input:
#       rdi <- (char *) src char array
#       rsi <- (char *) dest char array
# Return:
#       int count of characters processed
        .intel_syntax   noprefix
# Constants
        .equ    MASK,  0xdf           # Bit mask to set bit 5 (1st bit is bit 0) to 0 | 1101 1111
        .equ    NULL,  0x00
        .equ    a,     0x61           # ASCII a
        .equ    z,     0x7A           # ASCII z  
# Code
        .text
        .globl toUpper
        .type  toUpper, @function    
toUpper:
        push    rbp                   # Prologue
        mov     rbp, rsp

        mov     eax, 0                # Initialiize return value (count)
        mov     edx, 0                # Zero data reg, working with first byte will not zero
while:
        mov     dl, [rdi]             # Get character from source

        cmp     dl, NULL              # While condtion: NOT NULL
        je      end

        cmp     dl, a                 # Code point < 0x61? Skip
        jl      continue                

        cmp     dl, z                 # Code point > 0x7A? skip
        jg      continue  
     
        and     dl, MASK              # Convert byte to uppercase format
        add     eax, 1                # Count only lowercase alpha chars processed
continue:
        mov     [rsi], dl             # Store all chars, processed or not, in dest array.
        add     rdi, 1                # Increment addresses and return to top
        add     rsi, 1

        jmp     while
end:
        mov    [rsi], dl              # NULL terminate destination char array with src NULL
        pop     rbp
        ret
