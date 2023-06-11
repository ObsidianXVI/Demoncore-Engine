part of demoncore;

typedef TileSpriteGenerator = TileSprite? Function(TilePosition);

class GameMap extends CanvasDescendant {
  final G2ControllableSpriteInstance activeSprite;
  final List<G2SpriteBlueprint> sprites;

  GameMap({
    required super.gameCanvas,
    required this.activeSprite,
    required this.sprites,
  });

  List<G2SpriteInstance> buildSprites() {
    return sprites.buildAll(gameCanvas, TilePosition.origin());
  }
}
