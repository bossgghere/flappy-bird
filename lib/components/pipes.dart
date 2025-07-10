import 'dart:async';

import 'package:birdgame/constants.dart';
import 'package:birdgame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pipes extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipes(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'top_pipe.png' : 'bottom_pipe.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move pipe left
    position.x -= groundScrollingSpeed * dt;

    // Score when bird passes the top pipe
    if (isTopPipe &&
        !scored &&
        position.x + size.x < gameRef.bird.position.x) {
      scored = true;
      gameRef.scoreIncrement();
    }

    // Remove pipe if off-screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
