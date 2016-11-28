#include <iostream>
#include "process.h"

using namespace std;

bool notDigit(char c) {
  return (c < '0') || (c > '9');
}

void printNondigit(char c) {
  cout << c << " is not a number string" << endl;
}

int main() {
  process(istream_iterator<char>(cin), istream_iterator<char>(), printNondigit, notDigit);
  return 0;
}
