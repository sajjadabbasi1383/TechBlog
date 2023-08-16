import 'package:get/get.dart';
import 'package:tech_blog/component/api_constant.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

import '../models/articles_model.dart';
import '../models/podcast_model.dart';
import '../models/poster_model.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster;
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcastList = RxList();
  RxList<TagsModel> tagList = RxList();

  @override
  onInit(){
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async {
    var response = await DioService().getMethod(ApiConstant.getHomeItem);
    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });

      response.data['top_podcasts'].forEach((element) {
        topPodcastList.add(PodcastModel.fromJson(element));
      });
    }
  }
}
