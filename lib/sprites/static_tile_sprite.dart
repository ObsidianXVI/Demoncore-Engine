part of demoncore;

class StaticTileSpriteInstance extends TileSpriteInstance {
  final GlobalKey globalKey = GlobalKey();

  StaticTileSpriteInstance({
    required super.tilePosition,
    required super.spriteBlueprint,
    required super.gameCanvas,
    super.key,
  });

  @override
  StaticTileSpriteController createState() => StaticTileSpriteController();
}

class StaticTileSpriteController
    extends SpriteController<StaticTileSpriteInstance> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.tilePosition.rowNum * widget.gameCanvas.tileSize,
      left: widget.tilePosition.colNum * widget.gameCanvas.tileSize,
      width: widget.width * widget.gameCanvas.camera.zoomLevel,
      height: widget.height * widget.gameCanvas.camera.zoomLevel,
      child: Image(
        image: widget.baseImage,
        fit: BoxFit.cover,
        width: widget.width * widget.gameCanvas.camera.zoomLevel,
        height: widget.height * widget.gameCanvas.camera.zoomLevel,
      ),
    );
  }
}
