import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/view/main_screen.dart';
import 'package:tech_blog/my_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> const MainScreen()));
    });

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
              const SizedBox(height: 25,),
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
