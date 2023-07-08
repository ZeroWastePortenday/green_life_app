import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
              SfDateRangePicker(
                controller: controller,
                navigationDirection:
                    DateRangePickerNavigationDirection.vertical,
                selectionColor: ColorName.primaryColor,
                todayHighlightColor: ColorName.primaryColor,
                initialSelectedDate: selectedDate,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
                showNavigationArrow: true,
                headerHeight: 50.h,
                showActionButtons: true,
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
                selectionTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                onSubmit: (value) {
                  final date = value as DateTime?;
                  Navigator.pop(context, date);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
