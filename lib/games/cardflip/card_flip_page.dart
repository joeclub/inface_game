import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'card_flip_game.dart';


@RoutePage()
class CardFlipPage extends StatefulWidget {
  const CardFlipPage({super.key});

  @override
  State<CardFlipPage> createState() => _CardFlipPageState();
}

class _CardFlipPageState extends State<CardFlipPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: CardFlipGame(context: context),
    );
  }
}
