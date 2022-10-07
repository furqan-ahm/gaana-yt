import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/favoritesController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/favSongTile.dart';
import 'package:gaana/widgets/favorite_tabs.dart';
import 'package:get/get.dart';


class FavScreen extends GetView<FavoritesController> {
const FavScreen({ Key? key }) : super(key: key);

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
                    return FavSongTile(song: songs[index], index: index);
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