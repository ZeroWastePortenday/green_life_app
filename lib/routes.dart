import 'package:flutter/material.dart';
import 'package:green_life_app/ui/view/home_view.dart';
import 'package:green_life_app/ui/login/login_view.dart';
import 'package:green_life_app/ui/view/my_page_view.dart';
import 'package:green_life_app/ui/view/record_view.dart';
import 'package:green_life_app/ui/view/register_view.dart';
import 'package:green_life_app/ui/sign_up/sign_up_view.dart';
import 'package:green_life_app/ui/view/splash_view.dart';

class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const signUp = '/signUp';
  static const home = '/home';
  static const register = '/register';
  static const records = '/records';
  static const myPage = '/myPage';
}

class Pages {
  static Route<dynamic>? getPages(RouteSettings settings) {
    final arguments = settings.arguments;
    final router = _PageRouter(arguments);
    switch (settings.name) {
      case Routes.splash:
        return router.create(child: const SplashView());
      case Routes.login:
        return router.create(child: const LoginView());
      case Routes.signUp:
        return router.create(child: const SignUpView());
      case Routes.home:
        return router.create(child: const HomeView());
      case Routes.register:
        return router.create(
          child: RegisterView(
            selectedDateTime: arguments! as DateTime,
          ),
        );
      case Routes.records:
        return router.create(child: const RecordView());
      case Routes.myPage:
        return router.create(child: const MyPageView());
    }
    return null;
  }
}

class _PageRouter {
  _PageRouter(this.arguments);

  final Object? arguments;

  PageRoute<dynamic> create({
    required Widget child,
    bool? maintainState = true,
    bool? fullscreenDialog = false,
  }) {
    return MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(
        arguments: arguments,
      ),
      maintainState: maintainState!,
      fullscreenDialog: fullscreenDialog!,
    );
  }
}
