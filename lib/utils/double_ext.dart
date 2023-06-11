part of demoncore;

extension DoubleUtils on double {
  bool isBetween(double lower, double upper) {
    return (lower < this) && (this < upper);
  }

  bool isBetweenOrOn(double lower, double upper) {
    return (lower <= this) && (this <= upper);
  }
}
