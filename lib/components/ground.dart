import 'dart:async';

import 'package:birdgame/constants.dart';
import 'package:birdgame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground();

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('ground.png');
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load('ground.png');

    //add collision hit box
    add(RectangleHitbox());
  }

  //update
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    // if the pos is half reached rest the ground for infinite loop

    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
