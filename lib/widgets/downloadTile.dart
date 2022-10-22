import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:get/get.dart';

import '../models/songModel.dart';

class DownloadTile extends GetWidget<DownloadController> {
const DownloadTile({ Key? key, required this.song }) : super(key: key);


  final Song song;

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: 
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(song.thumbnailMax, width: 60, height: 60, fit: BoxFit.cover,),
          ),
          title: Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
          subtitle: Obx(
            () {

              final progress = controller.downloadingSongsProgress.value[song.videoId];

              return LinearProgressIndicator(
                value: progress,
                color: primaryColor,
              );
            }
          ),
        ),
      );
  }
}