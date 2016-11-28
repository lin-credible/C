template <class Iterator, class Act, class Test>
void process(Iterator begin, Iterator end, Act act, Test test) {
  for (; begin != end; ++begin) {
    if (test(*begin)) {
      act(*begin);
    }
  }
}
