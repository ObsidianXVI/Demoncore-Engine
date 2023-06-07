part of demoncore;

abstract class SpriteBlueprint<S extends SpriteInstance> {
  final RelativeTilePosition position;
  final AssetImage assetImage;

  SpriteBlueprint({
    required this.assetImage,
    required this.position,
  });

  TilePosition absPos(TilePosition origin) => position.makeAbsolue(origin);

  S render(GameCanvas gameCanvas, TilePosition origin);
}

abstract class StaticSprite extends SpriteBlueprint<StaticSpriteInstance> {
  final double width;
  final double height;

  StaticSprite({
    required super.assetImage,
    required super.position,
    required this.width,
    required this.height,
  });
}

abstract class TileSprite<S extends TileSpriteInstance>
    extends SpriteBlueprint<S> {
  TileSprite({
    required super.assetImage,
    required super.position,
  });
}

class StaticTileSprite extends SpriteBlueprint<StaticTileSpriteInstance> {
  StaticTileSprite({
    required super.assetImage,
    required super.position,
  });

  @override
  StaticTileSpriteInstance render(GameCanvas gameCanvas, TilePosition origin) {
    return StaticTileSpriteInstance(
      tilePosition: absPos(origin),
      spriteBlueprint: this,
      gameCanvas: gameCanvas,
    );
  }
}

abstract class ControllableSprite<T extends SpriteInstance>
    extends SpriteBlueprint<T> {
  final double width;
  final double height;

  ControllableSprite({
    required super.assetImage,
    required super.position,
    required this.width,
    required this.height,
  });
}

class ExtrudedControllableSprite
    extends ControllableSprite<ExtrudedControllableSpriteInstance> {
  ExtrudedControllableSprite({
    required super.assetImage,
    required super.position,
    required super.width,
    required super.height,
  });

  @override
  ExtrudedControllableSpriteInstance render(
      GameCanvas gameCanvas, TilePosition origin) {
    return ExtrudedControllableSpriteInstance(
      tilePosition: absPos(origin),
      controllableSpriteBP: this,
      gameCanvas: gameCanvas,
    );
  }
}

class ExtrudedStaticTileSprite
    extends ControllableSprite<ExtrudedStaticTileSpriteInstance> {
  ExtrudedStaticTileSprite({
    required super.assetImage,
    required super.position,
    required super.width,
    required super.height,
  });

  @override
  ExtrudedStaticTileSpriteInstance render(
      GameCanvas gameCanvas, TilePosition origin) {
    return ExtrudedStaticTileSpriteInstance(
      extrudedStaticTileSpriteBP: this,
      gameCanvas: gameCanvas,
      tilePosition: absPos(origin),
    );
  }
}

class AnimatedTileSprite extends TileSprite<AnimatedTileSpriteInstance> {
  final Loop<AssetImage> spriteFrames;

  AnimatedTileSprite({
    required this.spriteFrames,
    required super.assetImage,
    required super.position,
  });

  @override
  AnimatedTileSpriteInstance render(
      GameCanvas gameCanvas, TilePosition origin) {
    return AnimatedTileSpriteInstance(
      animatedTileSpriteBP: this,
      gameCanvas: gameCanvas,
      tilePosition: absPos(origin),
    );
  }
}
