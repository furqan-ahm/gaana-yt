import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/playList_card.dart';
import 'package:get/get.dart';


class LibraryScreen extends GetView<LibraryController> {
const LibraryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            const Center(child: Text('Library', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
              child: Text('Playlists', style: TextStyle(fontSize: 20,),),
            ),
            SizedBox(
              height: 100,
              child: Obx(
                (){
                  final playlists = controller.playlists.value;

                  if(playlists.isEmpty){
                    return const Center(
                      child: Text('You dont have any playlists yet'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: playlists.length,
                    itemBuilder: (context, index){
                      return PlayListCard(list: playlists[index]);
                    },
                  );
                }
              ),
            ),
            const SizedBox(height: 40,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
              child: Text('Favorites', style: TextStyle(fontSize: 20,),),
            ),
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
                        trailing: IconButton(onPressed: (){song.isOffline?controller.delete(index):controller.download(index);}, icon: Icon(song.isOffline?Icons.delete:Icons.download)),
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