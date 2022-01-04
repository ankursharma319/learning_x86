#include <iostream>

extern "C" int my_func();

int main() {
    int x = my_func();
    std::cout << "Hello world " << x << "!!!" << std::endl;
    return 0;
}
