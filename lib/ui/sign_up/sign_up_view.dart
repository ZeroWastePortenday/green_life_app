import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_life_app/const/consts.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/provider/sign_up/sign_up_provider.dart';
import 'package:green_life_app/routes.dart';
import 'package:green_life_app/ui/widgets/top_bar_divider.dart';
import 'package:green_life_app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final focusNode = FocusNode();
  bool isValidate = false;

  bool first = false;
  bool second = false;
  bool third = false;

  final textEditingController = TextEditingController();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signUpProvider, (previous, next) {
      next.whenOrNull(
        success: (data) {
          if (data) {
            Navigator.pushNamed(context, Routes.home);
          } else {
            // TODO : 닉네임 중복
          }
        },
      );
    });

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: focusNode.unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(Assets.images.backButton),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              Text(
                '마지막 단계에요!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 30.h,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '닉네임을 입력해주세요.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      autofocus: false,
                      focusNode: focusNode,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                          borderSide: const BorderSide(
                            color: ColorName.greyEA,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                          borderSide: const BorderSide(
                            color: ColorName.primaryColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 15.h,
                          bottom: 10.h,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isValidate = validateNicknameInput(value);
                        });
                      },
                      style: TextStyle(
                        fontSize: 18.sp,
                        height: 30 / 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Builder(
                      builder: (context) {
                        final color = isValidate
                            ? ColorName.primaryColor
                            : ColorName.grey94;
                        return Row(
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '8자 이내 한글 혹은 영문',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.check, color: color, size: 15.r),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: ColorName.greyF3,
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => first && second && third
                              ? setState(() {
                                  first = false;
                                  second = false;
                                  third = false;
                                })
                              : setState(() {
                                  first = true;
                                  second = true;
                                  third = true;
                                }),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: first && second && third
                                  ? ColorName.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                width: 1.w,
                                color: first && second && third
                                    ? ColorName.primaryColor
                                    : ColorName.grey94,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            if (first || second || third) {
                              first = false;
                              second = false;
                              third = false;
                            } else {
                              first = true;
                              second = true;
                              third = true;
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: 30,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '모두 동의',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: NormalDivider(),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => first = !first),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 15.r,
                            color: first
                                ? ColorName.primaryColor
                                : ColorName.grey94,
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            height: 20,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '[필수] 만 14세 이상',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorName.grey94,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => setState(() => second = !second),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 15.r,
                            color: second
                                ? ColorName.primaryColor
                                : ColorName.grey94,
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            height: 20,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '[필수] 이용약관 동의',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorName.grey94,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(termsOfServiceUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '보기',
                                style: TextStyle(
                                  color: ColorName.grey94,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => setState(() => third = !third),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 15.r,
                            color: third
                                ? ColorName.primaryColor
                                : ColorName.grey94,
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            height: 20,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '[필수] 개인정보처리방침 동의',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorName.grey94,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(privacyPolicyUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '보기',
                                style: TextStyle(
                                  color: ColorName.grey94,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        bottomSheet: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (first && second && third) {
                Navigator.pushNamed(context, Routes.home);

                final nickname = textEditingController.text;
                ref.read(signUpProvider.notifier).signUp(nickname);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: bottom + 20.h),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: first && second && third && isValidate
                      ? ColorName.primaryColor
                      : ColorName.greyF3,
                ),
                child: Center(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: first && second && third
                          ? Colors.white
                          : ColorName.grey94,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
