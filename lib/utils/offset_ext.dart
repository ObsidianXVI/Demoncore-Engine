part of demoncore;

extension OffsetUtils on Offset {
  Offset reverse() {
    return Offset(-dx, -dy);
  }
}
