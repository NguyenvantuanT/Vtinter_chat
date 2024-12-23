import 'package:get/get.dart';
import 'package:vtinter_chat/components/button/app_elevated_button.dart';
import 'package:vtinter_chat/components/text_field/app_text_field.dart';
import 'package:vtinter_chat/components/text_field/app_text_field_password.dart';
import 'package:vtinter_chat/pages/auth/login/controller/login_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:vtinter_chat/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.bgColor,
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerIcon(),
              _headerText(),
              const SizedBox(height: 20),
              _formLogin(context),
              const SizedBox(height: 10),
              _forgotPassword(context),
              const SizedBox(height: 20),
              Obx(() {
                return AppElevatedButton(
                  text: "Login",
                  isDisable: controller.isLoading.value,
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.submitLogin(context),
                );
              }),
              const SizedBox(height: 10),
              _linkSignUp(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have accout"),
        GestureDetector(
          onTap: controller.navigaToRegisterPage,
          behavior: HitTestBehavior.translucent,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Sign Up?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: controller.navigaToForgotPasswordPage,
          behavior: HitTestBehavior.translucent,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Forgot Password ?",
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: controller.emailController,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validator: Validator.required,
          ),
          const SizedBox(height: 20),
          AppTextFieldPassword(
            controller: controller.passController,
            hintText: "Pass",
            textInputAction: TextInputAction.done,
            validator: Validator.password,
            onFieldSubmitted: (_) => controller.submitLogin(context),
          ),
        ],
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
