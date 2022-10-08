import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/favoritesController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/favSongTile.dart';
import 'package:gaana/widgets/favorite_tabs.dart';
import 'package:get/get.dart';


class LibraryScreen extends GetView<FavoritesController> {
const LibraryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const FavoriteTabs(),
            const SizedBox(height: 10,),
            Obx(
              () {
                final songs = controller.getSongs;
    
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
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
                  },
                );
              }
            )
          ],
        ),
      ),
    );
  }
}