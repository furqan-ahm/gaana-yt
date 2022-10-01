import 'dart:io';

import 'package:gaana/constants.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../models/songModel.dart';


class DownloadController extends GetxController{

  late Directory appDirectory;
  


  downloadSong(Song song) async{
    final manifest = await yt.videos.streamsClient.getManifest(song.videoId);
    var streamInfo = manifest.audioOnly.first;

    if(streamInfo != null){
      var stream = yt.videos.streamsClient.get(streamInfo);

      var file = File(appDirectory.path+'/${song.videoId}.mp3');
      var fileStream = file.openWrite(mode: FileMode.write);

      await stream.pipe(fileStream);

      await fileStream.flush();
      await fileStream.close();
      
      return appDirectory.path+'/${song.videoId}.mp3';
    }

  }


  @override
  void onInit() {
    getApplicationDocumentsDirectory().then((value){
      appDirectory=value;
      print(appDirectory.path);
    });  
    super.onInit();
  }
}