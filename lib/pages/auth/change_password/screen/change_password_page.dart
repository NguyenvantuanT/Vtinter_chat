import 'package:get/get.dart';
import 'package:vtinter_chat/components/button/app_elevated_button.dart';
import 'package:vtinter_chat/components/text_field/app_text_field_password.dart';
import 'package:vtinter_chat/pages/auth/change_password/controller/change_password_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:vtinter_chat/utils/validator.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                  top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
              children: [
                const Center(
                  child: Text('Change Password',
                      style: TextStyle(color: AppColor.black, fontSize: 24.0)),
                ),
                const SizedBox(height: 38.0),
                const Center(
                    child: Icon(
                  Icons.lock,
                  size: 30.0,
                )),
                const SizedBox(height: 46.0),
                AppTextFieldPassword(
                  controller: controller.currentPasswordController,
                  hintText: 'Current Password',
                  validator: Validator.required,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 18.0),
                AppTextFieldPassword(
                  controller: controller.newPasswordController,
                  hintText: 'New Password',
                  validator: Validator.password,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 18.0),
                AppTextFieldPassword(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  validator: Validator.confirmPassword(
                    controller.newPasswordController.text,
                  ),
                  onFieldSubmitted: (_) => controller.onSubmit(context),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 92.0),
                AppElevatedButton.outline(
                  onPressed: () => controller.onSubmit(context),
                  text: 'Done',
                  isDisable: controller.isLoading.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
