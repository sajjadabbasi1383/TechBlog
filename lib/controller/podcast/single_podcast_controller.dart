import 'dart:async';

import 'package:flutter/material.dart';
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
  RxBool isLoopAll = false.obs;
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

  int? duration;
  Rx<Duration> progressState = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> bufferState = const Duration(seconds: 0).obs;
  Timer? timer;
  startProgress() {
    const tick = Duration(seconds: 1);
    switch (player.duration) {
      case null:
        duration = 0;
        break;
      default:
        duration = player.duration!.inSeconds-player.position.inSeconds;
        break;
    }

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      if (player.position.inSeconds == duration) {
        timer.cancel();
      }
      if (player.playing) {
        progressState.value = player.position;

        bufferState.value = player.bufferedPosition;
        debugPrint('TIMER :: ${progressState.value}');
      }
    });
  }

  timerCheck(){
    if(player.playing){
      startProgress();
    }
  }

  setLoopMode() {
    if (isLoopAll.value){
      player.setLoopMode(LoopMode.off);
      isLoopAll.value=false;
    }else{
      player.setLoopMode(LoopMode.all);
      isLoopAll.value=true;
    }
  }
}
