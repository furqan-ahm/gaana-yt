import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/viewController.dart';
import 'package:gaana/models/song.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerController extends GetxController{

  AudioPlayer player = AudioPlayer();


  final RxBool _playing=false.obs;
  final Rx<List<Song>> songs = Rx<List<Song>>([]);
  final RxDouble position = 0.0.obs;
  final RxDouble trackMaxPosition=1.0.obs;
  final RxBool songLoading = true.obs;

  late StreamSubscription playerStateSub;
  int currentTrack = 0;
  late ConcatenatingAudioSource playList;  
  
  PageController pageController= PageController(initialPage: 0, viewportFraction: 0.75);

  Song get currentSong => songs.value[currentTrack];
  bool get isPlaying => _playing.value;
  


  onPageChange(int i){
    play(i);
  }


  addSong(Video video){
    final song=Song(video: video);
    songs.value=[...songs.value, song];
    update();
    Get.showSnackbar(
      GetSnackBar(
        title: 'Added To Current Playlist',
        message: 'Go to Player Page?',
        duration: const Duration(seconds: 2),
        onTap: (val){
          Get.find<ViewController>().changePage(1);
        },
      ),
    );
    yt.videos.streamsClient.getManifest(video.id).then((value){
      if(value.audioOnly.isNotEmpty){
        song.audioUri=value.audioOnly.first.url;
        if(songs.value.length==1){
          play(0);
        }
      }
      else{
        Get.showSnackbar(
          GetSnackBar(
            title: 'Unable to play ${video.title}',
            message: 'Try playing something else',
          )
        );
        songs.value.remove(song);
        songs.value=songs.value;
      }
    });
  }

  forward(){
    if(currentTrack!=songs.value.length-1)pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  backward(){
    if(currentTrack!=0)pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  play(int index)async{
    currentTrack=index;
    await player.stop();
    songLoading.value=true;
    final AudioSource src = AudioSource.uri(
      songs.value[index].audioUri,
      tag: MediaItem(id: '$index', title: songs.value[index].video.title,artUri: Uri.parse(songs.value[index].video.thumbnails.mediumResUrl)),
    );
    player.setAudioSource(src).then((value){
      trackMaxPosition.value=value!.inMilliseconds.toDouble();
      player.play();
      songLoading.value=false;
    });
  }


  flush(){
    player.stop();
    trackMaxPosition.value=1.0;
    pageController.jumpTo(0);
    songs.value.clear();
    songs.value=[];
    currentTrack=0;
  }


  @override
  void onInit() {
    _playing.bindStream(player.playingStream);
    position.bindStream(player.positionStream.map((event) => event.inMilliseconds.toDouble()));
    
    playerStateSub=player.playerStateStream.listen((event) {
      if(event.processingState==ProcessingState.completed){
        player.pause();
        forward();
      }
    });
    
    super.onInit();
  }

  void togglePlay() {
    isPlaying?player.pause():player.play();
  }


  @override
  void onClose() {
    playerStateSub.cancel();

    super.onClose();
  }

}