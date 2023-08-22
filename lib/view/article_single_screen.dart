import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/list_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/view/article_list_sceen.dart';

import '../component/my_color.dart';
import '../component/my_string.dart';
import '../controller/single_article_controller.dart';

class ArticleSingleScreen extends StatefulWidget {
  const ArticleSingleScreen({super.key});

  @override
  State<ArticleSingleScreen> createState() => _ArticleSingleScreenState();
}

class _ArticleSingleScreenState extends State<ArticleSingleScreen> {
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  @override
  void initState() {
    super.initState();
    singleArticleController.getArticleInfo();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    double bodyMargin = size.width / 21;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => singleArticleController.articleInfoModel.value.title==null?
          SizedBox(
            height: Get.height,
            child: const SpinKitFadingCube(
              color: SolidColors.primaryColor,
              size: 40,
            ),
          )
          :Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        singleArticleController.articleInfoModel.value.image!,
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
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.arrow_back,
                              size: 26,
                              color: Colors.white,
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.bookmark_outline,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.share,
                              size: 21,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  singleArticleController.articleInfoModel.value.title!,
                  style: textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      singleArticleController.articleInfoModel.value.author!,
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      singleArticleController.articleInfoModel.value.createdAt!,
                      style: textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
                child: HtmlWidget(
                  singleArticleController.articleInfoModel.value.content!,
                  enableCaching: true,
                  onLoadingBuilder: (context, element, loadingProgress) =>
                      const SpinKitFadingCube(
                    color: SolidColors.primaryColor,
                    size: 27,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: singleArticleController.tagList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return singleArticleController.tagList[index].id == '2'||singleArticleController.tagList[index].id == '6'
                        ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          5, 8, index == 0 ? bodyMargin : 5, 8),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: SolidColors.greyColor2),
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(16, 8, 10, 8),
                            child: Center(
                              child: Text(
                                singleArticleController
                                    .tagList[index].title!,
                                style: textTheme.headlineMedium,
                              ),
                            ),
                          )),
                    )
                        : GestureDetector(
                            onTap: () async {
                              var tagId =
                                  singleArticleController.tagList[index].id!;
                              var tagName="لیست مرتبط با ${singleArticleController.tagList[index].title!}";
                              await Get.find<ListArticleController>()
                                  .getArticleWithTag(tagId);
                              Get.to(ArticleListScreen(title: tagName,));
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  5, 8, index == 0 ? bodyMargin : 5, 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: SolidColors.greyColor2),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 8, 10, 8),
                                    child: Center(
                                      child: Text(
                                        singleArticleController
                                            .tagList[index].title!,
                                        style: textTheme.headlineMedium,
                                      ),
                                    ),
                                  )),
                            ),
                          );
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: bodyMargin, top: 20, bottom: 11),
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
              SizedBox(
                height: size.height / 3.8,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: singleArticleController.releatedList.length,
                  itemBuilder: (context, index) {
                    return singleArticleController.releatedList[index].author ==
                            null
                        ? const SizedBox.shrink()
                        : Padding(
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
                                        imageUrl: singleArticleController
                                            .releatedList[index].image!,
                                        imageBuilder: (context, imageProvider) {
                                          return Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17),
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: GradientColors
                                                              .blogPost,
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                        )),
                                              ),
                                              Positioned(
                                                bottom: 8,
                                                right: 0,
                                                left: 0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      singleArticleController
                                                          .releatedList[index]
                                                          .author!,
                                                      style:
                                                          textTheme.titleMedium,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          singleArticleController
                                                              .releatedList[
                                                                  index]
                                                              .view!,
                                                          style: textTheme
                                                              .titleMedium,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .remove_red_eye_rounded,
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
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: size.width / 2.55,
                                  child: Text(
                                    singleArticleController
                                        .releatedList[index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
