import 'dart:async';

import 'package:flame/components.dart';

import 'box.dart';
import 'floor_tile.dart';
import 'stacking_boxes_game.dart';

class Floor extends PositionComponent with HasGameRef<StackingBoxesGame>{
 Floor({ required super.position});
 List<FloorTile> lstTiles = [];
 List<Vector2> lstBoxBasePositions = [];
 List<int> lstBoxes = List.filled(16, 0);
 List<Box> lstBoxComponents = [];

 //final Vector2 boxSize = Vector2(145, 133);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    scale = Vector2(0.8, 0.8);

    Sprite spriteFloor = await gameRef.loadSprite('games/stackingboxes/floor.png');
    add(
      SpriteComponent(
        sprite: spriteFloor,
        anchor: Anchor.center,
        priority: 0,
      ),
    );

    FloorTile floorTile = FloorTile(position: Vector2(-225, 0), boxIndex: 0, parentFloor: this );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-142, 17), boxIndex: 1, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-55, 35), boxIndex: 2, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(27, 53), boxIndex: 3, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-160, -22), boxIndex: 4, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-77, -4), boxIndex: 5, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(10, 14), boxIndex: 6, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(94, 31), boxIndex: 7, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-92, -43), boxIndex: 8, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-9, -26), boxIndex: 9, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(75, -9), boxIndex: 10, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(161, 8), boxIndex: 11, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(-24, -65), boxIndex: 12, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(58, -48), boxIndex: 13, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(142, -31), boxIndex: 14, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    floorTile = FloorTile(position: Vector2(227, -13), boxIndex: 15, parentFloor: this  );
    add(floorTile);
    lstTiles.add(floorTile);

    Vector2 boxPos = Vector2(-225, -45);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-142, -28);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-60, -10);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(22, 7);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-160, -67);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-77, -50);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(6, -33);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(88, -15);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-92, -88);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-9, -72);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(74, -55);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(155, -38);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(-24, -110);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(58, -94);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(141, -77);
    lstBoxBasePositions.add(boxPos);

    boxPos = Vector2(224, -60);
    lstBoxBasePositions.add(boxPos);

    // Sprite spriteBox = await gameRef.loadSprite('games/stackingboxes/box.png');
    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: lstBoxBasePositions[12],
    //   ),
    // );

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: lstBoxBasePositions[13],
    //   ),
    // );

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: lstBoxBasePositions[14],
    //   ),
    // );

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: lstBoxBasePositions[15],
    //   ),
    // );

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: lstBoxBasePositions[7],
    //   ),
    // );

    //boxPos = Vector2(-225, -139);

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: boxPos,
    //   ),
    // );

    // boxPos = Vector2(-142, -122);

    // add(
    //   SpriteComponent(
    //     sprite: spriteBox,
    //     anchor: Anchor.center,
    //     size: boxSize,
    //     position: boxPos,
    //   ),
    // );

    
    return super.onLoad();
  }

  void addBox(int boxIndex){
    int floor = lstBoxes[boxIndex];
    if( floor >= 4 ) return;
    Vector2 pos = Vector2(lstBoxBasePositions[boxIndex].x, lstBoxBasePositions[boxIndex].y - (floor * 94));
    Box box = Box(
      position: pos,
      boxIndex: boxIndex,
      parentFloor: this,
      boxFloor: lstBoxes[boxIndex]+1,
    );
    add(box);
    lstBoxComponents.add(box);
    lstBoxes[boxIndex]++;
  }

  void reset(){
    lstBoxes = List.filled(16, 0);
    for( int i=0; i<lstBoxComponents.length; ++i){
      remove(lstBoxComponents[i]);
    }
    lstBoxComponents.clear();
  }
}