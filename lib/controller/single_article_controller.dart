import 'package:get/get.dart';

import '../component/api_constant.dart';
import '../models/articles_model.dart';
import '../services/dio_service.dart';

class SingleArticleController extends GetxController{
  RxBool loading=false.obs;
  RxInt id=RxInt(0);
  @override
  onInit(){
    super.onInit();

  }

  getArticleList() async {
    loading.value=true;
    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {

      });
      loading.value=false;
    }
  }

}