import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'find_temperature_game.dart';

@RoutePage()
class FindTemperaturePage extends StatefulWidget {
  const FindTemperaturePage({super.key});

  @override
  State<FindTemperaturePage> createState() => _FindTemperaturePageState();
}

class _FindTemperaturePageState extends State<FindTemperaturePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FindTemperatureGame(context: context),
    );
  }
}
