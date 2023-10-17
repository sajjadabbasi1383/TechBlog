import 'package:flutter/material.dart';
import 'package:tech_blog/constant/my_color.dart';

class AppTheme{
  static ThemeData lightTheme =
     ThemeData(
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
