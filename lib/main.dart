import 'package:flutter/material.dart';
import 'game/game_state.dart';
import 'game/one_line.dart';

import 'generator/geo_board_surface.dart';
import 'level/level_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: LevelPage.routeName,
          routes: Pages.routes,
        );
      },
    );
  }
}

class Pages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    LevelPage.routeName: (context) => const LevelPage(),
    GameStatePage.routeName: (context) => const GameStatePage(),
    GeoBoardSurface.routeName: (context) => const GeoBoardSurface(),
  };
}
