import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Song {
  String videoId;
  String url;
  Duration? duration;
  String? path;
  String thumbnailMed;
  String thumbnailMax;

  late Uri audioUri;

  Song({
    required this.videoId,
    required this.url,
    required this.thumbnailMed,
    required this.thumbnailMax,
    required this.duration,
    this.path,
  });

  static Song fromVideo(Video vid) {
    return Song(
      videoId: vid.id.toString(),
      url: vid.url,
      thumbnailMed: vid.thumbnails.mediumResUrl,
      thumbnailMax: vid.thumbnails.maxResUrl,
      duration: vid.duration,
    );
  }

  static Song fromMap(Map<String, dynamic> data) {
    return Song(
        videoId: data['id'],
        path: data['path'],
        url: data['url'],
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
      'thumbnailMed':thumbnailMed,
      'thumbnailMax':thumbnailMax,
      'duration':duration!.inMilliseconds
    };
  }
}
