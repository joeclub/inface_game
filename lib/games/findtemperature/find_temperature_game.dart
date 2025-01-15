import 'dart:math';

import 'package:flame/components.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'game_card.dart';
import 'temperature_button.dart';

class FindTemperatureGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isGameEnd = false;

  late SpriteComponent background;
  late Sprite spriteDefault;
  late Sprite spriteFlip;
  List<GameCard> lstCards = [];

  late TemperatureButton sunButton;
  late TemperatureButton snowButton;

  List<bool> lstAnswers = [];
  int answerIndex = 0;
  late AnswerButton answerButton;

  late Sprite backgroundSprite;

  late Sprite sunSprite;
  late Sprite sunPreseedSprite;

  late Sprite snowSprite;
  late Sprite snowPreseedSprite;

  FindTemperatureGame({required super.hasFirstHalfScore, required super.hasRoundScore, required super.isEP});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 15, gameName: '기온 맞히기', timeLimit: limitTime, gameDescIndex: 15);
    world.add(gameStep);

    lstAnswers.add(false);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);

    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);

    backgroundSprite = await loadSprite('games/findtemperature/bg_border_circle_1.png');
    

    spriteDefault = await loadSprite('games/findtemperature/card_cover.png');
    spriteFlip = await loadSprite('games/findtemperature/card_inside.png');

    sunSprite = await loadSprite('games/findtemperature/btn_w_sun.png');
    sunPreseedSprite = await loadSprite('games/findtemperature/btn_w_sun_sel.png');

    snowSprite = await loadSprite('games/findtemperature/btn_w_cloud.png');
    snowPreseedSprite = await loadSprite('games/findtemperature/btn_w_cloud_sel.png');

    

    // Future.delayed(const Duration(seconds: 1), () {
    //   resetGame();
    // });
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameStep.limitTimer.current > gameStep.halfTime) {
      isSecondHalf = true;
    }

    if (gameStep.limitTimer.finished) {
      endGame();
    }
  }

  @override
  void endGame() {
    isGameEnd = true;
    super.endGame();
  }

  @override
  void initGame(){
    background = SpriteComponent(
      anchor: Anchor.center,
      sprite: backgroundSprite,
      position: Vector2(464, 420),
      size: Vector2.all(400),
    );
    world.add(
      background,
    );

    sunButton = TemperatureButton(
      position: Vector2(900, 360),
      spriteDefault: sunSprite,
      spritePressed: sunPreseedSprite,
      isSun: true,
    );
    world.add(sunButton);

    snowButton = TemperatureButton(
      position: Vector2(900, 480),
      spriteDefault: snowSprite,
      spritePressed: snowPreseedSprite,
      isSun: false,
    );
    world.add(snowButton);
    showButton(false);

    answerButton = AnswerButton(
      position: Vector2(1100, 420),
    );
    world.add(answerButton);
    answerButton.isVisible = false;

    lstCards.add(
      GameCard(
        position: Vector2(0, -200) + background.size * 0.5,
        spriteDefault: spriteDefault,
        spriteFlip: spriteFlip
      ),
    );

    lstCards.add(
      GameCard(
        position: Vector2(200, 0) + background.size * 0.5,
        spriteDefault: spriteDefault,
        spriteFlip: spriteFlip
      ),
    );

    lstCards.add(
      GameCard(
        position: Vector2(0, 200) + background.size * 0.5,
        spriteDefault: spriteDefault,
        spriteFlip: spriteFlip
      ),
    );

    lstCards.add(
      GameCard(
        position: Vector2(-200, 0) + background.size * 0.5,
        spriteDefault: spriteDefault,
        spriteFlip: spriteFlip
      ),
    );

    for( int i=0; i<lstCards.length; ++i ){
      background.add(lstCards[i]);
    }
  }

  @override
  void resetGame() {
    currRound++;
    gameStep.updateRound();
    
    answerButton.isVisible = false;
    showButton(false);
    sunButton.reset();
    snowButton.reset();

    for( int i=0; i<4; ++i){
      lstCards[i].flip(true);
    }

    Future.delayed(const Duration(seconds: 1), () {
      answerIndex = Random().nextInt(lstAnswers.length);
      int temp = answerIndex;
      int currCard = lstAnswers.length;
      for( int i=0; i<4; ++i){
        currCard = currCard ~/ 2;
        bool isNotSun = temp >= currCard;
        temp = (temp % currCard);
        lstCards[i].flip(isNotSun);
      }

      Future.delayed(const Duration(milliseconds: 400), (){
        showButton(true);
        sunButton.isTappable = true;
        snowButton.isTappable = true;
      });
    });
  }

  void showButton(bool show){
    sunButton.isVisible = show;
    snowButton.isVisible = show;
  }

  void enableButton(bool enable){
    sunButton.isTappable = enable;
    snowButton.isTappable = enable;
  }

  void tapButton(bool isSun){
    enableButton(false);
    answerButton.isVisible = true;
    bool correct = isSun == lstAnswers[answerIndex];
    answerButton.setRight(correct);
  }
}
