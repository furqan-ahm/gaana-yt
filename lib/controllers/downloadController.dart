import 'dart:io';

import 'package:gaana/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../models/songModel.dart';


class DownloadController extends GetxController{

  late Directory appDirectory;
  


  Future downloadSong(Song song) async{
    final manifest = await yt.videos.streamsClient.getManifest(song.videoId);
    final list = manifest.audioOnly.toList();
    list.sort(
      (a,b)=>b.bitrate.compareTo(a.bitrate)
    );
    var streamInfo = list.first;

    if(streamInfo != null){
      var stream = yt.videos.streamsClient.get(streamInfo);

      var file = File('${appDirectory.path}/${song.videoId}.mp3');
      var fileStream = file.openWrite(mode: FileMode.write);

      
      await stream.pipe(fileStream);
      
      await fileStream.flush();
      await fileStream.close();
      
      final thumbnail =await downloadThumbnail(song);

      song.thumbnailMax=thumbnail;

      song.path = '${appDirectory.path}/${song.videoId}.mp3';
      return '${appDirectory.path}/${song.videoId}.mp3';
    }
  }

  Future<String> downloadThumbnail(Song song) async{
    final response = await get(Uri.parse(song.thumbnailMax));

    final fileExt=song.thumbnailMax.split('.').last;

    final thumbnailPath = appDirectory.path+'/Thumbnail${song.videoId}.$fileExt';
    File file = File(thumbnailPath);

    file.writeAsBytesSync(
      response.bodyBytes
    );
    return thumbnailPath;
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