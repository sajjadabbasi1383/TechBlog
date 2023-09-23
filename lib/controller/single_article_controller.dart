import 'package:get/get.dart';
import 'package:tech_blog/models/articles_model.dart';
import 'package:tech_blog/models/tags_model.dart';

import '../component/api_constant.dart';
import '../models/article_info_model.dart';
import '../services/dio_service.dart';

class SingleArticleController extends GetxController{
  RxBool loading=false.obs;
  RxInt id=RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel=ArticleInfoModel(null,null,null).obs;
  RxList<TagsModel> tagList=RxList();
  RxList<ArticleModel> releatedList=RxList();

  getArticleInfo() async {
    articleInfoModel=ArticleInfoModel(null,null,null).obs;
    loading.value=true;
    var userId='';
    var response = await DioService().getMethod('${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');
    if (response.statusCode == 200) {
      articleInfoModel.value=ArticleInfoModel.fromJson(response.data);
      loading.value=false;
    }

    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagsModel.fromJson(element));
    });

    releatedList.clear();
    response.data['related'].forEach((element) {
      releatedList.add(ArticleModel.fromJson(element));
    });


  }

}