import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeoBoardEdge extends StatefulWidget {
  const GeoBoardEdge({Key? key}) : super(key: key);
  static const String routeName = '/generator';

  @override
  State<GeoBoardEdge> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<GeoBoardEdge> {
  late _Grid grid;
  List<_Line> lines = [];
  Color selectedColor = Colors.black;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    grid = _Grid(
        10,
        10,
        Size(MediaQuery.of(context).size.width - 20,
            MediaQuery.of(context).size.width - 20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoBoardEdge'),
      ),
      body: Center(
        child: Listener(
          onPointerDown: (details) {
            final Offset pointer = details.localPosition;
            List<List<dynamic>> distanceList = [];
            for (var x = 0; x < grid.col; x++) {
              for (var y = 0; y < grid.row; y++) {
                final distance = (grid.nodes[x][y].center - pointer).distance;
                if (distance < grid.nodeSize * 1.414 / 2) {
                  distanceList.add([x, y, distance]);
                }
              }
            }
            distanceList.sort((a, b) => a[2].compareTo(b[2]));

            lines.add(_Line(
                grid.nodes[distanceList.first[0]][distanceList.first[1]].center,
                pointer,
                selectedColor));
            HapticFeedback.selectionClick();
            setState(() {});
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
              Offset((10 + x * (size.width - 10)) / (col - 1),
                  (10 + y * (size.height - 10)) / (row - 1)),
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
    var paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < lines.length; ++i) {
      paint.color = lines[i].color;
      canvas.drawLine(lines[i].start, lines[i].end, paint);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}
