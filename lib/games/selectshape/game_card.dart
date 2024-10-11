import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'select_shape_game.dart';

enum CardType{
  // ignore: constant_identifier_names
  card_blue,
  // ignore: constant_identifier_names
  card_green,
  // ignore: constant_identifier_names
  card_red,
  // ignore: constant_identifier_names
  card_yellow,
}

class GameCard extends SpriteComponent with HasGameRef<SelectShapeGame>, TapCallbacks {
  GameCard( {required super.position, required this.shapeIndex, required this.parentClip, required this.isCorrect} );

  int shapeIndex;
  ClipComponent parentClip;
  bool isCorrect;
  late SpriteComponent correctSpriteComponent;
  late Sprite cardBack;
  late SpriteComponent shapeComponent;

  bool isTapped = false;
  
  @override
  FutureOr<void> onLoad() async {
    int cardIndex = Random().nextInt(CardType.values.length);
    String cardName = CardType.values[cardIndex].name;
    Sprite cardSprite = await gameRef.loadSprite('games/selectshape/$cardName.png');
    sprite = cardSprite;
    anchor = Anchor.center;
    size = Vector2(170, 210);

    String shapeName = ShapeType.values[shapeIndex].name;
    Sprite shapeSprite = await gameRef.loadSprite('games/selectshape/$shapeName.png');
    shapeComponent = SpriteComponent(
      sprite: shapeSprite,
      position: size * 0.5 + Vector2(0, -12),
      size: Vector2(68, 66),
      anchor: Anchor.center
    );
    add(shapeComponent);

    Sprite correctSprite = await gameRef.loadSprite('games/selectshape/over_click.png');
    correctSpriteComponent = SpriteComponent(
      sprite: correctSprite,
      position: size * 0.5 + Vector2(0, -9.5),
      size: Vector2(140, 180),
      anchor: Anchor.center
    );

    cardBack = await gameRef.loadSprite('games/selectshape/card_back.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    Vector2 pos = position;
    pos.y += dt * 150;

    if( pos.y > 650 ){
      gameRef.clipComponent.remove(this);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( isTapped == true ) return;
    flip();
    isTapped = true;

    gameRef.currScore += isCorrect ? 10 : -10;
    gameRef.currScore = max(gameRef.currScore, 0);
    gameRef.gameStep.updateScore(gameRef.currScore);
  }

  void flip(){
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          if( isCorrect ){
            sprite = cardBack;
            remove(shapeComponent);
            add(correctSpriteComponent);
          }
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                if( isCorrect == false ){
                  add(
                    ScaleEffect.to(
                      Vector2(0, 1),
                      EffectController(duration: 0.2),
                      onComplete: (){
                        add(
                          ScaleEffect.to(
                            Vector2(1, 1),
                            EffectController(duration: 0.2),
                            onComplete: (){
                            }
                          )
                        );
                      }
                    )
                  );
                }
              }
            )
          );
        }
      )
    );
  }
}