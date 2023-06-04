part of demoncore;

class CameraDependent extends StatelessWidget {
  final double width;
  final double height;
  final Camera camera;
  final Widget child;

  const CameraDependent({
    required this.width,
    required this.height,
    required this.camera,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: camera.zoomLevel * width,
      height: camera.zoomLevel * height,
      child: child,
    );
  }
}
