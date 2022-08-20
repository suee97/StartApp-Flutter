import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {


  /// Data
  static double CIRCLE_RADIUS = 50;
  static String whatIsChongHak =
      "  총학생회는 학생회칙이 정하는 바에 따라 입후보한 자에 대해 재학중인 전체학생들의 직접선거에 의해 선출되며, 성실, 협동, 창의를 교훈으로 민주적인 학생 자치활동을 통하여 민주시민으로서 자질을 함양하고 대학문화를 창출하여 자율적 발전을 도모하며 사회와 민주국가발전에 기여할 수 있는 능력 배양을 목적으로 한다.";
  static String stArt =
      "자랑스러운 우리 서울과학기술대학교 학우 여러분 안녕하십니까.\n2022년 올해 일년간 여러분과 함께 멋진 작품들을 만들어갈 제38대 ST’art 총학생회 인사드립니다.\n저희는 3월 재선거라는 어려운 상황 속에서도 전례 없는 투표자 수 4251명, 찬성율 90.54%라는 학우 여러분의 큰 지지와 관심과 함께 출범했습니다.\n\n이는 일상 회복의 시작점에서 총학생회에 대한 학우 여러분들의 큰 기대가 반영이 된 것이라 생각합니다. 막중한 책임감을 가지며 깊은 감사의 마음을 전합니다.\n저희 제38대 총학생회의 이름인 ST'art는 일상 회복을 시작(start)하겠다는 의미와 올 한 해간 멋진 작품과 같은 서울과학기술대학교를 만들겠다(ST+art)는 저희의 다짐이 담겨있습니다.\n\n이런 다짐과 함께 3가지 약속을 드리겠습니다.\n첫 번째, 코로나19로 인해 멈췄던 학교의 활기찬 모습으로 전환을 ‘시작’하겠습니다.\n꽁꽁 얼었던 겨울을 녹여줄 봄이 다가오고있습니다. 얼어 있던 우리 대학 캠퍼스를 녹일 수 있는 봄이 되겠습니다.\n다양한 사업과 이벤트들로 우리 대학의 활기를 되찾아 오는 그 여정을 여러분과 시작하겠습니다.\n\n두 번째, 코로나19로 인해 제약이 많았던 소통을 다시 ‘시작’하겠습니다.\n학생 사회에서 소통은 빠질 수 없습니다. 여러분과 소통하기 위해 다양한 방법으로 노력하겠습니다.\n적극적인 소통을 통해 학우 여러분의 의견을 한 곳으로 모으고 결과로 만들어내기 위해 최선을 다하겠습니다.\n\n세 번째, 학생 사회의 재흥을 ‘시작’하겠습니다.\n코로나19로 인해 우리 사회는 포스트 코로나라는 급격한 변화를 겪고 있습니다. 학생사회 역시 예외가 될 수 없었습니다.\n어쩌면 학생 사회의 위기인 이 순간을 기회로 학생사회를 혁신적으로 변화시키겠습니다.\n코로나19로 인해 많은 어려움이 있었음에도 우리 학우들을 위해 최선을 다해 임기를 보내고 이어온 학생회 선배님들과 총학생회의 부재 속에서 학우들을 위해 힘써주신 총학생회 비상대책위원회 모든 분들의 헌신에 감사의 말씀드립니다.\n언제나 학우 여러분의 곁에서 우리 학생들의 권리를 보장하기 위해 힘쓰겠습니다.\n\n2022년 4월 1일, 우리의 시작, 함께 만들어가는 작품.\n\n제38대 ST’art 총학생회 올림.";

  // FAQ탭 질문&답변
  static String faq_q1 = "Q. 자치회비 납부는 언제 하는 건가요?";
  static String faq_a1 =
      "A. 자치회비는 매학기 등록금 납부기간에 가상계좌를 통해 납부하실 수 있습니다. 고지서에 기재된 등록금에 11,000원을 추가한 금액을 입금하면 자동으로 자치회비 납부처리가 됩니다. 세부사항은 등록금 고지서를 통해 확인하실 수 있습니다. 또한 등록금 납부기간에 기재된 학생처나 총학생회 번호(02-970-7011)로 연락주시면 자세한 설명을 들으실 수 있습니다.";
  static String faq_q2 = "Q. 자치회비가 어디에 사용되는지 알고싶어요.";
  static String faq_a2 = "A. 총학생회 페이스북/인스타그램 위의 경로를 통해서 결산안을 확인하실 수 있습니다.";

  // 앱바 스타일
  static TextStyle startAppBarTextStyle =
      TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500);

  /// Function
  static String parseTime(String startTime, String endTime) {
    // 2022-07-12T22:23:21.159220 to 07/12

    return " ${startTime.substring(5, 7)}/${startTime.substring(8, 10)}\n~${endTime.substring(5, 7)}/${endTime.substring(8, 10)}";
  }

  static String calDday(String startTime) {
    var tmp = DateTime.now();
    var from = DateTime(tmp.year, tmp.month, tmp.day);
    var to = DateTime(
        int.parse(startTime.substring(0, 4)),
        int.parse(startTime.substring(5, 7)),
        int.parse(startTime.substring(8, 10)));

    int diff = (to.difference(from).inHours / 24).round();

    return diff != 0 ? "D - $diff" : "D-day";
  }

  static String dateRange(String startTime, String endTime) {
      // 2022-07-12T22:23:21.159220
      // to
      // 07.12

      return " ${startTime.substring(2, 4)}.${startTime.substring(5, 7)}.${startTime.substring(
          8, 10)} ~ ${endTime.substring(2, 4)}.${endTime.substring(5, 7)}.${endTime.substring(8, 10)}";
    }

  // 자동로그인 여부 확인
  static Future<bool> isAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    bool? tmp = pref.getBool("isAutoLogin");
    if (tmp == true) {
      return true;
    } else {
      return false;
    }
  }

  // 자동로그인 -> true/false 설정
  static Future<void> setAutoLogin(bool value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isAutoLogin', value);
  }

  // 비로그인 여부 확인
  static Future<bool> isNonLogin() async {
    final pref = await SharedPreferences.getInstance();
    bool? tmp = pref.getBool("isNonLogin");
    if (tmp == true) {
      return true;
    } else {
      return false;
    }
  }

  // 로그인 없이 이용하기 -> true/false 설정
  static Future<void> setNonLogin(bool value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isNonLogin', value);
  }

  // 스낵바
  static void showSnackBar(BuildContext context, String inputMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(inputMsg,
          style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 0,
          ),
        ),
      ),
    );
  }

  // 유저정보 관련 pref 초기화
  static Future<void> clearStudentInfoPref() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("appMemberId");
    pref.remove("appStudentNo");
    pref.remove("appName");
    pref.remove("department");
    pref.remove("appMemberShip");
    pref.remove("appCreatedAt");
    pref.remove("appUpdatedAt");
    pref.remove("appMemberStatus");
    pref.remove("appPhoneNo");
    print("유저 관련 모든 preference를 삭제했습니다.");
  }

  // 로그인 여부
  static bool _isLogin = false;
  static void setIsLogin(bool value) {
    _isLogin = value;
  }
  static bool getIsLogin() {
    return _isLogin;
  }
}

// class NotificationBadge extends StatelessWidget {
//   const NotificationBadge({Key? key, required this.totalNotifications}) : super(key: key);
//
//   final int totalNotifications;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40,
//         height: 40,
//       decoration: const BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "$totalNotifications",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
