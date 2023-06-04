part of demoncore;

abstract class AssetManager {
  final Map<String, AssetImage> imageRepository;

  AssetManager({
    required this.imageRepository,
  }) {
    Channel.signalStream.listen((Signal signal) {
      if (signal.code == SignalCode.gameCanvasReady) {
        preloadImages(signal.context);
      }
    });
  }

  Future<void> preloadImages(BuildContext context) async {
    for (AssetImage assetImage in imageRepository.values) {
      await precacheImage(assetImage, context);
    }
    return;
  }
}
