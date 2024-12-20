import 'package:get/get.dart';
import 'package:vtinter_chat/pages/auth/login/controller/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}