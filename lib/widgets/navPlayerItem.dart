import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/controllers/viewController.dart';
import 'package:get/get.dart';
import 'package:music_visualizer/music_visualizer.dart';

import '../constants.dart';

class NavPlayerItem extends GetWidget<PlayerController> {
const NavPlayerItem({ Key? key}) : super(key: key);

  @override
  // TODO: implement controller
  PlayerController get controller => Get.find<PlayerController>();

  @override
  Widget build(BuildContext context){
    return Obx(
      (){
        bool selected = Get.find<ViewController>().currentIndex.value==1;
        return SizedBox(
          height: 40,
          width: 80,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(scale: animation,child: child,),
            child: controller.isPlaying?
            MusicVisualizer(colors: [primaryColor, primaryColor, primaryColor, primaryColor], duration: const [900, 700, 600, 800, 500], barCount: 5)
            :
            Container(
              decoration: BoxDecoration(
                //color: selected?primaryColor:Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: primaryColor),
              ),
              child: Icon(selected?Icons.music_note:Icons.music_note_outlined,color: Colors.white,),
            ),
          )
        );
      }
    );
  }
}