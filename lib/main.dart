import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/binding.dart';
import 'package:tech_blog/view/article_single_manage_screen.dart';
import 'package:tech_blog/view/article_single_screen.dart';
import 'package:tech_blog/view/main_screen.dart';
import 'package:tech_blog/view/manage_article_screen.dart';
import 'package:tech_blog/view/splash_screen.dart';

import 'component/my_color.dart';

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
      locale: const Locale('fa'),
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
      
      getPages: [
        GetPage(name: NamedRoute.routeMainScreen, page: ()=>MainScreen(),binding: RegisterBinding()),
        GetPage(name: NamedRoute.routeSingleArticle, page: ()=>const ArticleSingleScreen(),binding: ArticleBinding()),
        GetPage(name: NamedRoute.routeManageArticle, page: ()=> ManageArticle(),binding: ArticleManagerBinding()),
        GetPage(name: NamedRoute.routeArticleSingleManage, page: ()=> const ArticleSingleManageScreen(),binding: ArticleManagerBinding()),
      ],
      
      home: const SplashScreen(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: SolidColors.primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return SolidColors.primaryColor;
          }),
          padding: MaterialStateProperty.resolveWith((states) {
            return const EdgeInsets.only(
                left: 25, right: 25, top: 10, bottom: 10);
          }),
        ),
      ),
      fontFamily: "dana",
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontFamily: "dana",
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: SolidColors.posterTitle),
        labelLarge: TextStyle(
            fontFamily: "dana",
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: SolidColors.blackColor),
        titleMedium: TextStyle(
            fontFamily: "dana",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: SolidColors.posterSubTitle),
        labelSmall: TextStyle(
            fontFamily: "dana",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: SolidColors.posterTitle),
        titleLarge: TextStyle(
            fontFamily: "dana",
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: SolidColors.colorTitle),
        titleSmall: TextStyle(
            fontFamily: "dana",
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: SolidColors.primaryColor),
        headlineMedium: TextStyle(
            fontFamily: "dana",
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.black),
        headlineSmall: TextStyle(
            fontFamily: "dana",
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: SolidColors.hintText),
        labelMedium: TextStyle(
            fontFamily: "dana",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: SolidColors.hintText),
      ),
    );
  }
}

class NamedRoute{
  static String routeMainScreen='/MainScreen';
  static String routeSingleArticle='/SingleArticle';
  static String routeManageArticle='/ManageArticle';
  static String routeArticleSingleManage='/ArticleSingleManage';
}

