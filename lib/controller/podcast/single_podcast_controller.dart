import 'dart:async';

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
  RxBool playState = false.obs;
  RxInt currentFileIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);
    await getPodcastFile();
    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  getPodcastFile() async {
    loading.value = true;

    var response =
        await DioService().getMethod(ApiUrlConstant.podcastFile + id);

    if (response.statusCode == 200) {
      for (var element in response.data['files']) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
        playList.add(AudioSource.uri(
            Uri.parse(PodcastFileModel.fromJson(element).file!)));
      }
      loading.value == false;
    }
  }

  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;

  Timer? timer;

  startProgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds-player.position.inSeconds;

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }

    timer = Timer.periodic(tick, (timer) {
      duration--;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;

      if (duration <= 0) {
        timer.cancel();
        progressValue.value = const Duration(seconds: 0);
        bufferedValue.value = const Duration(seconds: 0);
      }
    });
  }
}
