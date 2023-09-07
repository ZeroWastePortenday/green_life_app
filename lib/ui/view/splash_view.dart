import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_life_app/gen/assets.gen.dart';
import 'package:green_life_app/provider/login/login_provider.dart';
import 'package:green_life_app/provider/login/login_state.dart';
import 'package:green_life_app/routes.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      // TODO ref.read(loginProvider.notifier).autoLogin();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
            (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (previous, next) {
      if (next is LoginSuccessState) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (route) => false,
        );
      } else if (next is LoginNeededState) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
              (route) => false,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Assets.images.splashLogo.image(),
          ),
        ],
      ),
    );
  }
}
