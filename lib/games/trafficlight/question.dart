import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'question_mark.dart';
import 'traffic_light.dart';
import 'traffic_light_game.dart';

class Question extends PositionComponent with HasGameRef<TrafficLightGame>{
 Question({ required super.position, required this.isSecondHalf });

  int input = 0;
  int output = 0;
  int rhs = 0;

  List<int> inputList = [3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15];

  List<int> lstFilters = [];
  int lastFilter = 0;

  bool isSecondHalf;

  int secondHalfFilter = 0;

 @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    createQuestion();

    ColorRectComponent line1 = ColorRectComponent(
      color: const Color.fromARGB(255, 180, 181, 188),
      position: Vector2.zero(),
      size: Vector2(384, 2),
      anchor: Anchor.centerLeft,
    );
    add(line1);

    ColorRectComponent line2 = ColorRectComponent(
      color: const Color.fromARGB(255, 180, 181, 188),
      position: Vector2(310, 0),
      size: Vector2(2, 138),
      anchor: Anchor.topCenter,
    );
    add(line2);

    TrafficLight trafficLight0 = TrafficLight(
      position: Vector2.zero(),
      isExample: false,
      on: input,
    );
    add(trafficLight0);

    if( isSecondHalf ){
      QuestionMark questionMark1 = QuestionMark(
        position: Vector2(108, 0)
      );
      add(questionMark1);
    } else {
      SpriteComponent filter0 = SpriteComponent(
        position: Vector2(108, 0),
        size: Vector2(54, 108),
        sprite: gameRef.lstContidions[lstFilters[0]],
        anchor: Anchor.center,
      );
      add(filter0);
    }

    SpriteComponent filter1 = SpriteComponent(
      position: Vector2(216, 0),
      size: Vector2(54, 108),
      sprite: gameRef.lstContidions[lstFilters[1]],
      anchor: Anchor.center,
    );
    add(filter1);

    SpriteComponent filter2 = SpriteComponent(
      position: Vector2(310, 0),
      size: lastFilter == 0 ? Vector2(80, 45) : Vector2(77, 77),
      sprite: gameRef.lstContidions[lastFilter + 4],
      anchor: Anchor.center,
    );
    add(filter2);

    TrafficLight trafficLightRHS = TrafficLight(
      position: Vector2(310, 111),
      isExample: false,
      on: rhs,
    );
    add(trafficLightRHS);

    if( isSecondHalf ) {
      TrafficLight trafficLightOutput = TrafficLight(
      position: Vector2(404, 0),
      isExample: false,
      on: output,
    );
    add(trafficLightOutput);
    } else {
      QuestionMark questionMark = QuestionMark(
        position: Vector2(404, 0)
      );
      add(questionMark);
    }
    
  }

  createQuestion(){
    input = inputList[Random().nextInt(inputList.length)];
    List<int> lstFilterSeq = [0, 1, 2, 3];
    lstFilterSeq.shuffle();
    lstFilters.add(lstFilterSeq[0]);
    lstFilters.add(lstFilterSeq[1]);
    lastFilter = Random().nextInt(2);
    rhs = inputList[Random().nextInt(inputList.length)];

    output = input;
    for( int i=0; i<lstFilters.length; ++i){
      output = filter(output, 0, lstFilters[i]);
    }

    output = filter(output, rhs, lastFilter+4);

    secondHalfFilter = 0;
    int temp = input;
    temp = filter0(temp);
    temp = filter(temp, 0, lstFilters[1]);
    temp = filter(temp, rhs, lastFilter+4);
    if( temp == output ){
      secondHalfFilter += 1; 
    }

    temp = input;
    temp = filter1(temp);
    temp = filter(temp, 0, lstFilters[1]);
    temp = filter(temp, rhs, lastFilter+4);
    if( temp == output ){
      secondHalfFilter += (1<<1); 
    }

    temp = input;
    temp = filter2(temp);
    temp = filter(temp, 0, lstFilters[1]);
    temp = filter(temp, rhs, lastFilter+4);
    if( temp == output ){
      secondHalfFilter += (1<<2); 
    }

    temp = input;
    temp = filter3(temp);
    temp = filter(temp, 0, lstFilters[1]);
    temp = filter(temp, rhs, lastFilter+4);
    if( temp == output ){
      secondHalfFilter += (1<<3); 
    }

  }

  int filter(int inputValue, int rhs, int operator){
    switch(operator){
      case 0: return filter0(inputValue);
      case 1: return filter1(inputValue);
      case 2: return filter2(inputValue);
      case 3: return filter3(inputValue);
      case 4: return filter4(inputValue, rhs);
      case 5: return filter5(inputValue, rhs);
    }
    return 0;
  }

  int filter0(int inputValue){
    int result = 0;
    result += inputValue & 4;
    result += inputValue & 8;
    return result;
  }

  int filter1(int inputValue){
    int result = 0;
    result += inputValue & 1;
    result += inputValue & 2;
    return result;
  }

  int filter2(int inputValue){
    int result = 0;
    result += inputValue & 2;
    result += inputValue & 4;
    return result;
  }

  int filter3(int inputValue){
    int result = 0;
    result += inputValue & 1;
    result += inputValue & 8;
    return result;
  }

  int filter4(int inputValue, int rhsValue){
    return inputValue | rhsValue;
  }

  int filter5(int inputValue, int rhsValue){
    int result = 0;
    if( (inputValue & 1) > 0 || (rhsValue & 1) > 0 ){
      if( ((inputValue & 1) > 0 && (rhsValue & 1) > 0 ) == false ){
        result += 1;
      }
    }

    if( (inputValue & 2) > 0 || (rhsValue & 2) > 0 ){
      if( ((inputValue & 2) > 0 && (rhsValue & 2) > 0 ) == false ){
        result += 2;
      }
    }

    if( (inputValue & 4) > 0 || (rhsValue & 4) > 0 ){
      if( ((inputValue & 4) > 0 && (rhsValue & 4) > 0 ) == false ){
        result += 4;
      }
    }

    if( (inputValue & 8) > 0 || (rhsValue & 8) > 0 ){
      if( ((inputValue & 8) > 0 && (rhsValue & 8) > 0 ) == false ){
        result += 8;
      }
    }
    return result;
  }
}