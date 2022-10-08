import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/models/songModel.dart';
import 'package:get/get.dart';

class FavSongTile extends GetWidget<LibraryController> {
  const FavSongTile({Key? key, required this.song, required this.index}) : super(key: key);

  final Song song;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: song.isOffline?
                    Image.file(File(song.thumbnailMax), width: 60, height: 60, fit: BoxFit.cover,):
                    Image.network(song.thumbnailMax, width: 60, height: 60, fit: BoxFit.cover,),
                  ),
                  title: Text(song.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      song.isOffline?Container():IconButton(
                        icon: Icon(Icons.download),
                        onPressed: (){
                          controller.download(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          controller.delete(index);
                        },
                      ),
                    ],
                  ),
                  onTap: (){
                    Get.find<PlayerController>().addSong(song);
                  },
                ),
              );
      }
    );
  }
}
