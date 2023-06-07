part of demoncore;

class ExtrudedStaticTileSpriteInstance extends StaticTileSpriteInstance
    with Physics {
  final ExtrudedStaticTileSprite extrudedStaticTileSpriteBP;
  ExtrudedStaticTileSpriteInstance({
    required this.extrudedStaticTileSpriteBP,
    required super.gameCanvas,
    required super.tilePosition,
    super.key,
  }) : super(spriteBlueprint: extrudedStaticTileSpriteBP) {
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.activeSpriteMoved) {
        final GlobalKey? globalKey = key as GlobalKey?;
        final RenderBox? spriteRenderBox = getRenderBox();
        if (spriteRenderBox == null) return;
        final Size spriteSize = spriteRenderBox.size;
        final RenderBox? activeSpriteRB = signal.context as RenderBox?;
        if (activeSpriteRB == null) return;
        final Size activeSpriteSize = activeSpriteRB.size;
        final currentPos = spriteRenderBox.localToGlobal(Offset.zero);
        final activeSpritePos = activeSpriteRB.localToGlobal(Offset.zero);

        final bool collision =
            (currentPos.dx < activeSpritePos.dx + activeSpriteSize.width &&
                currentPos.dx + spriteSize.width > activeSpritePos.dx &&
                currentPos.dy < activeSpritePos.dy + activeSpriteSize.height &&
                currentPos.dy + spriteSize.height > activeSpritePos.dy);
        if (collision) {
          Channel.streamController
              .add(const Signal(code: SignalCode.spriteDetectedCollision));
        }
      }
    });
  }

  RenderBox? getRenderBox() =>
      globalKey.currentContext?.findRenderObject() as RenderBox?;

  @override
  StaticTileSpriteController createState() => StaticTileSpriteController();
}

class ExtrudedControllableSpriteInstance extends SpriteInstance {
  final GlobalKey globalKey = GlobalKey();
  final TilePosition tilePosition;
  final ControllableSprite controllableSpriteBP;

  ExtrudedControllableSpriteInstance({
    required this.tilePosition,
    required this.controllableSpriteBP,
    required super.gameCanvas,
    super.key,
  }) : super(
          spriteBlueprint: controllableSpriteBP,
          width: controllableSpriteBP.width,
          height: controllableSpriteBP.height,
        );

  RenderBox? getRenderBox() =>
      globalKey.currentContext?.findRenderObject() as RenderBox?;
  @override
  SpriteController<ExtrudedControllableSpriteInstance> createState() =>
      ExtrudedControllableSpriteController();
}

class ExtrudedControllableSpriteController
    extends SpriteController<ExtrudedControllableSpriteInstance> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
