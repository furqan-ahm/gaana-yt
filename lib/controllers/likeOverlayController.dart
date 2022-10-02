import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class LikeOverlayController extends GetxController{

  LikeOverlayController({required this.animController});
  final AnimationController animController;

  play(){
    animController.forward().then((value) => animController.reverse());
  }

}