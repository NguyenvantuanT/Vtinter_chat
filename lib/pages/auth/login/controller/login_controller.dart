import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/pages/main/home/screen/home_page.dart';
import 'package:vtinter_chat/pages/main_page.dart';
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

  @override
  void onInit() {
    super.onInit();
    emailController.text = Get.arguments ?? '';
  }

  void submidForgotPasswordPage() {
    Get.toNamed(PageName.forgotPasswordPage);
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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
          (route) => false,
        );
      }).catchError((onError) {});
    }).catchError((onError) {
      if (!context.mounted) return;
      DelightToastShow.showToast(context: context, text: "Lofgin fail");
      accountServices.getUser(body.email ?? '').then((_) {
        if (!context.mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainPage(),
          ),
          (route) => false,
        );
      }).catchError((onError) {});
    }).whenComplete(() => isLoading.value = true);
  }
}
