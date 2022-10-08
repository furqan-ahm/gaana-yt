import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';

class SongTile extends GetWidget<PlayerController> {
  const SongTile({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              controller.addSong(song);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: song.thumbnailMed,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Icon(Icons.music_note);
                },
              )
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(song.title, overflow: TextOverflow.ellipsis, maxLines: 2,),
              const SizedBox(height: 2,),
              song.duration!=null?Text(song.length, style: const TextStyle(color: Colors.grey),):Container()
            ],
          )),
          Align(alignment:Alignment.centerRight,child: IconButton(onPressed: () {controller.addSong(song);}, icon: const Icon(Icons.playlist_play)))
        ],
      ),
    );
  }
}
