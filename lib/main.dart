import 'package:flutter/material.dart';
import 'package:one_line_game/config/style/palette.dart';
import 'package:one_line_game/ui/home/home.dart';
import 'package:one_line_game/ui/setting/settings_screen.dart';
import 'game/game_state.dart';
import 'game/one_line.dart';

import 'generator/geo_board_surface.dart';
import 'level/level_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.pink,
              background: Palette.backgroundMain,
            ),
            textTheme: GoogleFonts.permanentMarkerTextTheme().apply(
              bodyColor: Palette.ink,
              displayColor: Colors.white,
            ),

            // textTheme: TextTheme(
            //   bodyText2: TextStyle(
            //     color: palette.ink,
            //   ),
            // ),
          ).copyWith(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Palette.ink,
              //backgroundColor: palette.darkPen,
            ),
            iconTheme: IconThemeData(
              color: Palette.ink,
              size: 32,
            ),
          ),
          initialRoute: HomePage.routeName,
          routes: Pages.routes,
        );
      },
    );
  }
}

class Pages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    HomePage.routeName: (context) => const HomePage(),
    SettingsScreen.routeName: (context) => const SettingsScreen(),
    LevelPage.routeName: (context) => const LevelPage(),
    GameStatePage.routeName: (context) => const GameStatePage(),
    GeoBoardSurface.routeName: (context) => const GeoBoardSurface(),
  };
}
