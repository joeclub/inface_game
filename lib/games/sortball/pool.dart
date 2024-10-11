import 'package:flame/components.dart';

class Pool extends PositionComponent with HasGameRef {
  final int ballCount;
  late NineTileBoxComponent tileBox;
  Pool({required super.position, required this.ballCount});

  @override
  Future<void> onLoad() async {
    final Sprite sprite = await gameRef.loadSprite('games/sortball/topBg.png');
    NineTileBox nineTileBox = NineTileBox(sprite)
      ..setGrid(leftWidth: 90, rightWidth: 90, topHeight: 1, bottomHeight: 1);
    nineTileBox = nineTileBox;
    anchor = Anchor.center;

    
    double width = (ballCount - 1) * 130 + 200;
    size = Vector2(width, 90);

    tileBox = NineTileBoxComponent(
      nineTileBox: nineTileBox,
      position: Vector2.zero(),
      size: size,
    );


    add(tileBox);

    super.onLoad();
  }
}
