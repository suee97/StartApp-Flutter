import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:start_app/screens/login/sign_up/check_duplication_screen.dart';
import 'package:start_app/screens/login/sign_up/signup_screen.dart';
import 'package:start_app/screens/login/sign_up/check_info_screen.dart';
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

  @override
  void initState() {
    super.initState();
  }

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
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform:
            InAppWebViewOptions(useShouldOverrideUrlLoading: true),
          ),
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onLoadStart: (controller, url) {},
          onLoadStop: (controller, url) {
            print("onLoadStop : $url");
            bool isAuthSucess = urlController.text
                .startsWith("${dotenv.env["DEV_API_BASE_URL"]}");
            if (isAuthSucess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CheckInfoScreen()));
            }
          },
          onLoadError: (controller, url, intnum, string) {
            print("loaderror$url$intnum$string");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CheckInfoScreen()),
                    (route) => false);
          },
          onLoadHttpError: (controller, url, intnum, string) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CheckDuplicationScreen()),
                    (route) => false);
            print("loadhttperror$intnum$string");
            Common.showSnackBar(context, '네트워크 오류가 발생했습니다.');
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              webviewurl = url.toString();
              urlController.text = webviewurl;
            });
          },
          shouldOverrideUrlLoading:
              (controller, NavigationAction navigationAction) async {
            final url = navigationAction.request.url.toString();

            print(navigationAction);

            if (url.contains("login_process")) {
              return NavigationActionPolicy.ALLOW;
            }

            return NavigationActionPolicy.ALLOW;
          },
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}