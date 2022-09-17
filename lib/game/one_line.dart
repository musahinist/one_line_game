import 'package:flutter/material.dart';
import 'package:one_line_game/generator/geo_board_surface.dart';

import 'widget/animated_star.dart';
import 'widget/bottom_bar.dart';

class OneLine extends StatefulWidget {
  const OneLine(
      {Key? key, required this.templateLines, required this.onPuzzleComleted})
      : super(key: key);
  final VoidCallback onPuzzleComleted;
  final List<Line> templateLines;
  @override
  State<OneLine> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<OneLine> {
  List<Line> lineNodes = [];

  int selectedIndexes = -1;
  final double radius = 8;

  final double gridPadding = 10;
  List<Line> templateLines = [];
  late double gridEdgeSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gridEdgeSize = MediaQuery.of(context).size.width - gridPadding * 2;

    templateLines = widget.templateLines;
  }

  onPointerDown(PointerDownEvent event) {
    final Offset pointer = event.localPosition;
    if (lineNodes.isNotEmpty) {
      lineNodes.add(Line(lineNodes.last.end, lineNodes.last.end));
      // lineNodes.last.end = pointer;
    }
    for (var i = 0; i < templateLines.length; i++) {
      final distance = (templateLines[i].start - pointer).distance;

      if (distance <= radius + 10) {
        selectedIndexes = i;

        if (lineNodes.isEmpty) {
          lineNodes.add(Line(templateLines[i].start, templateLines[i].start));
        }

        setState(() {});
        return;
      }
    }
  }

  onPointerMove(PointerMoveEvent event) {
    Offset pointer = event.localPosition;
    setState(() {});
    if (lineNodes.isNotEmpty) {
      lineNodes.last.end = pointer;
      for (var i = 0; i < templateLines.length; i++) {
        final distance = (templateLines[i].start - pointer).distance;
        if (distance <= radius + 10 && i != selectedIndexes) {
          Line line = Line(lineNodes.last.start, templateLines[i].start);
          Line reverseLine = Line(templateLines[i].start, lineNodes.last.start);
          bool inTemplate = templateLines.contains(line) ||
              templateLines.contains(reverseLine);
          bool inList =
              lineNodes.contains(line) || lineNodes.contains(reverseLine);

          if (!inList && inTemplate) {
            lineNodes.last.end = templateLines[i].start;
            selectedIndexes = i;

            lineNodes.add(Line(lineNodes.last.end, templateLines[i].start));
          }
          return;
        }
      }
    }
  }

  onPointerUp(PointerUpEvent event) {
    selectedIndexes = -1;
    if (lineNodes.isNotEmpty) {
      lineNodes.removeLast();
    }
    if (templateLines.length == lineNodes.length && !levelCompleted) {
      widget.onPuzzleComleted();
      levelCompleted = true;
    }
    setState(() {});
  }

  bool levelCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.star),
        title: Column(
          children: [
            const Text('2/20'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, GeoBoardSurface.routeName);
              },
              icon: const Icon(Icons.create))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: AnimatedStars(animate: levelCompleted),
      body: Center(
        child: Listener(
          onPointerDown: onPointerDown,
          onPointerMove: onPointerMove,
          onPointerUp: onPointerUp,
          child: SizedBox(
            width: gridEdgeSize,
            height: gridEdgeSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _LinePainter(templateLines, Colors.grey, 5),
                ),
                for (var i = 0; i < templateLines.length; i++)
                  Positioned(
                    left: templateLines[i].start.dx - radius,
                    top: templateLines[i].start.dy - radius,
                    child: CircleAvatar(
                        backgroundColor: Colors.blue, radius: radius),
                  ),
                CustomPaint(
                  painter: _LinePainter(lineNodes, Colors.pink, 6),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomBarWidget(
          undo: () {
            if (lineNodes.isNotEmpty) {
              lineNodes.removeLast();
            }
          },
          clear: () {
            lineNodes.clear();
          },
          hint: () {},
        ),
      ],
    );
  }
}

class Line {
  Offset start;
  Offset end;
  Line(this.start, this.end);

  @override
  String toString() => 'Line(start: $start, end: $end)';

  @override
  bool operator ==(covariant Line other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

class _LinePainter extends CustomPainter {
  final List<Line> lines;
  final Color color;

  final double strokeWidth;
  _LinePainter(this.lines, this.color, this.strokeWidth);
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
  bool shouldRepaint(_LinePainter oldDelegate) => true;
}
