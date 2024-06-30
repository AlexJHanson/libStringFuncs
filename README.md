# String Library written in assembly language 
<span style="font-size:20px; font-weight: bold;">x86_64 &nbsp;&nbsp; Architecture &nbsp;&nbsp;Linux Ubuntu </span>

## Interface &nbsp;&nbsp;<StringFuncs.h>

__int toUpper(char *src, char *dest)__

Converts lowercase alpha chars in C-Style string, whose first character is at memory location src, to uppercase. The resulting string is stored in dest

Returns the number of lowercase char code-points processed.

*__NOTE:__* *Caller is responsible for allocating enough memory for storage in destination!*

__int toLower(char *src, char *dest)__

Converts uppercase alpha chars in C-Style string, whose first character is at memory location src, to lowercase. The resulting string is stored in dest

Returns the number of uppercase char code-points processed.

*__NOTE:__* *Caller is responsible for allocating enough memory for storage in destination!*

__int flipCase(char *src, char *dest)__

Stores the flipped case of each alphabetic character from source in destination

Returns the number of alphabetic code-points processed.

*__NOTE:__* *Caller is responsible for allocating enough memory for storage in destination!*

## Using the library

provided as libStringFuncs.so 

gcc link command *__-lStringFuncs__* 

## Dependencies
Depends on libIOlibrary.so | @ https://github.com/AlexJHanson/AssemblyIOLib