import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class FavSongTile extends GetWidget<PlayerController> {
  const FavSongTile({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              song.thumbnailMed,
              width: 60,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(song.title, overflow: TextOverflow.ellipsis, maxLines: 2,)),
          Align(alignment:Alignment.centerRight,child: IconButton(onPressed: () {controller.addSong(song);}, icon: Icon(Icons.playlist_play)))
        ],
      ),
    );
  }
}
