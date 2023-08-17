import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/view/main_screen.dart';
import 'package:tech_blog/component/my_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    checkInternet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.logo.image(height: 90),
              const SizedBox(
                height: 25,
              ),
              const SpinKitFadingCube(
                color: SolidColors.primaryColor,
                size: 37.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

checkInternet(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Future.delayed(const Duration(seconds: 4)).then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen()));
      });
    }
  } on SocketException catch (_) {
    _showInternetSnakBar(context);
  }
}

void _showInternetSnakBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'تلاش دوباره',
        onPressed: () {
          checkInternet(context);
        },
        disabledTextColor: Colors.black,
        textColor: Colors.white,
      ),
      backgroundColor: Colors.red,
      content: Text(
        "اتصال به شبکه برقرار نشد",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      duration: const Duration(minutes: 2),
    ),
  );
}