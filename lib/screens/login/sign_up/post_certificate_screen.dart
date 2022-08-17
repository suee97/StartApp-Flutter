import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/sign_up_end_screen.dart';

class PostCertificateScreen extends StatefulWidget {
  const PostCertificateScreen({Key? key}) : super(key: key);

  @override
  State<PostCertificateScreen> createState() => _PostCertificateScreenState();
}

class _PostCertificateScreenState extends State<PostCertificateScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostCertificateScreen"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getImage(source: ImageSource.camera);
              },
              child: Container(
                width: 320.w,
                height: 320.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            LoginNavButton(
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  //     builder: (context) => SignUpEndScreen()), (route) => false);
                },
                title: "확인",
                colorHex: "425c5a",
                width: 304.w)
          ],
        ),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source, maxWidth: 640, maxHeight: 280, imageQuality: 100 //0-100
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
