import 'package:flutter/material.dart';

class OneLine extends StatefulWidget {
  const OneLine({Key? key}) : super(key: key);

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

    templateLines = [
      Line(
        Offset(gridEdgeSize / 2, 100),
        Offset(gridEdgeSize / 2 - 100, 300),
      ),
      Line(
        Offset(gridEdgeSize / 2 - 100, 300),
        Offset(gridEdgeSize / 2 + 120, 170),
      ),
      Line(
        Offset(gridEdgeSize / 2 + 120, 170),
        Offset(gridEdgeSize / 2 - 120, 170),
      ),
      Line(
        Offset(gridEdgeSize / 2 - 120, 170),
        Offset(gridEdgeSize / 2 + 100, 300),
      ),
      Line(
        Offset(gridEdgeSize / 2 + 100, 300),
        Offset(gridEdgeSize / 2, 100),
      ),
    ];
  }

  onPointerDown(PointerDownEvent event) {
    final Offset pointer = event.localPosition;
    for (var i = 0; i < templateLines.length; i++) {
      final distance = (templateLines[i].start - pointer).distance;

      if (distance <= radius + 10) {
        selectedIndexes = i;

        if (lineNodes.isNotEmpty) {
          // lineNodes.last.end = pointer;
        } else {
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
    if (templateLines.length != lineNodes.length) {
      lineNodes.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You win'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                lineNodes.clear();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OneLine'),
      ),
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
                  painter: _LinePainter(templateLines, Colors.grey, 5,
                      closePath: true),
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
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                if (lineNodes.isNotEmpty) {
                  lineNodes.removeLast();
                  setState(() {});
                }
              },
              icon: const Icon(
                Icons.undo,
                color: Colors.amber,
                size: 36,
              ),
              style: IconButton.styleFrom(),
            ),
            IconButton(
              onPressed: () {
                if (lineNodes.isNotEmpty) {
                  lineNodes.clear();
                  setState(() {});
                }
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.amber,
                size: 36,
              ),
              style: IconButton.styleFrom(),
            ),
            IconButton(
              onPressed: () {
                if (lineNodes.isNotEmpty) {
                  //   lineNodes.removeLast();
                  setState(() {});
                }
              },
              icon: const Icon(
                Icons.forward,
                color: Colors.amber,
                size: 36,
              ),
              style: IconButton.styleFrom(),
            ),
          ],
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
  final bool closePath;
  final double strokeWidth;
  _LinePainter(this.lines, this.color, this.strokeWidth,
      {this.closePath = false});
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
