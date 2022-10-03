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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              song.thumbnailMed,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(song.title, overflow: TextOverflow.ellipsis, maxLines: 2,),
              SizedBox(height: 2,),
              Text('${song.length}', style: TextStyle(color: Colors.grey),)
            ],
          )),
          Align(alignment:Alignment.centerRight,child: IconButton(onPressed: () {controller.addSong(song);}, icon: Icon(Icons.playlist_play)))
        ],
      ),
    );
  }
}
