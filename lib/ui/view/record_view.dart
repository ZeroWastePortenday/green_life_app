import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/utils/strings.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [TopBar(context)],
        ),
      ),
    );
  }

  ColoredBox TopBar(BuildContext context) {
    final todayYearMonth = getYearMonth(dateTime: selectedDate);
    return ColoredBox(
      color: Colors.white,
      child: Row(
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
            onTap: () {},
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
    );
  }
}
