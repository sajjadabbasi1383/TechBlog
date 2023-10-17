import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/my_component.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/routeManager/names.dart';

import '../../constant/my_color.dart';
import '../../controller/article/manage_article_controller.dart';


class ManageArticle extends StatelessWidget {
  ManageArticle({
    super.key,
  });

  final articleController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
          appBar: appBar(context, MyStrings.titleAppBarManageArticle),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(19,10,19,19),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(NamedRoute.routeArticleSingleManage);
          },
          child: Text(MyStrings.textManageArticle),
        ),
      ),
      body: Obx(
              () => articleController.loading.value==true?const SpinKitFadingCube(
                size: 45,
                color: SolidColors.primaryColor,
              ):articleController.articleList.isNotEmpty? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: articleController.articleList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 10, 20, 6),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(

                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(17))
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3.5,
                          height: Get.height / 7.5,
                          child: CachedNetworkImage(
                            imageUrl: articleController.articleList[index].image!,
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
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Text(
                                articleController.articleList[index].title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text(
                                  articleController.articleList[index].author!,
                                  style: textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "${articleController.articleList[index].view!} بازدید",
                                  style: textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ):articleEmptyState(textTheme)
      ),
    ));
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.emptyState.path,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: MyStrings.articleEmpty, style: textTheme.headlineMedium)),
          ),
        ],
      ),
    );
  }
}
