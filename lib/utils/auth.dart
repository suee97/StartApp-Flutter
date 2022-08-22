import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/status_code.dart';

class Auth {
  static final secureStorage = FlutterSecureStorage();

  /// ######################################################
  /// ##################### 토큰으로 인증 #####################
  /// ######################################################
  static Future<StatusCode> authAccessToken() async {
    final AT = await secureStorage.read(key: "ACCESS_TOKEN");
    final RT = await secureStorage.read(key: "REFRESH_TOKEN");

    if (AT == null || AT.isEmpty) {
      print("authAccessToken() call error : 잘못된 access token");
      return StatusCode.UNCATCHED_ERROR;
    }

    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"), headers: {
        "Authorization": "Bearer $AT"
      }).timeout(const Duration(seconds: 30));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        print("Common.authAccessToken() call : Success");
        print("Common.authAccessToken() call : access token : $AT");
        return StatusCode.SUCCESS;
      }

      if (resData["status"] == 401) {
        print("Common.authAccessToken() call : access token이 만료되었습니다.");
        print("Common.authAccessToken() call : access token : $AT");
        print("Common.authAccessToken() call : refresh token : $RT");
        return StatusCode.EXPIRED;
      }

      print("Common.authAccessToken() call : Error");
      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("Common.authAccessToken() call : Error");
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  /// #############################################################
  /// ##################### access token 재발급 #####################
  /// #############################################################
  static Future<StatusCode> reIssueAccessToken() async {
    final AT = await secureStorage.read(key: "ACCESS_TOKEN");
    final RT = await secureStorage.read(key: "REFRESH_TOKEN");

    if (AT == null || RT == null || AT.isEmpty || RT.isEmpty) {
      print(
          "reIssueAccessToken() call error : 잘못된 access token || refresh token");
      return StatusCode.UNCATCHED_ERROR;
    }

    try {
      final resString = await http.get(
          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/refresh"),
          headers: {
            "Authorization": "Bearer $AT",
            "Refresh": "Bearer $RT"
          }).timeout(const Duration(seconds: 30));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        print("reIssueAccessToken() call : access token 재발급 성공");
        List<dynamic> data = resData["data"];
        await secureStorage.write(
            key: "ACCESS_TOKEN", value: data[0]["accessToken"]);
        print("reIssueAccessToken() call : 새로운 access token : $AT");
        return StatusCode.SUCCESS;
      }

      print(resData);
      print("reIssueAccessToken() call : Error 토큰 재발급 실패");
      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("reIssueAccessToken() call : Error 토큰 재발급 실패");
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  static Future<StatusCode> authTokenAndReIssue() async {
    final authAccessTokenResult = await authAccessToken();
    if (authAccessTokenResult == StatusCode.SUCCESS) {
      return StatusCode.SUCCESS;
    }
    if (authAccessTokenResult == StatusCode.EXPIRED) {
      final reIssueAccessTokenResult = await reIssueAccessToken();
      if (reIssueAccessTokenResult != StatusCode.SUCCESS) {
        return StatusCode.UNCATCHED_ERROR;
      }
      return StatusCode.SUCCESS;
    }
    return StatusCode.UNCATCHED_ERROR;
  }
}
