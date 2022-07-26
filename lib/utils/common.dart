/// 일단은 하드코딩 하고 나중에 리팩토링하면서 필요한 부분 추가
/// 중요한 정보(api key, api url ..)는 .env파일에 있음

class Common {
  static double CIRCLE_RADIUS = 50;
  static String whatIsChongHak = "총학생회는 학생회칙이 정하는 바에 따라 입후보한 자에 대해 재학중인 전체학생들의 직접선거에 의해 선출되며, 성실, 협동, 창의를 교훈으로 민주적인 학생 자치활동을 통하여 민주시민으로서 자질을 함양하고 대학문화를 창출하여 자율적 발전을 도모하며 사회와 민주국가발전에 기여할 수 있는 능력 배양을 목적으로 한다.";
  static String stArt = "자랑스러운 우리 서울과학기술대학교 학우 여러분 안녕하십니까.\n2022년 올해 일년간 여러분과 함께 멋진 작품들을 만들어갈 제38대 ST’art 총학생회 인사드립니다.";

  static String parseTime(String startTime, String endTime) {
    /// 2022-07-12T22:23:21.159220
    /// to
    /// 07/12

    return " ${startTime.substring(5, 7)}/${startTime.substring(8, 10)}\n~${endTime.substring(5, 7)}/${endTime.substring(8, 10)}";
  }
}
