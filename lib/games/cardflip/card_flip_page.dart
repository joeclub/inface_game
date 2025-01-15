import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'card_flip_game.dart';


@RoutePage()
class CardFlipPage extends StatefulWidget {
  const CardFlipPage({super.key});

  @override
  State<CardFlipPage> createState() => _CardFlipPageState();
}

class _CardFlipPageState extends State<CardFlipPage> {

  final CardFlipGame _game = CardFlipGame(hasFirstHalfScore: true, hasRoundScore: true, isEP: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameBackButton.context = context;
    return GameWidget(
      game: _game,
    );
  }
}
