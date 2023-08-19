import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/article_controller.dart';
import '../component/my_color.dart';
import '../component/my_component.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(textTheme, "لیست مقالات"),
      body: SizedBox(
        child: Obx(
          () => articleController.loading==false? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: articleController.articleList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 10, 20, 6),
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
              );
            },
          ):const SpinKitFadingCube(
            size: 45,
            color: SolidColors.primaryColor,
          )
        ),
      ),
    ));
  }
}
