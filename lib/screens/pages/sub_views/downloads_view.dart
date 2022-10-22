import 'package:flutter/material.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/widgets/downloadTile.dart';
import 'package:get/get.dart';

class DownloadsView extends GetView<DownloadController> {
const DownloadsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const Center(child: Text('Downloads', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
            const SizedBox(height: 30,),
            Obx(
              () {
                final songs = controller.downloadingSongs.value; 
                if(songs.isEmpty){
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text('Completed!'),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: songs.length,
                  itemBuilder: (context, index)=>DownloadTile(song: songs[index]),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}