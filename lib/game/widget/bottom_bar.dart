import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.undo,
    required this.clear,
    required this.hint,
  }) : super(key: key);
  final VoidCallback undo;
  final VoidCallback clear;
  final VoidCallback hint;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: undo,
          icon: const Icon(
            Icons.undo,
            color: Colors.amber,
            size: 36,
          ),
          style: IconButton.styleFrom(),
        ),
        IconButton(
          onPressed: clear,
          icon: const Icon(
            Icons.refresh,
            color: Colors.amber,
            size: 36,
          ),
          style: IconButton.styleFrom(),
        ),
        IconButton(
          onPressed: hint,
          icon: Badge(
            badgeContent: Text(
              '2',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            child: const Icon(
              Icons.tips_and_updates_outlined,
              color: Colors.amber,
              size: 36,
            ),
          ),
          style: IconButton.styleFrom(),
        ),
      ],
    );
  }
}
