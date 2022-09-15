// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

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
        Offset(gridEdgeSize / 2 + 100, 300),
      ),
      Line(
        Offset(gridEdgeSize / 2 + 100, 300),
        Offset(gridEdgeSize / 2 - 100, 300),
      ),
      Line(
        Offset(gridEdgeSize / 2 - 100, 300),
        Offset(gridEdgeSize / 2, 100),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OneLine'),
      ),
      body: Center(
        child: Listener(
          onPointerDown: (details) {
            final Offset pointer = details.localPosition;
            for (var i = 0; i < templateLines.length; i++) {
              final distance = (templateLines[i].start - pointer).distance;

              if (distance <= radius + 10) {
                selectedIndexes = i;

                if (lineNodes.isNotEmpty) {
                  // lineNodes.last.end = pointer;
                } else {
                  lineNodes.add(
                      Line(templateLines[i].start, templateLines[i].start));
                }

                setState(() {});
                return;
              }
            }
          },
          onPointerMove: (details) {
            Offset pointer = details.localPosition;
            lineNodes.last.end = pointer;
            setState(() {});
            if (lineNodes.isNotEmpty) {
              for (var i = 0; i < templateLines.length; i++) {
                final distance = (templateLines[i].start - pointer).distance;
                if (distance <= radius + 10 && i != selectedIndexes) {
                  bool inList = lineNodes.contains(
                          Line(lineNodes.last.start, templateLines[i].start)) ||
                      lineNodes.contains(
                          Line(templateLines[i].start, lineNodes.last.start));

                  if (!inList) {
                    lineNodes.last.end = templateLines[i].start;
                    selectedIndexes = i;

                    lineNodes
                        .add(Line(lineNodes.last.end, templateLines[i].start));
                  }

                  return;
                }
              }
            }
          },
          onPointerUp: (details) {
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
                        title: Text('You win'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                lineNodes.clear();
                                setState(() {});
                              },
                              child: Text('OK'))
                        ],
                      ));
            }

            setState(() {});
          },
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
                // for (var i = 0; i < grid.col * grid.row; i++)
                //   Positioned(
                //     left: grid.nodes[i].center.dx - radius,
                //     top: grid.nodes[i].center.dy - radius,
                //     child: CircleAvatar(
                //         backgroundColor: Colors.blue, radius: radius),
                //   ),

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
              icon: Icon(
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
              icon: Icon(
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
              icon: Icon(
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

class _Grid {
  final int row; //y
  final int col; //x
  final Size size;
  final List<_Node> nodes;
  final double nodeSize;

  _Grid(this.row, this.col, this.size, double radius)
      : nodes = List.generate(
            row * col,
            (i) => _Node(
                  Offset(
                      radius + i % col * (size.width - radius * 2) / (col - 1),
                      radius +
                          i ~/ row * (size.height - radius * 2) / (row - 1)),
                )),
        nodeSize = (size.width - radius * 2) / (col - 1);
}

class Shape {
  final List<Offset> nodes;
  Shape(this.nodes);
}

class Line extends Equatable {
  Offset start;
  Offset end;
  Line(this.start, this.end);

  @override
  String toString() => 'Line(start: $start, end: $end)';

  @override
  List<Object?> get props => [start, end];
}

class _Node {
  final Offset center;

  _Node(this.center);
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

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}

bool lineEqual(Line l0, Line l1) {
  return l0.start.dx == l1.start.dx &&
      l0.start.dy == l1.start.dy &&
      l0.end.dx == l1.end.dx &&
      l0.end.dy == l1.end.dy;
}
