import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/component/my_component.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/constant/my_color.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/view/main/home_screen.dart';
import 'package:tech_blog/view/main/profile_screen.dart';
import 'package:tech_blog/view/register_screen.dart';

import '../../constant/dimens.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  final RxInt selectedPageIndex = 0.obs;
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double bodyMarginNavBar = Dimens.size.width / 10;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding: EdgeInsets.only(right: Dimens.bodyMargin, left: Dimens.bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                    child: Image.asset(
                  Assets.images.logo.path,
                  scale: 3,
                )),
                ListTile(
                  title: Text(
                    MyStrings.userProfile,
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(color: SolidColors.dividerColor, thickness: 0.9),
                ListTile(
                  title: Text(
                    MyStrings.aboutTec,
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(color: SolidColors.dividerColor, thickness: 0.9),
                ListTile(
                  title: Text(
                    MyStrings.shareTec,
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () async {
                    await Share.share(MyStrings.shareText);
                  },
                ),
                const Divider(color: SolidColors.dividerColor, thickness: 0.9),
                ListTile(
                  title: Text(
                    MyStrings.tecIngithub,
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {
                    myLaunchUrl(MyStrings.techBlogGithubUrl);
                  },
                ),
                const Divider(color: SolidColors.dividerColor, thickness: 0.9),
                SizedBox(height: Get.height/3.3,),
                Center(child: Text("Developed by Sajjad Abbasi",style: textTheme.headlineSmall,)),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Container(
                  color: Colors.white,
                  height: 25,
                  width: 28,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
              Assets.images.logo.image(height: Dimens.size.height / 15),
              const Icon(Icons.search, color: Colors.black),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Obx(
              () => IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(textTheme: textTheme,),
                  const ProfileScreen(),
                ],
              ),
            )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Stack(
                children: [
                  Container(
                    height: Dimens.size.height / 11,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: GradientColors.bottomNavBackground,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  BottomNavBar(
                    bodyMarginNavBar: bodyMarginNavBar,
                    size: Dimens.size,
                    changeScreen: (int value) {
                      selectedPageIndex.value = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.bodyMarginNavBar,
    required this.size,
    required this.changeScreen,
  });

  final double bodyMarginNavBar;
  final Size size;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: bodyMarginNavBar, left: bodyMarginNavBar),
            child: Container(
              height: size.height / 13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient:
                      const LinearGradient(colors: GradientColors.bottomNav)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => changeScreen(0),
                      icon: ImageIcon(
                        Assets.icons.home.provider(),
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () => Get.find<RegisterController>().toggleLogin(),
                      icon: ImageIcon(Assets.icons.write.provider(),
                          color: Colors.white)),
                  IconButton(
                      onPressed: (){
                          if (GetStorage().read('token') == null) {
                            Get.to(RegisterIntro());
                          } else {
                            changeScreen(1);
                          }
                      },
                      icon: ImageIcon(Assets.icons.user.provider(),
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
