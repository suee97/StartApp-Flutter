import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  MainWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  String title = "";
  VoidCallback onPressed;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.amberAccent,
        width: 100,
        height: 100,
        child: Center(
          child: Column(
            children: [icon, Text(title)],
          ),
        ),
      ),
    );
  }
}
