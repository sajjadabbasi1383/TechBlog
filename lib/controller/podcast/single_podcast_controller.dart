import 'package:get/get.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/services/dio_service.dart';

import '../../models/podcast_file_model.dart';

class SinglePodcastController extends GetxController{

  var id;
  SinglePodcastController({this.id});

  RxBool loading=false.obs;
  RxList<PodcastFileModel> podcastFileList=RxList();

  @override
  onInit(){
    super.onInit();
    getPodcastFile();
  }

  getPodcastFile()async{
    loading.value=true;

    var response=await DioService().getMethod(ApiUrlConstant.podcastFile+id);

    if(response.statusCode==200){
      for(var element in response.data['files']){
        podcastFileList.add(PodcastFileModel.fromJson(element));
      }
      loading.value==false;
    }

  }

}