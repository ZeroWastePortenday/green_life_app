// 일요일부터 시작하는 달력에서 오늘 날짜가 포함된 이번주 날짜 목록을 리턴
import 'package:green_life_app/utils/logger.dart';

List<DateTime> getThisWeekDateList({DateTime? selectedTime}) {
  final today = selectedTime ?? DateTime.now();
  final weekday = today.weekday == 7 ? 0 : today.weekday;
  final firstDayOfWeek = today.subtract(Duration(days: weekday));
  final lastDayOfWeek =
      today.add(Duration(days: DateTime.daysPerWeek - weekday));
  return List.generate(
    lastDayOfWeek.difference(firstDayOfWeek).inDays,
    (index) => firstDayOfWeek.add(Duration(days: index)),
  );
}

// 선택된 날짜가 오늘이나 과거라면 true, 미래라면 false를 리턴
bool isPastDate(DateTime selectedTime) {
  final today = DateTime.now().add(const Duration(days: 1));
  final dateTime = DateTime(today.year, today.month, today.day);
  Log.i('checkTime: $selectedTime, dateTime: $dateTime');
  return selectedTime.isBefore(dateTime);
}
