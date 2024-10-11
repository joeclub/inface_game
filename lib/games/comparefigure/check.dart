import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Check extends PositionComponent with HasGameRef, HasVisibility{
  Check({ required super.position});

  late TextComponent checkText;

  @override
  FutureOr<void> onLoad() async {
    checkText = TextComponent(
      anchor: Anchor.center,
      text: 'V',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 122, 73, 244)),
      ),
      position: size * 0.5,
    );

    add(checkText);
  }
}