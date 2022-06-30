import 'dart:math';

import 'package:flutter/material.dart';

class LinePuzzle extends StatefulWidget {
  const LinePuzzle({Key? key}) : super(key: key);
  static const routeName = 'Line Puzzle';

  @override
  State<LinePuzzle> createState() => _LinePuzzleState();
}

class _LinePuzzleState extends State<LinePuzzle> {
  List<Offset> lineNodes = [];
  late _Grid grid;
  int selectedIndexes = -1;
  Color? color = Colors.black;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double dim = MediaQuery.of(context).size.width - 36;
    grid = _Grid(6, 6, Size(dim, dim))..getRndPos();
  }

  List<int> nearIndexes(int selected) {
    List<int> near = [];
    if (selected % 6 > 0) {
      near.add(selected - 1);
    }
    if (selected % 6 < 5) {
      near.add(selected + 1);
    }
    if (selected ~/ 6 > 0) {
      near.add(selected - 6);
    }
    if (selected ~/ 6 < 5) {
      near.add(selected + 6);
    }

    return near;
  }

  bool inNode(Offset pointer, Offset node) {
    return pointer.dx > node.dx &&
        pointer.dx < node.dx + grid.nodeSize &&
        pointer.dy > node.dy &&
        pointer.dy < node.dy + grid.nodeSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinePuzzle'),
      ),
      body: Center(
        child: Listener(
          onPointerDown: (details) {
            final Offset pointer = details.localPosition;
            for (var i = 0; i < grid.row * grid.col; i++) {
              if (inNode(pointer, grid.nodes[i].pos)) {
                selectedIndexes = i;
                lineNodes.add(grid.nodes[i].center);
                color = grid.nodes[i].color;
                setState(() {});
                return;
              }
            }
          },
          onPointerMove: (details) {
            Offset pointer = details.localPosition;
            List<int> near = nearIndexes(selectedIndexes);

            for (var i = 0; i < near.length; i++) {
              if (inNode(pointer, grid.nodes[near[i]].pos)) {
                selectedIndexes = near[i];
                if (lineNodes.contains(grid.nodes[near[i]].center)) {
                  lineNodes.removeRange(
                      lineNodes.indexOf(grid.nodes[near[i]].center) + 1,
                      lineNodes.length);
                } else {
                  lineNodes.add(grid.nodes[near[i]].center);
                }
                setState(() {});
                return;
              }
            }
          },
          onPointerUp: (details) {
            selectedIndexes = -1;

            lineNodes.clear();

            setState(() {});
          },
          child: SizedBox(
            width: grid.size.width,
            height: grid.size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                for (var i = 0; i < grid.col * grid.row; i++)
                  Positioned(
                    left: grid.nodes[i].pos.dx,
                    top: grid.nodes[i].pos.dy,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: grid.nodeSize,
                      height: grid.nodeSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: .5),
                      ),
                      child: grid.nodes[i].color != null
                          ? CircleAvatar(backgroundColor: grid.nodes[i].color)
                          : null,
                    ),
                  ),
                CustomPaint(
                  painter: _LinePainter(lineNodes, color: color),
                ),
                if (selectedIndexes != -1)
                  Positioned(
                    left: grid.nodes[selectedIndexes].pos.dx,
                    top: grid.nodes[selectedIndexes].pos.dy,
                    child: CircleAvatar(
                      backgroundColor: color!.withOpacity(0.5),
                      radius: grid.nodeSize / 2,
                    ),
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
  final List<_Node> nodes;
  final double nodeSize;

  _Grid(this.row, this.col, this.size)
      : nodeSize = (size.width) / (col),
        nodes = List.generate(
          row * col,
          (i) => _Node(
              Offset(i % col * (size.width) / (col),
                  i ~/ row * (size.height) / (row)),
              null,
              (size.width) / (col)),
        );
  getRndPos() {
    for (var i = 0; i < 4; i++) {
      int rnd = Random().nextInt(nodes.length);
      if (i.isEven) {
        nodes[rnd].color = Colors.blue;
      } else {
        nodes[rnd].color = Colors.green;
      }
    }
  }
}

class _Node {
  final Offset pos;
  final Offset center;
  Color? color;

  _Node(this.pos, this.color, double nodeSize)
      : center = pos + Offset(nodeSize / 2, nodeSize / 2);

  @override
  String toString() => '_Node(pos: $pos, center: $center)';
}

class _LinePainter extends CustomPainter {
  final List<Offset> points;
  final Color? color;
  _LinePainter(this.points, {this.color = Colors.black});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 8
      ..color = color!
      ..strokeCap = StrokeCap.round;
    if (points.length > 1) {
      for (var i = 0; i < points.length - 1; ++i) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => true;
}
