import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vtinter_chat/pages/main/drawer/controller/drawer_controller.dart';
import 'package:vtinter_chat/pages/main/home/controller/home_controller.dart';
import 'package:vtinter_chat/pages/main_page_controller.dart';
import 'package:vtinter_chat/pages/profile/controller/profile_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainPageController>(MainPageController());
    Get.put<DrawerMainController>(DrawerMainController());
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
  }
}
