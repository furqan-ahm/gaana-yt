import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(
      PlayerController()
    );
  }

}