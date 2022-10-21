import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:get/get.dart';

class DownloadsFloatingButton extends GetWidget<DownloadController> {
const DownloadsFloatingButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Obx(
      () {
        if(controller.downloadingSongs.value.isEmpty)return const SizedBox.shrink();

        return FloatingActionButton(
          onPressed: (){
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
    );
  }
}