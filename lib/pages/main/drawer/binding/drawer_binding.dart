import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vtinter_chat/pages/main/drawer/controller/drawer_controller.dart';

class DrawerBinding extends Bindings{
  @override
  void dependencies() {
    // Get.put<DrawerMainController>(DrawerMainController());
    Get.lazyPut<DrawerMainController>(() => DrawerMainController());
  }

}