import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/routeManager/names.dart';
import 'package:tech_blog/routeManager/pages.dart';
import 'constant/my_color.dart';
import 'theme/app_theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: SolidColors.statusBarColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.systemNavigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: NamedRoute.initialRoute,
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,

      getPages: Pages.pages,

    );
  }


}
