import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'match_puzzle_game.dart';

class Highlight extends ColorRectComponent with HasGameRef<MatchPuzzleGame>, HasVisibility{
  Highlight({required super.position, required this.isSecondHalf}) : 
    super(color: const Color.fromARGB(255, 133, 58, 253),
    size: Vector2(338, 70), anchor: Anchor.center);

  bool isSecondHalf;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = isSecondHalf ? Vector2(52, 252) : Vector2(86, 252);
    return super.onLoad();
  }

}
