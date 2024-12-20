import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:vtinter_chat/routes/app_routes.dart';

class MainPageController extends GetxController{
  final zoomDrawerController = ZoomDrawerController().obs;

  void navigaToDrawer() {
    Get.toNamed(PageName.drawerPage);
  }

  toggleDrawer() {
    zoomDrawerController.value.toggle?.call();
  }
}