import 'package:flutter/material.dart';
import 'package:one_line_game/game/one_line.dart';

class Level {
  final int number;

  final List<Line> template;

  Level(this.number, this.template);
}

List<Level> levelList(double gridEdgeSize) => [
      Level(0, templateLines0),
      Level(1, templateLines1),
      Level(2, templateLines2),
      Level(3, templateLines3),
      Level(4, templateLines4),
      Level(5, templateLines5),
    ];

List<Line> templateLines0 = [
  Line(const Offset(185.0, 8.0), const Offset(52.3, 362.0)),
  Line(const Offset(52.3, 362.0), const Offset(362.0, 140.8)),
  Line(const Offset(362.0, 140.8), const Offset(8.0, 140.8)),
  Line(const Offset(8.0, 140.8), const Offset(317.8, 362.0)),
  Line(const Offset(317.8, 362.0), const Offset(185.0, 8.0))
];
List<Line> templateLines1 = [
  Line(const Offset(52.3, 52.3), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(317.8, 317.8)),
  Line(const Offset(317.8, 317.8), const Offset(52.3, 52.3)),
  Line(const Offset(52.3, 52.3), const Offset(52.3, 317.8)),
  Line(const Offset(52.3, 317.8), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(185.0, 317.8)),
  Line(const Offset(185.0, 317.8), const Offset(52.3, 52.3))
];
List<Line> templateLines2 = [
  Line(const Offset(185.0, 52.3), const Offset(52.3, 8.0)),
  Line(const Offset(52.3, 8.0), const Offset(52.3, 362.0)),
  Line(const Offset(52.3, 362.0), const Offset(185.0, 317.8)),
  Line(const Offset(185.0, 317.8), const Offset(52.3, 185.0)),
  Line(const Offset(52.3, 185.0), const Offset(185.0, 52.3)),
  Line(const Offset(185.0, 52.3), const Offset(317.8, 8.0)),
  Line(const Offset(317.8, 8.0), const Offset(317.8, 362.0)),
  Line(const Offset(317.8, 362.0), const Offset(185.0, 317.8)),
  Line(const Offset(185.0, 317.8), const Offset(317.8, 185.0)),
  Line(const Offset(317.8, 185.0), const Offset(185.0, 52.3))
];
List<Line> templateLines3 = [
  Line(const Offset(52.3, 52.3), const Offset(185.0, 185.0)),
  Line(const Offset(185.0, 185.0), const Offset(52.3, 317.8)),
  Line(const Offset(52.3, 317.8), const Offset(52.3, 185.0)),
  Line(const Offset(52.3, 185.0), const Offset(317.8, 185.0)),
  Line(const Offset(317.8, 185.0), const Offset(317.8, 317.8)),
  Line(const Offset(317.8, 317.8), const Offset(185.0, 185.0)),
  Line(const Offset(185.0, 185.0), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(229.3, 52.3)),
  Line(const Offset(229.3, 52.3), const Offset(185.0, 96.5)),
  Line(const Offset(185.0, 96.5), const Offset(140.8, 52.3)),
  Line(const Offset(140.8, 52.3), const Offset(52.3, 52.3)),
  Line(const Offset(52.3, 52.3), const Offset(52.3, 185.0)),
  Line(const Offset(52.3, 185.0), const Offset(185.0, 317.8)),
  Line(const Offset(185.0, 317.8), const Offset(317.8, 185.0)),
  Line(const Offset(317.8, 185.0), const Offset(317.8, 52.3))
];
List<Line> templateLines4 = [
  Line(const Offset(52.3, 52.3), const Offset(317.8, 317.8)),
  Line(const Offset(317.8, 317.8), const Offset(185.0, 52.3)),
  Line(const Offset(185.0, 52.3), const Offset(52.3, 317.8)),
  Line(const Offset(52.3, 317.8), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(52.3, 185.0)),
  Line(const Offset(52.3, 185.0), const Offset(317.8, 185.0)),
  Line(const Offset(317.8, 185.0), const Offset(52.3, 52.3)),
  Line(const Offset(52.3, 52.3), const Offset(8.0, 185.0)),
  Line(const Offset(8.0, 185.0), const Offset(52.3, 317.8)),
  Line(const Offset(52.3, 317.8), const Offset(317.8, 317.8)),
  Line(const Offset(317.8, 317.8), const Offset(362.0, 185.0)),
  Line(const Offset(362.0, 185.0), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(52.3, 52.3))
];
List<Line> templateLines5 = [
  Line(const Offset(140.8, 52.3), const Offset(52.3, 140.8)),
  Line(const Offset(52.3, 140.8), const Offset(229.3, 140.8)),
  Line(const Offset(229.3, 140.8), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(140.8, 52.3)),
  Line(const Offset(140.8, 52.3), const Offset(229.3, 140.8)),
  Line(const Offset(229.3, 140.8), const Offset(229.3, 317.8)),
  Line(const Offset(229.3, 317.8), const Offset(317.8, 229.3)),
  Line(const Offset(317.8, 229.3), const Offset(317.8, 52.3)),
  Line(const Offset(317.8, 52.3), const Offset(229.3, 317.8)),
  Line(const Offset(229.3, 317.8), const Offset(52.3, 317.8)),
  Line(const Offset(52.3, 317.8), const Offset(52.3, 140.8)),
  Line(const Offset(52.3, 140.8), const Offset(229.3, 317.8))
];
