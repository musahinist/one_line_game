import 'package:flutter/material.dart';
import 'package:one_line_game/geo_board/geo_board_edge.dart';
import 'package:one_line_game/geo_board/grid_board_2_dim_array.dart';
import 'package:one_line_game/geo_board/line_puzzle.dart';
import 'package:one_line_game/geo_board/line_puzzle_template.dart';
import 'package:one_line_game/geo_board/untangle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GridBoard2DimArray(),
    );
  }
}
