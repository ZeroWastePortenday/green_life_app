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

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.loginImage.image(fit: BoxFit.cover, width: width),
              Column(
                children: [
                  loginButton(
                    backgroundColor: ColorName.kakao,
                    onTap: () =>
                        ref.read(loginProvider.notifier).login(LoginType.kakao),
                    text: '카카오로 로그인',
                    textColor: Colors.black,
                    iconImage: Assets.images.kakaoLogo.image(),
                  ),
                  12.verticalSpace,
                  loginButton(
                    backgroundColor: ColorName.naver,
                    onTap: () =>
                        ref.read(loginProvider.notifier).login(LoginType.naver),
                    text: '네이버로 로그인',
                    textColor: Colors.white,
                    iconImage: Assets.images.naverLogo.image(),
                  ),
                  12.verticalSpace,
                  loginButton(
                    backgroundColor: Colors.white,
                    onTap: () => ref
                        .read(loginProvider.notifier)
                        .login(LoginType.google),
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
                            12.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SignInWithAppleButton(
                                onPressed: () => ref
                                    .read(loginProvider.notifier)
                                    .login(LoginType.apple),
                                text: 'Apple로 로그인',
                                iconAlignment: IconAlignment.left,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return 52.verticalSpace;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              114.verticalSpace,
              Text(
                '지구를 살리는\n당신의 선택, 그린라이프',
                style: TextStyle(
                  fontSize: 22.sp,
                  height: 30 / 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              Text(
                '오늘의 지구 미션을 확인하세요',
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 30 / 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
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
        height: 44,
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
