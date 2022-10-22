import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:get/get.dart';
import 'package:gaana/models/playListModel.dart';

import '../controllers/playerController.dart';

class PlayListCard extends StatefulWidget {
  const PlayListCard({
    Key? key,
    required this.list,
  }) : super(key: key);

  final PlayList list;

  @override
  State<PlayListCard> createState() => _PlayListCardState();
}

class _PlayListCardState extends State<PlayListCard> {
  bool selected = false;


  LibraryController controller = Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    final isOffline = widget.list.songs.first.isOffline;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: AspectRatio(
                aspectRatio: 6 / 4.5,
                child: isOffline
                    ? Image.file(File(widget.list.songs.first.thumbnailMax))
                    : Image.network(widget.list.songs.first.thumbnailMax)),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 6 / 4.5,
              child: Material(
                color: Colors.black54,
                child: selected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() => selected = !selected);
                              controller.deletePlayList(widget.list);
                            },
                            icon: const Icon(Icons.delete)
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit))
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          Get.find<PlayerController>().addPlayList(widget.list);
                        },
                        child: Center(
                          child: Text(
                            widget.list.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: InkWell(
              onTap: () => setState(() => selected = !selected),
              child: Icon(selected ? Icons.close : Icons.more_horiz)),
          )
        ],
      ),
    );
  }
}
