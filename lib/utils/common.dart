/// 일단은 하드코딩 하고 나중에 리팩토링하면서 필요한 부분 추가
/// 중요한 정보(api key, api url ..)는 .env파일에 있음

class Common {

  static int SPLASH_DURATION = 1;

  static String parseTime(String startTime, String endTime) {
    /// 2022-07-12T22:23:21.159220
    /// -> 2022-07-12

    return "${startTime.substring(0, 10)} ~ ${endTime.substring(0, 10)}";
  }
}
