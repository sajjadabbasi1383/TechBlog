import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../gen/assets.gen.dart';
import '../component/my_color.dart';
import '../component/my_component.dart';
import '../component/my_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
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
              height: 50,
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
              height: 35,
            ),
            CustomDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.myFavBlog,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            CustomDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.myFavPodcast,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            CustomDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                width: size.width / 1.17,
                child: Center(
                    child: Text(
                  MyStrings.logOut,
                  style: textTheme.headlineMedium,
                )),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
