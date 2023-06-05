part of demoncore;

class Camera extends DCObject {
  double zoomLevel = 1;
  Offset offset = Offset.zero;

  Camera() : super('cam');

  void changeZoom(double changeQty) {
    zoomLevel += changeQty;
    Channel.streamController.add(
      const Signal(code: SignalCode.cameraZoomChanged, context: null),
    );
  }
}
