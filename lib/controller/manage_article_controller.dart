import 'package:get/get.dart';
import '../component/api_constant.dart';
import '../models/articles_model.dart';
import '../services/dio_service.dart';

class ManageArticleController extends GetxController{
  RxList<ArticleModel> articleList=RxList();
  RxBool loading=false.obs;

  @override
  onInit(){
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    loading.value=true;
    var response = await DioService().getMethod("${ApiConstant.publishedByMe}3");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value=false;
    }
    //articleList.clear();
  }

}