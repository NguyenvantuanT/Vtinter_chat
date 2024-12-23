import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/services/remote/auth_services.dart';
import 'package:vtinter_chat/services/remote/body/change_password_body.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  AuthServices authServices = AuthServices();

  ChangePasswordController() {
    confirmPasswordController.addListener(() {});
  }

  Future<void> onSubmit(BuildContext context) async {
    if (formKey.currentState?.validate() == false) return;
    isLoading.value = true;

    ChangePasswordBody body = ChangePasswordBody()
      ..email = SharedPrefs.user?.email ?? ""
      ..currentPassword = currentPasswordController.text.trim()
      ..newPassword = newPasswordController.text.trim();

    authServices.changePassword(body).then((value) {
      if (!context.mounted) return;
      if (value) {
        DelightToastShow.showToast(
          context: context,
          text: "Change Success !",
          icon: Icons.check,
        );
        Get.offAllNamed(PageName.loginPage, arguments: {'email': body.email});
      } else {
        isLoading.value = false;
        DelightToastShow.showToast(
          context: context,
          text: 'Current password is wrong😐',
          icon: Icons.check,
        );
      }
    }).catchError((_) {});
  }
}
