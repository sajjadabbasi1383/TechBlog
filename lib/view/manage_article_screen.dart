import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/component/my_string.dart';
import 'package:validators/validators.dart';

// ignore: must_be_immutable
class ManageArticle extends StatelessWidget {
  ManageArticle({
    super.key,
  });

  var registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.tcbot,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: MyStrings.welcom, style: textTheme.headlineMedium)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(MyStrings.letsGo),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
