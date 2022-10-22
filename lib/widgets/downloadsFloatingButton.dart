import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/screens/pages/sub_views/downloads_view.dart';
import 'package:get/get.dart';

class DownloadsFloatingButton extends GetWidget<DownloadController> {
const DownloadsFloatingButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Hero(
      tag: 'download',
      child: Obx(
        () {
          if(controller.downloadingSongs.value.isEmpty)return const SizedBox.shrink();
          return FloatingActionButton(
            heroTag: null,
            onPressed: (){
              Get.to(const DownloadsView());
            },
            backgroundColor: primaryColor,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.download
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}