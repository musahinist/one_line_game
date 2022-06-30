import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridBoard2DimArray extends StatefulWidget {
  const GridBoard2DimArray({Key? key}) : super(key: key);

  @override
  State<GridBoard2DimArray> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<GridBoard2DimArray> {
  List<Offset> lineNodes = [];
  late _Grid grid;
  List<int> selectedIndexes = [];
  double radius = 16;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    grid = _Grid(6, 6, const Size(400, 400), radius);
  }

  // List<List<int>> nearIndexes(List<int> selected) {
  //   List<List<int>> near = [];
  //   for (int x = 0; x < 2; x++) {
  //     for (int y = 0; y < 2; y++) {
  //       near.addAll([
  //         [selected[0] - 1, selected[1]],
  //         [selected[0], selected[1] - 1],
  //         [selected[0], selected[1] + 1],
  //         [selected[0] + 1, selected[1]],
  //       ]);
  //     }
  //   }
  //   return near;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridBoard2DimArray'),
      ),
      body: Center(
        child: Listener(
          onPointerDown: (details) {
            final Offset pointer = details.localPosition;
            for (var x = 0; x < grid.col; x++) {
              for (var y = 0; y < grid.row; y++) {
                final distance = (grid.nodes[x][y].center - pointer).distance;

                if (distance <= grid.nodeSize / 2) {
                  selectedIndexes = [x, y];
                  //   print(selectedIndexes);
                  lineNodes.addAll(
                      [grid.nodes[x][y].center, grid.nodes[x][y].center]);
                  HapticFeedback.selectionClick();
                  setState(() {});
                  return;
                }
              }
            }
          },
          onPointerMove: (details) {
            Offset pointer = details.localPosition;
            if (lineNodes.isNotEmpty) {
              for (var x = max(0, selectedIndexes[0] - 1);
                  x <= min(selectedIndexes[0] + 1, grid.col - 1);
                  x++) {
                for (var y = max(0, selectedIndexes[1] - 1);
                    y <= min(selectedIndexes[1] + 1, grid.col - 1);
                    y++) {
                  final distance = (grid.nodes[x][y].center - pointer).distance;

                  if (distance < grid.nodeSize / 2 &&
                      lineNodes[lineNodes.length - 2] !=
                          grid.nodes[x][y].center) {
                    selectedIndexes = [x, y];
                    print(selectedIndexes);

                    lineNodes.removeLast();
                    lineNodes.addAll([grid.nodes[x][y].center, pointer]);
                    HapticFeedback.selectionClick();
                    setState(() {});
                    return;
                  }
                }
              }
              lineNodes.last = (pointer);
              setState(() {});
            } else {
              for (var x = 0; x < grid.col; x++) {
                for (var y = 0; y < grid.row; y++) {
                  final distance = (grid.nodes[x][y].center - pointer).distance;

                  if (distance <= grid.nodeSize / 4) {
                    selectedIndexes = [x, y];
                    lineNodes.addAll([grid.nodes[x][y].center, pointer]);
                    HapticFeedback.selectionClick();
                    setState(() {});
                    return;
                  }
                }
              }
            }
          },
          onPointerUp: (details) {
            lineNodes.removeLast();
            lineNodes.clear();

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
                      child: CircleAvatar(
                          backgroundColor: Colors.blue, radius: radius),
                    ),
                CustomPaint(
                  painter: _LinePainter(lineNodes),
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

  _Grid(this.row, this.col, this.size, double radius)
      : nodes = List.generate(
          row,
          (x) => List.generate(
            col,
            (y) => _Node(
              Offset(x * (size.width - radius * 2) / (col - 1),
                  y * (size.height - radius * 2) / (row - 1)),
            ),
          ),
        ),
        nodeSize = (size.width - radius * 2) / (col - 1);
}

class _Node {
  final Offset pos;
  final Offset center;

  _Node(this.pos) : center = pos + const Offset(16, 16);
}

class _LinePainter extends CustomPainter {
  final List<Offset> points;
  _LinePainter(this.points);
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
  bool shouldRepaint(_LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}
