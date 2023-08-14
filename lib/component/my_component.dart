import 'package:flutter/material.dart';


import '../gen/assets.gen.dart';
import '../models/fake_data.dart';
import 'my_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      indent: size.width/7,
      endIndent: size.width/7,
      thickness: 1.2,
    );
  }
}


class MainTags extends StatelessWidget {
   MainTags({
    super.key,
    required this.textTheme,
    required this.index
  });

  final TextTheme textTheme;
  var index;

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
                taglist[index].title,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ));
  }
}
