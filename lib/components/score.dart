import 'dart:async';
import 'dart:ui';
import 'package:birdgame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText()
      : super(
          text: '0',
          textRenderer: TextPaint(
            style: TextStyle(
              fontSize: 32,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.bottomCenter;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 20);
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Keep score centered at the bottom on resize
    position = Vector2(size.x / 2, size.y - 20);
  }
}
