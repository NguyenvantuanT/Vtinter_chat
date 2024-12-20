import 'dart:async';

import 'package:get/get.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/shared_prefs.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkStatus();
  }

  void _checkStatus() {
    Timer(const Duration(milliseconds: 2600), () {
      if (SharedPrefs.isLogin) {
        Get.offAllNamed(PageName.loginPage);
      } else {
        Get.offAllNamed(PageName.loginPage);
      }
    });
  }
}
