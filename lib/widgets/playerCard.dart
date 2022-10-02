import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

import '../models/songModel.dart';

class PlayerCard extends GetWidget<PlayerController> {
const PlayerCard({ Key? key, required this.index, required this.song }) : super(key: key);

  final int index;
  final Song song;

  @override
  Widget build(BuildContext context){
    return Dismissible(
            direction: DismissDirection.up,
            confirmDismiss: (d)async{
              controller.dismissTrack(index);
              return true;
            },
            key: Key(song.videoId.toString()+index.toString()),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: GestureDetector(
                onDoubleTap: (){
                  print('here');
                  controller.addToFav();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: song.isOffline?Image.file(File(song.thumbnailMax), fit: BoxFit.cover,):Image.network(song.thumbnailMax, fit: BoxFit.cover,)
                  ),
                ),
              ),
            ),
          );
  }
}