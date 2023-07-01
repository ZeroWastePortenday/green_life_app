import 'package:flutter_test/flutter_test.dart';
import 'package:green_life_app/utils/date_utils.dart';

void main() {
  test('2023년 7월 1일이 포함된 주의 첫 시작일은 25일고, 끝나는 날은 1일이다.', () {
    final dateList = getThisWeekDateList(selectedTime: DateTime(2023, 7));
    expect(dateList.length, 7);
    expect(dateList[0].day, 25);
    expect(dateList[6].day, 1);
  });
}
