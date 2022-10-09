import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../constants.dart';

class PlayerControls extends GetWidget<PlayerController> {
const PlayerControls({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                controller.toggleLoopMode();
              },
              icon: Icon(
                controller.loomMode.value==LoopMode.one?Icons.repeat_one:Icons.repeat, size: 26,
                color: controller.loomMode.value==LoopMode.off?null:primaryColor,
              )
            ),
            IconButton(onPressed: (){controller.backward();}, icon: Icon(Icons.fast_rewind, size: 37,)),
            FloatingActionButton.large(
              onPressed: (){
                controller.togglePlay();
              },
              backgroundColor: primaryColor,
              child: controller.songLoading.value?const CircularProgressIndicator(color: Colors.white,):Icon(!controller.isPlaying?Icons.play_arrow:Icons.pause, color: Colors.white, size: 42,),
            ),
            IconButton(onPressed: (){controller.forward();}, icon: const Icon(Icons.fast_forward, size: 37,)),
            IconButton(onPressed: (){
              controller.addToFav();
            }, icon: const Icon(Icons.favorite_outline, size: 26,)),
          ],
        );
      }
    );
  }
}