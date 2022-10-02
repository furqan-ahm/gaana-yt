import 'dart:io';

import 'package:gaana/constants.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../models/songModel.dart';


class DownloadController extends GetxController{

  late Directory appDirectory;
  


  Future downloadSong(Song song) async{
    final manifest = await yt.videos.streamsClient.getManifest(song.videoId);
    var streamInfo = manifest.audioOnly.first;

    if(streamInfo != null){
      var stream = yt.videos.streamsClient.get(streamInfo);

      var file = File('${appDirectory.path}/${song.videoId}.mp3');
      var fileStream = file.openWrite(mode: FileMode.write);

      await stream.pipe(fileStream);

      await fileStream.flush();
      await fileStream.close();

      print(song.thumbnailMax);
      final thumbnailId = await ImageDownloader.downloadImage(song.thumbnailMax,
                            destination: AndroidDestinationType.custom(directory: 'thumbnails')
                            ..inExternalFilesDir()
                            ..subDirectory("/${song.videoId}.jpg"),
        );
      final thumbnail = await ImageDownloader.findPath(thumbnailId!);

      song.thumbnailMax=thumbnail!;

      song.path = '${appDirectory.path}/${song.videoId}.mp3';
      return '${appDirectory.path}/${song.videoId}.mp3';
    }
  }

  downloadThumbnail(Song song) async{

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