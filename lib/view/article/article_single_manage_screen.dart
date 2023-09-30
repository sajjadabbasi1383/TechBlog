import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/controller/pick_file_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';
import 'package:tech_blog/view/article/article_content_editor.dart';

import '../../component/my_component.dart';
import '../../constant/dimens.dart';
import '../../constant/my_color.dart';
import '../../controller/article/manage_article_controller.dart';

class ArticleSingleManageScreen extends StatelessWidget {
  ArticleSingleManageScreen({super.key});

  final manageArticleController = Get.find<ManageArticleController>();
  final PickFileController pickFileController = Get.put(PickFileController());

  getTitle() {
    Get.defaultDialog(
        title: "ویرایش عنوان مقاله",
        titleStyle: const TextStyle(color: SolidColors.primaryColor),
        content: TextField(
          controller: manageArticleController.titleTextEditingController,
          decoration: const InputDecoration(
            hintText: "اینجا بنویس",
          ),
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
        ),
        radius: 9,
        confirm: ElevatedButton(
            onPressed: () {
              manageArticleController.updateTitle();
              Get.back();
            },
            child: const Text("ثبت")));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height / 3.4,
                    child: pickFileController.file.value.name == 'nothing'
                        ? CachedNetworkImage(
                            imageUrl: manageArticleController
                                .articleInfoModel.value.image!,
                            imageBuilder: (context, imageProvider) => Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.file(
                            File(pickFileController.file.value.path!),
                            fit: BoxFit.cover,
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
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            pickFile();
                          },
                          child: Container(
                            height: 35,
                            width: Get.width / 2.8,
                            decoration: const BoxDecoration(
                                color: SolidColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  MyStrings.selectImage,
                                  style: textTheme.labelSmall,
                                ),
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    getTitle();
                  },
                  child: seeMore(textTheme, MyStrings.editTitleArticle)),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Dimens.bodyMargin, 7, Dimens.bodyMargin, 25),
                child: Text(
                  manageArticleController.articleInfoModel.value.title == ''
                      ? MyStrings.titltArrticle
                      : manageArticleController.articleInfoModel.value.title!,
                  style: textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                  onTap: () => Get.to(ArticleContentEditor()),
                  child: seeMore(textTheme, MyStrings.editMainTextArticle)),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Dimens.bodyMargin, 7, Dimens.bodyMargin, 25),
                child: HtmlWidget(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  manageArticleController.articleInfoModel.value.content!,
                  enableCaching: true,
                  onLoadingBuilder: (context, element, loadingProgress) =>
                      const SpinKitFadingCube(
                    color: SolidColors.primaryColor,
                    size: 27,
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () => chooseCatsBottomShit(textTheme),
                  child: seeMore(textTheme, MyStrings.selectCategory)),

              Padding(
                padding: EdgeInsets.fromLTRB(
                    Dimens.bodyMargin, 7, Dimens.bodyMargin, 25),
                child: Text(
                  manageArticleController.articleInfoModel.value.catName == null
                      ? MyStrings.noCategorySelected
                      : manageArticleController.articleInfoModel.value.catName!,
                  style: textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //tag list
            ],
          ),
        ),
      ),
    ));
  }

  Widget cats(textTheme) {

    var homeScreenController=Get.find<HomeScreenController>();

    return SizedBox(
      height: Get.height/2.3,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: homeScreenController.tagList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5, 8,  5 , 8),
                  child: GestureDetector(
                    onTap: () {
                      manageArticleController.articleInfoModel.update((val) {
                        val?.catId=homeScreenController.tagList[index].id;
                        val?.catName=homeScreenController.tagList[index].title;
                      });
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: SolidColors.primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
                          child: Center(
                            child: Text(
                              homeScreenController.tagList[index].title!,
                              style: textTheme.headlineLarge,
                            ),
                          ),
                        )),
                  ),
                );
        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      ),
    );
  }

  chooseCatsBottomShit(TextTheme textTheme) {
    Get.bottomSheet(Container(
      height: Get.height / 1.8,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(MyStrings.selectCategory,style: textTheme.labelLarge,),
            const SizedBox(
              height: 14,
            ),
            cats(textTheme)
          ],
        ),
      ),
    ));
  }
}
