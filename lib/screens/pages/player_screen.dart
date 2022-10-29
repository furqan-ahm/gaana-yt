import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/like_overlay.dart';
import 'package:gaana/widgets/playerCard.dart';
import 'package:gaana/widgets/playerControls.dart';
import 'package:gaana/widgets/trackSlider.dart';
import 'package:get/get.dart';

import '../../models/songModel.dart';


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
            return controller.songs.value.isNotEmpty?SizedBox(
              height: Size.infinite.height,
              width: Size.infinite.width,
              child: Stack(
                children: [
                  Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 30,),
                            IconButton(
                              icon: const Icon(Icons.playlist_add,color: Colors.white,),
                              onPressed: (){
                                controller.savePlayList();
                              },
                            ),
                          ],
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
                            Song song = controller.songs.value[index];
                            return Dismissible(
                                    direction: DismissDirection.up,
                                    confirmDismiss: (d)async{
                                      controller.dismissTrack(index);
                                      return true;
                                    },
                                    key: UniqueKey(),
                                    child: PlayerCard(song: song,)
                                  );
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const TrackSlider(),
                      const SizedBox(height: 20,),
                      const PlayerControls()
                    ],
                  ),
                ],
              ),
            ):
            const Center(
              child: Text('Nothing to play'),
            );
          }
        ),
        const IgnorePointer(child: LikeOverlay())
      ],
    );
  }
}