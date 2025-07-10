import 'dart:async';

import 'package:birdgame/components/ground.dart';
import 'package:birdgame/components/pipes.dart';
import 'package:birdgame/constants.dart';
import 'package:birdgame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /* init bird */

  // bird position and size

  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeight),
      );

  //physical world properties

  double velocity = 0;

  //load the bird
  @override
  FutureOr<void> onLoad() async {
    // add the bird image
    sprite = await Sprite.load('bird.png');
    //add hit box
    add(RectangleHitbox());
  }

  // on jump/flap

  void flap() {
    velocity = jumpStrength;
  }

  //update

  void update(double dt) {
    //apply gravity
    velocity += gravity * dt;

    //update bird velocity and pos

    position.y += velocity * dt;

    if (position.y < 0) {
      position.y = 0;
      velocity = 0;
    }
  }

  // on collsion with other object
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    if (other is Ground || other is Pipes) {
      (parent as FlappyBirdGame).gameover();
    }

  }
}
