part of demoncore;

abstract class Sprite extends DCObject {
  final AssetImage baseImage;
  final double width;
  final double height;
  final GameCanvas gameCanvas;

  Sprite({
    required this.baseImage,
    required this.width,
    required this.height,
    required this.gameCanvas,
  }) : super('sprite');
}

abstract class StaticSprite extends StatelessWidget implements Sprite {
  @override
  final String id = ID.generate('sprite.static');
  @override
  final String label = 'sprite.static';
  @override
  final AssetImage baseImage;
  @override
  final double width;
  @override
  final double height;
  @override
  final GameCanvas gameCanvas;

  StaticSprite({
    required this.baseImage,
    required this.width,
    required this.height,
    required this.gameCanvas,
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
  Widget build(BuildContext context) {
    return Positioned(
      top: tilePosition.rowNum * gameCanvas.tileSize,
      left: tilePosition.colNum * gameCanvas.tileSize,
      child: CameraDependent(
        width: gameCanvas.tileSize,
        height: gameCanvas.tileSize,
        camera: gameCanvas.camera,
        child: Image(
          image: baseImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
