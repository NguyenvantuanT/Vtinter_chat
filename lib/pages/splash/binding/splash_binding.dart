import 'package:get/get.dart';
import 'package:vtinter_chat/pages/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }

}