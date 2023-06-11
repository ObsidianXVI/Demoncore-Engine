part of demoncore;

abstract class MapComponent {
  const MapComponent();

  List<G2SpriteBlueprint> createBlueprints();
}

class OffsetComponent extends MapComponent {
  final MapComponent child;
  final int top;
  final int left;

  const OffsetComponent({
    required this.child,
    this.top = 0,
    this.left = 0,
  });

  @override
  List<G2SpriteBlueprint> createBlueprints() {
    return child.createBlueprints().map((G2SpriteBlueprint bp) {
      return bp..position.translate([-left, -top]);
    }).toList();
  }
}

class Rectangle extends MapComponent {
  final G2SpriteBlueprint spriteBlueprint;
  final int width;
  final int height;

  const Rectangle({
    required this.spriteBlueprint,
    required this.width,
    required this.height,
  });

  @override
  List<G2SpriteBlueprint> createBlueprints() {
    final List<G2SpriteBlueprint> spriteBlueprints = [];
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        spriteBlueprints.add(
          spriteBlueprint..position.translate([i, j]),
        );
      }
    }

    return spriteBlueprints;
  }
}
