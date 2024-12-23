import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/remote/account_services.dart';
import 'package:vtinter_chat/services/remote/auth_services.dart';
import 'package:vtinter_chat/services/remote/body/login_body.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthServices authServices = AuthServices();
  AccountServices accountServices = AccountServices();
  RxBool isLoading = false.obs;
  final arguments = Get.arguments as Map? ?? {};
  @override
  void onInit() {
    super.onInit();
    emailController.text = arguments['email'] ?? '';
  }

  void navigaToForgotPasswordPage() {
    Get.toNamed(PageName.forgotPasswordPage);
  }

   void navigaToRegisterPage() {
    Get.toNamed(PageName.registerPage);
  }

  Future<void> submitLogin(BuildContext context) async {
    if (formKey.currentState?.validate() == false) return;
    isLoading.value = true;
    LoginBody body = LoginBody()
      ..email = emailController.text.trim()
      ..password = passController.text.trim();

    authServices.login(body).then((_) {
      accountServices.getUser(body.email ?? '').then((_) {
        if (!context.mounted) return;
        Get.offAllNamed(PageName.mainPage);
      }).catchError((onError) {});
    }).catchError((onError) {
      if (!context.mounted) return;
      DelightToastShow.showToast(context: context, text: "Lofgin fail");
      accountServices.getUser(body.email ?? '').then((_) {
        if (!context.mounted) return;
        Get.offAllNamed(PageName.mainPage);
      }).catchError((onError) {});
    }).whenComplete(() => isLoading.value = true);
  }
}
