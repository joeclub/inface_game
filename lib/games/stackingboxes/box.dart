import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'floor.dart';
import 'stacking_boxes_game.dart';

class Box extends SpriteComponent with HasGameRef<StackingBoxesGame>, TapCallbacks {
  Box({required super.position, required this.boxIndex, required this.parentFloor, required this.boxFloor});

  int boxIndex;
  Floor parentFloor;
  int boxFloor;
  @override
  FutureOr<void> onLoad() async {
    int x = boxIndex % 4;
    int y = 3 - (boxIndex ~/ 4);
    priority = y * 100 + x;
    anchor = Anchor.center;
    size = Vector2(145, 133);
    sprite = await gameRef.loadSprite('games/stackingboxes/box.png');

    //add(BoxTappable(position: size * 0.5, parentBox: this));

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentFloor.addBox(boxIndex);
  }
}

// class BoxTappable extends RectangleComponent with HasGameRef<StackingBoxesGame>, TapCallbacks {
//   BoxTappable({ required super.position, required this.parentBox}) : super(
//     size: Vector2(145, 90),
//     anchor: Anchor.center,
//   );

//   Box parentBox;

//   @override
//   FutureOr<void> onLoad() async {
//     debugMode = true;
//     return super.onLoad();
//   }

//   @override
//   void onTapUp(TapUpEvent event) {
//     super.onTapUp(event);
//     parentBox.parentFloor.addBox(parentBox.boxIndex);
//   }

//   @override
//   void render(Canvas canvas) {
//     //super.render(canvas);
//   }
// }
