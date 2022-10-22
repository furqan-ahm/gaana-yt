import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

class PlayerFloatingButton extends GetWidget<PlayerController> {
const PlayerFloatingButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Hero(
      tag: 'player',
      child: Obx(
        () {
          if(controller.songs.value.isEmpty)return const SizedBox.shrink();
    
          return FloatingActionButton.extended(
            heroTag: null,
            onPressed: (){
              controller.isPlaying?controller.player.pause():controller.player.play();
            },
            backgroundColor: primaryColor,
            label: Text(controller.isPlaying?'Pause':'Play')
          );
        }
      ),
    );
  }
}