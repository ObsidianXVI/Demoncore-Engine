part of demoncore;

abstract class G2SpriteBlueprint<S extends G2SpriteInstance> {
  final RelativeTilePosition position;
  final AssetImage assetImage;
  final SpriteRadius spriteRadius;
  final SpriteRadius physicsRadius;

  G2SpriteBlueprint({
    required this.assetImage,
    required this.position,
    required this.spriteRadius,
    required this.physicsRadius,
  });

  TilePosition absPos(TilePosition origin) => position.makeAbsolue(origin);

  S render(GameCanvas gameCanvas, TilePosition origin);
}

class G2ExtrudedSprite extends G2SpriteBlueprint<G2ExtrudedSpriteInstance> {
  G2ExtrudedSprite({
    required super.assetImage,
    required super.position,
    required super.spriteRadius,
    required super.physicsRadius,
  });

  @override
  G2ExtrudedSpriteInstance render(GameCanvas gameCanvas, TilePosition origin) {
    return G2ExtrudedSpriteInstance(
      physicsRadius: physicsRadius,
      gameCanvas: gameCanvas,
      spriteBlueprint: this,
      spriteRadius: spriteRadius,
    );
  }
}

class G2ControllableSprite
    extends G2SpriteBlueprint<G2ControllableSpriteInstance> {
  G2ControllableSprite({
    required super.assetImage,
    required super.position,
    required super.spriteRadius,
    required super.physicsRadius,
  });

  @override
  G2ControllableSpriteInstance render(
      GameCanvas gameCanvas, TilePosition origin) {
    return G2ControllableSpriteInstance(
      gameCanvas: gameCanvas,
      spriteBlueprint: this,
      spriteRadius: spriteRadius,
      physicsRadius: physicsRadius,
    );
  }
}
