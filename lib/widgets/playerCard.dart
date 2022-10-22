import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

import '../models/songModel.dart';

class PlayerCard extends GetWidget<PlayerController> {
const PlayerCard({ Key? key, required this.song }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onDoubleTap: (){
          controller.addToFav();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: song.isOffline?Image.file(File(song.offlineThumbnail!), fit: BoxFit.cover,):Image.network(song.thumbnailMax, fit: BoxFit.cover,)
          ),
        ),
      ),
    );
  }
}