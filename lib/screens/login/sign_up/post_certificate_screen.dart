import 'package:flutter/material.dart';
import 'package:start_app/screens/login/sign_up/sign_up_end_screen.dart';
import 'package:start_app/widgets/test_button.dart';

class PostCertificateScreen extends StatelessWidget {
  const PostCertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostCertificateScreen"),
      ),
      body: TestButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignUpEndScreen()),
              (route) => false);
        },
        title: ("다음"),
      ),
    );
  }
}
