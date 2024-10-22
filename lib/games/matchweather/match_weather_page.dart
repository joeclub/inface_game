import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_weather_game.dart';

@RoutePage()
class MatchWeatherPage extends StatefulWidget {
  const MatchWeatherPage({super.key});

  @override
  State<MatchWeatherPage> createState() => _MatchWeatherPageState();
}

class _MatchWeatherPageState extends State<MatchWeatherPage> {
  
  final MatchWeatherGame _game = MatchWeatherGame();

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
