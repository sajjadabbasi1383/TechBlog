
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/controller/pick_file_controller.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/articles_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';


class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxList<TagsModel> tagList = RxList();
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController=TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
          MyStrings.titltArrticle, MyStrings.editOrginalTextArticle, '')
      .obs;

  @override
  onInit() {
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    loading.value = true;
    var response =
        await DioService().getMethod("${ApiUrlConstant.publishedByMe}3");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
    //articleList.clear();
  }

  updateTitle(){
    articleInfoModel.update((val) {
      val!.title=titleTextEditingController.text;
    });
  }

  storeArticle()async{
    var fileController=Get.find<PickFileController>();
    loading.value=true;
    Map<String,dynamic> map={
      ApiKeyConstant.title:articleInfoModel.value.title,
      ApiKeyConstant.content:articleInfoModel.value.content,
      ApiKeyConstant.catId:articleInfoModel.value.catId,
      ApiKeyConstant.tagList:"[]",
      ApiKeyConstant.userId:GetStorage().read("user_id"),
      ApiKeyConstant.image:await dio.MultipartFile.fromFile(fileController.file.value.path!),
      ApiKeyConstant.command:"store",
    };

    var response=await DioService().postMethod(map, ApiUrlConstant.postArticle);
    log(response.data.toString());
    if(response.data['status_code']==201){
      Get.offAllNamed(NamedRoute.routeMainScreen);
    }else{
      Get.snackbar("خطا", "خطا در ارسال اطلاعات به سرور");
    }
    loading.value=false;
  }

}
