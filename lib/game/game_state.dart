import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_line_game/game/levels.dart';
import 'package:one_line_game/game/one_line.dart';

import '../generator/geo_board_surface.dart';
import 'level_dialog.dart';

class GameStatePage extends StatefulWidget {
  const GameStatePage({super.key});
  static const routeName = '/game_state';

  @override
  State<GameStatePage> createState() => _GameStatePageState();
}

class _GameStatePageState extends State<GameStatePage> {
  final double gridPadding = 10;
  late Level level;
  late double gridEdgeSize;
  int levelCount = 0;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gridEdgeSize = MediaQuery.of(context).size.width - gridPadding * 2;

    level = levelList[levelCount];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.star),
        title: Column(
          children: [
            Text('${levelCount + 1}/${levelList.length}'),
          ],
        ),
        actions: [
          if (kDebugMode)
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, GeoBoardSurface.routeName);
                },
                icon: const Icon(Icons.create))
        ],
      ),
      key: ValueKey(levelCount),
      body: OneLine(
        level: level,
        onPuzzleComleted: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => LevelDialog(
                onNext: () {
                  levelCount++;
                  level = levelList[levelCount];
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
