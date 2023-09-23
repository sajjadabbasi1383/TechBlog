import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:validators/validators.dart';

import '../constant/dimens.dart';



class RegisterIntro extends StatelessWidget {
   RegisterIntro({
    super.key,
  });
  final registerController=Get.find<RegisterController>();

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
                onPressed: () {
                  _showEmailBottomSheet(context, Dimens.size, textTheme);
                },
                child: Text(MyStrings.letsGo),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: size.height / 2.4,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MyStrings.insertYourEmail,
                        style: textTheme.headlineMedium),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: registerController.emailTextEditingController,
                        style: textTheme.headlineSmall,
                        onChanged: (value) {
                          print("$value is Email: ${isEmail(value)}");
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: MyStrings.tecEmail,
                          hintStyle: textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          if (isEmail(registerController.emailTextEditingController.text)) {
                            registerController.register();
                            Navigator.pop(context);
                            _showActiveCodeBottomSheet(
                                context, size, textTheme);
                          } else {
                            showAlertEmailDialog(context);
                          }
                        },
                        child: Text(MyStrings.continuation))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> _showActiveCodeBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: size.height / 2.4,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MyStrings.activateCode,
                        style: textTheme.headlineMedium),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: registerController.activeCodeTextEditingController,
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "******",
                          hintStyle: textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: ()async {
                          registerController.verify();
                        },
                        child: Text(MyStrings.continuation)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showAlertEmailDialog(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "باشه",
        style: textTheme.titleSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "لطفا ایمیل معتبر وارد کنید.",
        style: textTheme.titleSmall,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertCodeDialog(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "باشه",
        style: textTheme.titleSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "لطفا کد فعالسازی معتبر وارد کنید.",
        style: textTheme.titleSmall,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
