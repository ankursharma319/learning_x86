#include <iostream>
#include <string>

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
    std::cout << "Hello world " << x << "!!!" << std::endl;
    return 0;
}
