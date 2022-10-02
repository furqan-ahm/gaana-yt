import 'dart:io';

import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesController extends GetxController{

  
  late CollectionBox<Map> favBox;
  late BoxCollection db;
  

  Rx<List<String>> downloading = Rx<List<String>>([]);

  Rx<List<Song>> songs = Rx<List<Song>>([]);

  addFavorite(Song song)async{
    await favBox.put(
      song.videoId, song.toMap()
    );
    songs.value=[...songs.value,song];
  }


  initDataBase()async{

    Directory path =await getApplicationDocumentsDirectory();

    db = await BoxCollection.open('db', {'favorites'}, path: path.path);
    favBox = await db.openBox('favorites');
    favBox.getAllValues().then((value){
      songs.value=value.values.map((e) => Song.fromMap(e)).toList();
    });
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
      File(songs.value[index].path!).delete();
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
    }
  }



}