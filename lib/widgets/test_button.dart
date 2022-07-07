import 'package:flutter/material.dart';

/// Button widget for simple test with large font

class TestButton extends StatelessWidget {
  TestButton({Key? key, required this.title, required this.callback}) : super(key: key);

  String title = "";
  VoidCallback callback = () => {};

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: callback,
        child: Text(
            title,
          style: const TextStyle(fontSize: 30),
        )
    );
  }
}
