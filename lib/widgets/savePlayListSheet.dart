import 'package:flutter/material.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:gaana/models/playListModel.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/songModel.dart';

class SavePlayListSheet extends GetWidget<LibraryController> {
  const SavePlayListSheet({Key? key, required this.songs}) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: ThemeData.dark().backgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Save Current PlayList?'),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.playlistNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'PlayList Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            color: primaryColor,
            borderRadius: BorderRadius.circular(11),
            child: InkWell(
              onTap: () {
                controller.addPlayList(PlayList(name: controller.playlistNameController.text, songs: songs));
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                    width: Size.infinite.width, child: const Center(child: Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
