import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SongTile extends GetWidget<PlayerController> {
  const SongTile({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            song.thumbnailMed,
            width: 100,
            fit: BoxFit.fitHeight,
          ),
          Expanded(child: Text(song.title,)),
          Align(alignment:Alignment.centerRight,child: IconButton(onPressed: () {controller.addSong(song);}, icon: Icon(Icons.playlist_play)))
        ],
      ),
    );
  }
}
