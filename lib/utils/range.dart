part of demoncore;

class Range<T> {
  final T start;
  final T end;

  /// [start] and ][end] inclusive
  const Range(this.start, this.end);
}

class PositionRange extends Range<Vector2D> {
  const PositionRange(super.start, super.end);
}
