part of demoncore;

class Loop<T> {
  final Iterable<T> values;
  int iterator = 0;

  Loop(this.values);

  T get currentValue => values.elementAt(iterator);

  T advance() {
    iterator += 1;
    if (iterator == values.length) {
      iterator = 0;
    }
    return currentValue;
  }
}
