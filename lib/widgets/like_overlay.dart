import 'package:flutter/material.dart';
import 'package:gaana/controllers/likeOverlayController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LikeOverlay extends StatefulWidget {
  const LikeOverlay({ Key? key }) : super(key: key);

  @override
  _LikeOverlayState createState() => _LikeOverlayState();
}

class _LikeOverlayState extends State<LikeOverlay> with SingleTickerProviderStateMixin{
  
  late AnimationController animController;

  @override
  void initState() {
    animController = AnimationController(vsync: this,duration: Duration(milliseconds: 700));
    Get.find<PlayerController>().setAnimationController(animController);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Align(alignment:Alignment.center+Alignment(0,-0.4),child: Lottie.asset('assets/anims/like.json',controller: animController, width: 200, height: 200));
  }
}