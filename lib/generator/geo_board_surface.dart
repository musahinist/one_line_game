import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeoBoardSurface extends StatefulWidget {
  const GeoBoardSurface({Key? key}) : super(key: key);
  static const routeName = '/geo_board_surface';

  @override
  State<GeoBoardSurface> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<GeoBoardSurface> {
  late _Grid grid;
  List<_Line> lines = [];
  Color selectedColor = Colors.black;
  final double radius = 8;
  late double width;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    grid = _Grid(
        15,
        15,
        Size(
          width,
          MediaQuery.of(context).size.height,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoBoardSurface'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              print(lines);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Listener(
            onPointerDown: (details) {
              final Offset pointer = details.localPosition;
              if (lines.isEmpty) {
                List<List<dynamic>> distanceList = [];
                for (var x = 0; x < grid.row; x++) {
                  for (var y = 0; y < grid.col; y++) {
                    final distance = (grid.nodes[x][y].pos - pointer).distance;
                    if (distance < grid.nodeSize * 1.414 / 2) {
                      distanceList.add([x, y, distance]);
                    }
                  }
                }
                distanceList.sort((a, b) => a[2].compareTo(b[2]));

                lines.add(_Line(
                    grid.nodes[distanceList.first[0]][distanceList.first[1]]
                        .pos,
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
              for (var x = 0; x < grid.row; x++) {
                for (var y = 0; y < grid.col; y++) {
                  final distance = (grid.nodes[x][y].pos - pointer).distance;
                  distanceList.add([x, y, distance]);
                }
              }
              distanceList.sort((a, b) => a[2].compareTo(b[2]));
              if (lines.last.start ==
                  grid.nodes[distanceList.first[0]][distanceList.first[1]]
                      .pos) {
                lines.removeLast();
              } else {
                lines.last.end = grid
                    .nodes[distanceList.first[0]][distanceList.first[1]].pos;
              }

              HapticFeedback.selectionClick();
              setState(() {});
            },
            child: SizedBox(
              width: width,
              height: width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (var x = 0; x < grid.row; x++)
                    for (var y = 0; y < grid.col; y++)
                      Positioned(
                        left: grid.nodes[x][y].pos.dx - radius,
                        top: grid.nodes[x][y].pos.dy - radius,
                        child: CircleAvatar(
                            backgroundColor: Colors.grey, radius: radius),
                      ),
                  CustomPaint(
                    painter: _LinePainter(lines),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        ButtonBar(
          children: [
            IconButton(
              onPressed: () {
                if (lines.isNotEmpty) {
                  lines.removeLast();
                }
              },
              icon: const Icon(
                Icons.undo,
                color: Colors.amber,
                size: 36,
              ),
              style: IconButton.styleFrom(),
            ),
          ],
        )
      ],
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
              Offset((16 + (x * (size.width - 16)) / (row + 1)),
                  (16 + (y * (size.width - 16)) / (col + 1))),
            ),
          ),
        ),
        nodeSize = (size.width) / (col);
}

class _Node {
  final Offset pos;

  _Node(this.pos);
}

class _Line {
  final Offset start;
  Offset end;
  final Color color;

  _Line(this.start, this.end, this.color);

  @override
  bool operator ==(covariant _Line other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end && other.color == color;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ color.hashCode;

  @override
  String toString() =>
      'Line( Offset(${start.dx}.w,${start.dy}.w), Offset(${end.dx}.w,${end.dy}.w))';
}

class _LinePainter extends CustomPainter {
  final List<_Line> lines;
  _LinePainter(this.lines);
  @override
  void paint(Canvas canvas, Size size) {
    var paintEdge = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
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
      // canvas.drawPath(path, paintSurface);
      canvas.drawPath(path, paintEdge);
      canvas.drawCircle(lines[0].start, 12, paintSurface);
      canvas.drawCircle(lines.last.end, 12, paintSurface);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}
