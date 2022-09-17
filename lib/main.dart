import 'package:flutter/material.dart';
import 'package:one_line_game/game/game_state.dart';
import 'package:one_line_game/game/one_line.dart';
import 'package:one_line_game/generator/geo_board_edge.dart';
import 'package:one_line_game/generator/geo_board_surface.dart';
import 'package:one_line_game/level/level_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: GameStatePage.routeName,
      routes: Pages.routes,
    );
  }
}

class Pages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    LevelPage.routeName: (context) => const LevelPage(),
    GameStatePage.routeName: (context) => const GameStatePage(),
    GeoBoardEdge.routeName: (context) => const GeoBoardEdge(),
    GeoBoardSurface.routeName: (context) => const GeoBoardSurface(),
  };
}
