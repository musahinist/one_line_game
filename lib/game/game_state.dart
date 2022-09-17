import 'package:flutter/material.dart';
import 'package:one_line_game/game/levels.dart';
import 'package:one_line_game/game/one_line.dart';

import 'level_dialog.dart';

class GameStatePage extends StatefulWidget {
  const GameStatePage({super.key});
  static const routeName = '/game_state';

  @override
  State<GameStatePage> createState() => _GameStatePageState();
}

class _GameStatePageState extends State<GameStatePage> {
  final double gridPadding = 10;
  List<Line> templateLines = [];
  late double gridEdgeSize;
  int levelCount = 0;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gridEdgeSize = MediaQuery.of(context).size.width - gridPadding * 2;

    templateLines = levelList(gridEdgeSize)[levelCount].template;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(levelCount),
      body: OneLine(
        templateLines: templateLines,
        onPuzzleComleted: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => LevelDialog(
                onNext: () {
                  levelCount++;
                  templateLines = levelList(gridEdgeSize)[levelCount].template;
                  setState(() {});
                },
              ),
            );
          });
        },
      ),
    );
  }
}
