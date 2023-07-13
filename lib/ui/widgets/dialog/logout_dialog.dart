import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/const/strings.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';

Widget LogoutDialog({
  required BuildContext context,
  required String nickname,
}) {
  return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60.h),
              SizedBox(
                height: 56.h,
                child: Text(
                  nickname + logoutText1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    height: 28 / 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 28.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      logoutText2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        height: 28 / 18,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Assets.images.sweatEmoji.image(),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 56.h,
                child: Text(
                  logoutText3,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    height: 28 / 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 39.h),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: ColorName.greyF2,
                indent: 20.w,
                endIndent: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        color: Colors.transparent,
                        height: 91.h,
                        child: Center(
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: ColorName.grey94,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1.w,
                    height: 54.h,
                    color: ColorName.greyF2,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        color: Colors.transparent,
                        height: 91.h,
                        child: Center(
                          child: Text(
                            logoutButtonText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: ColorName.grey94,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w),
                child: SvgPicture.asset(Assets.images.closeIcon),
              ),
            ),
          ),
        ],
      ));
}
