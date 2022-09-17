import 'package:flutter/material.dart';

class LevelDialog extends StatelessWidget {
  const LevelDialog({super.key, required this.onNext});
  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('You win'),
      actions: [
        TextButton(
          onPressed: () {
            onNext();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
