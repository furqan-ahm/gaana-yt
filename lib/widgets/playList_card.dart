import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/models/playListModel.dart';

class PlayListCard extends StatelessWidget {
const PlayListCard({ Key? key, required this.list }) : super(key: key);

  final PlayList list;

  @override
  Widget build(BuildContext context){
    final isOffline = list.songs.first.isOffline;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: AspectRatio(
                aspectRatio: 6/4.5,
                child: isOffline?Image.file(File(list.songs.first.thumbnailMax)):Image.network(list.songs.first.thumbnailMax)
              ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 6/4.5,
              child: Container(
                color: Colors.black54,
                child: Center(child: Text(list.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}