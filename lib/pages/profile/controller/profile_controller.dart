import 'dart:io';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtinter_chat/components/delight_toast_show.dart';
import 'package:vtinter_chat/models/user_model.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/get_storage_local.dart';
// import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/services/remote/account_services.dart';
import 'package:vtinter_chat/services/remote/storage_services.dart';

class ProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  StorageServices postImageServices = StorageServices();
  AccountServices accountServices = AccountServices();
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  Rxn<File> fileAvatar = Rxn<File>();
  RxBool isLoading = false.obs;
  RxBool isButtonEnable = true.obs;
  UserModel user = GetStorageLocal.user ?? UserModel();

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: user.name)
      ..addListener(checkFormChanged);
    emailController = TextEditingController(text: user.email);
  }

  void checkFormChanged() {
    isButtonEnable.value = nameController.text != user.name ||
        emailController.text != user.email ||
        fileAvatar.value != null;
  }

  Future<void> pickAvatar() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    fileAvatar.value = File(file.path);
  }

  Future<void> updateProfile(BuildContext context) async {
    if (formKey.currentState?.validate() == false) return;
    isLoading.value = true;

    final body = UserModel()
      ..name = nameController.text.trim()
      ..email = emailController.text.trim()
      ..avatar = fileAvatar.value != null
          ? await postImageServices.post(image: fileAvatar.value!)
          : user.avatar ?? "";
    accountServices.updateUser(body).then((_) {
      GetStorageLocal.user = body;
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: 'Profile has been saved 😍',
      );
      Get.offNamed(PageName.mainPage);
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
