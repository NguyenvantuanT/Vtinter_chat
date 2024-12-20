import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController{
  final zoomDrawerController = ZoomDrawerController().obs;

  toggleDrawer() {
    zoomDrawerController.value.toggle?.call();
  }
}