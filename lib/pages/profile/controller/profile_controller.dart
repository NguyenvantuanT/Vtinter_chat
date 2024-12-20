import 'dart:io';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/models/user_model.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/services/remote/account_services.dart';
import 'package:vtinter_chat/services/remote/storage_services.dart';

class ProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  StorageServices postImageServices = StorageServices();
  AccountServices accountServices = AccountServices();
  ImagePicker picker = ImagePicker();

  File? fileAvatar;
  RxBool isLoading = false.obs;
  RxBool isButtonEnable = true.obs;
  dynamic user = SharedPrefs.user ?? UserModel();

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: user.name)
      ..addListener(() => isButtonEnable.value = false);
    emailController = TextEditingController(text: user.email);
  }

  Future<void> pickAvatar() async {
    XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result == null) return;
    fileAvatar = File(result.path);
  }

  Future<void> updateProfile(BuildContext context) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    final body = UserModel()
      ..name = nameController.text.trim()
      ..email = emailController.text.trim()
      ..avatar = fileAvatar != null
          ? await postImageServices.post(image: fileAvatar!)
          : SharedPrefs.user?.avatar ?? "";
    accountServices.updateUser(body).then((_) {
      SharedPrefs.user = body;
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: 'Profile has been saved 😍',
      );
      Get.toNamed(PageName.mainPage);
    }).catchError((onError) {
      dev.log("Failed to update Profile: $onError");
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: 'Profile has been saved 😍',
      );
      isLoading.value = false;
    });
  }
}
