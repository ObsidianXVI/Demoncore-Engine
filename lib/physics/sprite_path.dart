part of demoncore;

class SpritePath {
  final Sprite sprite;
  final Offset translationVector;

  SpritePath({
    required this.sprite,
    required this.translationVector,
  });

/*   void fn() {
    RenderBox box1 =
        containerKey1.currentContext?.findRenderObject() as RenderBox;
    RenderBox box2 =
        containerKey2.currentContext?.findRenderObject() as RenderBox;

    final size1 = box1.size;
    final size2 = box2.size;

    final position1 = box1.localToGlobal(Offset.zero);
    final position2 = box2.localToGlobal(Offset.zero);

    final collide = (position1.dx < position2.dx + size2.width &&
        position1.dx + size1.width > position2.dx &&
        position1.dy < position2.dy + size2.height &&
        position1.dy + size1.height > position2.dy);
  } */
}
