part of demoncore;

abstract class Vector<T> {
  final List<T> values;
  final int dimensions;

  const Vector(this.values, {required this.dimensions});
}

class Vector2D extends Vector {
  const Vector2D(super.values) : super(dimensions: 2);
}
