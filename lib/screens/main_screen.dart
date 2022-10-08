import 'package:flutter/material.dart';
import 'package:gaana/constants.dart';
import 'package:gaana/controllers/viewController.dart';
import 'package:gaana/screens/pages/library_screen.dart';
import 'package:gaana/screens/pages/home_screen.dart';
import 'package:gaana/screens/pages/player_screen.dart';
import 'package:gaana/widgets/navPlayerItem.dart';
import 'package:get/get.dart';
import 'package:music_visualizer/music_visualizer.dart';


class MainScreen extends GetView<ViewController> {
const MainScreen({ Key? key }) : super(key: key);


  @override
  // TODO: implement controller
  ViewController get controller => Get.put(ViewController());

  @override
  Widget build(BuildContext context){
    return Obx(
      () {
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: primaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(controller.currentIndex.value==0?Icons.home:Icons.home_outlined)
              ),
              const BottomNavigationBarItem(
                label: 'Player',
                icon: NavPlayerItem()
              ),
              BottomNavigationBarItem(
                label: 'Fav',
                icon: Icon(controller.currentIndex.value==2?Icons.library_music:Icons.library_music_outlined)
              )
            ],
          ),
          body: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: IndexedStack(
                  index: controller.currentIndex.value,
                  children: const[
                    HomeScreen(),
                    PlayerScreen(),
                    LibraryScreen()
                  ],
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}