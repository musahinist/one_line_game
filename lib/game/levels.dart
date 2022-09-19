import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'one_line.dart';

class Level {
  final int number;

  final List<Line> template;

  Level(this.number, this.template);
}

List<Level> get levelList => [
      Level(1, [
        Line(Offset(39.375.w, 39.375.w), Offset(39.375.w, 319.875.w)),
        Line(Offset(39.375.w, 319.875.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(319.875.w, 39.375.w)),
        Line(Offset(319.875.w, 39.375.w), Offset(39.375.w, 39.375.w))
      ]),
      Level(2, [
        Line(Offset(179.625.w, 39.375.w), Offset(86.125.w, 319.875.w)),
        Line(Offset(86.125.w, 319.875.w), Offset(319.875.w, 132.875.w)),
        Line(Offset(319.875.w, 132.875.w), Offset(39.375.w, 132.875.w)),
        Line(Offset(39.375.w, 132.875.w), Offset(296.5.w, 319.875.w)),
        Line(Offset(296.5.w, 319.875.w), Offset(179.625.w, 39.375.w))
      ]),
      Level(3, [
        Line(Offset(39.375.w, 319.875.w), Offset(39.375.w, 39.375.w)),
        Line(Offset(39.375.w, 39.375.w), Offset(319.875.w, 39.375.w)),
        Line(Offset(319.875.w, 39.375.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(39.375.w, 319.875.w)),
        Line(Offset(39.375.w, 319.875.w), Offset(109.5.w, 249.75.w)),
        Line(Offset(109.5.w, 249.75.w), Offset(62.75.w, 179.625.w)),
        Line(Offset(62.75.w, 179.625.w), Offset(296.5.w, 179.625.w)),
        Line(Offset(296.5.w, 179.625.w), Offset(249.75.w, 249.75.w)),
        Line(Offset(249.75.w, 249.75.w), Offset(179.625.w, 156.25.w)),
        Line(Offset(179.625.w, 156.25.w), Offset(109.5.w, 249.75.w)),
        Line(Offset(109.5.w, 249.75.w), Offset(249.75.w, 249.75.w)),
        Line(Offset(249.75.w, 249.75.w), Offset(319.875.w, 319.875.w))
      ]),
      Level(4, [
        Line(Offset(39.375.w, 39.375.w), Offset(39.375.w, 319.875.w)),
        Line(Offset(39.375.w, 319.875.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(319.875.w, 39.375.w)),
        Line(Offset(319.875.w, 39.375.w), Offset(39.375.w, 39.375.w)),
        Line(Offset(39.375.w, 39.375.w), Offset(132.875.w, 132.875.w)),
        Line(Offset(132.875.w, 132.875.w), Offset(132.875.w, 249.75.w)),
        Line(Offset(132.875.w, 249.75.w), Offset(226.375.w, 249.75.w)),
        Line(Offset(226.375.w, 249.75.w), Offset(226.375.w, 132.875.w)),
        Line(Offset(226.375.w, 132.875.w), Offset(132.875.w, 132.875.w)),
        Line(Offset(132.875.w, 132.875.w), Offset(226.375.w, 249.75.w)),
        Line(Offset(226.375.w, 249.75.w), Offset(319.875.w, 319.875.w))
      ]),
      Level(5, [
        Line(Offset(62.75.w, 109.5.w), Offset(62.75.w, 319.875.w)),
        Line(Offset(62.75.w, 319.875.w), Offset(296.5.w, 319.875.w)),
        Line(Offset(296.5.w, 319.875.w), Offset(296.5.w, 109.5.w)),
        Line(Offset(296.5.w, 109.5.w), Offset(62.75.w, 109.5.w)),
        Line(Offset(62.75.w, 109.5.w), Offset(179.625.w, 16.0.w)),
        Line(Offset(179.625.w, 16.0.w), Offset(296.5.w, 109.5.w)),
        Line(Offset(296.5.w, 109.5.w), Offset(62.75.w, 319.875.w)),
        Line(Offset(62.75.w, 319.875.w), Offset(179.625.w, 16.0.w)),
        Line(Offset(179.625.w, 16.0.w), Offset(296.5.w, 319.875.w)),
        Line(Offset(296.5.w, 319.875.w), Offset(62.75.w, 109.5.w))
      ]),
      Level(6, [
        Line(Offset(62.75.w, 132.875.w), Offset(156.25.w, 62.75.w)),
        Line(Offset(156.25.w, 62.75.w), Offset(296.5.w, 62.75.w)),
        Line(Offset(296.5.w, 62.75.w), Offset(203.0.w, 132.875.w)),
        Line(Offset(203.0.w, 132.875.w), Offset(62.75.w, 132.875.w)),
        Line(Offset(62.75.w, 132.875.w), Offset(296.5.w, 62.75.w)),
        Line(Offset(296.5.w, 62.75.w), Offset(296.5.w, 226.375.w)),
        Line(Offset(296.5.w, 226.375.w), Offset(203.0.w, 296.5.w)),
        Line(Offset(203.0.w, 296.5.w), Offset(62.75.w, 296.5.w)),
        Line(Offset(62.75.w, 296.5.w), Offset(62.75.w, 132.875.w)),
        Line(Offset(62.75.w, 132.875.w), Offset(203.0.w, 296.5.w)),
        Line(Offset(203.0.w, 296.5.w), Offset(203.0.w, 132.875.w)),
        Line(Offset(203.0.w, 132.875.w), Offset(296.5.w, 226.375.w))
      ]),
      Level(7, [
        Line(Offset(179.625.w, 16.0.w), Offset(62.75.w, 179.625.w)),
        Line(Offset(62.75.w, 179.625.w), Offset(179.625.w, 132.875.w)),
        Line(Offset(179.625.w, 132.875.w), Offset(296.5.w, 179.625.w)),
        Line(Offset(296.5.w, 179.625.w), Offset(179.625.w, 16.0.w)),
        Line(Offset(179.625.w, 16.0.w), Offset(179.625.w, 343.25.w)),
        Line(Offset(179.625.w, 343.25.w), Offset(62.75.w, 179.625.w)),
        Line(Offset(62.75.w, 179.625.w), Offset(296.5.w, 179.625.w)),
        Line(Offset(296.5.w, 179.625.w), Offset(179.625.w, 343.25.w))
      ]),
      Level(8, [
        Line(Offset(39.375.w, 39.375.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(203.0.w, 132.875.w)),
        Line(Offset(203.0.w, 132.875.w), Offset(39.375.w, 39.375.w)),
        Line(Offset(39.375.w, 39.375.w), Offset(132.875.w, 203.0.w)),
        Line(Offset(132.875.w, 203.0.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(86.125.w, 249.75.w)),
        Line(Offset(86.125.w, 249.75.w), Offset(132.875.w, 203.0.w)),
        Line(Offset(132.875.w, 203.0.w), Offset(203.0.w, 132.875.w)),
        Line(Offset(203.0.w, 132.875.w), Offset(249.75.w, 86.125.w)),
        Line(Offset(249.75.w, 86.125.w), Offset(39.375.w, 39.375.w))
      ]),
      Level(9, [
        Line(Offset(179.625.w, 39.375.w), Offset(39.375.w, 179.625.w)),
        Line(Offset(39.375.w, 179.625.w), Offset(179.625.w, 319.875.w)),
        Line(Offset(179.625.w, 319.875.w), Offset(319.875.w, 179.625.w)),
        Line(Offset(319.875.w, 179.625.w), Offset(179.625.w, 39.375.w)),
        Line(Offset(179.625.w, 39.375.w), Offset(179.625.w, 86.125.w)),
        Line(Offset(179.625.w, 86.125.w), Offset(86.125.w, 179.625.w)),
        Line(Offset(86.125.w, 179.625.w), Offset(179.625.w, 273.125.w)),
        Line(Offset(179.625.w, 273.125.w), Offset(273.125.w, 179.625.w)),
        Line(Offset(273.125.w, 179.625.w), Offset(179.625.w, 86.125.w)),
        Line(Offset(179.625.w, 86.125.w), Offset(179.625.w, 132.875.w)),
        Line(Offset(179.625.w, 132.875.w), Offset(132.875.w, 179.625.w)),
        Line(Offset(132.875.w, 179.625.w), Offset(226.375.w, 179.625.w)),
        Line(Offset(226.375.w, 179.625.w), Offset(179.625.w, 132.875.w)),
        Line(Offset(179.625.w, 132.875.w), Offset(179.625.w, 273.125.w))
      ]),
      Level(10, [
        Line(Offset(62.75.w, 62.75.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(62.75.w, 296.5.w)),
        Line(Offset(62.75.w, 296.5.w), Offset(296.5.w, 296.5.w)),
        Line(Offset(296.5.w, 296.5.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(296.5.w, 62.75.w)),
        Line(Offset(296.5.w, 62.75.w), Offset(62.75.w, 62.75.w)),
        Line(Offset(62.75.w, 62.75.w), Offset(62.75.w, 179.625.w)),
        Line(Offset(62.75.w, 179.625.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(296.5.w, 179.625.w)),
        Line(Offset(296.5.w, 179.625.w), Offset(296.5.w, 296.5.w))
      ]),
      Level(11, [
        Line(Offset(39.375.w, 39.375.w), Offset(39.375.w, 179.625.w)),
        Line(Offset(39.375.w, 179.625.w), Offset(39.375.w, 319.875.w)),
        Line(Offset(39.375.w, 319.875.w), Offset(179.625.w, 319.875.w)),
        Line(Offset(179.625.w, 319.875.w), Offset(319.875.w, 319.875.w)),
        Line(Offset(319.875.w, 319.875.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(179.625.w, 319.875.w)),
        Line(Offset(179.625.w, 319.875.w), Offset(39.375.w, 179.625.w)),
        Line(Offset(39.375.w, 179.625.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(39.375.w, 39.375.w)),
        Line(Offset(39.375.w, 39.375.w), Offset(179.625.w, 39.375.w)),
        Line(Offset(179.625.w, 39.375.w), Offset(179.625.w, 179.625.w)),
        Line(Offset(179.625.w, 179.625.w), Offset(319.875.w, 179.625.w)),
        Line(Offset(319.875.w, 179.625.w), Offset(319.875.w, 319.875.w))
      ]),
      Level(12, [
        Line(Offset(179.625.w, 39.375.w), Offset(156.25.w, 62.75.w)),
        Line(Offset(156.25.w, 62.75.w), Offset(179.625.w, 62.75.w)),
        Line(Offset(179.625.w, 62.75.w), Offset(203.0.w, 62.75.w)),
        Line(Offset(203.0.w, 62.75.w), Offset(179.625.w, 39.375.w)),
        Line(Offset(179.625.w, 39.375.w), Offset(179.625.w, 62.75.w)),
        Line(Offset(179.625.w, 62.75.w), Offset(132.875.w, 109.5.w)),
        Line(Offset(132.875.w, 109.5.w), Offset(179.625.w, 109.5.w)),
        Line(Offset(179.625.w, 109.5.w), Offset(226.375.w, 109.5.w)),
        Line(Offset(226.375.w, 109.5.w), Offset(179.625.w, 62.75.w)),
        Line(Offset(179.625.w, 62.75.w), Offset(179.625.w, 109.5.w)),
        Line(Offset(179.625.w, 109.5.w), Offset(109.5.w, 156.25.w)),
        Line(Offset(109.5.w, 156.25.w), Offset(179.625.w, 156.25.w)),
        Line(Offset(179.625.w, 156.25.w), Offset(249.75.w, 156.25.w)),
        Line(Offset(249.75.w, 156.25.w), Offset(179.625.w, 109.5.w)),
        Line(Offset(179.625.w, 109.5.w), Offset(179.625.w, 156.25.w)),
        Line(Offset(179.625.w, 156.25.w), Offset(86.125.w, 203.0.w)),
        Line(Offset(86.125.w, 203.0.w), Offset(179.625.w, 203.0.w)),
        Line(Offset(179.625.w, 203.0.w), Offset(273.125.w, 203.0.w)),
        Line(Offset(273.125.w, 203.0.w), Offset(179.625.w, 156.25.w)),
        Line(Offset(179.625.w, 156.25.w), Offset(179.625.w, 203.0.w)),
        Line(Offset(179.625.w, 203.0.w), Offset(62.75.w, 249.75.w)),
        Line(Offset(62.75.w, 249.75.w), Offset(179.625.w, 249.75.w)),
        Line(Offset(179.625.w, 249.75.w), Offset(296.5.w, 249.75.w)),
        Line(Offset(296.5.w, 249.75.w), Offset(179.625.w, 203.0.w)),
        Line(Offset(179.625.w, 203.0.w), Offset(179.625.w, 249.75.w)),
        Line(Offset(179.625.w, 249.75.w), Offset(179.625.w, 343.25.w)),
        Line(Offset(179.625.w, 343.25.w), Offset(132.875.w, 343.25.w)),
        Line(Offset(132.875.w, 343.25.w), Offset(132.875.w, 319.875.w)),
        Line(Offset(132.875.w, 319.875.w), Offset(179.625.w, 319.875.w)),
        Line(Offset(179.625.w, 319.875.w), Offset(226.375.w, 319.875.w)),
        Line(Offset(226.375.w, 319.875.w), Offset(226.375.w, 343.25.w)),
        Line(Offset(226.375.w, 343.25.w), Offset(179.625.w, 343.25.w))
      ]),
      Level(13, [
        Line(Offset(86.125.w, 39.375.w), Offset(39.375.w, 86.125.w)),
        Line(Offset(39.375.w, 86.125.w), Offset(132.875.w, 179.625.w)),
        Line(Offset(132.875.w, 179.625.w), Offset(39.375.w, 273.125.w)),
        Line(Offset(39.375.w, 273.125.w), Offset(86.125.w, 319.875.w)),
        Line(Offset(86.125.w, 319.875.w), Offset(179.625.w, 226.375.w)),
        Line(Offset(179.625.w, 226.375.w), Offset(132.875.w, 179.625.w)),
        Line(Offset(132.875.w, 179.625.w), Offset(179.625.w, 132.875.w)),
        Line(Offset(179.625.w, 132.875.w), Offset(86.125.w, 39.375.w)),
        Line(Offset(86.125.w, 39.375.w), Offset(132.875.w, 179.625.w)),
        Line(Offset(132.875.w, 179.625.w), Offset(226.375.w, 179.625.w)),
        Line(Offset(226.375.w, 179.625.w), Offset(179.625.w, 132.875.w)),
        Line(Offset(179.625.w, 132.875.w), Offset(273.125.w, 39.375.w)),
        Line(Offset(273.125.w, 39.375.w), Offset(319.875.w, 86.125.w)),
        Line(Offset(319.875.w, 86.125.w), Offset(226.375.w, 179.625.w)),
        Line(Offset(226.375.w, 179.625.w), Offset(319.875.w, 273.125.w)),
        Line(Offset(319.875.w, 273.125.w), Offset(273.125.w, 319.875.w)),
        Line(Offset(273.125.w, 319.875.w), Offset(179.625.w, 226.375.w)),
        Line(Offset(179.625.w, 226.375.w), Offset(226.375.w, 179.625.w)),
        Line(Offset(226.375.w, 179.625.w), Offset(273.125.w, 39.375.w))
      ])
    ];
