import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SongTile extends GetWidget<PlayerController> {
  const SongTile({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            video.thumbnails.mediumResUrl,
            width: 100,
            fit: BoxFit.fitHeight,
          ),
          Expanded(child: Text(video.title,)),
          Align(alignment:Alignment.centerRight,child: IconButton(onPressed: () {controller.addSong(video);}, icon: Icon(Icons.playlist_play)))
        ],
      ),
    );
  }
}
