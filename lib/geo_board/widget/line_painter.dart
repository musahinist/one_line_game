import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final List<Offset> points;
  LinePainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    if (points.length > 1) {
      for (var i = 0; i < points.length - 1; ++i) {
        //  paint.color = points[i].color;
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LinePainter oldDelegate) => true;
}
