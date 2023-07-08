import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/gen/fonts.gen.dart';
import 'package:green_life_app/models/today_state.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/utils/score_utils.dart';
import 'package:green_life_app/utils/strings.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isExpanded = false;
  var selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const nickname = '지구를 지키자';
    final todayState = TodayState.saved; // 0이면 아예 처음
    final count = 365;
    final score = 44;
    final averageScore = 78;

    final guideText = switch (todayState) {
      TodayState.first => '$nickname님의\n그린라이프를 시작해보세요!',
      TodayState.notSaved || TodayState.saved => '$nickname님의\n그린라이프 $count일째',
    };

    final todayScore = switch (todayState) {
      TodayState.first || TodayState.notSaved => '클릭!',
      TodayState.saved => '$score점'
    };

    final averageScoreText = switch (todayState) {
      TodayState.first => '0점',
      TodayState.notSaved || TodayState.saved => '$averageScore점'
    };

    final recordText = switch (todayState) {
      TodayState.first || TodayState.notSaved => '그린라이프 기록하기',
      TodayState.saved => '기록 수정하기',
    };
    final buttonText = isExpanded ? '나의 그린라이프 공유하기' : recordText;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomButton(context, buttonText),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBar(guideText),
                HomeImageContainer(score, nickname),
                AnimatedContainer(
                  height: isExpanded ? 0.h : 40.h,
                  duration: const Duration(milliseconds: 400),
                ),
                ScoreButtons(todayState, todayScore, averageScoreText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedOpacity ScoreButtons(
    TodayState todayState,
    String todayScore,
    String averageScore,
  ) {
    return AnimatedOpacity(
      opacity: isExpanded ? 0 : 1,
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        height: isExpanded ? 0.h : 80.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.greyEA),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        child: isExpanded
            ? const SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (todayState == TodayState.saved) {
                          setState(() {
                            isExpanded = true;
                          });
                        } else {
                          Navigator.pushNamed(context, Routes.register);
                        }
                      },
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: Center(
                                child: Text(
                                  '오늘의 점수',
                                  style: TextStyle(
                                    color: ColorName.grey94,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 7.h),
                              child: Text(
                                todayScore,
                                style: TextStyle(
                                  color: ColorName.primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: isExpanded ? 0.h : 52.h,
                    color: ColorName.greyEA,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.records);
                      },
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: Center(
                                child: Text(
                                  '평균점수',
                                  style: TextStyle(
                                    color: ColorName.grey94,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 7.h),
                              child: Text(
                                averageScore,
                                style: TextStyle(
                                  color: ColorName.primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget TopBar(String guideText) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: isExpanded ? 59.h : 85.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: isExpanded
                  ? GestureDetector(
                      onTap: () {
                        showDialog<DateTime?>(
                          context: context,
                          builder: (context) => CalendarDialog(
                            context: context,
                            selectedDate: selectedTime,
                          ),
                        ).then((time) {
                          setState(() {
                            if (time != null) {
                              selectedTime = time;
                            }
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            getYearMonthDay(selectedTime),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              height: 30 / 20,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Assets.images.calendarIcon.image(),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 60.h,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          guideText,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            height: 30 / 20,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.h,
                left: 24.w,
                bottom: 24.h,
              ),
              child: SvgPicture.asset(Assets.images.mypageIcon),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector BottomButton(BuildContext context, String buttonText) {
    return GestureDetector(
      onTap: () {
        if (!isExpanded) {
          Navigator.pushNamed(context, Routes.register);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                color: ColorName.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(Assets.images.rightArrow),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: isExpanded ? 60.h : 100.h,
          ),
        ],
      ),
    );
  }

  Widget HomeImageContainer(int score, String nickname) {
    final grade = calculateGrade(score);

    return GestureDetector(
      onTap: () {
        if (isExpanded) {
          setState(() {
            isExpanded = false;
          });
        }
      },
      child: AnimatedContainer(
        width: double.infinity,
        height: isExpanded ? 557.h : 362.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          color: ColorName.homeImageBackground,
        ),
        duration: const Duration(milliseconds: 400),
        child: Column(
          children: [
            AnimatedContainer(
              height: isExpanded ? 50.h : 30.h,
              duration: const Duration(
                milliseconds: 400,
              ),
            ),
            Assets.images.homeTextLogo.image(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: isExpanded ? 32.h : 42.h,
            ),
            getGradeImage(grade),
            Builder(
              builder: (_) {
                if (!isExpanded) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: isExpanded ? 40.h : 0.h,
                  );
                } else {
                  final text = getGuideText(grade);

                  return FutureBuilder(
                    future: Future<dynamic>.delayed(
                      const Duration(milliseconds: 400),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
                      }

                      return FutureBuilder(
                        future: Future<dynamic>.delayed(Duration.zero),
                        builder: (context, s2) {
                          return AnimatedOpacity(
                            opacity: s2.connectionState == ConnectionState.done
                                ? 1
                                : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Column(
                              children: [
                                SizedBox(height: 29.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$score',
                                      style: TextStyle(
                                        color: ColorName.primaryColor,
                                        fontSize: 62.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.gmarketSans,
                                      ),
                                    ),
                                    Text(
                                      '점',
                                      style: TextStyle(
                                        color: ColorName.primaryColor,
                                        fontSize: 44.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.gmarketSans,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text(
                                  text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 26 / 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Builder getGradeImage(Grade grade) {
    return Builder(
      builder: (_) {
        // return Assets image gradeLevel by grade
        return switch (grade) {
          Grade.perfect => Assets.images.gradeLevel5.image(
              width: 290.w,
              height: 231.h,
            ),
          Grade.high => Assets.images.gradeLevel4.image(
              width: 290.w,
              height: 231.h,
            ),
          Grade.medium => Assets.images.gradeLevel3.image(
              width: 290.w,
              height: 231.h,
            ),
          Grade.low => Assets.images.gradeLevel2.image(
              width: 290.w,
              height: 231.h,
            ),
          Grade.veryLow => Assets.images.gradeLevel1.image(
              width: 290.w,
              height: 231.h,
            ),
        };
      },
    );
  }
}

Widget CalendarDialog({
  required BuildContext context,
  required DateTime selectedDate,
}) {
  final controller = DateRangePickerController();

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              SfDateRangePicker(
                controller: controller,
                selectionColor: ColorName.primaryColor,
                todayHighlightColor: ColorName.primaryColor,
                initialSelectedDate: selectedDate,
                onSelectionChanged: (value) {
                  final date = value.value as DateTime;
                  Navigator.pop(context, date);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
