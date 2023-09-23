import 'package:get/get.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/articles_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';




class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxList<TagsModel> tagList = RxList();
  RxBool loading = false.obs;
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
        await DioService().getMethod("${ApiConstant.publishedByMe}3");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
    //articleList.clear();
  }
}
