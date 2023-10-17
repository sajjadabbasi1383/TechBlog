import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/view/my_cats_screen.dart';
import '../../constant/dimens.dart';
import '../../gen/assets.gen.dart';
import '../../constant/my_color.dart';
import '../../component/my_component.dart';
import '../../constant/my_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var email=GetStorage().read('email')??MyStrings.tecEmail;
    var name=GetStorage().read('nameFamily')??'سجاد عباسی';
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Image(
              image: Assets.images.profileAvatar.provider(),
              height: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  Assets.icons.bluePen.provider(),
                  color: SolidColors.colorTitle,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  MyStrings.imageProfileEdit,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              name,
              style: textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              email,
              style: textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomDivider(),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: Dimens.size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.myFavBlog,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            const CustomDivider(),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: Dimens.size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.myFavPodcast,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            const CustomDivider(),
            InkWell(
              onTap: () {
                Get.to(const MyCats());
              },
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: Dimens.size.width / 1.17,
                child: Center(
                    child: Text(
                      MyStrings.editeUserName,
                      style: textTheme.headlineMedium,
                    )),
              ),
            ),
            const CustomDivider(),
            InkWell(
              onTap: () {
                showLogOutAlertDialog(context);
              },
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: Dimens.size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.logOut,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

showLogOutAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "خارج شدن",
      style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold)
    ),
    onPressed: () {
      Get.find<RegisterController>().logOut();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text(
      "نه، دستم خورد!",
      style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold)
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "آیا می خواهید از حساب کاربری تان خارج شوید؟",
      style: TextStyle(fontSize: 16,color: SolidColors.primaryColor,)
    ),
    actions: [
      okButton,
      cancelButton
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

