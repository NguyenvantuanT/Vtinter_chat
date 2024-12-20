
import 'package:get/get.dart';
import 'package:vtinter_chat/pages/splash/controller/splash_controller.dart';
import 'package:vtinter_chat/resource/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade400,
          child: const Text(
            "V T",
            style: TextStyle(
                color: AppColor.grey,
                fontSize: 45.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
