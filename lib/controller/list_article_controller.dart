import 'package:get/get.dart';

import '../component/api_constant.dart';
import '../models/articles_model.dart';
import '../services/dio_service.dart';

class ListArticleController extends GetxController{
  RxList<ArticleModel> articleList=RxList();
  RxBool loading=false.obs;

  @override
  onInit(){
    super.onInit();
    getArticleList();
  }

  getArticleList() async {
    loading.value=true;
    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value=false;
    }
  }


  getArticleWithTag(String id) async {
    articleList.clear();
    loading.value=true;
    var response = await DioService().getMethod('${ApiConstant.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=');
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value=false;
    }
  }

}