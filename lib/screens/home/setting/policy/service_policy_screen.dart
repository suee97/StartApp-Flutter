import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../utils/common.dart';

class ServicePolicyScreen extends StatelessWidget {
  const ServicePolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "서비스 이용약관",
            style: Common.startAppBarTextStyle,
          ),
          elevation: 0,
          centerTitle: true,
          foregroundColor: HexColor("425C5A"),
          backgroundColor: Colors.white,
        ),
        body: SfPdfViewer.asset("pdfs/service_policy_220823.pdf"));
  }
}
