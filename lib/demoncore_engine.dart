library demoncore;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part './core/dc_object.dart';

part './asset_manager/asset_manager.dart';

part './map/game_map.dart';
part './map/map_builder.dart';
part './map/position.dart';

part './sprites/sprites.dart';
part './sprites/static_tile_sprite.dart';
part './sprites/extruded_sprite.dart';

part './canvas/game_canvas.dart';
part './canvas/canvas_descendant.dart';

part './physics/physics.dart';
part './physics/sprite_path.dart';

part './channels/channels.dart';
part './channels/signal.dart';

part './camera/camera.dart';
part './camera/camera_dependent.dart';

part './utils/screen_utils.dart';
part './utils/double_iterator.dart';
part './utils/id_gen.dart';

class DemoncoreEngine {
  final AssetManager assetManager;

  DemoncoreEngine({
    required this.assetManager,
  });
}
