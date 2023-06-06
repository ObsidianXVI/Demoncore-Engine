part of demoncore;

enum SignalCode {
  gameCanvasReady('game.canvas.ready'),
  gameCanvasKeyEventReceived('game.canvas.keyevent.received'),
  cameraZoomChanged('camera.zoom.changed'),
  activeSpriteMoved('sprite.active.moved'),
  spriteDetectedCollision('sprite.extruded.collision.detected'),
  ;

  final String code;
  const SignalCode(this.code);
}

class Signal {
  final SignalCode code;
  final dynamic context;

  const Signal({required this.code, this.context});
  const Signal.gameCanvasReady({this.context})
      : code = SignalCode.gameCanvasReady;
}
