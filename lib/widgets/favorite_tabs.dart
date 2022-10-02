import 'package:flutter/material.dart';
import 'package:gaana/controllers/favoritesController.dart';
import 'package:get/get.dart';


class FavoriteTabs extends GetWidget<FavoritesController> {
const FavoriteTabs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Obx(
      (){
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