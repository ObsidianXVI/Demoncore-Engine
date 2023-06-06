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
