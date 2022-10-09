import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:gaana/controllers/viewController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:gaana/widgets/savePlayListSheet.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../models/playListModel.dart';

class PlayerController extends GetxController{

  AudioPlayer player = AudioPlayer();
  late AnimationController likeAnimController;

  final _loopModes = [LoopMode.off, LoopMode.one,LoopMode.all]; 

  final RxBool _playing=false.obs;
  final Rx<List<Song>> songs = Rx<List<Song>>([]);
  final RxDouble position = 0.0.obs;
  final RxDouble trackMaxPosition=1.0.obs;
  final RxBool songLoading = false.obs;
  final Rx<LoopMode> loomMode=Rx<LoopMode>(LoopMode.off);

  late StreamSubscription playerStateSub;
  int currentTrack = 0;
  late ConcatenatingAudioSource playList = ConcatenatingAudioSource(children: []);  
  
  SwiperController pageController= SwiperController();

  Song get currentSong => songs.value[currentTrack];
  bool get isPlaying => _playing.value;
  
  bool _autoPageChange=false;


  setAnimationController(AnimationController controller){
    likeAnimController=controller;
  }

  onPageChange(int i){
    if(!_autoPageChange)play(i);
    _autoPageChange=false;
  }

  addToFav(){
    final favController = Get.find<LibraryController>();
    if(!favController.isFav(currentSong)){
      likeAnimController.forward().then((value){
        likeAnimController.reverse();
      });
      favController.addFavorite(currentSong);
    }
  }


  addPlayList(PlayList list)async{
    await flush();
    for (var song in list.songs) {
      addSong(song, true);
    }
  }



  addSong(Song song, [isPlayList=false]){

    if(!isPlayList) {
      Get.snackbar(
        'Added To Current Playlist',
        'Go to Player Page?',
        duration: const Duration(seconds: 1),
        onTap: (val){
          Get.find<ViewController>().changePage(1);
        },
      );
    }
    if(song.path!=null){
      playList.add(
        AudioSource.uri(
          Uri.parse(song.path!),
          tag: MediaItem(
            id: song.videoId,
            title: song.title,
            artUri: Uri.parse(song.thumbnailMed)
          )
        )
      ).then((value){
        if(currentTrack==0&&!isPlaying){
          play(0);
        }
      });
      
      songs.value=[...songs.value, song];
      return;
    }
    yt.videos.streamsClient.getManifest(song.videoId).then((value){
      if(value.audioOnly.isNotEmpty){
        final list = value.audioOnly.toList();
        list.sort(
          (a,b)=>b.bitrate.compareTo(a.bitrate)
        );
        song.audioUri=list.first.url;
        playList.add(
          AudioSource.uri(
            song.audioUri,
            tag: MediaItem(
              id: song.videoId,
              title: song.title,
              artUri: Uri.parse(song.thumbnailMed)
            )
          )
        ).then((value){
          if(currentTrack==0&&!isPlaying){
            play(0);
          }
        });
        songs.value=[...songs.value, song];
      }
      else{
        Get.showSnackbar(
          GetSnackBar(
            title: 'Unable to play ${song.title}',
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
    print('new length is ${songs.value.length}');
    songs.value=[...songs.value];
  }


  @override
  void onInit() {
    _playing.bindStream(player.playingStream);
    position.bindStream(player.positionStream.map((event) => event.inMilliseconds.toDouble()));
    loomMode.bindStream(player.loopModeStream);
    player.setAudioSource(playList);
    player.currentIndexStream.listen((event) async{
      if(event!=null&&event!=currentTrack){
        currentTrack=event;
        _autoPageChange=true;
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

  void savePlayList() async{
    await Get.bottomSheet(
      SavePlayListSheet(songs: songs.value,)
    );
  }

  void toggleLoopMode() {
    int i = _loopModes.indexOf(player.loopMode);
    player.setLoopMode(i==2?_loopModes[0]:_loopModes[i+1]);
  }

}