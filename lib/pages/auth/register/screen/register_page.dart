import 'package:get/get.dart';
import 'package:vtinter_chat/components/button/app_elevated_button.dart';
import 'package:vtinter_chat/components/text_field/app_text_field.dart';
import 'package:vtinter_chat/components/text_field/app_text_field_password.dart';
import 'package:vtinter_chat/pages/auth/register/controller/register_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:vtinter_chat/utils/validator.dart';
import 'package:flutter/material.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
              _headerAvata(context),
              _headerTitle(),
              const SizedBox(height: 20),
              _formSignUp(),
              const SizedBox(height: 10),
              _forgotPassword(),
              const SizedBox(height: 20),
              AppElevatedButton(
                text: "Register",
                isDisable: controller.isLoading.value,
                onPressed: () => controller.onSubmit(context),
              ),
              const SizedBox(height: 10),
              _linkLogin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Alredy have accout"),
        GestureDetector(
          onTap: controller.navigatorLoginPage,
          behavior: HitTestBehavior.translucent,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Login?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: controller.navigatorLoginPage,
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

  Widget _formSignUp() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: controller.usernameController,
            hintText: "Username",
            textInputAction: TextInputAction.next,
            validator: Validator.required,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: controller.emailController,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validator: Validator.email,
          ),
          const SizedBox(height: 20),
          AppTextFieldPassword(
            controller: controller.passwordController,
            hintText: "Pass",
            textInputAction: TextInputAction.next,
            validator: Validator.password,
          ),
          const SizedBox(height: 20),
          AppTextFieldPassword(
            controller: controller.confirmPassController,
            hintText: "Confirm password",
            textInputAction: TextInputAction.done,
            validator: Validator.confirmPassword(
                controller.passwordController.text.trim()),
          ),
        ],
      ),
    );
  }

  Widget _headerTitle() {
    return const Text(
      "S I G N U P",
      style: TextStyle(fontSize: 22),
    );
  }

  Widget _headerAvata(BuildContext context) {
    return GestureDetector(
      onTap: controller.getImageFromGallery,
      child: Obx(() => CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.15,
          backgroundImage: controller.fileAvatar.value != null
              ? FileImage(controller.fileAvatar.value!)
              : const AssetImage("assets/images/default_ava.jpg")
                  as ImageProvider),)
      
      
    );
  }
}



  //nguyenvantuan487t@gmail.com pass 1234567
  //vtinter@gmail.com pass 1234567
  //cun@gmail.com pass 1234567

