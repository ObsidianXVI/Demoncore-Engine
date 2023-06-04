part of demoncore;

class Channel {
  static final StreamController<Signal> streamController =
      StreamController.broadcast();
  static final Stream<Signal> signalStream = streamController.stream;
}
