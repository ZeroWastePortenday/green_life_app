import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/models/result.dart';
import 'package:green_life_app/models/score/monthly_record.dart';
import 'package:green_life_app/provider/mission/get_monthly_record_provider.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/ui/widgets/top_bar_divider.dart';
import 'package:green_life_app/utils/strings.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class RecordView extends ConsumerStatefulWidget {
  const RecordView({super.key});

  @override
  ConsumerState<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends ConsumerState<RecordView> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      getRecordByMonth(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthlyRecord = ref.watch(getMonthlyRecordProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(context),
            NormalDivider(),
            Builder(
              builder: (_) {
                if (monthlyRecord is Success<MonthlyRecord>) {
                  return realBody(monthlyRecord.data);
                } else if (monthlyRecord is Error<MonthlyRecord>) {
                  return _buildErrorWidget(context, monthlyRecord.message);
                } else {
                  return _buildLoadingWidget(context);
                }
              },
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 60.h),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              border: Border.all(color: ColorName.primaryColor),
            ),
            child: Center(
              child: Text(
                '메인으로 돌아가기',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: ColorName.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ScoresWidget(
    int dayCount,
    double averageScore,
  ) {
    return Container(
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(color: ColorName.greyEA),
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Center(
                      child: Text(
                        '미션 실천일',
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
                      '$dayCount일',
                      style: TextStyle(
                        color: ColorName.grey94,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 52.h,
            color: ColorName.greyEA,
          ),
          Expanded(
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
                      '${averageScore.toInt()}점',
                      style: TextStyle(
                        color: ColorName.grey94,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox TitleText() {
    return SizedBox(
      height: 30.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '이번달 기록 모아보기',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  ColoredBox TopBar(BuildContext context) {
    final todayYearMonth = getYearMonth(dateTime: selectedDate);
    return ColoredBox(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showMonthPicker(
                context: context,
                initialDate: selectedDate,
                dismissible: true,
                headerColor: ColorName.primaryColor,
                headerTextColor: Colors.white,
                selectedMonthBackgroundColor: ColorName.primaryColor,
                selectedMonthTextColor: Colors.white,
                unselectedMonthTextColor: Colors.black,
              ).then((date) {
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                    getRecordByMonth(date);
                  });
                }
              });
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset(Assets.images.backButton),
                ),
                Text(
                  todayYearMonth,
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
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.myPage);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 27.h,
                left: 20.h,
                right: 20.h,
              ),
              child: SvgPicture.asset(Assets.images.mypageIcon),
            ),
          ),
        ],
      ),
    );
  }

  void getRecordByMonth(DateTime date) {
    ref.read(getMonthlyRecordProvider.notifier).getRecordByMonth(date);
  }

  Padding realBody(MonthlyRecord data) {
    final dayCount = data.achievementDayCountByMonth;
    final averageScore = data.averageScoreByMonth;
    final overFiftyPercentCount = data.scoreCount50ByMonth;
    final overEightyPercentCount = data.scoreCount80ByMonth;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          TitleText(),
          SizedBox(height: 20.h),
          ScoresWidget(dayCount, averageScore),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: ColorName.primaryLightColor,
                    border: Border.all(color: ColorName.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                          child: Center(
                            child: Text(
                              '50점 이상',
                              style: TextStyle(
                                color: ColorName.grey94,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          '$overFiftyPercentCount회',
                          style: TextStyle(
                            color: ColorName.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: ColorName.greenBackground,
                    border: Border.all(color: ColorName.green),
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                          child: Center(
                            child: Text(
                              '50점 이상',
                              style: TextStyle(
                                color: ColorName.grey94,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          '$overEightyPercentCount회',
                          style: TextStyle(
                            color: ColorName.green,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return const SizedBox.shrink();
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return const SizedBox.shrink();
  }
}
