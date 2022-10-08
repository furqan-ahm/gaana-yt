import 'package:flutter/material.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:get/get.dart';


class FavoriteTabs extends GetWidget<LibraryController> {
const FavoriteTabs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Obx(
      (){

        // return SizedBox(
        //   height: 40,
        //   width: Size.infinite.width,
        //   child: ListView(
        //     padding: EdgeInsets.symmetric(horizontal: 20),
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         child: Material(
        //           color: controller.offlineOnly.value?Colors.grey:Colors.red,
        //           borderRadius: BorderRadius.all(Radius.circular(20)),
        //           child: InkWell(
        //             onTap: (){},
        //             child: const Center(child: Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 10),
        //               child: Text('Favorites'),
        //             )),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         child: Material(
        //           color: !controller.offlineOnly.value?Colors.grey:Colors.red,
        //           borderRadius: BorderRadius.all(Radius.circular(20)),
        //           child: InkWell(
        //             onTap: (){},
        //             child: const Center(child: Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 10),
        //               child: Text('Downloaded'),
        //             )),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         child: Material(
        //           color: !controller.offlineOnly.value?Colors.grey:Colors.red,
        //           borderRadius: BorderRadius.all(Radius.circular(20)),
        //           child: InkWell(
        //             onTap: (){},
        //             child: const Center(child: Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 10),
        //               child: Text('Device Media'),
        //             )),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                controller.offlineOnly.value=false;
              },
              child: Text('All', style: TextStyle(fontSize: 18, color: !controller.offlineOnly.value?Colors.red:Colors.white),)
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 20,
              width: 2,
              color: Colors.white,
            ),
            InkWell(
              onTap: (){
                controller.offlineOnly.value=true;
              },
              child: Text('Offline', style: TextStyle(fontSize: 18, color: controller.offlineOnly.value?Colors.red:Colors.white),)
            )
          ],
        );
      }
    );
  }
}