import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/viewController.dart';
import 'package:gaana/models/songModel.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerController extends GetxController{

  AudioPlayer player = AudioPlayer();
  late AnimationController likeAnimController;


  final RxBool _playing=false.obs;
  final Rx<List<Song>> songs = Rx<List<Song>>([]);
  final RxDouble position = 0.0.obs;
  final RxDouble trackMaxPosition=1.0.obs;
  final RxBool songLoading = false.obs;

  late StreamSubscription playerStateSub;
  int currentTrack = 0;
  late ConcatenatingAudioSource playList = ConcatenatingAudioSource(children: []);  
  
  SwiperController pageController= SwiperController();

  Song get currentSong => songs.value[currentTrack];
  bool get isPlaying => _playing.value;
  



  setAnimationController(AnimationController controller){
    likeAnimController=controller;
  }

  onPageChange(int i){
    play(i);
  }

  addToFav(int index){
    likeAnimController.forward().then((value){
      likeAnimController.reset();
    });
  }


  addSong(Video video){
    final song=Song.fromVideo(video);
    songs.value=[...songs.value, song];
    Get.showSnackbar(
      GetSnackBar(
        title: 'Added To Current Playlist',
        message: 'Go to Player Page?',
        duration: const Duration(seconds: 1),
        onTap: (val){
          Get.find<ViewController>().changePage(1);
        },
      ),
    );
    yt.videos.streamsClient.getManifest(video.id).then((value){
      if(value.audioOnly.isNotEmpty){
        song.audioUri=value.audioOnly.first.url;
        playList.add(
          AudioSource.uri(
            song.audioUri,
            tag: MediaItem(
              id: video.id.value,
              title: video.title,
              artUri: Uri.parse(video.thumbnails.mediumResUrl)
            )
          )
        ).then((value){
          if(songs.value.length==1){
            play(0);
          }
        });
      }
      else{
        Get.showSnackbar(
          GetSnackBar(
            title: 'Unable to play ${video.title}',
            message: 'Try playing something else',
            duration: const Duration(seconds: 1),
          )
        );
        songs.value.remove(song);
        songs.value=[...songs.value];
      }
    });
  }

  forward(){
    if(currentTrack<songs.value.length-1)pageController.next();
  }

  backward(){
    if(currentTrack!=0)pageController.previous();
  }

  play(int index)async{
    currentTrack=index;
    await player.seek(Duration.zero, index: index);
    player.play();
  }


  flush(){
    player.stop();
    playList.clear();
    trackMaxPosition.value=1.0;
    pageController.move(0);
    songs.value.clear();
    songs.value=[];
    currentTrack=0;
  }

  
  void dismissTrack(int index) {
    
    if(player.currentIndex==index&&index==songs.value.length-1){
      print('last');
      player.seekToPrevious();
    }
    playList.removeAt(index);
    songs.value.removeAt(index);
    songs.value=[...songs.value];
  }


  @override
  void onInit() {
    _playing.bindStream(player.playingStream);
    position.bindStream(player.positionStream.map((event) => event.inMilliseconds.toDouble()));
    player.setAudioSource(playList);
    player.currentIndexStream.listen((event) {
      if(event!=null&&event!=currentTrack){
        currentTrack=event;
        print(event);
        pageController.move(currentTrack);
      }
    });
    trackMaxPosition.bindStream(player.durationStream.map((event) => event==null?1:event.inMilliseconds.toDouble()));
    playerStateSub=player.playerStateStream.listen((event) {
      if(event.processingState==ProcessingState.completed){
        player.pause();
        forward();
      }
      if(event.processingState==ProcessingState.buffering){
        songLoading.value=true;
      }
      if(event.processingState==ProcessingState.ready){
        songLoading.value=false;
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