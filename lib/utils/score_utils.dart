// enum 0~29점 / 30~59점 / 60 ~ 79점 / 80 ~ 99점 / 100점
import 'package:green_life_app/const/strings.dart';

enum Grade {
  perfect,
  high,
  medium,
  low,
  veryLow,
}

Grade calculateGrade(int score) {
  if (score >= 0 && score <= 29) {
    return Grade.veryLow;
  } else if (score >= 30 && score <= 59) {
    return Grade.low;
  } else if (score >= 60 && score <= 79) {
    return Grade.medium;
  } else if (score >= 80 && score <= 99) {
    return Grade.high;
  } else if (score == 100) {
    return Grade.perfect;
  } else {
    throw Exception('Invalid score');
  }
}

// get GuideText by Grade
String getGuideText(Grade grade) {
  switch (grade) {
    case Grade.perfect:
      return perfectScoreGuideText;
    case Grade.high:
      return highScoreGuideText;
    case Grade.medium:
      return midScoreGuideText;
    case Grade.low:
      return lowScoreGuideText;
    case Grade.veryLow:
      return veryLowScoreGuideText;
  }
}
