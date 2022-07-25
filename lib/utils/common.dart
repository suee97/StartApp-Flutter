/// 일단은 하드코딩 하고 나중에 리팩토링하면서 필요한 부분 추가
/// 중요한 정보(api key, api url ..)는 .env파일에 있음

class Common {
  static double CIRCLE_RADIUS = 50;
  static String whatIsChongHak = "진리의 빛을 좇으며 정의를 수호하려 한 3·1 독립운동에서, 4·19 민주혁명, 5·18 민주화 운동과 6월 민주항쟁으로 이어지는 학생운동의 발자취는 숱한 탄압에도 불구하고 세상을 밝히려는 의지의 증명이었다. 이는 열강의 압박 속에서도 실력에 대한 열망으로 공립어의동실업보습학교를 설립한 순종황제의 뜻과 학생자치를 부정하고 억압한 학도 호국단을 폐지해 서울과학기술대학교 총학생회를 구성한 어의인의 의지와 다르지 않았다.";

  static String parseTime(String startTime, String endTime) {
    /// 2022-07-12T22:23:21.159220
    /// to
    /// 07/12

    return " ${startTime.substring(5, 7)}/${startTime.substring(8, 10)}\n~${endTime.substring(5, 7)}/${endTime.substring(8, 10)}";
  }
}
