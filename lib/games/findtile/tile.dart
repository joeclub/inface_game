import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'find_tile_game.dart';

enum TileType{
  defaultTile,
  sample,
  click,
}

class Tile extends SpriteComponent with HasGameRef<FindTileGame>, TapCallbacks {
  Tile( {required super.position, required this.spriteDefault, required this.spriteSample, required this.spriteClick} );
  
  List<Sprite> lstSprites = [];

  bool isTappable = false;
  TileType tileType = TileType.defaultTile;

  Sprite spriteDefault;
  Sprite spriteSample;
  Sprite spriteClick;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(76);
    sprite = spriteDefault;
    lstSprites.add(spriteDefault);
    lstSprites.add(spriteSample);
    lstSprites.add(spriteClick);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( isTappable == false ) return;
    if( tileType != TileType.defaultTile ) return;
    flip(TileType.click);
  }

  void flip(TileType type){
    isTappable = false;
    int index = type.index;
    Sprite nextSprite = lstSprites[index];
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          sprite = nextSprite;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                tileType = type;
                if( type == TileType.defaultTile ){
                  isTappable = true;
                }

                if( tileType == TileType.click){
                  gameRef.checkCorrect();
                }
              }
            )
          );
        }
      )
    );
  }
}