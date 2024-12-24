import 'dart:async';

import 'package:get/get.dart';
import 'package:vtinter_chat/routes/app_routes.dart';
import 'package:vtinter_chat/services/local/get_storage_local.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkStatus();
  }

  void _checkStatus() {
    Timer(const Duration(milliseconds: 2600), () {
      if (GetStorageLocal.isLogin) {
        Get.offAllNamed(PageName.mainPage);
      } else {
        Get.offAllNamed(PageName.loginPage);
      }
    });
  }
}
