import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_blog/view/article_list_sceen.dart';
import 'package:tech_blog/view/splash_screen.dart';

import 'component/my_color.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: SolidColors.statusBarColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.systemNavigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      theme: ThemeData(

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17)
          ),
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
            padding: MaterialStateProperty.resolveWith((states){
              return const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10);
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
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:   ArticleListScreen(),
    );
  }
}
