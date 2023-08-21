import 'package:get/get.dart';

import '../component/api_constant.dart';
import '../models/article_info_model.dart';
import '../services/dio_service.dart';

class SingleArticleController extends GetxController{
  RxBool loading=false.obs;
  RxInt id=RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel=ArticleInfoModel().obs;

  getArticleInfo() async {
    loading.value=true;
    var response = await DioService().getMethod('${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=1');
    if (response.statusCode == 200) {
      articleInfoModel.value=ArticleInfoModel.fromJson(response.data);
      loading.value=false;
    }
  }

}