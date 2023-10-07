import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tech_blog/constant/dimens.dart';

import '../../constant/my_color.dart';
import '../../gen/assets.gen.dart';

class SinglePodcast extends StatelessWidget {
  const SinglePodcast({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: Assets.images.singlePlaceHolder.path,
                    imageBuilder: (context, imageProvider) =>
                        Image(image: imageProvider),
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.images.singlePlaceHolder.path,
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 70,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: GradientColors.singleAppbarGradiant)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                color: Colors.transparent,
                                width: 35,
                                height: 35,
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 26,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            const Icon(
                              Icons.bookmark_outline,
                              size: 24,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              color: Colors.transparent,
                              width: 35,
                              height: 35,
                              child: const Icon(
                                Icons.share,
                                size: 21,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "عنوان پادکست",
                    style: textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image(
                        image: Assets.images.profileAvatar.provider(), height: 44),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "سجاد عباسی",
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ImageIcon(Assets.icons.microphon.provider(),color: SolidColors.seeMore,),
                              const SizedBox(width: 10,),
                              Text("بخش چهارم: فریلنسر دیوانه",style: textTheme.headlineMedium,)

                            ],
                          ),
                          Text("22:00",style: textTheme.headlineSmall,)
                        ],
                      ),
                    );
                  },),
              )
            ],
          ),),
          Positioned(
              bottom: 10,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient:
                    const LinearGradient(colors: GradientColors.bottomNav)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 0.6,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.skip_next,color: Colors.white,size: 38,),
                          Icon(Icons.play_circle,color: Colors.white,size: 44,),
                          Icon(Icons.skip_previous,color: Colors.white,size: 38,),
                          SizedBox(),
                          Icon(Icons.repeat,color: Colors.white,size: 30,),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      )
    ));
  }
}
