part of demoncore;

class AnimatedTileSpriteInstance extends TileSpriteInstance {
  final AnimatedTileSprite animatedTileSpriteBP;
  AnimatedTileSpriteInstance({
    required this.animatedTileSpriteBP,
    required super.gameCanvas,
    required super.tilePosition,
    super.key,
  }) : super(
          spriteBlueprint: animatedTileSpriteBP,
        );

  @override
  AnimatedTileSpriteState createState() => AnimatedTileSpriteState();
}

class AnimatedTileSpriteState
    extends SpriteController<AnimatedTileSpriteInstance> {
  late Timer frameChangeTimer;

  @override
  void initState() {
    frameChangeTimer = Timer.periodic(const Duration(seconds: 500), (timer) {
      widget.animatedTileSpriteBP.spriteFrames.advance();
    });
    super.initState();
  }

  @override
  void dispose() {
    frameChangeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.tilePosition.rowNum * widget.gameCanvas.tileSize,
      left: widget.tilePosition.colNum * widget.gameCanvas.tileSize,
      width: widget.width * widget.gameCanvas.camera.zoomLevel,
      height: widget.height * widget.gameCanvas.camera.zoomLevel,
      child: Image(
        image: widget.animatedTileSpriteBP.spriteFrames.currentValue,
        fit: BoxFit.cover,
        width: widget.width * widget.gameCanvas.camera.zoomLevel,
        height: widget.height * widget.gameCanvas.camera.zoomLevel,
      ),
    );
  }
}
