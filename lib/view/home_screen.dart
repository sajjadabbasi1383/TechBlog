import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/controller/single_article_controller.dart';
import 'package:tech_blog/view/article_list_screen.dart';
import '../controller/list_article_controller.dart';
import '../gen/assets.gen.dart';
import 'package:get/get.dart';
import '../component/my_color.dart';
import '../component/my_component.dart';
import '../component/my_string.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'article_single_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  ListArticleController listArticleController=Get.put(ListArticleController());


  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: homeScreenController.loading.value == false
                ? Column(
                    children: [
                      poster(),
                      const SizedBox(
                        height: 11,
                      ),
                      tags(),
                      const SizedBox(
                        height: 13,
                      ),
                      SeeMoreBlog(bodyMargin: bodyMargin, textTheme: textTheme),
                      const SizedBox(
                        height: 11,
                      ),
                      topVisited(),
                      const SizedBox(
                        height: 13,
                      ),
                      SeeMorePodcast(
                          bodyMargin: bodyMargin, textTheme: textTheme),
                      const SizedBox(
                        height: 11,
                      ),
                      topPodcast(),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  )
                : SizedBox(
                    height: Get.height / 1.5,
                    child: const SpinKitFadingCube(
                      size: 45,
                      color: SolidColors.primaryColor,
                    ),
                  )),
      ),
    );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 3.8,
      child: Obx(
        () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: homeScreenController.topVisitedList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                singleArticleController.id.value = int.parse(
                    homeScreenController.topVisitedList[index].id.toString());
                Get.to(const ArticleSingleScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(
                    right: index == 0 ? bodyMargin : 8, left: 6),
                child: Column(
                  children: [
                    //blog item
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: SizedBox(
                          width: size.width / 2.55,
                          height: size.height / 5.7,
                          child: CachedNetworkImage(
                            imageUrl: homeScreenController
                                .topVisitedList[index].image!,
                            imageBuilder: (context, imageProvider) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        gradient: const LinearGradient(
                                          colors: GradientColors.blogPost,
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 0,
                                    left: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          homeScreenController
                                              .topVisitedList[index].author!,
                                          style: textTheme.titleMedium,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              homeScreenController
                                                  .topVisitedList[index].view!,
                                              style: textTheme.titleMedium,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            placeholder: (context, url) =>
                                const SpinKitFadingCube(
                              color: SolidColors.primaryColor,
                              size: 27,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: size.width / 2.55,
                      child: Text(
                        homeScreenController.topVisitedList[index].title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topPodcast() {
    return SizedBox(
      height: size.height / 3.8,
      child: Obx(
        () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: homeScreenController.topPodcastList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(right: index == 0 ? bodyMargin : 8, left: 6),
              child: Column(
                children: [
                  //blog item
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: SizedBox(
                      width: size.width / 2.55,
                      height: size.height / 5.7,
                      child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcastList[index].poster!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          );
                        },
                        placeholder: (context, url) => const SpinKitFadingCube(
                          color: SolidColors.primaryColor,
                          size: 27,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: SolidColors.greyColor2),
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2.55,
                    child: Text(
                      homeScreenController.topPodcastList[index].title!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget poster() {
    return Stack(
      children: [
        Container(
          width: size.width / 1.12,
          height: size.height / 4.3,
          foregroundDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: GradientColors.homePosterCoverGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ],
              );
            },
            placeholder: (context, url) => const SpinKitSpinningLines(
              color: SolidColors.primaryColor,
              size: 70,
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: SolidColors.greyColor2),
              child: const Icon(
                Icons.image_not_supported_outlined,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 30,
          left: 25,
          child: Text(
            homeScreenController.poster.value.title!,
            style: textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }

  Widget tags() {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: homeScreenController.tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId =
              homeScreenController.tagList[index].id!;
              var tagName="لیست مرتبط با ${homeScreenController.tagList[index].title!}";
              await listArticleController.getArticleWithTag(tagId);
              Get.to(ArticleListScreen(title: tagName,));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 8, index == 0 ? bodyMargin : 5, 8),
              child: MainTags(textTheme: textTheme, index: index),
            ),
          );
        },
      ),
    );
  }
}

class SeeMorePodcast extends StatelessWidget {
  const SeeMorePodcast({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.microphon.provider(),
            color: SolidColors.colorTitle,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            MyStrings.viewHotestPodCasts,
            style: textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class SeeMoreBlog extends StatelessWidget {
  const SeeMoreBlog({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ArticleListScreen(title: "لیست مقالات")),
      child: Padding(
        padding: EdgeInsets.only(right: bodyMargin),
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
              MyStrings.viewHotestBlog,
              style: textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
