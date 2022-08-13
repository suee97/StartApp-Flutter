import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:start_app/screens/login/sign_up/get_student_id_screen.dart';
import 'package:start_app/screens/login/sign_up/signup_screen.dart';

import '../../../utils/common.dart';

class AuthWebviewScreen extends StatefulWidget {

  final String url;

  const AuthWebviewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<AuthWebviewScreen> createState() => _AuthWebviewScreenState();
}

class _AuthWebviewScreenState extends State<AuthWebviewScreen> {

  late final _controller;
  String webviewurl = "";
  final urlController = TextEditingController();
  late InAppWebViewController webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("학교 인증"),
      ),
      body: Stack(
          children: [InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true),
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onLoadStart: (controller, url) {
              print("onLoadStart : $url");
            },
            onLoadStop: (controller, url) {
              print("onLoadStop : $url");
              bool isAuthSucess = urlController.text.startsWith("${dotenv.env["DEV_API_BASE_URL"]}");
              if(isAuthSucess){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignupScreen()));
              }
            },
            onLoadError: (controller, url, intnum, string){
              print("loaderror$url$intnum$string");
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GetStudentIdScreen()), (route) => false);
              Common.showSnackBar(context, '네트워크 오류가 발생했습니다.');
            },
            onLoadHttpError: (controller, url, intnum, string){
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GetStudentIdScreen()), (route) => false);
              print("loadhttperror$intnum$string");
              Common.showSnackBar(context, '네트워크 오류가 발생했습니다.');
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.webviewurl = url.toString();
                urlController.text = this.webviewurl;
              });
            },
          ),
          ]
      ),

    );
  }
}