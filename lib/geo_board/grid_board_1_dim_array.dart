import 'package:flutter/material.dart';

class GridBoard1DimArray extends StatefulWidget {
  const GridBoard1DimArray({Key? key}) : super(key: key);

  @override
  State<GridBoard1DimArray> createState() => _GeoBoardGameState();
}

class _GeoBoardGameState extends State<GridBoard1DimArray> {
  List<Offset> lineNodes = [];
  late _Grid grid;
  int selectedIndexes = -1;
  double radius = 18;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    grid = _Grid(6, 6, const Size(384, 384), radius);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridBoard1DimArray'),
      ),
      body: Center(
        child: Listener(
          onPointerDown: (details) {
            final Offset pointer = details.localPosition;
            for (var i = 0; i < grid.row * grid.col; i++) {
              final distance = (grid.nodes[i].center - pointer).distance;
              print(pointer);

              if (distance <= grid.nodeSize / 2) {
                selectedIndexes = i;

                lineNodes.addAll([grid.nodes[i].center, grid.nodes[i].center]);

                setState(() {});
                return;
              }
            }
          },
          onPointerMove: (details) {
            Offset pointer = details.localPosition;

            if (lineNodes.isNotEmpty) {
              List<int> near = nearIndexes(selectedIndexes);

              for (var i = 0; i < near.length; i++) {
                final distance =
                    (grid.nodes[near[i]].center - pointer).distance;

                if (distance < grid.nodeSize / 2) {
                  selectedIndexes = near[i];

                  if (lineNodes.length > 2 &&
                      grid.nodes[near[i]].center ==
                          lineNodes[lineNodes.length - 3]) {
                    lineNodes.removeAt(lineNodes.length - 2);

                    setState(() {});
                    return;
                  }
                  lineNodes.removeLast();

                  lineNodes.addAll([grid.nodes[near[i]].center, pointer]);

                  setState(() {});
                  return;
                }
              }
              lineNodes.last = pointer;
              setState(() {});
            } else {
              for (var i = 0; i < grid.col * grid.row; i++) {
                final distance = (grid.nodes[i].center - pointer).distance;

                if (distance <= grid.nodeSize / 4) {
                  selectedIndexes = i;
                  lineNodes.addAll([grid.nodes[i].center, pointer]);

                  setState(() {});
                  return;
                }
              }
            }
          },
          onPointerUp: (details) {
            selectedIndexes = -1;
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
                for (var i = 0; i < grid.col * grid.row; i++)
                  Positioned(
                    left: grid.nodes[i].pos.dx,
                    top: grid.nodes[i].pos.dy,
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
  final List<_Node> nodes;
  final double nodeSize;

  _Grid(this.row, this.col, this.size, double radius)
      : nodes = List.generate(
            row * col,
            (i) => _Node(
                  Offset(i % col * (size.width - radius * 2) / (col - 1),
                      i ~/ row * (size.height - radius * 2) / (row - 1)),
                )),
        nodeSize = (size.width - radius * 2) / (col - 1);
}

class _Node {
  final Offset pos;
  final Offset center;

  _Node(this.pos) : center = pos + const Offset(20, 20);
}

class _LinePainter extends CustomPainter {
  final List<Offset> points;
  _LinePainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 12
      ..color = Colors.blue
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
