part of demoncore;

class GameCanvas extends StatefulWidget {
  final Color backgroundColor;
  final double tileSize;
  final double stepSize;
  final Camera camera = Camera();
  final GameMapBuilder gameMapBuilder;

  GameCanvas({
    required this.backgroundColor,
    required this.tileSize,
    required this.stepSize,
    required this.gameMapBuilder,
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
        if (keyEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
          widget.camera.offset += Offset(widget.stepSize, 0);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
          widget.camera.offset += Offset(-widget.stepSize, 0);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowUp) {
          widget.camera.offset += Offset(0, widget.stepSize);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowDown) {
          widget.camera.offset += Offset(0, -widget.stepSize);
          knownKey = true;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.keyD) {
          widget.camera.changeZoom(1);
          knownKey = true;
        } else {
          knownKey = false;
        }
        if (knownKey) {
          setState(() {});

          Channel.streamController.add(
            Signal(
              code: SignalCode.activeSpriteMoved,
              context: gameMap.activeSprite.getRenderBox(),
            ),
          );
        }
      }
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

  GameMap get gameMap => widget.gameMapBuilder.buildMap(widget);

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
                    children: gameMap.layers,
                  ),
                ),
                Center(
                  child: gameMap.activeSprite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
