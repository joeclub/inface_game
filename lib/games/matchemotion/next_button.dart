import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'emotion.dart';
import 'match_emotion_game.dart';

class NextButton extends SpriteComponent with HasGameRef<MatchEmotionGame>, TapCallbacks {
  NextButton( {required super.position} );
  
  late Sprite disabledSprite;
  late Sprite normalSprite;

  bool isEnabled = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(60, 60);
    normalSprite = await gameRef.loadSprite('games/matchemotion/btn_next@2x.png');
    disabledSprite = await gameRef.loadSprite('games/matchemotion/btn_disabled.png');
    sprite = disabledSprite;
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if( isEnabled == false ) return;

    int correctCount = 0;
    for( int i=0; i<gameRef.lstEmotionIndices.length; ++i){
      Emotion emotion = gameRef.lstEmotionComponents[i];
      if( emotion.isTapped ){
        if( emotion.emotionIndex == gameRef.emotionIndex ){
          correctCount++;
        } else {
          correctCount--;
        }
      }
    }
    int score = correctCount * 10;
    if( correctCount == gameRef.correctCount ){
      score *= 2;
    }
    gameRef.currScore += score;
    gameRef.currScore = math.max(0, gameRef.currScore);
    gameRef.gameStep.updateScore(gameRef.currScore);
    gameRef.selectedEmotionCount = 0;
    gameRef.addSelectedEmotion(0);
    gameRef.resetGame();
  }
  
  void updateButtonState(int count){
    isEnabled = count > 0;
    sprite = isEnabled ? normalSprite : disabledSprite;
  }
}
