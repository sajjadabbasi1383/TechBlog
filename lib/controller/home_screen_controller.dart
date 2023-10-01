import 'package:get/get.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

import '../models/articles_model.dart';
import '../models/podcast_model.dart';
import '../models/poster_model.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster=PosterModel().obs;
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcastList = RxList();
  RxList<TagsModel> tagList = RxList();

  RxBool loading=false.obs;

  @override
  onInit(){
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async {
    loading.value=true;
    var response = await DioService().getMethod(ApiUrlConstant.getHomeItem);
    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });

      response.data['top_podcasts'].forEach((element) {
        topPodcastList.add(PodcastModel.fromJson(element));
      });

      response.data['tags'].forEach((element) {
        tagList.add(TagsModel.fromJson(element));
      });

      poster.value=PosterModel.fromJson(response.data['poster']);

      loading.value=false;
    }
  }
}
