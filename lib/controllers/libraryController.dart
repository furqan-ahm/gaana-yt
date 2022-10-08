import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/models/playListModel.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LibraryController extends GetxController{

  
  late CollectionBox<Map> favBox;
  late CollectionBox<Map> playListBox;
  late BoxCollection db;
  

  Rx<List<String>> downloading = Rx<List<String>>([]);
  RxBool offlineOnly = false.obs;
  Rx<List<Song>> songs = Rx<List<Song>>([]);
  Rx<List<PlayList>> playlists = Rx<List<PlayList>>([]);


  final TextEditingController playlistNameController = TextEditingController();

  List<Song> get getSongs{
    return offlineOnly.value?songs.value.where((element) => element.isOffline).toList():songs.value;
  } 


  addFavorite(Song song)async{
    await favBox.put(
      song.videoId, song.toMap()
    );
    songs.value=[...songs.value,song];
  }



  initDataBase()async{

    Directory path =await getApplicationDocumentsDirectory();

    db = await BoxCollection.open('db', {'favorites', 'playlists'}, path: path.path);
    favBox = await db.openBox('favorites');
    playListBox = await db.openBox('playlists');
    favBox.getAllValues().then((value){
      songs.value=value.values.map((e) => Song.fromMap(e)).toList();
    });
    playListBox.getAllValues().then((value){
      playlists.value=value.values.map((e) => PlayList.fromMap(e)).toList();
    });
  }


  addPlayList(PlayList list)async{

    if(playlists.value.where((element) => element.name==list.name).isNotEmpty){
      Get.snackbar('Error creating', 'Playlist with that name already exists', duration: const Duration(seconds: 2), snackPosition: SnackPosition.BOTTOM);
      return;
    }

    await playListBox.put(
      list.name, list.toMap()
    );
    playlists.value=[...playlists.value,list];
  }



  @override
  void onInit() {
    initDataBase();
    super.onInit();
  }

  @override
  void onClose() {
    db.close();
    super.onClose();
  }

  bool isFav(Song song) {
    return songs.value.where((element) => element.videoId==song.videoId).isNotEmpty;
  }


  void delete(int index)async{
    await favBox.delete(songs.value[index].videoId);
    if(songs.value[index].isOffline){
      File(songs.value[index].path!).exists().then((value) {if(value)File(songs.value[index].path!).delete();});
    }
    songs.value.removeAt(index);
    songs.value=[...songs.value];
  }

  void download(int index) async{
    if(!downloading.value.contains(songs.value[index].videoId)){
      downloading.value=[...downloading.value, songs.value[index].videoId];
      await Get.find<DownloadController>().downloadSong(songs.value[index]);
      await favBox.delete(songs.value[index].videoId);
      await favBox.put(songs.value[index].videoId,songs.value[index].toMap());
      
      downloading.value.remove(songs.value[index].videoId);
      downloading.value=[...downloading.value];
      songs.value=[...songs.value];
      print('done');
    }
  }



}