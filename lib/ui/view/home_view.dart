import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/gen/fonts.gen.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/today_score.dart';
import 'package:green_life_app/provider/global_data.dart';
import 'package:green_life_app/provider/mission/get_today_mission_provider.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/ui/widgets/dialog/calendar_dialog.dart';
import 'package:green_life_app/utils/score_utils.dart';
import 'package:green_life_app/utils/strings.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool isExpanded = false;
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    getTodayMissionAfter100ms();
  }

  void getTodayMissionAfter100ms() {
    Future.delayed(const Duration(milliseconds: 100), () {
      loadTodayMission();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiResult = ref.watch(getTodayMissionProvider);

    if (apiResult is Success) {
      final today = (apiResult as Success<TodayScore>).data;

      return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: BottomButton(context, getButtonText(today.getRecordText)),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(
                    nickname: GlobalData.nickname,
                    todayState: today.hasRecord,
                    count: today.recordDayCount,
                  ),
                  HomeImageContainer(
                    today.totalScoreByDay,
                    GlobalData.nickname,
                  ),
                  AnimatedContainer(
                    height: isExpanded ? 0.h : 20.h,
                    duration: const Duration(milliseconds: 400),
                  ),
                  ScoreButtons(today.getScoreText, today.averageScore.toInt(),
                      () {
                    onClickToTodayScore(
                      todayState: today.hasRecord,
                      context: context,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  String getButtonText(String recordText) =>
      isExpanded ? '나의 그린라이프 공유하기' : recordText;

  void onClickToTodayScore({
    required bool todayState,
    required BuildContext context,
  }) {
    if (todayState) {
      setState(() {
        isExpanded = true;
      });
    } else {
      moveToRegister(context);
    }
  }

  void moveToRegister(BuildContext context) {
    Navigator.pushNamed(context, Routes.register, arguments: selectedTime)
        .then((value) {
      if (value == true) {
        getTodayMissionAfter100ms();
      }
    });
  }

  AnimatedOpacity ScoreButtons(
    String todayScore,
    int averageScore,
    void Function() onTapTodayScore,
  ) {
    return AnimatedOpacity(
      opacity: isExpanded ? 0 : 1,
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        height: isExpanded ? 0.h : 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          boxShadow: [
            BoxShadow(
              color: ColorName.shadow,
              blurRadius: 4.r,
              spreadRadius: -4.r,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: ColorName.shadow,
              blurRadius: 4.r,
              spreadRadius: -4.r,
              offset: const Offset(6, 0),
            ),
            BoxShadow(
              color: ColorName.shadow,
              blurRadius: 4.r,
              spreadRadius: -4.r,
              offset: const Offset(0, -6),
            ),
            BoxShadow(
              color: ColorName.shadow,
              blurRadius: 4.r,
              spreadRadius: -4.r,
              offset: const Offset(-6, 0),
            ),
          ],
        ),
        child: isExpanded
            ? const SizedBox.shrink()
            : ScoreButtonBody(todayScore, averageScore, onTapTodayScore),
      ),
    );
  }

  Widget ScoreButtonBody(
    String todayScore,
    int averageScore,
    void Function() onTapTodayScore,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTapTodayScore,
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
                  ),
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
                      '$averageScore점',
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
        ),
      ],
    );
  }

  Widget TopBar({
    required String nickname,
    required bool todayState,
    int? count,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: isExpanded ? 59.h : (59 + 60 + 20).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: FutureBuilder(
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
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: AnimatedOpacity(
                        opacity:
                            s2.connectionState == ConnectionState.done ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        child: isExpanded
                            ? DateSelectableTopBar()
                            : NormalTopBar(
                                nickname: nickname,
                                count: count,
                              ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          MyPageButton(),
        ],
      ),
    );
  }

  GestureDetector MyPageButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.myPage);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 24.w,
          bottom: 24.h,
        ),
        child: SvgPicture.asset(Assets.images.mypageIcon),
      ),
    );
  }

  Widget NormalTopBar({
    required String nickname,
    int? count,
  }) {
    final todayState = count != null && count != 0;
    final guideText = todayState ? '그린라이프' : '그린라이프를 시작해보세요!';

    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 20.sp,
      height: 30 / 20,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        2.verticalSpace,
        Assets.images.appLogo.image(),
        25.24.verticalSpace,
        Text(
          '$nickname님의',
          style: style,
        ),
        Row(
          children: [
            Text(
              guideText,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                height: 30 / 20,
              ),
            ),
            if (todayState)
              Text(
                ' $count일째',
                style: TextStyle(
                  color: ColorName.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  height: 30 / 20,
                ),
              ),
          ],
        ),
      ],
    );
  }

  GestureDetector DateSelectableTopBar() {
    return GestureDetector(
      onTap: showDateSelectDialog,
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
    );
  }

  void showDateSelectDialog() {
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
          ref.read(getTodayMissionProvider.notifier).getSelectedDateMission(
                selectedTime);
        }
      });
    });
  }

  GestureDetector BottomButton(BuildContext context, String buttonText) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return GestureDetector(
      onTap: () {
        if (!isExpanded) {
          moveToRegister(context);
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
          (bottomPadding + 20).verticalSpace,
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
            selectedTime = DateTime.now();
            loadTodayMission();
            isExpanded = false;
          });
        }
      },
      child: AnimatedContainer(
        width: double.infinity,
        height: isExpanded ? 557.h : 382.h,
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

  void loadTodayMission() {
    ref.read(getTodayMissionProvider.notifier).getTodayMission();
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
