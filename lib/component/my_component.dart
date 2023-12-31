
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:url_launcher/url_launcher.dart';


import '../constant/dimens.dart';
import '../constant/my_color.dart';
import '../gen/assets.gen.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      indent: Dimens.size.width/7,
      endIndent: Dimens.size.width/7,
      thickness: 1.2,
    );
  }
}


class MainTags extends StatelessWidget {
   const MainTags({
    super.key,
    required this.textTheme,
    required this.index
  });

  final TextTheme textTheme;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: GradientColors.tags,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
          child: Row(
            children: [
              ImageIcon(
                Assets.icons.hashtagicon.provider(),
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                Get.find<HomeScreenController>().tagList[index].title!,
                style: textTheme.labelSmall,
              ),
            ],
          ),
        ));
  }
}


myLaunchUrl(String url)async{
  var uri=Uri.parse(url);
    await launchUrl(uri);
}

PreferredSize appBar(BuildContext context,String title) {
  var textTheme = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: const Size.fromHeight(62),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Center(child: Text(title,style: textTheme.titleSmall,)),
          ),
        ],
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: SolidColors.primaryColor.withAlpha(150),
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.keyboard_arrow_right_rounded,size: 33,),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget seeMore(var textTheme,String title) {
  return Padding(
    padding: EdgeInsets.only(right: Dimens.bodyMargin),
    child: Row(
      children: [
        ImageIcon(
          Assets.icons.bluePen.provider(),
          color: SolidColors.colorTitle,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: textTheme.titleLarge,
        ),
      ],
    ),
  );
}