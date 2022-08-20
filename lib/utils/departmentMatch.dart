import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentMatch{

  static Set<String> engineerDepartments = {'기계시스템디자인공학과기계','자동차공학과','안전공학과','신소재공학과', '건설시스템공학과', '건축학부(건축공학전공)','건축학부(건축학전공)','[계약학과]건축기계설비공학과'};
  static Set<String> iceDepartments = {'전기정보공학과','전자IT미디어공학과','컴퓨터공학과','스마트ICT융합공학과'};
  static Set<String> natureDepartments = {'화공생명공학과','환경공학과','식품공학과','정밀화학과','스포츠과학과','안경광학과'};
  static Set<String> andDepartments = {'디자인학과(산업디자인전공)','디자인학과(시각디자인전공)','도예학과','금속공예디자인학과','조형예술학과'};
  static Set<String> humanDepartments = {'행정학과','영어영문학과','문예창작학과'};
  static Set<String> sgcDepartments = {'산업정보시스템전공', 'ITM전공', 'MSDE학과', '경영학전공', '글로벌테크노경영전공'};
  static Set<String> disciplinaryDepartments = {'융합공학부(융합기계공학전공)','융합공학부(건설환경융합전공)','융합사회학부(헬스피트니스전공)','융합사회학부(문화예술전공)','융합사회학부(영어전공)','융합사회학부(벤처경영전공)'};
  static Set<String> cccsDepartments = {'인공지능응용학과','지능형반도체공학과','미래에너지융합학과'};
  static Set<String> cultureDepartments = {'인문사회교양학부','자연과학부','융합교양학부'};

  static Set<Map<String, Set<String>>> groups = {
    {'공과대학' : engineerDepartments},
    {'정보통신대학' : iceDepartments},
    {'에너지바이오대학' : natureDepartments},
    {'조형대학' : andDepartments},
    {'인문사회대학' : humanDepartments},
    {'기술경영융합대학' : sgcDepartments},
    {'미래융합대학' : disciplinaryDepartments},
    {'창의융합대학' : cccsDepartments},
    {'교양대학' : cultureDepartments}
  };

  static String getDepartment(String department) {
    String group = '';
    String temp = '';
    for(var x in DepartmentMatch.groups){
      for(var y in x.values){
        if(y.contains(department)) {
          temp = x.keys.toString();
          temp = temp.split('(')[1];
          group = temp.split(')')[0];
          return group;
        }
      }
      }
    return group;
    }
}

