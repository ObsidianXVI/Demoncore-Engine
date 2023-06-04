part of demoncore;

class Camera extends DCObject {
  int zoomLevel = 1;
  Offset offset = Offset.zero;

  Camera() : super('cam');
}
