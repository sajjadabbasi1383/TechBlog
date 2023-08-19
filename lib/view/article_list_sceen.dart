import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/article_controller.dart';
import '../component/my_component.dart';

class ArticleListScreen extends StatelessWidget {
   ArticleListScreen({super.key});
   ArticleController articleController=Get.put(ArticleController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(textTheme,"مقالات جدید"),
      body:Obx(
        ()=> SizedBox(
          child: ListView.builder(
            itemCount: articleController.articleList.length,
            itemBuilder: (context, index) {
            return Text(articleController.articleList[index].title!);
          },),
        ),
      ) ,
    ));
  }

}
