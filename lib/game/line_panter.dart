import 'package:flutter/material.dart';

import 'one_line.dart';

class LinePainter extends CustomPainter {
  final List<Line> lines;
  final Color color;
  final bool repaint;

  final double strokeWidth;
  LinePainter(this.lines, this.color, this.strokeWidth, {this.repaint = false});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = StrokeCap.round;
    if (lines.isNotEmpty) {
      for (var i = 0; i < lines.length; ++i) {
        canvas.drawLine(lines[i].start, lines[i].end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => repaint;
}
