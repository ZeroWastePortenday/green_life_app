import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/const/consts.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/provider/app_version_provider.dart';
import 'package:green_life_app/provider/login/logout.dart';
import 'package:green_life_app/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageView extends ConsumerWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const nickname = '지구를지키자';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(context),
            Divider(
              thickness: 1.h,
              height: 1.h,
              color: ColorName.greyF2,
            ),
            WelcomeBox(nickname),
            MyPageTopButtons(ref),
            Divider(
              thickness: 8.h,
              height: 8.h,
              color: ColorName.greyF3,
            ),
            MyPageBottomButtons(context),
          ],
        ),
      ),
    );
  }

  Padding MyPageTopButtons(WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      child: Column(
        children: [
          MyPageButton(
            '이용약관',
            onTap: () {
              launchUrl(
                Uri.parse(termsOfServiceUrl),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          InnerDivider(),
          MyPageButton(
            '개인정보처리방침',
            onTap: () {
              launchUrl(
                Uri.parse(privacyPolicyUrl),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          InnerDivider(),
          MyPageButton(
            '버전정보',
            subText: ref.watch(appVersionProvider).when(
                  data: (version) => version,
                  loading: () => '',
                  error: (error, stackTrace) => '',
                ),
          ),
        ],
      ),
    );
  }

  Divider InnerDivider() => Divider(
        thickness: 1.h,
        height: 1.h,
        color: ColorName.greyF2,
      );

  Widget MyPageBottomButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          MyPageButton(
            '로그아웃',
            onTap: () {
              logout(() {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              });
            },
            textColor: ColorName.grey76,
          ),
          InnerDivider(),
          MyPageButton('계정삭제', onTap: () {}, textColor: ColorName.grey76),
          InnerDivider(),
        ],
      ),
    );
  }

  Widget MyPageButton(
    String text, {
    void Function()? onTap,
    Color? textColor,
    String? subText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Visibility(
              visible: subText != null,
              child: Text(
                '$subText',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorName.grey76,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: (24 - 8).h),
      child: ColoredBox(
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(Assets.images.backButton),
            ),
            Text(
              '마이페이지',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                height: 30 / 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget WelcomeBox(String nickname) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: ColorName.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: 26.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$nickname님',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '그린라이프에 오신 걸 환영해요 :)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
