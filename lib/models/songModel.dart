import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Song {
  String title;
  String videoId;
  String url;
  Duration? duration;
  String? path;
  String thumbnailMed;
  String thumbnailMax;

  late Uri audioUri;


  bool get isOffline => path!=null;

  Song({
    required this.videoId,
    required this.url,
    required this.title,
    required this.thumbnailMed,
    required this.thumbnailMax,
    required this.duration,
    this.path,
  });

  static Song fromVideo(Video vid) {
    return Song(
      title: vid.title,
      videoId: vid.id.toString(),
      url: vid.url,
      thumbnailMed: vid.thumbnails.mediumResUrl,
      thumbnailMax: vid.thumbnails.highResUrl,
      duration: vid.duration,
    );
  }


  String get length{
    int seconds = duration!.inSeconds;
    int minutes = seconds~/60;
    int hours = minutes~/60;

    seconds=seconds%60;
    minutes=minutes%60;
    hours=hours;

    final result ='${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    if(hours!=0)return '${hours.toString().padLeft(2, '0')}:$result';

    return result;
  }


  static Song fromMap(Map data) {
    return Song(
        videoId: data['id'],
        path: data['path'],
        url: data['url'],
        title: data['title'],
        thumbnailMed: data['thumbnailMed'],
        thumbnailMax: data['thumbnailMax'],
        duration: Duration(milliseconds: data['duration'],
         
      ));
  }

  toMap() {
    return {
      'id': videoId,
      'url': url,
      'path': path,
      'title':title,
      'thumbnailMed':thumbnailMed,
      'thumbnailMax':thumbnailMax,
      'duration':duration!.inMilliseconds
    };
  }
}
