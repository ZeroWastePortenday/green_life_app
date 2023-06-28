import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/provider/login/login_provider.dart';
import 'package:green_life_app/provider/login/login_type.dart';
import 'package:green_life_app/provider/login/logout.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).login(LoginType.google);
              },
              child: const Text('구글 로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).login(LoginType.kakao);
              },
              child: const Text('카카오 로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).login(LoginType.naver);
              },
              child: const Text('네이버 로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).login(LoginType.apple);
              },
              child: const Text('Apple 로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                logout(() {});
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
