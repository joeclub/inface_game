import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';

import 'stack_ball_game.dart';

class ResetGameButton extends TextComponent with HasGameRef<StackBallGame>, TapCallbacks {
  ResetGameButton(String text) : super(text: text) {
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 40,
        color: BasicPalette.black.color,
      ),
    );
  }
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.resetGame();
  }
}
