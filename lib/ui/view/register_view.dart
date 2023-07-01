import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/provider/register/register_check_provider.dart';
import 'package:green_life_app/utils/date_utils.dart';
import 'package:green_life_app/utils/logger.dart';
import 'package:green_life_app/utils/strings.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final todayDateTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  int selectedIndex = 0;
  bool dialogVisible = false;

  @override
  void initState() {
    // thisWeekList에서 오늘 날짜 인덱스 찾기
    selectedIndex = getThisWeekDateList().indexWhere(
      (element) => element.day == todayDateTime.day,
    );
    ref.read(registerCheckProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todayYearMonth = getTodayYearMonth(selectedDateTime);
    final dayOfWeekList = getDayOfWeekList();
    final thisWeekList = getThisWeekDateList();

    // thisWeekList를 이용해 요일별 날짜를 표시하는 위젯 목록을 생성
    final widgetList = getThisWeekWidgetList(dayOfWeekList, thisWeekList);

    final questionList = [
      '1. 더미 더미 더미 텍스트가 들어갑니다.',
      '2. 더미 더미 더미 텍스트가 들어갑니다.',
      '3. 더미 더미 더미 텍스트가 들어갑니다.',
      '4. 더미 더미 더미 텍스트가 들어갑니다.',
      '5. 더미 더미 더미 텍스트가 들어갑니다.',
      '6. 더미 더미 더미 텍스트가 들어갑니다.',
      '7. 더미 더미 더미 텍스트가 들어갑니다.',
      '8. 더미 더미 더미 텍스트가 들어갑니다.',
      '9. 더미 더미 더미 텍스트가 들어갑니다.',
      '10. 더미 더미 더미 텍스트가 들어갑니다.',
    ];

    return RepaintBoundary(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              TopBar(todayYearMonth),
              ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widgetList,
                  ),
                ),
              ),
              const Divider(thickness: 1, height: 1, color: ColorName.greyF2),
              ListBody(questionList),
            ],
          ),
        ),
      ),
    );
  }

  Expanded ListBody(List<String> questionList) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ColoredBox(
            color: ColorName.registerBackground,
            child: Padding(
              padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
              child: ListView.builder(
                itemCount: 10 + 1,
                itemBuilder: (ctx, i) {
                  if (i == 10) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 60.h,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          final checkList = ref.read(registerCheckProvider);
                          Log.i(checkList);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: ColorName.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '저장',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      CheckListItem(questionList, i),
                      SizedBox(height: 14.h),
                    ],
                  );
                },
              ),
            ),
          ),
          if (dialogVisible)
            ColoredBox(
              color: const Color(0x2B000000),
              child: Container(),
            )
          else
            const SizedBox.shrink(),
          if (dialogVisible)
            Padding(
              padding: EdgeInsets.only(top: 142.h),
              child: Container(
                width: 230.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.alertImage.image(),
                    SizedBox(height: 20.h),
                    Text(
                      '미래의 그린라이프 미션은\n아직 작성하실 수 없어요!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  ColoredBox TopBar(String todayYearMonth) {
    return ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todayYearMonth,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  height: 30 / 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    dialogVisible = true;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    bottom: 8.h,
                    left: 20.h,
                    right: 20.h,
                  ),
                  child: SvgPicture.asset(Assets.images.mypageIcon),
                ),
              )
            ],
          ),
        ));
  }

  Widget CheckListItem(
    List<String> questionList,
    int index,
  ) {
    final selected = ref.watch(registerCheckProvider)[index] ?? false;
    return Container(
      width: double.infinity,
      height: 110.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              questionList[index],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                YesButton(index, selected),
                NoButton(index, selected),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector NoButton(int index, bool selected) {
    return GestureDetector(
      onTap: () {
        ref.read(registerCheckProvider.notifier).check(index, false);
      },
      child: Container(
        width: 133.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: !selected ? ColorName.green : ColorName.greyEA,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
          color: !selected ? ColorName.greenBackground : Colors.white,
        ),
        child: Center(
          child: Text(
            '아니오',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: !selected ? ColorName.green : ColorName.grey94,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector YesButton(int index, bool selected) {
    return GestureDetector(
      onTap: () {
        ref.read(registerCheckProvider.notifier).check(index, true);
      },
      child: Container(
        width: 133.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? ColorName.green : ColorName.greyEA,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
          color: selected ? ColorName.greenBackground : Colors.white,
        ),
        child: Center(
          child: Text(
            '예',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: selected ? ColorName.green : ColorName.grey94,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getThisWeekWidgetList(
    List<String> dayOfWeekList,
    List<DateTime> thisWeekList,
  ) {
    final widgetList = <Widget>[];
    for (var i = 0; i < 7; i++) {
      widgetList.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isPastDate(thisWeekList[i])) {
                selectedDateTime = thisWeekList[i];
                selectedIndex = i;
                dialogVisible = false;
                ref.read(registerCheckProvider.notifier).load(selectedDateTime);
              } else {
                dialogVisible = true;
              }
            });
          },
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
                child: Center(
                  child: Text(
                    dayOfWeekList[i],
                    style: TextStyle(
                      color: ColorName.grey94,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color:
                      selectedIndex == i ? ColorName.green : ColorName.greyF6,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    thisWeekList[i].day.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return widgetList;
  }
}
