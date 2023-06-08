part of demoncore;

typedef JSON = Map<String, dynamic>;

class GameMapMatrix {
  final int width;
  final int height;
  final int tileWidth;
  final List<MapLayer> layers;
  final Map<int, AssetImage> tilesets;

  const GameMapMatrix({
    required this.width,
    required this.height,
    required this.tileWidth,
    required this.layers,
    required this.tilesets,
  });

  List<SpriteBlueprint> generateBlueprints() {
    final List<SpriteBlueprint> spriteBlueprints = [];
    for (MapLayer mapLayer in layers) {
      int index = 0;
      print(index);

      for (int col = 0; col < mapLayer.width; col++) {
        for (int row = 0; col < mapLayer.height; row++) {
          final int matrixVal = mapLayer.data[index];
          if (matrixVal != 0) {
            print(matrixVal);
            spriteBlueprints.add(
              StaticTileSprite(
                assetImage: tilesets[matrixVal]!,
                position: RelativeTilePosition(
                  col + mapLayer.originX,
                  row + mapLayer.originY,
                ),
              ),
            );
          }
          if (index < mapLayer.data.length - 2) index += 1;
        }
      }
    }
    return spriteBlueprints;
  }
}

class MapLayer {
  final int width;
  final int height;
  final int originX;
  final int originY;
  final bool visible;
  final List<int> data;

  const MapLayer({
    required this.width,
    required this.height,
    required this.originX,
    required this.originY,
    required this.data,
    this.visible = true,
  });
}
