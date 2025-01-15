import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'find_temperature_game.dart';

@RoutePage()
class FindTemperaturePage extends StatefulWidget {
  const FindTemperaturePage({super.key});

  @override
  State<FindTemperaturePage> createState() => _FindTemperaturePageState();
}

class _FindTemperaturePageState extends State<FindTemperaturePage> {
  
  final FindTemperatureGame _game = FindTemperatureGame(hasFirstHalfScore: false, hasRoundScore: false, isEP: false);

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
