#include <iostream>

using namespace std;

template <int N>
struct factorial {
  enum {value = N * factorial<N - 1>::value};
};

template <>
struct factorial<0> {
  enum {value = 1};
};

int main() {
  cout << factorial<5>::value << endl;
  return 0;
}

