import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/utils/strings.dart';

class RecordView extends StatelessWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(context)
          ],
        ),
      ),
    );
  }

  ColoredBox TopBar(BuildContext context) {
    final todayYearMonth = getTodayYearMonth();
    return ColoredBox(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              SizedBox(width: 8.w,),
              Assets.images.calendarIcon.image(),
            ],
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
