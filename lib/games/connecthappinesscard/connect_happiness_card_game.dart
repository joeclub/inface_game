import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'game_card.dart';
import 'scoreboard.dart';
import 'select_button.dart';

class ConnectHappinessCardGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  
  late ScoreBoard scoreBoard;

  late TextComponent roundText;

  bool isStageEnding = false;

  final numCards = 4 * 8;
  List<GameCard> lstCards = [];
  List<GameCard> lstUnhappiness = [];
  List<GameCard> lstSelect = [];

  late ColorRectComponent background;

  GameCard? cardStart;
	GameCard? cardEnd;

  int happinessScore = 0;
	int unhappinessScore = 0;
  int roundScore = 0;

  bool findUnhappiness = false;
  bool findEnd = false;

  ConnectHappinessCardGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 20, gameName: '행복카드 연결하기', timeLimit: limitTime, gameDescIndex: 19);
    world.add(gameStep);
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

  void endGame() {
  }

  @override
  void initGame(){
    background = ColorRectComponent(
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(482, 420),
      size: Vector2(711, 544),
      anchor: Anchor.center
    );
    world.add(background);

    ColorRectComponent background2 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2(987, 420),
      size: Vector2(300, 544),
      anchor: Anchor.center
    );
    world.add(background2);

    ColorRectComponent background3 = ColorRectComponent(
      color: const Color.fromARGB(255, 247, 247, 247),
      position: background2.size * 0.5,
      size: Vector2(297, 541),
      anchor: Anchor.center
    );
    background2.add(background3);

    scoreBoard = ScoreBoard(position: background3.size * 0.5 + Vector2(0, -10));
    background3.add(scoreBoard);

    roundText = TextComponent(
      anchor: Anchor.center,
      text: 'ROUND 1',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 34, color: Colors.black),
      ),
      position: background3.size * 0.5 - Vector2( 0, 220),
    );
    background3.add(roundText);

    SelectButton button = SelectButton(position: background3.size * 0.5 - Vector2( 0, -210));
    background3.add(button);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    roundText.text = 'ROUND $currRound';
    
    for(int i=0; i<lstCards.length; ++i){
      world.remove(lstCards[i]);
    }
    lstCards.clear();
    lstUnhappiness.clear();
    lstSelect.clear();
    findUnhappiness = false;
    findEnd = false;
    isStageEnding = false;
    happinessScore = 0;
	  unhappinessScore = 0;
    roundScore = 0;

    createCard();
    Future.delayed(const Duration(milliseconds: 200), (){
      setCardSetting();
    });
  }

  void createCard(){
    Vector2 startPos = background.size * 0.5 + Vector2(-180, -28);

    for(int i=0; i<numCards; ++i){
      int posX = i % 8;
      int posY = i ~/ 8;
      GameCard card = GameCard(
        position: startPos + Vector2(posX * 87, posY * 122),
        cardIndex: i,
        state: CardState.closed,
      );
      world.add(card);
      lstCards.add(card);
    }

    for (int y = 0; y < 4; ++y)
		{
			for (int x = 0; x < 8; ++x)
			{
				int index = x + y * 8;
				GameCard card = lstCards[index];
				GameCard? card1;
				// 위
				if (y + 1 < 4)
				{
					y++;
					index = x + y * 8;
					card1 = lstCards[index];
					card.lstNeighbor.add(card1);
					y--;
				}

				// 아래
				if (y - 1 >= 0)
				{
					y--;
					index = x + y * 8;
					card1 = lstCards[index];
					card.lstNeighbor.add(card1);
					y++;
				}

				// 왼쪽
				if (x - 1 >= 0)
				{
					x--;
					index = x + y * 8;
					card1 = lstCards[index];
					card.lstNeighbor.add(card1);
					x++;
				}

				// 오른쪽
				if (x + 1 < 8)
				{
					x++;
					index = x + y * 8;
					card1 = lstCards[index];
					card.lstNeighbor.add(card1);
					x--;
				}
			}
		}
  }

  void setCardSetting(){
    int startIndex = math.Random().nextInt(numCards);
		cardStart = lstCards[startIndex];
		cardEnd = null;
		while (true)
		{
			bool match = false;
			int endIndex = math.Random().nextInt(numCards);

			cardEnd = lstCards[endIndex];

			if (cardEnd == cardStart) continue;

			for (int i = 0; i < cardStart!.lstNeighbor.length; ++i)
			{
				if (cardStart!.lstNeighbor[i] == cardEnd)
				{
					match = true;
					break;
				}
			}

			if (match == false) break;
		}

		// 불행카드 세팅
		int unhappinessCount = math.Random().nextInt(3) + 1;
		if (isSecondHalf) unhappinessCount += 3;

		List<int> lstSeq = [];
		for (int i = 0; i < numCards; ++i)
		{
			lstSeq.add(i);
		}

		int temp;
		for (int i = 0; i < numCards; ++i)
		{
			int rand = math.Random().nextInt(numCards);
			temp = lstSeq[i];
			lstSeq[i] = lstSeq[rand];
			lstSeq[rand] = temp;
		}

		temp = 0;
		while (lstUnhappiness.length < unhappinessCount)
		{
			int index = lstSeq[temp++];
			GameCard unhappiness = lstCards[index];
			if (unhappiness != cardStart && unhappiness != cardEnd)
			{
				lstUnhappiness.add(unhappiness);
			}
		}

		switch (lstUnhappiness.length)
		{
			case 1:
				{
					happinessScore = 30;
					unhappinessScore = -750;
				}
				break;
			case 2:
				{
					happinessScore = 30;
					unhappinessScore = -750;
				}
				break;
			case 3:
				{
					happinessScore = 40;
					unhappinessScore = -550;
				}
				break;
			case 4:
				{
					happinessScore = 40;
					unhappinessScore = -550;
				}
				break;
			case 5:
				{
					happinessScore = 50;
					unhappinessScore = -300;
				}
				break;
			case 6:
				{
					happinessScore = 50;
					unhappinessScore = -300;
				}
				break;
		}

		scoreBoard.happinessScore.text = "+$happinessScore";
		scoreBoard.unhappinessScore.text = unhappinessScore.toString();
		scoreBoard.unhappinessCount.text = lstUnhappiness.length.toString();
    scoreBoard.roundScore.text = roundScore.toString();

    Future.delayed(const Duration(milliseconds: 200), (){
      cardStart!.setState(CardState.start);
      Future.delayed(const Duration(milliseconds: 200), (){
        cardEnd!.setState(CardState.end);
      });
    });

    

		//cardStart.SetState(HappinessCard.CardState.Start);
		//yield return new WaitForSeconds(0.1f);
		//cardEnd.SetState(HappinessCard.CardState.End);

		//yield return new WaitForSeconds(0.3f);

		//gameStart = true;

		// for (int i = 0; i < lstCard.Count; ++i)
		// {
		// 	if (lstCard[i].state == HappinessCard.CardState.Closed)
		// 	{
		// 		UIButton button = lstCard[i].GetComponent<UIButton>();
		// 		button.enabled = true;
		// 	}
		// }
  }

  bool checkHappiness(GameCard card)
	{
		for (int i = 0; i < lstUnhappiness.length; ++i)
		{
			if (card == lstUnhappiness[i])
			{
				roundScore += unhappinessScore;
				scoreBoard.roundScore.text = roundScore.toString();
				findUnhappiness = true;
				onClickConfirm();
				return false;
			}
		}

		roundScore += happinessScore;
		scoreBoard.roundScore.text = roundScore.toString();
		lstSelect.add(card);
		return true;
	}

  void checkConnect()
	{
		Future.delayed(const Duration(milliseconds: 400), (){
      for (int i = 0; i < lstCards.length; ++i)
      {
        lstCards[i].traverse = false;
      }

      findNextConnect(cardStart!);

      if (findEnd == true)
      {
        for (int i = 0; i < lstCards.length; ++i)
        {
          lstCards[i].traverse = false;
        }
        onClickConfirm();
      }
    });
  }

  void findNextConnect(GameCard card)
	{
		for (int i = 0; i < card.lstNeighbor.length; ++i)
		{
			if (card.lstNeighbor[i]!.state == CardState.end)
			{
				findEnd = true;
				break;
			}

			if (card.lstNeighbor[i]!.state != CardState.happiness) continue;

			if (card.lstNeighbor[i]! != card && card.lstNeighbor[i]!.traverse == false)
			{
				card.lstNeighbor[i]!.traverse = true;
				findNextConnect(card.lstNeighbor[i]!);
			}
		}
	}

  void onClickConfirm() async 
	{
		if (findUnhappiness == false)
		{
			if (lstSelect.isEmpty) return;
		}
		
		findNextConnect(cardStart!);

    await ending();
	}

  Future<void> ending() async {
    isStageEnding = true;
    CardState state = CardState.success;
		if (findEnd == false)
		{
			state = (findUnhappiness) ? CardState.fail : CardState.happiness;
		}
		else
		{
			if (findUnhappiness) state = CardState.fail;
		}

		if (state == CardState.success ||
			state == CardState.fail)
		{
			cardStart!.setState(state);
      await Future.delayed(const Duration(milliseconds: 200));
		}

		for (int i = 0; i < lstSelect.length; ++i)
		{
			lstSelect[i].setState(state);
			await Future.delayed(const Duration(milliseconds: 200));
		}

		if (state == CardState.success ||
			state == CardState.fail)
		{
			cardEnd!.setState(state);
			await Future.delayed(const Duration(milliseconds: 200));
		}

		await Future.delayed(const Duration(seconds: 1));

		//AddScore(roundScore);
    currScore += roundScore * (findEnd ? 2 : 1);
    //currScore = math.max(0, roundScore);
    gameStep.updateScore(currScore);
    resetGame();
  }
}