import 'package:flutter/material.dart';
import 'package:start_app/utils/common.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "개인정보 처리방침",
          style: Common.startAppBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SfPdfViewer.asset("pdfs/privacy_policy_220823.pdf")
    );
  }
}
