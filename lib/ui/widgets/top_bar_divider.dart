import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_life_app/gen/colors.gen.dart';

Widget NormalDivider({double? indent, double? endIndent}) {
  return Divider(
    thickness: 1.h,
    height: 1.h,
    color: ColorName.greyF2,
    indent: indent,
    endIndent: endIndent,
  );
}
