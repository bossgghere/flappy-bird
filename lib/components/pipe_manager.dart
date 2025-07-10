import 'dart:math';

import 'package:birdgame/components/pipes.dart';
import 'package:birdgame/constants.dart';
import 'package:birdgame/game.dart';
import 'package:flame/components.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  //at every update we generate new pipes

  double pipeSpwanTimer = 0;

  @override
  void update(double dt) {
    // TODO: implement update
    pipeSpwanTimer += dt;

    

    if (pipeSpwanTimer > pipeInterval) {
      pipeSpwanTimer = 0;
      spawnNewPipe();
    }
  }

  //new pipe
  void spawnNewPipe() {
    final double screenHeight = gameRef.size.y;
    

    //calculations
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    //height of the bottom pipe-- random sel from min and max height
    //
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height if the toppipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    //main
    //
    //
    //creating the actual pipes after the dimentions
    //
    final bottomPipe = Pipes(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    // creating top pipe
    final topPipe = Pipes(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
