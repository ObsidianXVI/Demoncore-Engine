part of demoncore;

abstract class G2SpriteInstance extends CameraDependent implements DCObject {
  @override
  final String id = ID.generate('sprite');
  @override
  final String label = 'sprite';
  final AssetImage baseImage;
  final GameCanvas gameCanvas;
  final G2SpriteBlueprint spriteBlueprint;
  final SpriteRadius spriteRadius;

  G2SpriteInstance({
    required this.spriteBlueprint,
    required this.gameCanvas,
    required this.spriteRadius,
    super.key,
  })  : baseImage = spriteBlueprint.assetImage,
        super(
          camera: gameCanvas.camera,
          width: spriteRadius.width,
          height: spriteRadius.height,
          child: Image(
            image: spriteBlueprint.assetImage,
            fit: BoxFit.cover,
          ),
        );
  G2SpriteInstance.tile({
    required this.spriteBlueprint,
    required this.gameCanvas,
    super.key,
  })  : baseImage = spriteBlueprint.assetImage,
        spriteRadius = SpriteRadius(
          width: gameCanvas.tileSize,
          height: gameCanvas.tileSize,
        ),
        super(
          camera: gameCanvas.camera,
          width: gameCanvas.tileSize,
          height: gameCanvas.tileSize,
          child: Image(
            image: spriteBlueprint.assetImage,
            fit: BoxFit.cover,
          ),
        );

  @override
  G2SpriteController createState();
}

abstract class G2SpriteController<S extends G2SpriteInstance>
    extends CameraDependentState<S> {
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

class G2ExtrudedSpriteInstance extends G2SpriteInstance {
  final SpriteRadius physicsRadius;
  static final GlobalKey globalKey = GlobalKey();
  G2ExtrudedSpriteInstance({
    required this.physicsRadius,
    required super.gameCanvas,
    required super.spriteBlueprint,
    required super.spriteRadius,
  }) : super(key: globalKey);

  G2ExtrudedSpriteInstance.tile({
    required this.physicsRadius,
    required super.gameCanvas,
    required super.spriteBlueprint,
    super.key,
  }) : super(
          spriteRadius: SpriteRadius(
            width: gameCanvas.tileSize,
            height: gameCanvas.tileSize,
          ),
        );

  AreaMatrix get positionMatrix {
    final RenderBox renderBox =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    final Offset pos = renderBox.localToGlobal(Offset.zero);
    return AreaMatrix(
      x1: pos.dx,
      x2: pos.dx + spriteRadius.width,
      y1: pos.dy,
      y2: pos.dy + spriteRadius.height,
    );
  }

  @override
  G2SpriteController<G2SpriteInstance> createState() =>
      G2ExtrudedSpriteController();
}

class G2ExtrudedSpriteController
    extends G2SpriteController<G2ExtrudedSpriteInstance> {
  final GlobalKey controllerKey = GlobalKey();

  bool collidesWith(RenderBox other) {
    final RenderBox currentRB =
        controllerKey.currentContext!.findRenderObject() as RenderBox;
    final Size currentSize = currentRB.size;
    final Size otherSize = other.size;

    final Offset currentPos = currentRB.localToGlobal(Offset.zero);
    final Offset otherPos = other.localToGlobal(Offset.zero);

    final doesCollide = (currentPos.dx < otherPos.dx + otherSize.width &&
        currentPos.dx + currentSize.width > otherPos.dx &&
        currentPos.dy < otherPos.dy + otherSize.height &&
        currentPos.dy + currentSize.height > otherPos.dy);

    return doesCollide;
  }
}

class G2ControllableSpriteInstance extends G2ExtrudedSpriteInstance {
  G2ControllableSpriteInstance({
    required super.gameCanvas,
    required super.spriteBlueprint,
    required super.spriteRadius,
    required super.physicsRadius,
  });

  @override
  G2ControllableSpriteController createState() =>
      G2ControllableSpriteController();
}

class G2ControllableSpriteController
    extends G2SpriteController<G2ControllableSpriteInstance> {}
