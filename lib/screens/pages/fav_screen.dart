import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/favoritesController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/songTile.dart';
import 'package:get/get.dart';


class FavScreen extends GetView<FavoritesController> {
const FavScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Obx(
            () {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.songs.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: controller.songs.value[index].isOffline?
                      Image.file(File(controller.songs.value[index].thumbnailMax),)
                      :
                      Image.network(controller.songs.value[index].thumbnailMax),
                      title: Text(controller.songs.value[index].title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.songs.value[index].isOffline?Container():IconButton(
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
                        Get.find<PlayerController>().addSong(controller.songs.value[index]);
                      },
                    );
                  },
                ),
              );
            }
          )
        ],
      ),
    );
  }
}