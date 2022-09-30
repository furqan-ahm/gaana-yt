import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:gaana/widgets/trackSlider.dart';
import 'package:get/get.dart';


class PlayerScreen extends GetView<PlayerController> {
const PlayerScreen({ Key? key }) : super(key: key);


  @override
  PlayerController get controller => Get.find<PlayerController>();

  @override
  Widget build(BuildContext context){
    return Obx(
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
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.onPageChange,
                      itemCount: controller.songs.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(child: Image.network(controller.songs.value[index].video.thumbnails.mediumResUrl, fit: BoxFit.cover,)),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  TrackSlider(),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){controller.backward();}, icon: Icon(Icons.fast_rewind, size: 37,)),
                      FloatingActionButton.large(
                        onPressed: (){
                          controller.togglePlay();
                        },
                        backgroundColor: primaryColor,
                        child: controller.songLoading.value?CircularProgressIndicator(color: Colors.white,):Icon(!controller.isPlaying?Icons.play_arrow:Icons.pause, color: Colors.white, size: 42,),
                      ),
                      IconButton(onPressed: (){controller.forward();}, icon: Icon(Icons.fast_forward, size: 37,)),
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
    );
  }
}