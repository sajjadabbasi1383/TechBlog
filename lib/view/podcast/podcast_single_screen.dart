import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tech_blog/constant/dimens.dart';

import '../../constant/my_color.dart';
import '../../controller/podcast/single_podcast_controller.dart';
import '../../gen/assets.gen.dart';
import '../../models/podcast_model.dart';

class SinglePodcast extends StatelessWidget {
  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;

  SinglePodcast({super.key}) {
    podcastModel = Get.arguments;
    singlePodcastController =
        Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(singlePodcastController.id.toString());

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
                  SizedBox(
                    height: Get.height / 3,
                    width: Get.width,
                    child: CachedNetworkImage(
                      imageUrl: podcastModel.poster!,
                      imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.images.singlePlaceHolder.path,
                      ),
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
                    podcastModel.title!,
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
                        image: Assets.images.profileAvatar.provider(),
                        height: 44),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      podcastModel.author!,
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: singlePodcastController.podcastFileList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                  Assets.icons.microphon.provider(),
                                  color: SolidColors.seeMore,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: Get.width / 1.5,
                                    child: Text(
                                      singlePodcastController
                                          .podcastFileList[index].title!,
                                      style: textTheme.headlineMedium,
                                    ))
                              ],
                            ),
                            Text(
                              "${singlePodcastController.podcastFileList[index].length!}:00",
                              style: textTheme.headlineSmall,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 38,
                        ),
                        GestureDetector(
                          onTap: () {

                            singlePodcastController.player.playing
                                ? singlePodcastController.player.pause()
                                : singlePodcastController.player.play();

                            singlePodcastController.playState.value =
                                singlePodcastController.player.playing;
                          },
                          child: Obx(
                            () => Icon(
                                singlePodcastController.playState.value
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                color: Colors.white,
                                size: 44),
                          ),
                        ),
                        const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 38,
                        ),
                        const SizedBox(),
                        const Icon(
                          Icons.repeat,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ],
    )));
  }
}
