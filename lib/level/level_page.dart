import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../game/game_state.dart';
import '../game/levels.dart';
import '../game/line_panter.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});
  static const String routeName = '/level';

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  toolbarHeight: 80,
        title: const Text('Levels'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                // size: 36,
              ),
              style: IconButton.styleFrom(),
            ),
          ),
        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: levelList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, GameStatePage.routeName);
                },
                child: Column(
                  children: [
                    Container(
                      height: 1.sw * .36,
                      width: 1.sw * .38,
                      alignment: Alignment.topLeft,
                      child: Transform.scale(
                        scale: 0.34.w,
                        child: CustomPaint(
                          painter: LinePainter(
                              levelList[index].template,
                              Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${index + 1}'),
                          //  Icon(Icons.check),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
