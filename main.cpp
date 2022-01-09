#include <iostream>
#include <string>
#include <climits>

class MyClass {
public:
    MyClass() : x(10), y(20), z(30.5) {}
    void modify() {
        x = 5;
    }
private:
    int x;
    long y;
    float z;
};

extern "C" int my_func(int a, float b, bool c, char * d, int e, MyClass myClass, MyClass* ptr, std::string f);

int main() {
    std::string s = "MY STRING";
    char c[] = "MY CHAR";
    MyClass mycl;
    int x = my_func(91, -78.9, true, c, 909, mycl, &mycl, s);
    std::cout << "sizeof(unsigned long long) = " << sizeof(unsigned long long) << std::endl;
    std::cout << "sizeof(unsigned long) = " << sizeof(unsigned long) << std::endl;
    std::cout << "sizeof(unsigned int) = " << sizeof(unsigned int) << std::endl;
    std::cout << "INT_MAX = " << INT_MAX << std::endl;
    std::cout << "LONG_MAX = " << LONG_MAX << std::endl;
    std::cout << "Hello world " << x << "!!!" << std::endl;
    return 0;
}

// (long x) > 99.5 -- both are converted to 64bit float and compared
// 99.5 is stored as a 64 bit long whose bit interpretation is same as float64 99.5

// (float x) > 99.5 -- both are converted 32bit float and compared
// 99.5 is stored as a 64 bit long whose bit interpretation is same as float32 99.5
// first 32 bits of the stored long are 0

// (int x) > 99.5 -- optimized away to compare with the literal 99 - 
// the literal 99 can be interpreted as any of signed int, unsigned int,
// signed long, unsigned long, etc. because the bit representation is same

// (int x) > 99 -- compared with literal 99
// (unsigned long x) > 99 -- compared with literal 99
// (signed long x) > 99 -- compared with literal 99

// (signed long x) > -99 -- compared with literal -98
// (signed int x) > -99 -- compared with literal -98
// (int x) > -99 -- compared with literal -98 - same as signed int x

// (unsigned int x) > -99 -- compiler warning - but compared with literal -99
// (unsigned long x) > -99 -- compiler warning - but compared with literal -99

// MAX_INT = 2147483647, MAX_LONG = 9223372036854775807
// (int x) > 214748364789 -- optimized away to return false always
// (int x) > -214748364789 -- optimized away to return true always
// (long x) > -214748364789 -- compared with literal -214748364789
// (long x) > 9223372036854775807 -- optimized away to return false always
// (long x) > 9223372036854775810 -- produces a warning and compares with literal -9223372036854775806 (overflowed)

// (unsigned char x) > 99 -- compared with literal 99
// (signed char x) > 99 -- compared with literal 99
// (signed char x) > -99 -- compared with literal -98
// (unsigned char x) > -99 -- optimized away to return true, no warning
// (unsigned char x) > 255 -- optimized away to return false, no warning
// (unsigned char x) > 254 -- compared with literal -1

// (float x) > 8985.8784786456464563445365434654345654356543465435463445634565435654456543456543465443654365435654345434554636535463
// stores two longs - 
//	.long	1912405669 = 0111 0001 1111 1100 1111 1110 1010 0101 
//	.long	1086426352 = 0100 0000 1100 0001 1000 1100 1111 0000
// the bit representations of these translate to
// 0100 0000 1100 0001 1000 1100 1111 0000 0111 0001 1111 1100 1111 1110 1010 0101
// in 64 bit fp, this is = 8.9858784786456471920246258378E3
// converts x to double precision and compares with the one above

// (signed int x) > (unsigned int y) - gives warning - compares raw bits without any conversion
// (signed int x) > (signed long y) - converts both to signed long and compares
// (signed int x) > (float y) - converts both to float and compares
// (signed char x) > (unsigned long y) - gives warning - sign extends char to long and compares (movsx	rdi, dil)
// (unsigned char x) > (signed long y) - no warning - zero extends char to long and compares

//#pragma GCC push_options
//#pragma GCC optimize ("O0")
bool compare(unsigned int a) {
    return a > 99;
}
//#pragma GCC pop_options

// converting from unsigned char to int using implicit conversion and static_cast
// produces the same assembly code
// movzx	eax, dil
// i.e. - just pad the bits with 0s til its 32 bits and reinterpret the bits as int

// converting from signed char to int using implicit conversion and static_cast
// produces the same assembly code
// movsx	eax, dil
// i.e. - just pad the bits with 0s or 1s (depending on the sign of original value)
// til its 32 bits and reinterpret the bits as int

// when converting to long, its - movsx	rax, dil

// converting from int to unsigned char using implicit conversion and static_cast
// produces the same assembly code
// mov	eax, edi
// if the int is smaller than 8 bits, just a simple reinterpret
// if int is bigger than 8 bits, only reinterpret first 8 bits
// for e.g. 266 is 0001 0000 1010, first 8 bits represent 10
// so just wraps around basically, kind of doing a modulo

unsigned char convert(int x) {
    unsigned char a = static_cast<unsigned char>(x);
    return a;
}
