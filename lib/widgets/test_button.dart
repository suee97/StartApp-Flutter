import 'package:flutter/material.dart';

/// Button widget for simple test with large font

class TestButton extends StatelessWidget {
  TestButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  String title = "";
  VoidCallback onPressed = () => {};

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
            title,
          style: const TextStyle(fontSize: 30),
        )
    );
  }
}
