part of demoncore;

class CameraDependent extends StatefulWidget {
  final double width;
  final double height;
  final Camera camera;
  final Widget child;
  late CameraDependentState cameraDependentState;

  CameraDependent({
    required this.width,
    required this.height,
    required this.camera,
    required this.child,
    super.key,
  });

  @override
  CameraDependentState createState() {
    cameraDependentState = CameraDependentState();
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.cameraZoomChanged) {
        cameraDependentState.refresh();
      }
    });
    return cameraDependentState;
  }
}

class CameraDependentState<T extends CameraDependent> extends State<T> {
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.camera.zoomLevel * widget.width,
      height: widget.camera.zoomLevel * widget.height,
      child: widget.child,
    );
  }
}
