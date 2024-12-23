import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/remote/auth_services.dart';
import 'package:vtinter_chat/services/remote/body/forgot_password_body.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  RxBool isLoading = false.obs;

  Future<void> onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate() == false) return;

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));

    ForgotPasswordBody body = ForgotPasswordBody()
      ..email = emailController.text.trim();
    authServices.forgotPassword(body).then((_) {
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: "Check your email and change pass",
      );
      Get.offAllNamed(PageName.loginPage, arguments: {'email': body.email});
    }).catchError((error) {
      FirebaseAuthException a = error as FirebaseAuthException;
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: a.message ?? "",
      );
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
