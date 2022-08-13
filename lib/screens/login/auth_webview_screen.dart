import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AuthWebviewScreen extends StatefulWidget {
  const AuthWebviewScreen({Key? key}) : super(key: key);

  @override
  State<AuthWebviewScreen> createState() => _AuthWebviewScreenState();
}

class _AuthWebviewScreenState extends State<AuthWebviewScreen> {

  late final _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdfasdfasfd"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://for-a.seoultech.ac.kr/STECH/API/VIEW/login.jsp?orgnCd=571d03af1ce527b6d19dc0ddd8c0&returnUrl=http://localhost:8080/STECH/API/VIEW/returnTest.jsp")),
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
        },
        onReceivedHttpAuthRequest: (controller, url) async {
          print("onReceicedHttp : $url");
        },
      ),
    );
  }
}
