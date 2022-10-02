import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/favoritesController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/favorite_tabs.dart';
import 'package:get/get.dart';


class FavScreen extends GetView<FavoritesController> {
const FavScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                    return ListTile(
                      leading: songs[index].isOffline?
                      Image.file(File(songs[index].thumbnailMax),)
                      :
                      Image.network(songs[index].thumbnailMax),
                      title: Text(songs[index].title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          songs[index].isOffline?Container():IconButton(
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
                        Get.find<PlayerController>().addSong(songs[index]);
                      },
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