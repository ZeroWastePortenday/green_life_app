import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_life_app/gen/colors.gen.dart';
import 'package:green_life_app/gen/fonts.gen.dart';
import 'package:green_life_app/initial_settings.dart';
import 'package:green_life_app/routes.dart';

Future<void> main() async {
  await initSettings();
  debugRepaintRainbowEnabled = true;
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.home,
            onGenerateRoute: Pages.getPages,
            theme: ThemeData(
              fontFamily: FontFamily.pretendard,
              brightness: Brightness.light,
              primaryColor: ColorName.primaryColor,
            ),
          );
        },
      ),
    ),
  );
}
