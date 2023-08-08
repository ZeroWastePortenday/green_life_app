import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/provider/login/login_provider.dart';
import 'package:green_life_app/provider/login/login_state.dart';
import 'package:green_life_app/provider/login/login_type.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/ui/widgets/buttons/apple/apple_login_button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider, (previous, next) {
      if (next is LoginNeedToSignUpState) {
        Navigator.pushNamed(context, Routes.signUp);
      } else if (next is LoginSuccessState) {
        Navigator.pushNamed(context, Routes.home);
      } else if (next is LoginErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 66.h, bottom: 34.h),
                  child: Assets.images.loginImage.image(),
                ),
                SizedBox(
                  height: 30.h,
                  child: Center(
                    child: Text(
                      '지구를 살리는 선택',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Assets.images.loginLogo.image(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    loginButton(
                      backgroundColor: ColorName.kakao,
                      onTap: () =>
                          ref.read(loginProvider.notifier).login(LoginType.kakao),
                      text: '카카오로 로그인',
                      textColor: Colors.black,
                      iconImage: Assets.images.kakaoLogo.image(),
                    ),
                    SizedBox(height: 12.h),
                    loginButton(
                      backgroundColor: ColorName.naver,
                      onTap: () =>
                          ref.read(loginProvider.notifier).login(LoginType.naver),
                      text: '네이버로 로그인',
                      textColor: Colors.white,
                      iconImage: Assets.images.naverLogo.image(),
                    ),
                    SizedBox(height: 12.h),
                    loginButton(
                      backgroundColor: Colors.white,
                      onTap: () =>
                          ref.read(loginProvider.notifier).login(LoginType.google),
                      text: 'Google로 로그인',
                      textColor: Colors.black,
                      iconImage: Assets.images.googleLogo.image(),
                      hasBorder: true,
                    ),
                    Builder(
                      builder: (_) {
                        if (Platform.isIOS) {
                          return Column(
                            children: [
                              SizedBox(height: 12.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SignInWithAppleButton(
                                  onPressed: () => ref
                                      .read(loginProvider.notifier)
                                      .login(LoginType.apple),
                                  height: 48,
                                  text: 'Apple로 로그인',
                                  iconAlignment: IconAlignment.left,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox(height: 52.h,);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration loginBoxDecoration(Color backgroundColor, {bool? hasBorder}) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(4),
      border: (hasBorder ?? false)
          ? Border.all(
              color: ColorName.loginBorder,
            )
          : null,
    );
  }

  GestureDetector loginButton({
    required Color backgroundColor,
    required void Function() onTap,
    required String text,
    required Color textColor,
    required Image iconImage,
    bool? hasBorder,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: loginBoxDecoration(backgroundColor, hasBorder: hasBorder),
        width: 320.w,
        height: 48,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: iconImage,
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
