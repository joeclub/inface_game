import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

import 'change_direction_game.dart';
import 'correct_effect.dart';
import 'female.dart';

class Pipe extends SpriteComponent with HasGameRef<ChangeDirectionGame> {
  Pipe({required super.position});
  double maleDir = 1;
  double maleSpeed = 0;
  double femalePos = 0;
  
  late SpriteComponent male;
  late Female female;

  bool endGame = false;
  bool isDestroyed = false;
    
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(1008, 46);
    sprite = await gameRef.loadSprite('games/changedirection/Pipe.png');

    int iLeft = Random().nextInt(2);
    maleDir = iLeft == 0 ? 1 : -1;
    double offset = 30;

    maleSpeed = Random().nextInt(400) + 100;

    String maleSpriteName = iLeft == 0 ? "orangeRightAnimArrow" : "orangeLeftAnimArrow";

    Sprite maleSprite = await gameRef.loadSprite('games/changedirection/$maleSpriteName.png');
    male = SpriteComponent(
      anchor: iLeft == 0 ? Anchor.centerRight : Anchor.centerLeft,
      sprite: maleSprite,
      position: iLeft == 0 ? Vector2(offset, 23) : Vector2(1008-offset, 23),
      size: Vector2(51, 34)
    );

    add(male);

    femalePos = Random().nextInt(600).toDouble() + 204;
    female = Female(position: Vector2(femalePos, 23));
    add(female);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if( gameRef.showEndGamePopup ) return;

    if( endGame == false ){
      male.position += Vector2(dt * maleSpeed * maleDir, 0);
      if( maleDir > 0 ){
        if( male.position.x > femalePos ){
          endGame = true;
          remove(female);
          remove(male);
          bool isCorrect = female.dir == 0;
          if( isCorrect ) 
          {
            gameRef.currScore += 10;
            gameRef.count++;
            gameRef.countText.text = gameRef.count.toString();
          }
          CorrectEffect correctEffect = CorrectEffect(
            position: Vector2(femalePos, 23),
            isCorrect: isCorrect,
            isLeft: true,
          );
          add(correctEffect);
          Future.delayed(const Duration(seconds: 1), (){
            gameRef.refreshPipe(this);
          });
        }
      } else {
        if( male.position.x < femalePos ){
          endGame = true;
          remove(female);
          remove(male);
          bool isCorrect = female.dir == 1;
          if( isCorrect )
          {
            gameRef.currScore += 10;
            gameRef.count++;
            gameRef.countText.text = gameRef.count.toString();
          }
          CorrectEffect correctEffect = CorrectEffect(
            position: Vector2(femalePos, 23),
            isCorrect: isCorrect,
            isLeft: false,
          );
          add(correctEffect);
          Future.delayed(const Duration(seconds: 1), (){
            gameRef.refreshPipe(this);
          });
        }
      }
      gameRef.gameStep.updateScore(gameRef.currScore);
    } 
  }
}
