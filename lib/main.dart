import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_life_app/initial_settings.dart';
import 'package:green_life_app/ui/view/login_view.dart';

Future<void> main() async {
  await initSettings();
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginView(),
          );
        },
      ),
    ),
  );
}
