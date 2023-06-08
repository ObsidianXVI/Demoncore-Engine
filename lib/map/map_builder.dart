part of demoncore;

/// Allow [GameMap]s to be created through a Flutter-like model
/// e.g:
///   Center(
///     Island(
///       Align(
///         alignment: left,
///         sprite: House()
///       )
///     )
///   );

class GameMapBuilder {
  final MapComponent map;
  final ExtrudedControllableSprite controllableSprite;
  late List<SpriteBlueprint> blueprints;

  GameMapBuilder({
    required this.map,
    required this.controllableSprite,
  }) {
    blueprints = map.createBlueprints();
  }

  GameMap buildMap(GameCanvas gameCanvas) {
    final TilePosition origin = TilePosition(0, 0);
    final List<SpriteInstance> sprites =
        blueprints.map((e) => e.render(gameCanvas, origin)).toList();

    return GameMap(
      gameCanvas: gameCanvas,
      activeSprite: controllableSprite.render(gameCanvas, origin),
      layers: sprites,
    );
  }
}


