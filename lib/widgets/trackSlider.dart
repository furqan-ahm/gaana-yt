import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

class TrackSlider extends GetWidget<PlayerController>{
  const TrackSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final pos = controller.position.value;
        final max = controller.trackMaxPosition.value;
        return Slider(
          min: 0,
          max: max,
          activeColor: primaryColor,
          thumbColor: Colors.transparent,
          value: pos>max?max:pos,
          onChanged: (val){
            controller.player.seek(Duration(milliseconds: val.toInt()));
          }
        );
      }
    );
  }
}