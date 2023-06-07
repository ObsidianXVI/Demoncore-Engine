part of demoncore;

abstract class AssetManager {
  final Map<String, AssetImage> imageRepository;

  const AssetManager({
    required this.imageRepository,
  });

  Future<void> preloadImages(BuildContext context) async {
    for (AssetImage assetImage in imageRepository.values) {
      await precacheImage(assetImage, context);
    }
    return;
  }
}
