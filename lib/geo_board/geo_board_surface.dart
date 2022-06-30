import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/tool_bar.dart';

class GeoBoardSurface extends StatefulWidget {
  const GeoBoardSurface({Key? key}) : super(key: key);

  @override
  State<GeoBoardSurface> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<GeoBoardSurface> {
  late _Grid grid;
  List<_Line> lines = [];
  Color selectedColor = Colors.black;
  @override
  void initState() {
    super.initState();
    grid = _Grid(10, 10, const Size(400, 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoBoardSurface'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Listener(
            onPointerDown: (details) {
              final Offset pointer = details.localPosition;
              if (lines.isEmpty) {
                List<List<dynamic>> distanceList = [];
                for (var x = 0; x < grid.col; x++) {
                  for (var y = 0; y < grid.row; y++) {
                    final distance =
                        (grid.nodes[x][y].center - pointer).distance;
                    if (distance < grid.nodeSize * 1.414 / 2) {
                      distanceList.add([x, y, distance]);
                    }
                  }
                }
                distanceList.sort((a, b) => a[2].compareTo(b[2]));

                lines.add(_Line(
                    grid.nodes[distanceList.first[0]][distanceList.first[1]]
                        .center,
                    pointer,
                    selectedColor));
                HapticFeedback.selectionClick();
                setState(() {});
              } else {
                lines.add(_Line(lines.last.end, pointer, selectedColor));
                setState(() {});
              }
            },
            onPointerMove: (details) {
              lines.last.end = details.localPosition;
              setState(() {});
            },
            onPointerUp: (details) {
              final Offset pointer = details.localPosition;
              List<List<dynamic>> distanceList = [];
              for (var x = 0; x < grid.col; x++) {
                for (var y = 0; y < grid.row; y++) {
                  final distance = (grid.nodes[x][y].center - pointer).distance;
                  distanceList.add([x, y, distance]);
                }
              }
              distanceList.sort((a, b) => a[2].compareTo(b[2]));
              if (lines.last.start ==
                  grid.nodes[distanceList.first[0]][distanceList.first[1]]
                      .center) {
                lines.removeLast();
              } else {
                lines.last.end = grid
                    .nodes[distanceList.first[0]][distanceList.first[1]].center;
              }

              HapticFeedback.selectionClick();
              setState(() {});
            },
            child: SizedBox(
              width: grid.size.width,
              height: grid.size.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (var x = 0; x < grid.col; x++)
                    for (var y = 0; y < grid.row; y++)
                      Positioned(
                        left: grid.nodes[x][y].pos.dx,
                        top: grid.nodes[x][y].pos.dy,
                        child: const CircleAvatar(
                            backgroundColor: Colors.grey, radius: 4),
                      ),
                  CustomPaint(
                    painter: _LinePainter(lines),
                  ),
                ],
              ),
            ),
          ),
          ToolBar(
            onClear: () {
              setState(() {
                lines.clear();
              });
            },
            onUndo: () {
              setState(() {
                if (lines.isNotEmpty) {
                  lines.removeLast();
                }
              });
            },
            onColorChanged: (color) {
              selectedColor = color;
            },
          )
        ],
      ),
    );
  }
}

class _Grid {
  final int row; //y
  final int col; //x
  final Size size;
  final List<List<_Node>> nodes;
  final double nodeSize;

  _Grid(this.row, this.col, this.size)
      : nodes = List.generate(
          row,
          (x) => List.generate(
            col,
            (y) => _Node(
              Offset(x * (size.width - 8) / (col - 1),
                  y * (size.height - 8) / (row - 1)),
            ),
          ),
        ),
        nodeSize = (size.width - 8) / (col - 1);
}

class _Node {
  final Offset pos;
  final Offset center;

  _Node(this.pos) : center = pos + const Offset(4, 4);
}

class _Line {
  final Offset start;
  Offset end;
  final Color color;

  _Line(this.start, this.end, this.color);
}

class _LinePainter extends CustomPainter {
  final List<_Line> lines;
  _LinePainter(this.lines);
  @override
  void paint(Canvas canvas, Size size) {
    var paintEdge = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    var paintSurface = Paint()..style = PaintingStyle.fill;

    var path = Path();
    if (lines.isNotEmpty) {
      path.moveTo(lines[0].start.dx, lines[0].start.dy);

      for (var i = 0; i < lines.length; i++) {
        paintEdge.color = lines[i].color;
        canvas.drawLine(lines[i].start, lines[i].end, paintEdge);

        path.lineTo(lines[i].start.dx, lines[i].start.dy);
      }
      path.lineTo(lines.last.end.dx, lines.last.end.dy);
      paintSurface.color = lines.first.color.withOpacity(0.5);
      canvas.drawPath(path, paintSurface);
      // canvas.drawPath(path, paintEdge);
      canvas.drawCircle(lines[0].start, 12, paintSurface);
      canvas.drawCircle(lines.last.end, 12, paintSurface);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}
