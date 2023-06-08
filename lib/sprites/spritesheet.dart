part of demoncore;

class Spritesheet<S extends SpriteBlueprint, T extends TilePosition> {
  final List<T> positions;
  final List<S> sprites;

  const Spritesheet({
    required this.positions,
    required this.sprites,
  });

  bool positionExists(T position) => positions.contains(position);
}
