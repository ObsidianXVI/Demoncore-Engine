part of demoncore;

class StaticTileSprite extends StaticSprite {
  final TilePosition tilePosition;
  StaticTileSprite({
    required this.tilePosition,
    required super.baseImage,
    required super.gameCanvas,
    super.key,
  }) : super(
          width: gameCanvas.tileSize,
          height: gameCanvas.tileSize,
        );

  @override
  StaticTileSpriteController createState() => StaticTileSpriteController();
}

class StaticTileSpriteController extends SpriteController<StaticTileSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: widget.key,
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
      /* CameraDependent(
        width: gameCanvas.tileSize,
        height: gameCanvas.tileSize,
        camera: gameCanvas.camera,
        child: Image(
          image: baseImage,
          fit: BoxFit.cover,
        ),
      ), */
    );
/*     return Positioned(
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
      /* CameraDependent(
        width: gameCanvas.tileSize,
        height: gameCanvas.tileSize,
        camera: gameCanvas.camera,
        child: Image(
          image: baseImage,
          fit: BoxFit.cover,
        ),
      ), */
    ); */
  }
}
