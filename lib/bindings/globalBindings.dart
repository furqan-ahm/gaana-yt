import 'package:gaana/controllers/downloadController.dart';
import 'package:gaana/controllers/libraryController.dart';
import 'package:gaana/controllers/playerController.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(
      PlayerController()
    );
    Get.put(DownloadController());
    Get.put(LibraryController());
  }

}