import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.controller, required this.isObscure})
      : super(key: key);

  final TextEditingController controller;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      style: const TextStyle(fontSize: 28),
      enableSuggestions: false,
      obscureText: isObscure,
    );
  }
}
