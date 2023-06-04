part of demoncore;

typedef TileSpriteGenerator = StaticTileSprite? Function(TilePosition);

class GameMap extends CanvasDescendant {
  final int rows;
  final int cols;
  final Map<TilePosition, StaticTileSprite> tiles = {};

  GameMap({
    required super.gameCanvas,
    required this.rows,
    required this.cols,
    TileSpriteGenerator? tileSpriteGenerator,
  }) {
    if (tileSpriteGenerator != null) {
      D2RangeIterator(range1: cols, range2: rows).forEach((n1, n2) {
        final TilePosition tilePosition = TilePosition(n1, n2);
        final StaticTileSprite? tileSprite = tileSpriteGenerator(tilePosition);
        if (tileSprite != null) {
          tiles.addAll({
            tilePosition: tileSprite,
          });
        }
      });
    }
  }
}
