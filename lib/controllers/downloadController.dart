import 'dart:io';

import 'package:gaana/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../models/songModel.dart';


class DownloadController extends GetxController{

  late Directory appDirectory;

  late Rx<List<Song>> downloadingSongs=Rx<List<Song>>([]);
  late Rx<Map<String, double>> downloadingSongsProgress = Rx<Map<String, double>>({});

  Future downloadSong(Song song, Function? onComplete) async{
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

      final total = streamInfo.size.totalBytes;
      double progress = 0;
      stream.listen((event) {
        progress += event.length/total;

        //no idea if this works but worth a try
        downloadingSongsProgress.value[song.videoId]=progress;
        downloadingSongsProgress.refresh();
        print(progress);
        fileStream.add(event);
      }).onDone(() async{
        await fileStream.flush();
        await fileStream.close();
        
        final thumbnail =await downloadThumbnail(song);
        song.thumbnailMax=thumbnail;

        song.path = '${appDirectory.path}/${song.videoId}.mp3';
        onComplete==null?null:onComplete();
      });
      
      // await stream.pipe(fileStream);
      
      // await fileStream.flush();
      // await fileStream.close();
      //song.path = '${appDirectory.path}/${song.videoId}.mp3';
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