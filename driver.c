#include <libIO.h>
#include <StringFuncs.h>
#define MAX 50

int main() {

    char text[MAX];
    char dest[MAX];

    writeStr("Enter up to 50 alphabetic characters: ");
    readLn(text, MAX);

    flipCase(text, dest);

    writeStr("Case flipped: ");
    writeStr(dest);
    writeStr("\n");

    toUpper(text, dest);

    writeStr("All upper: ");
    writeStr(dest);
    writeStr("\n");

    toLower(text, dest);

    writeStr("All lower: ");
    writeStr(dest);
    writeStr("\n");

    return 0;
}