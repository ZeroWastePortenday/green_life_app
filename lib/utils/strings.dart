bool validateNicknameInput(String? input) {
  // 입력값이 없는 경우
  if (input == null || input.isEmpty) {
    return false;
  }
  // 정규식 패턴을 설정합니다.
  final regex = RegExp(r'^[a-zA-Z가-힣]{1,8}$');

  // 입력값을 정규식과 비교하여 체크합니다.
  if (regex.hasMatch(input)) {
    return true; // 유효한 형식입니다.
  } else {
    return false; // 유효하지 않은 형식입니다.
  }
}

// get today's year and month and day
String getYearMonthDay(DateTime selected) {
  final year = selected.year.toString();
  final month = selected.month.toString();
  final day = selected.day.toString();
  return '$year년 $month월 $day일';
}

// get today's year and month
String getTodayYearMonth({DateTime? dateTime}) {
  dateTime ??= DateTime.now();
  final year = dateTime.year.toString();
  final month = dateTime.month.toString();
  return '$year년 $month월';
}

// 일요일 부터 월요일까지 요일만 String List로 반환
List<String> getDayOfWeekList() {
  return ['일', '월', '화', '수', '목', '금', '토'];
}
