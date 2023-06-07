part of demoncore;

class RelativeTilePosition {
  final int rowNum;
  final int colNum;

  RelativeTilePosition(this.colNum, this.rowNum);

  operator +(List<int> translationVector) {
    return RelativeTilePosition(
      colNum + translationVector.elementAt(0),
      rowNum + translationVector.elementAt(1),
    );
  }

  TilePosition makeAbsolue(TilePosition tilePosition) {
    return tilePosition + [colNum, rowNum];
  }
}

class TilePosition {
  final int rowNum;
  final int colNum;

  TilePosition(this.colNum, this.rowNum);

  operator +(List<int> translationVector) {
    return TilePosition(
      colNum + translationVector.elementAt(0),
      rowNum + translationVector.elementAt(1),
    );
  }
}
