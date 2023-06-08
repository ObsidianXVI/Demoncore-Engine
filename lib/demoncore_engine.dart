library demoncore;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part './core/dc_object.dart';

part './asset_manager/asset_manager.dart';

part './map/game_map.dart';
part './map/map_builder.dart';
part './map/map_component.dart';
part './map/position.dart';

part './sprites/sprites.dart';
part './sprites/static_tile_sprite.dart';
part './sprites/animated_tile_sprite.dart';
part './sprites/extruded_sprite.dart';
part './sprites/spritesheet.dart';
part './sprites/sprite_blueprint.dart';

part './canvas/game_canvas.dart';
part './canvas/canvas_descendant.dart';

part './physics/physics.dart';
part './physics/sprite_path.dart';

part './channels/channels.dart';
part './channels/signal.dart';

part './camera/camera.dart';
part './camera/camera_dependent.dart';

part './debug/debug.dart';

part './utils/screen_utils.dart';
part './utils/double_iterator.dart';
part './utils/id_gen.dart';
part './utils/loop.dart';

class DemoncoreEngine extends StatelessWidget {
  final String title;
  final String initialGameView;
  final AssetManager assetManager;
  final DebugConfigs debugConfigs;
  final Map<String, GameCanvas Function(BuildContext)> gameViews;

  const DemoncoreEngine({
    required this.title,
    required this.initialGameView,
    required this.assetManager,
    required this.debugConfigs,
    required this.gameViews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Builder(
        builder: (BuildContext context) {
          assetManager.preloadImages(context).whenComplete(() {
            Navigator.pushNamed(context, initialGameView);
          });
          return const Center(
            child: Text('Engine is loading...'),
          );
        },
      ),
      routes: gameViews,
    );
  }
}
