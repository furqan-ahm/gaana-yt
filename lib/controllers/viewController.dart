import 'package:get/get.dart';

class ViewController extends GetxController{

  final RxInt currentIndex=0.obs;


  changePage(int index){
    currentIndex.value=index;
  }

}