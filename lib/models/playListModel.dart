import 'package:gaana/models/songModel.dart';

class PlayList{

  String name;
  List<Song> songs;

  PlayList({required this.name, this.songs=const <Song>[]});


  toMap()=>{
    'name':name,
    'songs':songs.map((e) => e.toMap()).toList()
  };

  static PlayList fromMap(Map data){
    return PlayList(
      name: data['name'],
      songs: (data['songs'] as List).map((e) => Song.fromMap(e)).toList()
    );
  }

}