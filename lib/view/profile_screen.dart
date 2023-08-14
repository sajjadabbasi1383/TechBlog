import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';
import '../component/my_color.dart';
import '../component/my_component.dart';
import '../component/my_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
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
              "سجاد عباسی",
              style: textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "sajjadabbas0083@gmail.com",
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
