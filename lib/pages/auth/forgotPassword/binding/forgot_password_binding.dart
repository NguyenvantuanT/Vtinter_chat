import 'package:get/get.dart';
import 'package:vtinter_chat/pages/auth/forgotPassword/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ForgotPasswordController>(ForgotPasswordController());
  }

}