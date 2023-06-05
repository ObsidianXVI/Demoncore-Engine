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
  final GameMap Function(GameCanvas) buildMap;

  const GameMapBuilder({
    required this.buildMap,
  });
}
