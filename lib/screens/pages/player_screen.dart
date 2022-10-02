import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/like_overlay.dart';
import 'package:gaana/widgets/playerCard.dart';
import 'package:gaana/widgets/trackSlider.dart';
import 'package:get/get.dart';


class PlayerScreen extends GetView<PlayerController> {
const PlayerScreen({ Key? key }) : super(key: key);


  @override
  PlayerController get controller => Get.find<PlayerController>();

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Obx(
          (){
            return controller.songs.value.isNotEmpty?Container(
              height: Size.infinite.height,
              width: Size.infinite.width,
              child: Stack(
                children: [
                  Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.delete,color: Colors.white,),
                          onPressed: (){
                            controller.flush();
                          },
                        ),
                      ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height/3,
                        child: Swiper(
                          loop: false,
                          controller: controller.pageController,
                          viewportFraction: 0.76,
                          scale: 0.8,
                          duration: 400,
                          onIndexChanged: controller.onPageChange,
                          itemCount: controller.songs.value.length,
                          itemBuilder: (context, index) {
                            return PlayerCard(index: index, song: controller.songs.value[index]);
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      TrackSlider(),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.loop, size: 26,)),
                          IconButton(onPressed: (){controller.backward();}, icon: Icon(Icons.fast_rewind, size: 37,)),
                          FloatingActionButton.large(
                            onPressed: (){
                              controller.togglePlay();
                            },
                            backgroundColor: primaryColor,
                            child: controller.songLoading.value?CircularProgressIndicator(color: Colors.white,):Icon(!controller.isPlaying?Icons.play_arrow:Icons.pause, color: Colors.white, size: 42,),
                          ),
                          IconButton(onPressed: (){controller.forward();}, icon: Icon(Icons.fast_forward, size: 37,)),
                          IconButton(onPressed: (){
                            controller.addToFav();
                          }, icon: Icon(Icons.favorite_outline, size: 26,)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ):
            Center(
              child: Text('Nothing to play'),
            );
          }
        ),
        IgnorePointer(child: LikeOverlay())
      ],
    );
  }
}