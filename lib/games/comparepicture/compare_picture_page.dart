import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'compare_picture_game.dart';

@RoutePage()
class ComparePicturePage extends StatefulWidget {
  const ComparePicturePage({super.key});

  @override
  State<ComparePicturePage> createState() => _ComparePicturePageState();
}

class _ComparePicturePageState extends State<ComparePicturePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: ComparePictureGame(context: context),
    );
  }
}
