part of demoncore;

class ExtrudedStaticTileSprite extends StaticTileSprite with Physics {
  final GlobalKey globalKey = GlobalKey();
  ExtrudedStaticTileSprite({
    required super.baseImage,
    required super.gameCanvas,
    required super.tilePosition,
    super.key,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Channel.signalStream.listen((Signal signal) {
        if (signal.code == SignalCode.activeSpriteMoved) {
          final RenderBox spriteRenderBox =
              globalKey.currentContext?.findRenderObject() as RenderBox;
          final Size spriteSize = spriteRenderBox.size;
          final RenderBox activeSpriteRB = signal.context as RenderBox;
          final Size activeSpriteSize = activeSpriteRB.size;
          final currentPos = spriteRenderBox.localToGlobal(Offset.zero);
          final activeSpritePos = activeSpriteRB.localToGlobal(Offset.zero);

          final bool collision = (currentPos.dx <
                  activeSpritePos.dx + activeSpriteSize.width &&
              currentPos.dx + spriteSize.width > activeSpritePos.dx &&
              currentPos.dy < activeSpritePos.dy + activeSpriteSize.height &&
              currentPos.dy + spriteSize.height > activeSpritePos.dy);
          if (collision) {
            Channel.streamController
                .add(const Signal(code: SignalCode.spriteDetectedCollision));
          }
        }
      });
    });
  }

  @override
  StaticTileSpriteController createState() => StaticTileSpriteController();
}

class ExtrudedControllableSprite extends Sprite {
  final GlobalKey globalKey = GlobalKey();
  ExtrudedControllableSprite({
    required super.baseImage,
    required super.width,
    required super.height,
    required super.gameCanvas,
    super.key,
  });

  @override
  SpriteController<ExtrudedControllableSprite> createState() =>
      ExtrudedControllableSpriteController();
}

class ExtrudedControllableSpriteController
    extends SpriteController<ExtrudedControllableSprite> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
