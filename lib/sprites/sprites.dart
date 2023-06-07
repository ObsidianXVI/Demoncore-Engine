part of demoncore;

abstract class SpriteInstance extends CameraDependent implements DCObject {
  @override
  final String id = ID.generate('sprite');
  @override
  final String label = 'sprite';
  final AssetImage baseImage;
  final GameCanvas gameCanvas;
  final SpriteBlueprint spriteBlueprint;

  SpriteInstance({
    required this.spriteBlueprint,
    required this.gameCanvas,
    required super.width,
    required super.height,
    super.key,
  })  : baseImage = spriteBlueprint.assetImage,
        super(
          camera: gameCanvas.camera,
          child: Image(
            image: spriteBlueprint.assetImage,
            fit: BoxFit.cover,
          ),
        );

  @override
  SpriteController createState();
}

abstract class SpriteController<S extends SpriteInstance>
    extends CameraDependentState<S> {
  SpriteController();

  @override
  void initState() {
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.cameraZoomChanged) {
        setState(() {});
      }
    });
    super.initState();
  }
}

abstract class TileSpriteInstance extends SpriteInstance {
  final TilePosition tilePosition;
  TileSpriteInstance({
    required this.tilePosition,
    required super.gameCanvas,
    required super.spriteBlueprint,
    super.key,
  }) : super(
          width: gameCanvas.tileSize,
          height: gameCanvas.tileSize,
        );
}

abstract class StaticSpriteInstance extends SpriteInstance {
  final StaticSprite staticSpriteBP;
  StaticSpriteInstance({
    required this.staticSpriteBP,
    required super.gameCanvas,
    super.key,
  }) : super(
          spriteBlueprint: staticSpriteBP,
          width: staticSpriteBP.width,
          height: staticSpriteBP.height,
        );
}
