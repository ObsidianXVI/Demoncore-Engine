part of demoncore;

abstract class Matrix<T> {
  final int rows;
  final int cols;
  final List<List<T>> values;

  const Matrix({
    required this.rows,
    required this.cols,
    required this.values,
  });
}

class AreaMatrix extends Matrix<double> {
  final double x1, x2, y1, y2;
  AreaMatrix({
    required this.x1,
    required this.x2,
    required this.y1,
    required this.y2,
  }) : super(
          rows: 2,
          cols: 2,
          values: [
            [x1, y1],
            [x2, y2],
          ],
        );

  AreaMatrix translate(Offset offset) {
    final double nx1, nx2, ny1, ny2;
    if (offset.dx > 0) {
      // save x1
      nx1 = x1;
      nx2 = x2 + offset.dx;
    } else {
      // save x2
      nx2 = x2;
      nx1 = x1 + offset.dx;
    }
    if (offset.dy > 0) {
      // save y1
      ny1 = y1;
      ny2 = y2 + offset.dy;
    } else {
      // save y2
      ny2 = y2;
      ny1 = y1 + offset.dy;
    }

    return AreaMatrix(
      x1: nx1,
      x2: nx2,
      y1: ny1,
      y2: ny2,
    );
  }

  Offset? checkForOverlap(
    AreaMatrix other,
    Offset translationVector,
  ) {
    bool isOverlapping = false;
    Offset adjustedOffset = Offset.zero;
    // active body moving to the left
    if (translationVector.dx < 0) {
      if (x1.isBetweenOrOn(other.x1, other.x2)) {
        isOverlapping = true;
        adjustedOffset += Offset(other.x2 - x1, 0);
      }
    } else if (translationVector.dx > 0) {
      if (x2.isBetweenOrOn(other.x1, other.x2)) {
        isOverlapping = true;
        adjustedOffset += Offset(other.x1 - x2, 0);
      }
    }

    // active body moving downwards
    if (translationVector.dy < 0) {
      if (y1.isBetweenOrOn(other.y1, other.y2)) {
        isOverlapping = true;
        adjustedOffset += Offset(0, other.y2 - y1);
      }
    } else if (translationVector.dy > 0) {
      if (y2.isBetweenOrOn(other.y1, other.y2)) {
        isOverlapping = true;
        adjustedOffset += Offset(0, other.y1 - y2);
      }
    }

    if (isOverlapping) {
      return adjustedOffset;
    } else {
      return null;
    }
  }
}
