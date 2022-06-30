import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key, required this.onColorChanged}) : super(key: key);
  final ValueSetter<Color> onColorChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color selectedColor = Colors.black;
  List<Color> colorList = [
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(colorList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = colorList[index];
              widget.onColorChanged(selectedColor);
            });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: colorList[index],
                border: Border.all(
                    color: selectedColor == colorList[index]
                        ? Colors.black
                        : Colors.transparent,
                    width: 2)),
          ),
        );
      }),
    );
  }
}
