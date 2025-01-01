import 'dart:io';
import 'dart:developer' as dev;

import 'package:chat_app/components/button/app_elevated_button.dart';
import 'package:chat_app/components/delight_toast_show.dart';
import 'package:chat_app/components/text_field/app_text_field.dart';
import 'package:chat_app/components/text_field/app_text_field_password.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/resource/themes/app_style.dart';
import 'package:chat_app/services/remote/auth_services.dart';
import 'package:chat_app/services/remote/storage_services.dart';
import 'package:chat_app/resource/themes/app_colors.dart';
import 'package:chat_app/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  StorageServices postImageServices = StorageServices();
  AuthServices authServices = AuthServices();
  final _auth = FirebaseAuth.instance;

  // tao tham chieu den collection task luu tru trong firebase
  // de add, update, delete
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');


  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? fileAvatar;

  Future<void> getImageFromGallery() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    fileAvatar = File(file.path);
    setState(() {});
  }

  Future<void> _onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate() == false) return;

    setState(() => isLoading = true);

    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text)
        .then((_) async {
      UserModel user = UserModel()
        ..name = usernameController.text.trim()
        ..email = emailController.text.trim()
        ..avatar = fileAvatar != null
            ? await postImageServices.post(image: fileAvatar! , email: emailController.text.trim())
            : null;

      _addUser(user);


      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: 'Register successfully, please login 😍',
      );
      
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(email: emailController.text.trim()),
        ),
        (Route<dynamic> route) => false,
      );
    }).catchError((onError) {
      FirebaseAuthException a = onError as FirebaseAuthException;
      if (!context.mounted) return;
      DelightToastShow.showToast(
        context: context,
        text: a.message ?? '',
      );
      
    }).whenComplete(() {
      setState(() => isLoading = false);
    });
  }

  void _addUser(UserModel user) {
    userCollection
        .doc(user.email)
        .set(user.toJson()) // bản chất là update nếu chưa cs thì thêm mới có rồi thì update
        .then((_) {})
        .catchError((error) {
      dev.log("Failed to add User: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.bgColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.of(context).padding.top + 50.0,
            bottom: 30.0,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: getImageFromGallery,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundImage: fileAvatar != null
                      ? FileImage(fileAvatar ?? File(''))
                      : const AssetImage("assets/images/default_ava.jpg")
                          as ImageProvider,
                ),
              ),
              Text(
                "Register",
                style: AppStyles.STYLE_28_BOLD.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20.0),
              _formSignUp(),
              const SizedBox(height: 40.0),
              AppElevatedButton(
                text: "Register",
                isDisable: isLoading,
                onPressed: () => _onSubmit(context),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account? ",
                      style: AppStyles.STYLE_12
                          .copyWith(color: AppColor.textColor)),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    child: Text('Login',
                        style: AppStyles.STYLE_14_BOLD
                            .copyWith(color: AppColor.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSignUp() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            controller: usernameController,
            labelText: "Username",
            textInputAction: TextInputAction.next,
            validator: Validator.required,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: emailController,
            labelText: "Email",
            textInputAction: TextInputAction.next,
            validator: Validator.email,
          ),
          const SizedBox(height: 20),
          AppTextFieldPassword(
            controller: passwordController,
            labelText: "Password",
            textInputAction: TextInputAction.next,
            validator: Validator.password,
          ),
          const SizedBox(height: 20),
          AppTextFieldPassword(
            onChanged: (_) => setState(() {}),
            controller: confirmPassController,
            labelText: "Confirm password",
            textInputAction: TextInputAction.done,
            validator:
                Validator.confirmPassword(passwordController.text.trim()),
          ),
        ],
      ),
    );
  }
}
