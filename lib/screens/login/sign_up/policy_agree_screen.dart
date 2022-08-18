import 'package:flutter/material.dart';

class PolicyAgreeScreen extends StatefulWidget {
  const PolicyAgreeScreen({Key? key}) : super(key: key);

  @override
  State<PolicyAgreeScreen> createState() => _PolicyAgreeScreenState();
}

class _PolicyAgreeScreenState extends State<PolicyAgreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("이용약관 페이지"),
    );
  }
}
