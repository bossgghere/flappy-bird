import 'dart:async';
import 'dart:io';

import 'package:birdgame/components/background.dart';
import 'package:birdgame/components/bird.dart';
import 'package:birdgame/components/ground.dart';
import 'package:birdgame/components/pipe_manager.dart';
import 'package:birdgame/components/pipes.dart';
import 'package:birdgame/components/score.dart';
import 'package:birdgame/constants.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  //all the basic com: bird,bg,g,pipes

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  FutureOr<void> onLoad() {
    //load backg
    background = Background();
    add(background);

    //load bird
    bird = Bird();
    add(bird);

    //load ground
    ground = Ground();
    add(ground);

    //load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    //load score
    scoreText = ScoreText();
    add(scoreText);
  }

  //tap
  @override
  void onTap() {
    bird.flap();
  }

  //scoreeeeee

  int score = 0;

  void scoreIncrement() {
    score += 1;
  }

  //game over
  bool isGameOver = false;

  void gameover() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    //show dilaugebox for user
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text('Highscore:$score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              resetGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;

    // Remove all existing pipe components
    children.whereType<Pipes>().forEach((pipe) => pipe.removeFromParent());

    resumeEngine();
  }
}
