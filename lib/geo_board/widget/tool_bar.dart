import 'package:flutter/material.dart';

import 'color_picker.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({
    Key? key,
    required this.onColorChanged,
    required this.onClear,
    required this.onUndo,
  }) : super(key: key);
  final ValueSetter<Color> onColorChanged;
  final VoidCallback onClear;
  final VoidCallback onUndo;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorPicker(onColorChanged: widget.onColorChanged),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.onClear,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: const Icon(
                Icons.delete_forever,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.onUndo,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: const Icon(
                Icons.undo,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
