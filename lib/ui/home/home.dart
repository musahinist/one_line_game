import 'package:flutter/material.dart';
import 'package:one_line_game/level/level_page.dart';
import 'package:one_line_game/ui/setting/settings_screen.dart';

import '../../config/const/app_const.dart';
import 'widget/app_title.dart';
import 'package:badges/badges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FloatingActionButton(
            mini: true,
            heroTag: "setting",
            shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 3)),
            backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
            child: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppTitleWidget(),
            SizedBox(
              height: 264,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 52,
                      child: FloatingActionButton.extended(
                          heroTag: "start",
                          backgroundColor: Colors.greenAccent[400],
                          icon: const Icon(Icons.sports_esports_outlined),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 4)),
                          label: const Text(
                            'Play',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, LevelPage.routeName);
                          }),
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      height: 52,
                      child: FloatingActionButton.extended(
                          heroTag: "challenge",
                          backgroundColor: Colors.pinkAccent,
                          icon: const Icon(Icons.workspaces_outline),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 4)),
                          label: const Text(
                            'Challenge',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {}),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          heroTag: "profile",
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.white, width: 4)),
                          backgroundColor: Colors.indigoAccent,
                          onPressed: () {
                            //   Navigator.pushNamed(context, SettingPage.routeName);
                          },
                          child: const Icon(Icons.person_outline),
                        ),
                        FloatingActionButton(
                          heroTag: "market",
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.white, width: 4)),
                          backgroundColor: Colors.purpleAccent,
                          onPressed: () {
                            //   Navigator.pushNamed(context, SettingPage.routeName);
                          },
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                        Badge(
                          badgeContent: const Text(
                            '3',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          badgeColor: Colors.blue,
                          padding: const EdgeInsets.all(8),
                          child: FloatingActionButton(
                            heroTag: "stats",
                            shape: const CircleBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 4)),
                            backgroundColor: Colors.amber,
                            onPressed: () {},
                            child: const Icon(Icons.tips_and_updates_outlined),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: "vollume",
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 4)),
              backgroundColor: Colors.teal,
              onPressed: () {},
              child: Icon(
                  false ? Icons.volume_off_outlined : Icons.volume_up_outlined),
            )
          ],
        ),
      ),
    );
  }
}
