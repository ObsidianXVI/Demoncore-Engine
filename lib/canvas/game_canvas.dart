part of demoncore;

class GameCanvas extends StatefulWidget {
  final Color backgroundColor;
  final double tileSize;
  final Camera camera = Camera();
  late GameMap gameMap;

  GameCanvas({
    required this.backgroundColor,
    required this.tileSize,
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
    Channel.streamController.add(Signal.gameCanvasReady(context: context));
    super.initState();
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
          child: Stack(
            children: widget.gameMap.tiles.values.toList(),
          ),
        ),
      ),
    );
  }
}
