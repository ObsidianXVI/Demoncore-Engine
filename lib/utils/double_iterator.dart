part of demoncore;

class D2ListIterator<T> {
  final List<List<T>> matrix;

  const D2ListIterator({
    required this.matrix,
  });

  void perform(void Function(T) iteratorFn) {
    for (List<T> ls in matrix) {
      for (int i = 0; i < ls.length; i++) {
        iteratorFn(ls[i]);
      }
    }
  }
}

class D2RangeIterator {
  final int range1;
  final int range2;

  D2RangeIterator({
    required this.range1,
    required this.range2,
  });

  void forEach(void Function(int n1, int n2) iteratorFn) {
    for (int i = 0; i < range1; i++) {
      for (int j = 0; j < range2; j++) {
        iteratorFn(i, j);
      }
    }
  }
}
