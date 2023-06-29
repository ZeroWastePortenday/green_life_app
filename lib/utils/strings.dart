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
