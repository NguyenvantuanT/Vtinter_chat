import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/components/button/app_elevated_button.dart';
import 'package:vtinter_chat/components/text_field/app_text_field.dart';
import 'package:vtinter_chat/pages/profile/controller/profile_controller.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:vtinter_chat/utils/validator.dart';
import 'package:flutter/material.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
            top: MediaQuery.of(context).padding.top + 38.0, bottom: 50.0),
        child: Column(
          children: [
            const Text(
              "Profile",
              style: TextStyle(color: AppColor.orange, fontSize: 24.6),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width - 20.0,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: _buildAvatar(),
            ),
            const SizedBox(height: 20.0),
            AppTextField(
              readOnly: true,
              hintText: "Email",
              prefixIcon: const Icon(Icons.email, color: AppColor.grey),
              controller: controller.emailController,
            ),
            const SizedBox(height: 20.0),
            AppTextField(
              hintText: "Full Name",
              controller: controller.nameController,
              validator: Validator.required,
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.person, color: AppColor.grey),
            ),
            const Spacer(),
            AppElevatedButton(
              text: "Update",
              isDisable: controller.isLoading.value,
              onPressed: controller.isButtonEnable.value
                  ? null
                  : () => controller.updateProfile(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    const radius = 50.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        controller.isLoading.value
            ? Container(
                width: radius * 2,
                height: radius * 2,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.orange.shade200,
                ),
                child: const SizedBox.square(
                  dimension: 32.0,
                  child: CircularProgressIndicator(
                    color: AppColor.pink,
                    strokeWidth: 2.0,
                  ),
                ),
              )
            : controller.fileAvatar != null
                ? Container(
                    width: radius * 2,
                    height: radius * 2,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      color: AppColor.bgColor,
                      image: DecorationImage(
                        image:
                            FileImage(File(controller.fileAvatar?.path ?? '')),
                      ),
                    ),
                  )
                : controller.user.avatar != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: CachedNetworkImage(
                          imageUrl: SharedPrefs.user?.avatar ?? "",
                          fit: BoxFit.cover,
                          width: radius * 2,
                          height: radius * 2,
                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              width: radius * 2,
                              height: radius * 2,
                              color: AppColor.orange,
                              child: const Center(
                                child: Icon(Icons.error_rounded,
                                    color: AppColor.white),
                              ),
                            );
                          },
                          placeholder: (_, __) {
                            return const SizedBox.square(
                              dimension: radius * 2,
                              child: Center(
                                child: SizedBox.square(
                                  dimension: 26.0,
                                  child: CircularProgressIndicator(
                                    color: AppColor.pink,
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const CircleAvatar(
                        radius: radius,
                        backgroundImage:
                            // Assets.images.defaultAvatar.provider()
                            AssetImage("assets/images/default_ava.jpg"),
                      ),
        const SizedBox(width: 30.0),
        GestureDetector(
          onTap: () => controller.pickAvatar(),
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              color: AppColor.grey.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 30.0,
              color: AppColor.grey,
            ),
          ),
        )
      ],
    );
  }
}
