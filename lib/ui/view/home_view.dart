import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/models/today_state.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/utils/strings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const nickname = '지구를 지키자';
    final todayState = TodayState.first; // 0이면 아예 처음
    final count = 365;

    final guideText = switch (todayState) {
      TodayState.first => '$nickname님의\n그린라이프를 시작해보세요!',
      TodayState.notSaved || TodayState.saved => '$nickname님의\n그린라이프 $count일째',
    };

    final todayScore = switch (todayState) {
      TodayState.first || TodayState.notSaved => '클릭!',
      TodayState.saved => '100점'
    };

    final averageScore = switch (todayState) {
      TodayState.first => '0점',
      TodayState.notSaved || TodayState.saved => '78점'
    };

    final recordText = switch (todayState) {
      TodayState.first || TodayState.notSaved => '그린라이프 기록하기',
      TodayState.saved => '기록 수정하기',
    };
    final buttonText = isExpanded ? '나의 그린라이프 공유하기' : recordText;
    final todayString = getTodayYearMonthDay();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomButton(context, buttonText),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBar(todayString, guideText),
                AnimatedContainer(
                  height: isExpanded ? 0.h : 20.h,
                  duration: const Duration(milliseconds: 400),
                ),
                HomeImageContainer(),
                AnimatedContainer(
                  height: isExpanded ? 0.h : 40.h,
                  duration: const Duration(milliseconds: 400),
                ),
                ScoreButtons(todayState, todayScore, averageScore),
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
                  Container(
                    width: 1,
                    height: isExpanded ? 0.h : 52.h,
                    color: ColorName.greyEA,
                  ),
                  Expanded(
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
                  )
                ],
              ),
      ),
    );
  }

  Row TopBar(String todayString, String guideText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: isExpanded
              ? Text(
                  todayString,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    height: 30 / 20,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: SizedBox(
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
          )
        ],
      ),
    );
  }

  Widget HomeImageContainer() {
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
            SizedBox(height: 30.h),
            Assets.images.homeTextLogo.image(),
          ],
        ),
      ),
    );
  }
}
