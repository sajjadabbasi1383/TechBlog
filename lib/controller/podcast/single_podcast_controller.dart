import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/services/dio_service.dart';

import '../../models/podcast_file_model.dart';

class SinglePodcastController extends GetxController {
  var id;

  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  late var playList;
  final player = AudioPlayer();
  RxBool playState=false.obs;

  @override
  onInit()async{
    super.onInit();
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);
    await getPodcastFile();
    await player.setAudioSource(playList,initialIndex: 0,initialPosition: Duration.zero);
  }

  getPodcastFile() async {
    loading.value = true;

    var response =
        await DioService().getMethod(ApiUrlConstant.podcastFile + id);

    if (response.statusCode == 200) {
      for (var element in response.data['files']) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
        playList.add(AudioSource.uri(Uri.parse(PodcastFileModel.fromJson(element).file!)));
      }
      loading.value == false;
    }
  }
}
