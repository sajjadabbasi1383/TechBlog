import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/controller/pick_file_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';

import '../../component/my_component.dart';
import '../../constant/dimens.dart';
import '../../constant/my_color.dart';
import '../../controller/article/manage_article_controller.dart';

class ArticleSingleManageScreen extends StatelessWidget{
   ArticleSingleManageScreen({super.key});

  final manageArticleController = Get.find<ManageArticleController>();
  final PickFileController pickFileController = Get.put(PickFileController());

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
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider,fit: BoxFit.cover,),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.file(File(pickFileController.file.value.path!),fit: BoxFit.cover,),
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
              seeMore(textTheme, MyStrings.editTitleArticle),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Dimens.bodyMargin, 7, Dimens.bodyMargin, 25),
                child: Text(
                  manageArticleController.articleInfoModel.value.title!,
                  style: textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              seeMore(textTheme, MyStrings.editMainTextArticle),
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
              seeMore(textTheme, MyStrings.selectCategory),

              //tag list
              SizedBox(
                height: 60,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: manageArticleController.tagList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return manageArticleController.tagList[index].id == '2' ||
                            manageArticleController.tagList[index].id == '6'
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(
                                5, 8, index == 0 ? Dimens.bodyMargin : 5, 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: SolidColors.greyColor2),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 10, 8),
                                  child: Center(
                                    child: Text(
                                      manageArticleController
                                          .tagList[index].title!,
                                      style: textTheme.headlineMedium,
                                    ),
                                  ),
                                )),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(
                                5, 8, index == 0 ? Dimens.bodyMargin : 5, 8),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: SolidColors.greyColor2),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 10, 8),
                                  child: Center(
                                    child: Text(
                                      manageArticleController
                                          .tagList[index].title!,
                                      style: textTheme.headlineMedium,
                                    ),
                                  ),
                                )),
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