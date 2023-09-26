import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tech_blog/component/my_component.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();
  final manageArticleController =Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: appBar(context, "نوشتن / ویرایش مقاله"),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height/2.5,
                child: HtmlEditor(
                    controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                    hint: "میتونی مقاله تو اینجا بنویسی ...",
                    shouldEnsureVisible: true,
                    initialText: manageArticleController.articleInfoModel.value.content
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                    textStyle: TextStyle(color: Colors.black),
                  ),
                  callbacks: Callbacks(
                    onChangeContent: (p0) {
                      manageArticleController.articleInfoModel.update((val) {
                        val!.content=p0;
                      });
                      log(manageArticleController.articleInfoModel.value.content.toString());
                    }

                  ),
                ),
              ),
              ElevatedButton(onPressed: ()=>Get.back(), child: const Text("ثبت"))
            ],
          ),
        ),
      ),
    );
  }
}
