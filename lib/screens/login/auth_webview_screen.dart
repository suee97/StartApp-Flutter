import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:start_app/screens/login/signup_screen.dart';

class AuthWebviewScreen extends StatefulWidget {
  const AuthWebviewScreen({Key? key}) : super(key: key);

  @override
  State<AuthWebviewScreen> createState() => _AuthWebviewScreenState();
}

class _AuthWebviewScreenState extends State<AuthWebviewScreen> {

  late final _controller;
  String url = "";
  final urlController = TextEditingController();

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
                  "https://kkangddong.w3spaces.com/index.html")),
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
            bool isAuthSucess = urlController.text.startsWith("https://kkangddong.w3spaces.com/contents");
            if(isAuthSucess){
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SignupScreen()));
          }
          },
          onReceivedHttpAuthRequest: (controller, url) async {
            print("onReceicedHttp : $url");
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
        ),
        ]
      ),

    );
  }
}
