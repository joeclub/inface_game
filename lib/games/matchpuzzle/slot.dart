import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'highlight.dart';
import 'match_puzzle_game.dart';

class Slot extends PositionComponent with HasGameRef<MatchPuzzleGame>, TapCallbacks{
  Slot({ required super.position, required this.puzzleIndex, required this.slotIndex, required this.isSecondHalf});

  bool isSecondHalf;
  int puzzleIndex;
  int slotIndex;
  late Highlight highlight;
  late SpriteComponent spriteComponent;

  @override
  FutureOr<void> onLoad() async {
    size = isSecondHalf ? Vector2(50, 250) : Vector2(84, 250);
    highlight = Highlight(position: size * 0.5, isSecondHalf: isSecondHalf);
    add(highlight);
    highlight.isVisible = false;
    
    spriteComponent = SpriteComponent(
      sprite: gameRef.lstSprites[puzzleIndex],
      anchor: Anchor.center,
      position: size * 0.5,
      size: isSecondHalf ? Vector2(50, 250) : Vector2(84, 250),
    );
    add(spriteComponent);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( gameRef.selectedSlotIndex < 0 ) {
      gameRef.selectedSlotIndex = slotIndex;
      highlight.isVisible = true;
    } else {
      gameRef.lstSlots[gameRef.selectedSlotIndex].highlight.isVisible = false;
      int temp = gameRef.lstSlots[gameRef.selectedSlotIndex].puzzleIndex;
      gameRef.lstSlots[gameRef.selectedSlotIndex].puzzleIndex = puzzleIndex;
      puzzleIndex = temp;
      gameRef.lstSlots[gameRef.selectedSlotIndex].updatePuzzleSprite();
      updatePuzzleSprite();
      gameRef.selectedSlotIndex = -1;
    }
  }

  void updatePuzzleSprite(){
    spriteComponent.sprite = gameRef.lstSprites[puzzleIndex];
  }

}