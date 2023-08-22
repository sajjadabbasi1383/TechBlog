import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/list_article_controller.dart';
import 'package:tech_blog/view/article_single_screen.dart';
import '../component/my_color.dart';
import '../component/my_component.dart';
import '../controller/single_article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({required this.title,super.key});

  ListArticleController listArticleController = Get.put(ListArticleController());
  SingleArticleController singleArticleController = Get.put(SingleArticleController());
  String title="لیست مقالات";

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(textTheme, title),
      body: SizedBox(
        child: Obx(
          () => listArticleController.loading==false? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listArticleController.articleList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 10, 20, 6),
                child: GestureDetector(
                  onTap: () {
                    singleArticleController.id.value=int.parse(listArticleController.articleList[index].id.toString());
                    Get.to(ArticleSingleScreen());
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width / 3.5,
                        height: Get.height / 7.5,
                        child: CachedNetworkImage(
                          imageUrl: listArticleController.articleList[index].image!,
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
                              listArticleController.articleList[index].title!,
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
                                listArticleController.articleList[index].author!,
                                style: textTheme.labelMedium,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                "${listArticleController.articleList[index].view!} بازدید",
                                style: textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
