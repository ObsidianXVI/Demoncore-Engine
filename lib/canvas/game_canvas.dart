part of demoncore;

class GameCanvas extends StatefulWidget {
  final Color backgroundColor;
  double tileSize;
  double stepSize;
  final Camera camera = Camera();
  final GameMap Function(GameCanvas) gameMap;

  GameCanvas({
    required this.backgroundColor,
    required this.tileSize,
    required this.stepSize,
    required this.gameMap,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => GameCanvasState();
}

class GameCanvasState extends State<GameCanvas> {
  final FocusNode focusNode = FocusNode();

  GameCanvasState();

  @override
  void initState() {
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.gameCanvasKeyEventReceived) {
        final KeyEvent keyEvent = signal.context as KeyEvent;
        final bool knownKey;
        final Offset camOffset;
        if (keyEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
          camOffset = Offset(widget.stepSize, 0);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
          camOffset = Offset(-widget.stepSize, 0);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowUp) {
          camOffset = Offset(0, widget.stepSize);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowDown) {
          camOffset = Offset(0, -widget.stepSize);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.bracketRight) {
          widget.camera.changeZoom(0.2);
          knownKey = true;
          camOffset = Offset.zero;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.bracketLeft) {
          widget.camera.changeZoom(-0.2);
          knownKey = true;
          camOffset = Offset.zero;
        } else {
          knownKey = false;
          camOffset = Offset.zero;
        }
        if (knownKey) {
          setState(() {});

          checkCollisionPhysics(camOffset);
        }
      }
    });
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.cameraZoomChanged) {
        widget.tileSize = widget.tileSize * widget.camera.zoomLevel;
        widget.stepSize = widget.stepSize * widget.camera.zoomLevel;
      }
      setState(() {});
    });
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.spriteDetectedCollision) {
        print('colliso!');
        showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
                  child: Text('colliso!'),
                ));
      }
    });
    super.initState();
  }

  List<G2ExtrudedSpriteInstance> get extrudedSprites => widget
      .gameMap(widget)
      .buildSprites()
      .whereType<G2ExtrudedSpriteInstance>()
      .toList();

  void checkCollisionPhysics(Offset camOffset) {
    ////////// PHYSICS
    // the expected translation vector of the sprite
    final Offset spriteOffset = camOffset.reverse();
    // calculate the movement area
    final AreaMatrix movementArea = widget
        .gameMap(widget)
        .activeSprite
        .positionMatrix
        .translate(spriteOffset);
    // check against other extruded sprites by comparing AreaMatrixes, and
    // every extruded sprite that collides with the active sprite
    // adjusts the translation vector to prevent the collision
    final Offset changeTranslationVector =
        collisionAdjustedOffset(movementArea, spriteOffset);
    // adjust the sprite's translation, convert it to camera translation
    final Offset newCamOffset =
        (spriteOffset + changeTranslationVector).reverse();
    // perform translation by moving the camera
    widget.camera.offset += newCamOffset;
  }

  Offset collisionAdjustedOffset(AreaMatrix movementArea, Offset original) {
    Offset adjOffset = Offset.zero;
    for (G2ExtrudedSpriteInstance extrudedSprite in extrudedSprites) {
      final Offset? newOffset =
          movementArea.checkForOverlap(extrudedSprite.positionMatrix, original);
      if (newOffset != null) {
        adjOffset += newOffset;
      }
    }
    return adjOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (KeyEvent keyEvent) {
          Channel.streamController.add(Signal(
            code: SignalCode.gameCanvasKeyEventReceived,
            context: keyEvent,
          ));
        },
        child: Container(
          color: widget.backgroundColor,
          width: ScreenDimensions.getWidth(context),
          height: ScreenDimensions.getHeight(context),
          child: Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  top: widget.camera.offset.dy,
                  left: widget.camera.offset.dx,
                  width: ScreenDimensions.getWidth(context),
                  height: ScreenDimensions.getHeight(context),
                  child: Stack(
                    children: widget.gameMap(widget).buildSprites(),
                  ),
                ),
                Center(
                  child: widget.gameMap(widget).activeSprite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
