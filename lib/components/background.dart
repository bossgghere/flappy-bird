import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Background extends Component with HasGameRef {
  late SpriteComponent bg1;
  late SpriteComponent bg2;

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load('background.png');
    final screenSize = gameRef.size;

    bg1 = SpriteComponent(sprite: sprite, size: screenSize, position: Vector2(0, 0));
    bg2 = SpriteComponent(sprite: sprite, size: screenSize, position: Vector2(screenSize.x, 0));

    addAll([bg1, bg2]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // scroll both backgrounds
    bg1.position.x -= 100 * dt;
    bg2.position.x -= 100 * dt;

    final screenWidth = gameRef.size.x;

    // if one bg moves off-screen, place it to the right of the other
    if (bg1.position.x + screenWidth <= 0) {
      bg1.position.x = bg2.position.x + screenWidth;
    }

    if (bg2.position.x + screenWidth <= 0) {
      bg2.position.x = bg1.position.x + screenWidth;
    }
  }
}
