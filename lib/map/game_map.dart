part of demoncore;

typedef TileSpriteGenerator = TileSprite? Function(TilePosition);

class GameMap extends CanvasDescendant {
  final ExtrudedControllableSpriteInstance activeSprite;
  final List<SpriteInstance> layers;

  GameMap({
    required super.gameCanvas,
    required this.activeSprite,
    required this.layers,
  });
}
