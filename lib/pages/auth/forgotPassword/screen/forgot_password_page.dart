import 'package:get/get.dart';
import 'package:vtinter_chat/components/button/app_elevated_button.dart';
  import 'package:vtinter_chat/components/text_field/app_text_field.dart';
import 'package:vtinter_chat/pages/auth/forgotPassword/controller/forgot_password_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:vtinter_chat/utils/validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.of(context).padding.top + 130.0, bottom: 50.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _headerIcon(),
              _headerText(),
              const SizedBox(height: 10.0),
              AppTextField(
                controller: controller.emailController,
                hintText: "Email",
                validator: Validator.email,
              ),
              const SizedBox(height: 30.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: AppElevatedButton(
                  text: "Next",
                  onPressed: () => controller.onSubmit(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    return const Text(
      "V T I N T E R",
      style: TextStyle(fontSize: 22),
    );
  }

  Icon _headerIcon() {
    return const Icon(
      Icons.person,
      color: AppColor.grey,
      size: 80,
    );
  }
}
