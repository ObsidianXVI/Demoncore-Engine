part of demoncore;

abstract class Sprite extends CameraDependent implements DCObject {
  @override
  final String id = ID.generate('sprite');
  @override
  final String label = 'sprite';
  final AssetImage baseImage;
  final GameCanvas gameCanvas;

  Sprite({
    required this.baseImage,
    required this.gameCanvas,
    required super.width,
    required super.height,
    super.key,
  }) : super(
          camera: gameCanvas.camera,
          child: Image(
            image: baseImage,
            fit: BoxFit.cover,
          ),
        );

  @override
  SpriteController createState();
}

abstract class SpriteController<S extends Sprite>
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

abstract class StaticSprite extends Sprite {
  StaticSprite({
    required super.baseImage,
    required super.width,
    required super.height,
    required super.gameCanvas,
    super.key,
  });
}

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
