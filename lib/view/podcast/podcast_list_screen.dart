import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/dimens.dart';
import 'package:tech_blog/constant/my_color.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/routeManager/names.dart';

import '../../component/my_component.dart';

class HotPodcastList extends StatelessWidget {
  final String title;
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  HotPodcastList({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context,title),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 15, 0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: homeScreenController.topPodcastList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(NamedRoute.routeSinglePodcast,arguments: homeScreenController.topPodcastList[index] );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topPodcastList[index].poster!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                              placeholder: (context, url) => const SpinKitFadingCube(
                                color: SolidColors.primaryColor,
                                size: 27,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Color.fromARGB(255, 227, 10, 10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, 0, Dimens.bodyMargin / 1),
                          child: Column(
                            children: [
                              Text(
                                homeScreenController.topPodcastList[index].title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                homeScreenController
                                    .topPodcastList[index].author!,
                                style: const TextStyle(
                                  color: SolidColors.subText,
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}