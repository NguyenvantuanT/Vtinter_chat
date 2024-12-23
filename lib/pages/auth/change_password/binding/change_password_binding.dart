import 'package:get/get.dart';
import 'package:vtinter_chat/pages/auth/change_password/controller/change_password_controller.dart';

class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }

}