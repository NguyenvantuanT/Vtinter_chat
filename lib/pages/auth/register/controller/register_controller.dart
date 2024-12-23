import 'dart:io';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/remote/auth_services.dart';
import 'package:vtinter_chat/services/remote/body/resigter_body.dart';
import 'package:vtinter_chat/services/remote/storage_services.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  StorageServices postImageServices = StorageServices();
  AuthServices authServices = AuthServices();

  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  Rx<File?> fileAvatar = Rx<File?>(null); 

  Future<void> getImageFromGallery() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    fileAvatar.value = File(file.path);
  }

  Future<void> onSubmit(BuildContext context) async {
    if (formKey.currentState?.validate() == false) return;
    isLoading.value = true;

     String? avatarUrl;
      if (fileAvatar.value != null) {
        avatarUrl = await postImageServices.post(image: fileAvatar.value!);
      }
    ResigterBody body = ResigterBody()
      ..name = usernameController.text.trim()
      ..email = emailController.text.trim()
      ..password = emailController.text.trim()
      ..confirmPass = confirmPassController.text.trim()
      ..avatar = avatarUrl;
    authServices.resigter(body).then((_) {
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: "Sign Up Success",
        icon: Icons.check,
      );
      Get.offAllNamed(PageName.loginPage, arguments: {'email': body.email});
    }).catchError((error) {
      dev.log("Failed to register: $error");
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: 'Server error 😐',
        icon: Icons.error,
      );
    }).whenComplete(() => isLoading.value = true);
  }
}
